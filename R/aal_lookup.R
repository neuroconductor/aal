#' Lookup specific indices for labels
#'
#' @param xyz Indices in coordinates of the atlas to look up specific
#' @param version Version of AAL ROI image, versions 4 and 5.
#'
#' @return A \code{data.frame} with the results
#' @export
#'
#' @examples
#' aal_lookup(xyz = c(61, 60, 67))
#' aal_lookup(xyz = rbind(c(61, 60, 67),
#' c(50, 44, 32)
#' ))
aal_lookup = function(xyz, version = c("5", "4")) {
  if (is.matrix(xyz)) {
    stopifnot(ncol(xyz) == 3)
  } else {
    stopifnot(length(xyz) == 3)
    xyz = matrix(xyz, ncol = 3)
  }
  colnames(xyz) = c("dim1", "dim2", "dim3")
  atlas = aal_image(version = version)
  labs = aal_get_labels(version = version)

  atlas_df = cbind(xyz, index = atlas[xyz])
  atlas_df = data.frame(atlas_df, stringsAsFactors = FALSE)
  atlas_df = merge(atlas_df, labs, by = "index",
                   sort = FALSE, all.x = TRUE)
  rownames(atlas_df) = NULL
  return(atlas_df)
}
