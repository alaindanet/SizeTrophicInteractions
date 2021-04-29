
<!-- README.md is generated from README.Rmd. Please edit that file -->

# sizeTrophicInteractions

<!-- badges: start -->

[![R-CMD-check](https://github.com/alaindanet/SizeTrophicInteractions/workflows/R-CMD-check/badge.svg)](https://github.com/alaindanet/SizeTrophicInteractions/actions)
<!-- badges: end -->

The goal of sizeTrophicInteractions is to …

## Installation

You can install sizeTrophicInteractions with:

``` r
devtools::install_github("alaindanet/sizeTrophicInteractions")
```

## Example

### Generate individual size

#### With Pokémon

``` r
  lot <- tibble::tibble(
    id = seq(1:4),
    species = rep(c("Pikachu", "Salameche"), each = 2),
    type = c("I", "N", "S/L", "G"),
    min = c(rep(NA, 3), 1),
    max = c(rep(NA, 3), 2),
    nb = c(5, 1, 50, 10)
  )
  measure <- tibble::tibble(
    id = c(rep(1, 5), 2, rep(3, 30)),
    size = c(seq(10, 15), rnorm(30, 10, 2))
  )

  output <- get_size_from_lot(
    lot = lot,
    id_var = id,
    type_var = type,
    nb_var = nb,
    min_var = min,
    max_var = max,
    species = species,
    measure = measure,
    measure_id_var = id,
    size_var = size)
```

### With OFB data

``` r
library(sizeTrophicInteractions)

# sample of OFB data
data(ind_measure_testing)
data(lot_testing)
```

``` r
get_size_from_lot(
      lot = lot_testing,
      id_var = lop_id,
      type_var = type_lot,
      nb_var = lop_effectif,
      min_var = lop_longueur_specimens_taille_mini,
      max_var = lop_longueur_specimens_taille_maxi,
      species = species,
      measure = ind_measure_testing,
      measure_id_var = mei_lop_id,
      size_var = mei_taille)
#> incorrect lot G have been filtered
#> # A tibble: 3,530 x 3
#>     lop_id species fish      
#>      <int> <chr>   <list>    
#>  1 2141822 VAI     <dbl [6]> 
#>  2 4298431 BAF     <dbl [3]> 
#>  3 4390067 BAF     <dbl [2]> 
#>  4 4152850 TRF     <dbl [15]>
#>  5 2461191 TRF     <dbl [11]>
#>  6 2276025 ABL     <dbl [3]> 
#>  7 2395932 ABL     <dbl [11]>
#>  8 3153703 CHE     <dbl [8]> 
#>  9 4736608 PSR     <dbl [4]> 
#> 10 2398199 TRF     <dbl [16]>
#> # … with 3,520 more rows
```
