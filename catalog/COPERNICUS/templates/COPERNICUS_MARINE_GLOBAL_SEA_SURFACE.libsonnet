{
description: |||
   Multi Observation Global Ocean Sea Surface Salinity and Sea Surface Density
   is an oceanographic product that provides daily, global, and gap-free
   Level-4 (L4) analyses of Sea Surface Salinity (SSS) and Sea Surface Density
   (SSD) at a high resolution of 1/8 degree. This product is generated
   by blending observations from multiple satellite missions
   (like SMOS and SMAP) with in-situ measurements
   (such as those from Argo floats and TSGs) using a sophisticated
   multivariate optimal interpolation algorithm, thereby creating a long and
   consistent time series that includes both
   historical (reprocessed) data and near-real-time updates.
   By delivering these climate variables, the dataset is useful
   for monitoring the global water cycle, studying changes in ocean circulation
   driven by density variations, and serving as an input for climate
   modeling and ocean forecasting systems.

|||,
nrt_daily_description: |||
  This dataset provides the Near-Real-Time (NRT) version of the daily,
  global, Level-4 analysis for Sea Surface Salinity (SSS) and Sea Surface
  Density (SSD).
|||,
nrt_daily_v1_deprecation: |||

  This collection was ingested from Copernicus dataset version 202311, which
  stopped being updated in September 2026. Use the successor collection
  `COPERNICUS/MARINE/GLOBAL_SEA_SURFACE/NRT_DAILY_V2` instead.
|||,
nrt_daily_v2_description: |||

  This collection is ingested from Copernicus dataset version 202607, which
  uses an updated upstream SMOS Level-3 Sea Surface Salinity source
  (MULTIOBS_GLO_PHY_SSS_L3_MYNRT_015_014 instead of the CATDS repository).
  The change in upstream data can change pixel values compared to the
  previous dataset version, so it is published as a separate collection.
|||,
rep_daily_description: |||
  This dataset provides the Multi-Year Reprocessed version of the daily,
  global, Level-4 analysis for Sea Surface Salinity (SSS) and Sea Surface
  Density (SSD).
|||,
documentation: |||

   Documentation:

    * [User's Guide](https://documentation.marine.copernicus.eu/PUM/CMEMS-MOB-PUM-015-013.pdf)

    * [Quality Information Document](https://documentation.marine.copernicus.eu/QUID/CMEMS-MOB-QUID-015-013.pdf)

    * [Copernicus Marine Datastore](https://data.marine.copernicus.eu/products)

|||,
citation: |||
  Copernicus Multi Observation Global Ocean Sea Surface Salinity and Sea Surface
  Density: Global Ocean Satellite and In-Situ Observations, CNR (Rome, Italy) is
  providing daily Sea Surface Salinity and Sea Surface Density analyses.
  [doi:10.48670/moi-00051](https://doi.org/10.48670/moi-00051)
|||,
term_of_use: |||
  This dataset is released for use under Service Level Agreement (SLA),
  using the acronym "CMEMS" or the shortened name "Copernicus Marine Service"
  both denote the E.U. Copernicus Marine Environment Monitoring Service.
  Highlights and key features of the licence are provided in this document
  [License](https://marine.copernicus.eu/user-corner/service-commitments-and-licence)
|||,
}
