#' AAL Label Names
#'
#' @format A list with 2 elements, which are either `v4` or `v5`,
#' each having a `data.frame` of:
#' \describe{
#' \item{index}{the corresponding value of the image}
#' \item{name}{the name of the region of the brain}
#' }
#' @note Cerebellum is misspelled in the original data, but correctly
#' spelled in the data in this package.  Also, Cingulum in version 4
#' has been changed to Cingulate to harmonize with version 5.  Similarly,
#' `Frontal_Sup_2` has been set to `Frontal_Sup` in version 5
"aal_labels"
