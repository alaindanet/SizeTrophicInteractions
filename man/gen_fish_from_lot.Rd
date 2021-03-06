% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/building_dataset.R
\name{gen_fish_from_lot}
\alias{gen_fish_from_lot}
\title{Generate fish from fishing lot (AFB)}
\usage{
gen_fish_from_lot(
  id = NULL,
  type = NULL,
  min_size = NULL,
  max_size = NULL,
  nb = NULL,
  ind_measure = NULL,
  ind_id = NULL,
  ind_size = NULL,
  ...
)
}
\arguments{
\item{id}{int id of the lot}

\item{type}{character type of the lot (N, G, S/L, I)}

\item{min_size}{dbl minimum size of the lot}

\item{max_size}{dbl maximum size of the lot}

\item{nb}{int effectif of the lot}

\item{ind_measure}{data.frame individual measurement of the fish}

\item{ind_id}{variable name id of the lot in ind_measure}

\item{ind_size}{variable name for the size in ind_measure}
}
\description{
Generate fish from fishing lot (AFB)
}
\details{
From fishing lot, we build generate the fish size individual
}
