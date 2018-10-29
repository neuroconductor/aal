library(readr)
library(dplyr)
lut = readr::read_csv("data-raw/LUT.csv")

aal_lut = lut %>%
  rename(index = Index)

aal_lut$color = rgb(red = aal_lut$Red, green = aal_lut$Green,
    blue = aal_lut$Blue, maxColorValue = 255)
aal_colors = aal_lut %>%
  filter(index > 0) %>%
  select(color) %>%
  unlist()
names(aal_colors) = NULL
usethis::use_data(aal_colors, compress = "xz", overwrite = TRUE)

aal_colours = aal_colors
usethis::use_data(aal_colours, compress = "xz", overwrite = TRUE)

