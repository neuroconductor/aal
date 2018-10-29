#' Filename of AAL image
#'
#' @param version Version of AAL ROI image, versions 4 and 5.
#'
#' @return A character vector
#' @export
#'
#' @examples
#' aal_fname(version = 4)
#' aal_fname(version = 5)
#' aal_fname(version = "4")
#' aal_fname(version = "5")
#'
#' v4_img = aal_image(version = 4)
#' v5_img = aal_image()
#'
aal_fname = function(version = c("5", "4")) {
  version = as.character(version)
  version = match.arg(version)
  fname = paste0("ROI_MNI_V", version, ".nii.gz")
  fname = system.file("extdata", fname, package = "aal")
  stopifnot(file.exists(fname))
  fname
}

#' @export
#' @rdname aal_fname
#' @importFrom neurobase readnii
aal_image = function(version = c("5", "4")) {
  fname = aal_fname(version = version)
  stopifnot(file.exists(fname))
  img = neurobase::readnii(fname)
  img
}
