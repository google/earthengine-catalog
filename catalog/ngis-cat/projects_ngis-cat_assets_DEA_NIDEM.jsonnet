local id = 'projects/ngis-cat/assets/DEA/NIDEM';
local subdir = 'ngis-cat';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';
local units = import 'units.libsonnet';

local license = spdx.cc_by_4_0;

local basename = std.strReplace(id, '/', '_');
local base_filename = basename + '.json';
local self_ee_catalog_url = ee_const.ee_catalog_url + basename;
local catalog_subdir_url = ee_const.catalog_base + subdir + '/';
local parent_url = catalog_subdir_url + 'catalog.json';
local self_url = catalog_subdir_url + base_filename;

{
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.collection,
  stac_extensions: [
    ee_const.ext_eo,
    ee_const.ext_sci,
  ],
  id: id,
  title: 'National Intertidal Digital Elevation Model 25m 1.0.0',
  'gee:type': ee_const.gee_type.image,
  
  description: |||
    The National Intertidal Digital Elevation Model (NIDEM; Bishop-Taylor et al. 2018, 2019) is a continental-scale elevation dataset for Australia's exposed intertidal zone. 
    NIDEM provides the first three-dimensional representation of Australia's intertidal sandy beaches and shores, tidal flats and rocky shores and reefs at 25 m spatial resolution, 
    addressing a key gap between the availability of sub-tidal bathymetry and terrestrial elevation data. NIDEM was generated by combining global tidal modelling 
    with a 30-year time series archive of spatially and spectrally calibrated Landsat satellite data managed within the Digital Earth Australia (DEA) platform. 
    NIDEM complements existing intertidal extent products, and provides data to support a new suite of use cases that require a more detailed understanding 
    of the three-dimensional topography of the intertidal zone, such as hydrodynamic modelling, coastal risk management and ecological habitat mapping.
    The product: https://cmi.ga.gov.au/data-products/dea/325/dea-intertidal-elevation-landsat#basics
    The definition of the four bands, including NIDEM, NIDEM_mask, NIDEM_uncertainty, and NIDEM_unfiltered please visit https://cmi.ga.gov.au/data-products/dea/325/dea-intertidal-elevation-landsat#details
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id),
  keywords: [
    'australia',
    'dea_australia',
    'dem',
    'nidem',
  ],
  providers: [
    ee.producer_provider('Digital Earth Australia', 'https://cmi.ga.gov.au/data-products/dea/325/dea-intertidal-elevation-landsat#basics'),
    ee.host_provider(self_ee_catalog_url),
  ],

  extent: ee.extent(108.81, -44.41, 157.82, -9.13, '1986-08-16T00:00:00Z', '2017-07-31T23:59:59Z'),

  // Summaries contain additional information specific to the dataset type.
  summaries: {

    'gee:schema': [
      {
        name: 'dea_national_intertidal_digital_elevation_model',
        description: |||
          The National Intertidal Digital Elevation Model (NIDEM; Bishop-Taylor et al. 2018, 2019) is a continental-scale elevation dataset for Australia's exposed intertidal zone. 
          NIDEM provides the first three-dimensional representation of Australia's intertidal sandy beaches and shores, tidal flats and rocky shores and reefs at 25 m spatial resolution, 
          addressing a key gap between the availability of sub-tidal bathymetry and terrestrial elevation data. NIDEM was generated by combining global tidal modelling 
          with a 30-year time series archive of spatially and spectrally calibrated Landsat satellite data managed within the Digital Earth Australia (DEA) platform. 
          NIDEM complements existing intertidal extent products, and provides data to support a new suite of use cases that require a more detailed understanding 
          of the three-dimensional topography of the intertidal zone, such as hydrodynamic modelling, coastal risk management and ecological habitat mapping.
          The product: https://cmi.ga.gov.au/data-products/dea/325/dea-intertidal-elevation-landsat#basics
          The definition of the four bands, including NIDEM, NIDEM_mask, NIDEM_uncertainty, and NIDEM_unfiltered please visit https://cmi.ga.gov.au/data-products/dea/325/dea-intertidal-elevation-landsat#details
        |||,

        type: ee_const.var_type.double,
      },
    ],
    platform: [
      'DEA',
    ],
    instruments: [
      'DEA NIDEM',
    ],
    gsd: [
      25.0,
    ],
    // Describe all of the bands in the order they appear in an ee.Image.
    'eo:bands': [
      {
        name: 'nidem',
        description: |||
          The NIDEM dataset provides elevation in metre units relative to modelled Mean Sea Level for each pixel of intertidal terrain across the Australian coastline.
          The DEMs have been cleaned by masking out non-intertidal pixels and pixels where tidal processes poorly explain patterns of inundation (see NIDEM_mask dataset).
          This is the primary output product, and is expected to be the default product for most applications.
          The dataset consists of 306 raster files corresponding to the 306 ITEM v2.0 tidal modelling polygons, and a continental-scale mosaic.
        |||,
        'gee:units': units.meters,
      },
      {
        name: 'nidem_mask',
        description: |||
          The NIDEM mask dataset flags non-intertidal terrestrial pixels with elevations greater than 25 m, and sub-tidal pixels with depths greater than -25 m relative to Mean Sea Level. 
          Pixels where tidal processes poorly explain patterns of inundation are also flagged by identifying any pixels with ITEM confidence NDWI standard deviation greater than 0.25. 
          The NIDEM mask was used to filter and clean the NIDEM dataset to remove modelling artefacts and noise (e.g. intertidal pixels in deep water or high elevations) and invalid 
          elevation estimates caused by coastal change or poor model performance. The dataset consists of 306 raster files corresponding to the 306 ITEM v2.0 tidal modelling polygons, 
          and a continental-scale mosaic.
        |||,
        'gee:units': units.meters,
      },
      {
        name: 'nidem_uncertainty',
        description: |||
          The NIDEM uncertainty dataset provides a measure of the uncertainty (not to be confused with accuracy) of NIDEM elevations in metre units for each pixel. 
          The range of Landsat observation tide heights used to compute median tide heights for each waterline contour can vary significantly between tidal modelling polygons. 
          To quantify this range, the standard deviation of tide heights for all Landsat images used to produce each ITEM interval and subsequent waterline contour was calculated. 
          These values were interpolated to return an estimate of uncertainty for each individual pixel in the NIDEM datasets: larger values indicate the waterline contour was based on 
          a composite of images with a larger range of tide heights. The dataset consists of 306 raster files corresponding to the 306 ITEM v2.0 tidal modelling polygons, 
          and a continental-scale mosaic.
        |||,
        'gee:units': units.meters,
      },
      {
        name: 'nidem_unfiltered',
        description: |||
          The unfiltered NIDEM dataset provides un-cleaned elevation in metre units relative to modelled Mean Sea Level for each pixel of intertidal terrain across the Australian coastline. 
          Compared to the default NIDEM product, these layers have not been filtered to remove noise, modelling artefacts or invalid elevation values (see NIDEM mask below). 
          This supports applying custom filtering methods to the raw NIDEM data. The dataset consists of 306 raster files corresponding to the 306 ITEM v2.0 tidal modelling polygons, 
          and a continental-scale mosaic.
        |||,
        'gee:units': units.meters,
      },
    ],

    nidem: {minimum: -5.0, maximum: 3.9, 'gee:estimated_range': true},

    // 1 or more band visualizations
    'gee:visualizations': [
      {
        display_name: 'nidem',
        lookat: {lat: -23.70, lon: 133.88, zoom: 5},
        image_visualization: {
          band_vis: {
            min: [-5.0],
            max: [3.9],
            palette: [
              '440154', 
              '471365', 
              '482475', 
              '463480', 
              '414487', 
              '3b528b', 
              '355f8d',
              '2f6c8e', 
              '2a788e', 
              '25848e', 
              '21918c', 
              '1e9c89', 
              '22a884', 
              '2fb47c',
              '44bf70', 
              '5ec962', 
              '7ad151', 
              '9bd93c', 
              'bddf26', 
              'dfe318', 
              'fde725',
            ],
             bands: ['nidem']}},
      },

    ],
  },

  // How to cite the data.
  'sci:citation': |||
    Bishop-Taylor, R., Sagar, S., Lymburner, L., & Beaman, R. J. (2019). 
    Between the tides: Modelling the elevation of Australias exposed intertidal zone at continental scale. 
    Estuarine, Coastal and Shelf Science, 223, 115 128. https://doi.org/10.1016/j.ecss.2019.03.006
  |||,

  // For standard SPDX licenses, use:
  'gee:terms_of_use': ee.gee_terms_of_use(license),
}