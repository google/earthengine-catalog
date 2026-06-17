{
description: |||
  The Global Ocean Colour (Copernicus-GlobColour) dataset is a Bio-Geo-Chemical
  (BGC) product developed by ACRI-ST. Derived from multiple satellite sources
  like SeaWiFS, MODIS, and OLCI. It provides a comprehensive range of
  oceanographic variables, including: Chlorophyll (CHL),
  Phytoplankton Functional types and sizes (PFT), Primary Production (PP),
  Suspended Matter (SPM), Secchi Transparency Depth (ZSD),
  Diffuse Attenuation (KD490), Particulate Backscattering (BBP),
  Absorption Coefficient (CDM), Reflectance (RRS) and more.

|||,
optics_multi_description: |||
  Optics multi-sensor, 4km, monthly dataset provides Level 4 Bio-Geo-Chemical
  (BGC) data. Derived from multiple satellite observations, this product has a
  global spatial resolution of 4 km and a temporal resolution of one month.
|||,
primary_production_multi_description: |||
  This dataset provides a global estimate of marine primary production.
  It uses multi-sensor satellite data to measure the rate of carbon fixation by
  phytoplankton, which is a key indicator of ocean health.
  The primary production values are expressed in units of mg/m^2/day, making
  it a valuable tool for monitoring global carbon cycles and marine ecosystem
  dynamics.
|||,
reflectance_multi_description: |||
  This dataset provides a global record of marine remote sensing reflectance.
  This L4 product integrates data from multiple satellite sensors to provide a
  consistent and high-quality dataset with a 4 km spatial resolution. The marine
  reflectance data, which measures the light leaving the ocean surface at
  various wavelengths, is a fundamental ocean color parameter used to derive
  other biogeochemical properties like chlorophyll-a concentration and total
  suspended matter.
|||,
reflectance_olci_description: |||
  This dataset is a global product from the Copernicus Marine Service (CMEMS).
  It provides Remote-Sensing Reflectance (Rrs), a fundamental optical property
  of the water that represents the light leaving the ocean surface.
  Derived from the Ocean and Land Colour Instrument (OLCI), this L4 dataset is
  processed into a ready-to-use format. With an exceptionally high spatial
  resolution of 300 meters, this dataset is particularly valuable for detailed
  coastal and regional studies of water quality and marine constituents.
|||,
transparency_olci_description: |||
  This dataset provides global-scale data on ocean transparency.
  Its primary layer is the Diffuse Attenuation Coefficient at 490nm (KD490)),
  a key indicator of water clarity. Higher KD490values signify lower
  transparency due to the rapid absorption of blue-green light by constituents
  like phytoplankton or sediments. This L4 dataset, derived from the Ocean and
  Land Colour Instrument (OLCI), is a valuable resource for monitoring marine
  bio-geochemical processes and assessing water quality.
|||,
transparency_multi_description: |||
  This dataset is a global product from the Copernicus Marine Service that
  provides key information on ocean transparency. It's a gap-free multi-sensor
  dataset that includes two primary layers: KD490, which measures light
  absorption, and ZSD, a traditional measure of water clarity.
  This comprehensive, daily product is vital for monitoring marine ecosystems,
  water quality, and light availability.
|||,
plankton_multi_description: |||
  This dataset provides key bio-geochemical information about ocean plankton.
  This L4 dataset is unique for its "gap-free" nature, meaning it uses a
  space-time interpolation to fill in data gaps caused by clouds or other
  obstructions, providing a complete daily image.
  It is derived from multiple satellite sensors, including SeaWiFS, MODIS, and
  OLCI. The primary layer is chlorophyll-a concentration (CHL), which serves as
  a proxy for the biomass of phytoplankton, a crucial component of the marine
  food web. The dataset is used to monitor phytoplankton blooms, assess ocean
  productivity, and study marine ecosystems.
|||,
plankton_olci_description: |||
  This dataset is a global product from the Copernicus Marine Service (CMEMS)
  focused on ocean plankton. This dataset is derived specifically from the
  Ocean and Land Colour Instrument (OLCI) on the Sentinel-3 satellites and
  provides a very high spatial resolution of 300 meters, making it ideal for
  coastal and regional-scale analysis.The primary layer is chlorophyll-a
  concentration (CHL), which serves as a proxy for the biomass of phytoplankton,
  a crucial component of the marine food web.
|||,
documentation: |||

   Documentation:

    * [User's Guide](https://documentation.marine.copernicus.eu/PUM/CMEMS-OC-PUM.pdf)

    * [Quality Information Document](https://documentation.marine.copernicus.eu/QUID/CMEMS-OC-QUID-009-101to104-111-113-116-118.pdf)

    * [Copernicus Marine Datastore](https://data.marine.copernicus.eu/products)

   NOTE: The provider may remove Copernicus Marine data (especially Near
    Real-Time, NRT, observations) from their repository after some time,
    possibly aggregating that data into different (e.g., monthly) products.
    However, the corresponding assets remain available in the Earth Engine
    collection.

|||,
citation: |||
  Copernicus Global Ocean Colour:  Global Ocean Satellite Observations,
  ACRI-ST company (Sophia Antipolis, France) is providing Bio-Geo-Chemical
  (BGC) products based on the Copernicus-GlobColour processor.
  [doi:10.48670/moi-00279](https://doi.org/10.48670/moi-00279)
|||,
term_of_use: |||
  This dataset is released for use under Service Level Agreement (SLA),
  using the acronym "CMEMS" or the shortened name "Copernicus Marine Service"
  both denote the E.U. Copernicus Marine Environment Monitoring Service.
  Highlights and key features of the licence are provided in this document
  [License](https://marine.copernicus.eu/user-corner/service-commitments-and-licence)
|||,
}
