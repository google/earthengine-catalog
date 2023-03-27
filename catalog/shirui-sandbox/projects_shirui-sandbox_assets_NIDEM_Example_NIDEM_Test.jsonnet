local id = 'projects/shirui-sandbox/assets/NIDEM_Example/NIDEM_Test';
local subdir = 'shirui-sandbox';

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
    The National Intertidal Digital Elevation Model (NIDEM) is a continental-scale elevation dataset for Australia exposed intertidal zone.
    This product provides the first three-dimensional representation of Australia intertidal sandy beaches and shores, 
    tidal flats and rocky shores and reefs at 25 m spatial resolution, addressing a key gap between the availability of sub-tidal bathymetry and terrestrial elevation data.
    Intertidal environments support important ecological habitats (e.g. sandy beaches and shores, tidal flats and rocky shores and reefs), 
    and provide many valuable benefits such as storm surge protection, carbon storage and natural resources for recreational and commercial use.
    Intertidal zones are faced with increasing threats from coastal erosion, land reclamation (e.g. port construction), and sea level rise. 
    Accurate elevation data describing the height and shape of the coastline is needed to help predict when and where these threats will have the greatest impact. 
    However, this data is expensive and challenging to map across the entire intertidal zone of a continent the size of Australia.
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id),
  keywords: [
    'australia',
    'dea',
    'dea_australia',
    'dem',
    'nidem',
  ],
  providers: [
    ee.producer_provider('Digital Earth Australia', 'https://cmi.ga.gov.au/data-products/dea/325/dea-intertidal-elevation-landsat#basics'),
    ee.host_provider(self_ee_catalog_url),
  ],
  // Spatial and temporal extent.
  // Where and where does the dataset cover?  Date/times are UTC using "Z" for
  // the timezone.  They must be YYYY-MM-DDTHH:MM:SSZ.
  // The end time may be None for on going datasets.
  // Global extents should use ee.extent_global.
  // extent: ee.extent_global('2006-01-24T00:00:00Z', '2011-05-13T00:00:00Z'),
  // Alternatively, local extents use:
  // extent: ee.extent(-171.0, -15.0, 164.0, 70.0, '2012-02-07T00:00:00Z', None),
  // NIDEM: the extend is for full dataset,
  // https://cmi.ga.gov.au/print/pdf/node/325
  // https://epsg.io/3577
  extent: ee.extent(93.41, -60.55, 173.34, -8.47, '1986-08-16T00:00:00Z', '2017-07-31T23:59:59Z'),

  // TODO(schwehr): Describe optional fields
  // 'gee:provider_ids'

  // Summaries contain additional information specific to the dataset type.
  summaries: {
    // Describes values set on each image.
    // TODO(schwehr): Describe difference between scheam and properties???
    'gee:schema': [
      {
        name: 'dea_intertidal_elevation_landsat',
        description: |||
          The National Intertidal Digital Elevation Model (NIDEM) is a continental-scale elevation dataset for Australia exposed intertidal zone.
          This product provides the first three-dimensional representation of Australia intertidal sandy beaches and shores, 
          tidal flats and rocky shores and reefs at 25 m spatial resolution, addressing a key gap between the availability of sub-tidal bathymetry and terrestrial elevation data.
          Intertidal environments support important ecological habitats (e.g. sandy beaches and shores, tidal flats and rocky shores and reefs), 
          and provide many valuable benefits such as storm surge protection, carbon storage and natural resources for recreational and commercial use.
          Intertidal zones are faced with increasing threats from coastal erosion, land reclamation (e.g. port construction), and sea level rise. 
          Accurate elevation data describing the height and shape of the coastline is needed to help predict when and where these threats will have the greatest impact. 
          However, this data is expensive and challenging to map across the entire intertidal zone of a continent the size of Australia.
        |||,

        type: ee_const.var_type.double,  // See var_type for the possibilities
      },
    ],
    platform: [
      'DEA',
    ],
    instruments: [
      'DEA NIDEM',
    ],
    // Describe all of the bands in the order they appear in an ee.Image.
    'eo:bands': [
      {
        name: 'elevation',
        description: 'Elevation',
        'gee:units': units.meters,
        // center_wavelength: 0.49,  // in nm
        gsd: 25.0,  // ground separation distance in meters
        // 'gee:wavelength': '0.520-0.600&mu;m',
      },
    ],

    // Optional band statistics - one entry per band.
    // If the exact statistics are known, then set gee:estimated_range to true
    elevation: {minimum: -3.0, maximum: 3.0, 'gee:estimated_range': true},

    // 1 or more band visualizations
    'gee:visualizations': [
      // TODO(schwehr): Example visualization with 1 band.
      // Example with 3 bands, but only 1 value for min and max.
      {
        display_name: 'Elevation',
        // Do not use too many significant digits.
        // Try to avoid zoom levels of 0-4 for datasets with many assets as that
        // can be hard on the system.
        lookat: {lat: -18.06, lon: 122.16, zoom: 5},
        image_visualization: {
          band_vis: {
            min: [-3.0],  max: [3.0], bands: ['elevation']}},
      },
      // TODO(schwehr): Example with multiple bands and stats for all.
      // TODO(schwehr): Example with a palette
    ],
  },

  // The scientific extension.
  // The best doi that describes the *data*.
  // 'sci:doi': 'doi.org/10.1016/j.ecss.2019.03.006',
  // How to cite the data.
  'sci:citation': |||
    Bishop-Taylor, R., Sagar, S., Lymburner, L., & Beaman, R. J. (2019). 
    Between the tides: Modelling the elevation of Australias exposed intertidal zone at continental scale. 
    Estuarine, Coastal and Shelf Science, 223, 115 128. https://doi.org/10.1016/j.ecss.2019.03.006
  |||,

  // TODO(schwehr): Move to image collection.
  // Optional: If a dataset repeats, you can add an interval definition.
  // 'gee:interval': {
  //   type: 'revisit_interval',
  //   unit: 'day',
  //   interval: 16,
  //. },

  // For standard SPDX licenses, use:
  'gee:terms_of_use': ee.gee_terms_of_use(license),
  //'gee:terms_of_use': license.name + ': [' + license.id + '](' license.reference ')',
  // If there is a custom license (the license is set to spdx.proprietary, set
  // gee:terms_of_use to enough text that a reader has a sense of what they are
  // getting into.  Be sure to add a link to the license in this markdown text
  // and add the link to the license section with ee.link.license(url).
  // 'gee:terms_of_use': |||
  //   Put the custom license here.
  // |||,
}
