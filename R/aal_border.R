#' AAL List of Border Edges
#'
#' @format A list with 2 elements, which are either `v4` or `v5`,
#' each having a `list` of elements, :
#' \describe{
#' \item{BORDER.V}{a numeric vector of values corresponding to those
#' in the image}
#' \item{BORDER.XYZ}{a V by 3 matrix that contains the regions edges in mm,
#' which can be used as indices if the image read in is the same dimensions.}
#' }
"aal_border"


#' @rdname aal_border
#' @export
#' @param version Version of AAL ROI image, versions 4 and 5.
aal_get_border =  function(version = c("5", "4")) {
  version = as.character(version)
  version = match.arg(version)
  fname = paste0("v", version)
  aal::aal_border[[fname]]
}
