library(rvest)
library(xml2)
library(RNifti)
library(neurobase)
library(dplyr)

# v4_url = "http://www.gin.cnrs.fr/wp-content/uploads/aal_for_SPM12.zip"
# destfile = tempfile(fileext = ".zip")
# res = download.file(url = v4_url, destfile = destfile)
# stopifnot(res == 0)
#
# exdir = tempfile()
# dir.create(exdir, showWarnings = FALSE)
# files = unzip(destfile, exdir = exdir)


# v5_url = "http://www.gin.cnrs.fr/wp-content/uploads/aal2_for_SPM12.tar.gz"
# destfile = tempfile(fileext = ".tar.gz")
# res = download.file(url = v5_url, destfile = destfile)
# stopifnot(res == 0)
#
# exdir = tempfile()
# dir.create(exdir, showWarnings = FALSE)
# files = untar(destfile, exdir = exdir, list = TRUE)
# files = file.path(exdir, files)
# res = untar(destfile, exdir = exdir)
# stopifnot(res == 0)

get_data = function(a_xml) {
  if (is.character(a_xml)) {
    if (file.exists(a_xml)) {
      a_xml = read_xml(a_xml)
    } else {
      stop(paste0(
        "File doesn't exist, probably deleted - re download from ",
        "http://www.gin.cnrs.fr/en/tools/aal-aal2/"))
    }
  }
  a_xml = a_xml %>%
    as_list()
  a_xml = a_xml$atlas
  at_version = attr(a_xml, "version")
  hdr = a_xml$header
  a_xml = a_xml$data
  nm = names(a_xml)
  stopifnot(all(nm == "label"))
  df = t(sapply(a_xml, unlist))
  df = as.data.frame(df, stringsAsFactors = FALSE)
  df$index = as.numeric(df$index)
  rownames(df) = NULL
  df$version = hdr$version[[1]]
  df$coordinate_system = hdr$coordinate_system[[1]]
  df$at_version = at_version

  return(df)
}

a_file = "data-raw/AAL.xml"
r_file = "data-raw/ROI_MNI_V4.xml"

rimg = readnii("inst/extdata/ROI_MNI_V4.nii.gz")

a_fname = "inst/extdata/AAL.nii.gz"
if (file.exists(a_fname)) {
  aimg = readnii(a_fname)
  stopifnot(isTRUE(all.equal(aimg, rimg)))
}

a_xml = read_xml(a_file)
r_xml = read_xml(r_file)

a_data = get_data(a_xml)
r_data = get_data(r_xml)
stopifnot(isTRUE(all.equal(a_data, r_data)))

r_vals = mask_vals(rimg, rimg != 0)
stopifnot(all(r_vals %in% r_data$index))

v4 = a_data %>%
  select(index, name) %>%
  mutate(name = sub("Cerebelum", "Cerebellum", name),
         name = sub("Cingulum", "Cingulate", name),
         name = sub("Frontal_Sup_2", "Frontal_Sup", name),
         name = sub("Frontal_Mid_2", "Frontal_Mid", name),
         name = sub("Frontal_Inf_Orb_2", "Frontal_Inf_Orb", name)
  )
v4_img = rimg




########################################3
# V5 data
########################################
a_file = "data-raw/AAL2.xml"
r_file = "data-raw/ROI_MNI_V5.xml"



rimg = readnii("inst/extdata/ROI_MNI_V5.nii.gz")
rimg2 = readNifti("inst/extdata/ROI_MNI_V5.nii.gz")

a_fname = "inst/extdata/AAL2.nii.gz"
if (file.exists(a_fname)) {

  aimg = readnii(a_fname)
  aimg2 = readNifti(a_fname)

  alt = readnii("inst/extdata/aal2.nii.gz")
  alt2 = readNifti("inst/extdata/aal2.nii.gz")

  stopifnot(all.equal(as.array(aimg2), as.array(rimg2)))
  stopifnot(all.equal(as.array(alt2), as.array(rimg2)))
  tab = table(c(aimg), c(rimg))
  # labeled differently
  stopifnot(isTRUE(all.equal(sum(tab), sum(diag(tab)))))

  tab = table(c(aimg), c(rimg))
}


a_xml = read_xml(a_file)
r_xml = read_xml(r_file)

a_data = get_data(a_xml)
r_data = get_data(r_xml)
stopifnot(isTRUE(all.equal(a_data, r_data)))

r_vals = mask_vals(rimg, rimg != 0)
stopifnot(all(r_vals %in% r_data$index))


v5 = a_data %>%
  select(index, name) %>%
  mutate(name = sub("Cerebelum", "Cerebellum", name),
         name = sub("Cingulum", "Cingulate", name),
         name = sub("Frontal_Sup_2", "Frontal_Sup", name),
         name = sub("Frontal_Mid_2", "Frontal_Mid", name),
         name = sub("Frontal_Inf_Orb_2", "Frontal_Inf_Orb", name)
  )
v5_img = rimg


aal_labels = list(v4 = v4,
                  v5 = v5)
usethis::use_data(aal_labels, compress = "xz",
                  overwrite = TRUE)
