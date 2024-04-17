docker build / -f dockerfiles\r-ver_4.3.1.Dockerfile --progress=plain -t gcps_r-ver_4.3.1

docker run --name gcpsbase -it gcps_r-ver_4.3.1:latest


install.packages("pak")
pak::pkg_install("remotes")
remotes::install_github("https://github.com/LDSamson/iopqualr.git")
pak::pkg_install("rmarkdown")
rmarkdown::render("/rocker_scripts/rmarkdown/simplereport.Rmd", output_format = "html_document")


# installing basic version, without rocker 'verse', but with latex support:
docker build -f custom.Dockerfile --progress=plain -t r_base_4.3.1 .
docker run --name r_base -it r_base_4.3.1

Sys.setenv(LC_COLLATE = "C", LC_TIME = "C", LANGUAGE = "en")
local({oldwd <- getwd(); on.exit(setwd(oldwd)); setwd("/custom_scripts/R-IQ-OQ/"); Sweave("R-IQ-OQ.Rnw")})

cd /custom_scripts/R-IQ-OQ/
pdflatex R-IQ-OQ.tex


