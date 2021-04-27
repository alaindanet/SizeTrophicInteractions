library("devtools")
options(devtools.name = "Alain Danet",
  devtools.desc.author = "person('Alain', 'Danet',
  email='alain.danet@mnhn.fr', role = c('aut', 'cre'))",
  devtools.desc.license = "MIT + file LICENSE"
)

create_package("~/Documents/post-these/packages/sizeTrophicInteractions")
use_mit_license()
use_readme_rmd()
use_vignette("intro")
use_package_doc()
use_testthat()

#data
use_data()

# versioning and set up package checking
use_git()
use_github_action_check_standard()
use_coverage("codecov")
usethis::use_github_action("test-coverage")
usethis::use_github_action("pkgdown")
use_cran_comments()

# use pkgdown
pkgdown::build_site()
usethis::use_git_ignore("docs")
usethis::use_git_ignore("inst/docs")

#test
devtools::load_all()
devtools::test()

# build package 
attachment::att_to_description()
devtools::check()
devtools::install()
devtools::build_readme()
pkgdown::build_site()
