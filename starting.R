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

# versioning and set up package checking
use_git()
use_github_action_check_standard()
use_coverage("codecov")
usethis::use_github_action("test-coverage")
use_github_action()

use_cran_comments()
