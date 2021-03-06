
library(tibble)
library(purrr)
library(tidyr)
library(dplyr)
library(magrittr)

nb_class <- 9
min_size <- 1
max_size <- 10

fake <- tibble(
  species = rep(c("Pikachu", "Salameche"), each = 10),
  size = c(seq(1,10), 110, seq(101,109)))
# Compute_classes
classes_species <- compute_classes(fake, species, size, nb_class = nb_class)

test_that("class assignation works", {
  # Quantile method
  expected_vector <- as.integer(c(1, 1, seq.int(2, 9), rep(NA, 10)))
  expect_equal(get_size_class(fake, Pikachu, size, classes_species), expected_vector)
  # Salameche
  expected_vector <- as.integer(c(rep(NA, 10), 9, 1, seq.int(1, 8)))
  expect_equal(get_size_class(fake, Salameche, size, classes_species), expected_vector)

})

fake_station <- tibble(
  station = rep(rep(c(1, 2, 3, 4, 5), each = 2), times = 2),
  species = rep(c("Pikachu", "Salameche"), each = 10),
  size = c(seq(1, 10), 110, seq(101, 109)))

test_that("class assignation works with several species", {

  expected_df <- tibble(
    species = rep(c("Pikachu", "Salameche"), each = 10),
    class_id = c(
      c(1, 1, seq.int(2, 9)),
      c(9, 1, 1, seq.int(2, 8))) %>%
    as.integer(.),
    size = c(seq(1, 10), 110, seq(101, 109)),
    station = rep(rep(c(1, 2, 3, 4, 5), each = 2), times = 2)
    )
  expect_equal(assign_size_class(fake_station, species, size, classes_species),
    expected_df)
})

#################################
#  Extraction of local network  #
#################################

data(toy_metaweb)
test_that("extraction of a network works", {

  station1 <- filter(fake_station, station == 1)
  test <- extract_network(station1, species, size, toy_metaweb)

  expect_type(test, "double")
  expect_equal(dim(test), c(5, 5))

  local_network <- extract_network(fake_station, species, size, metaweb = toy_metaweb, out_format = "edge")
   expect_type(local_network, "character")

})

test_that("local network generation works", {
  local_network <- build_local_network(fake_station, species, size, station,
   metaweb = toy_metaweb, out_format = "igraph")
  local_network %<>% mutate(
    network = map(network, function(x) arrange(x, from, to)),
    test = map(data,
      # Replicate network extraction
      function(x, metaweb) {
      node <- unite(x, sp_class, species, class_id) %>%
	select(sp_class) %>% unlist
      to_subset <- c(node, metaweb$resource) %>% unique
      local_network <- metaweb$metaweb[to_subset, to_subset]
      local_network %<>%
	igraph::graph_from_adjacency_matrix(., mode = "directed") %>%
	igraph::as_data_frame() %>%
	arrange(from, to)
      }, metaweb = toy_metaweb)
)
  expect_equal(
    map_chr(local_network$test, class) %>% unique,
    "data.frame")
  expect_identical(
    local_network$network,
    local_network$test
  )
})

test_that("NA exclusion works", {
  if (!any(is.na(fake_station$size))) {
    fake_station$size[sample(seq_len(nrow(fake_station)), 1)] <-
      NA_real_
  }
  expect_message(
    local_network <- build_local_network(
    data = fake_station,
    species = species,
    var = size,
    group_var = station,
    metaweb = toy_metaweb,
    classes = NULL,
    out_format = "igraph"
    ), "They have been removed"
  )
  expect_equal(length(which(is.na(unnest(local_network, data)))), 0)
})
