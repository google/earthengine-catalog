local id = 'projects/geoscience-aus-cat/assets/ga_s2ls_intertidal_cyear_3';
local subdir = 'geoscience-aus-cat';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';
local units = import 'units.libsonnet';

local license = spdx.cc_by_4_0;

local version = '1.0.0';

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
    ee_const.ext_ver,
  ],
  id: id,
  version: version,
  title: 'Geoscience Australia Sentinel-2 Landsat Intertidal Calendar Year Collection 3' + version,
  'gee:type': ee_const.gee_type.image,
  description: |||
    The DEA Intertidal product suite maps the changing elevation, exposure and tidal characteristics of Australia's exposed intertidal zone, the complex zone that defines the interface between land and sea. Incorporating both Sentinel-2 and Landsat data, the product suite provides an annual 
    10 m resolution elevation product for the intertidal zone, enabling users to better monitor and understand some of the most dynamic regions of Australia's coastlines. Utilising novel tidal modelling capabilities, the product suite includes a continental scale mapping of intertidal exposure 
    over time, enabling scientists and managers to integrate the data into ecological and migratory species applications and modelling.

    For more information, please see the
    [DEA Intertidal](https://knowledge.dea.ga.gov.au/data/product/dea-intertidal/)

    This product is part of the [Digital Earth Australia Program](https://www.ga.gov.au/scientific-topics/dea)
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    ee.link.license(license.reference),
    {
      rel: ee_const.rel.cite_as,
      href: 'https://doi.org/10.1016/j.ecss.2019.03.006',
      type: ee_const.media_type.html,
    },
    {
      rel: ee_const.rel.source,
      href: 'https://data.dea.ga.gov.au/?prefix=derivative/ga_s2ls_intertidal_cyear_3/1-0-0/',
    },
  ],
  keywords: [
    'australia',
    'ga',
    'dem',
    // 'landsat_sentinel2_derived'
    // 'intertidal',
    // 'elevation',
    // 'elevation_uncertainty',
    // 'exposure',
  ],
  providers: [
    ee.producer_provider(
      'Geoscience Australia',
      'https://knowledge.dea.ga.gov.au/data/product/dea-intertidal/'),
    ee.processor_provider('NGIS', 'https://ngis.com.au/'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent(
    108.81, -44.41, 157.82, -9.13,
    '2016-01-01T00:00:00Z', '2022-12-31T23:59:59Z'),
  summaries: {
    gsd: [10],
    'eo:bands': [
      {
        name: 'elevation',
        description: |||
          DEA Intertidal Elevation provides elevation in metre units relative to modelled Mean Sea Level for each pixel of the satellite-observed exposed intertidal zone across the Australian coastline. The elevation model is generated from DEA Landsat and Sentinel-2 surface reflectance data from each 3-year composite period, utilising a pixel-based approach based on ensemble tidal modelling. For every pixel, the time series of surface reflectance data is converted to the Normalised Difference Water Index (NDWI) and each observation tagged with the tidal height modelled at the time of acquisition by the satellite. A rolling median is applied from low to high tide to reduce noise (such as white water, sunglint, and non-tidal water level variability), then analysed to identify the tide height at which the pixel transitions from dry to wet. This tide height represents the elevation of the pixel.
          [Band details](https://knowledge.dea.ga.gov.au/data/product/dea-intertidal/?tab=details#core-product-layers)
        |||,
        'gee:units': units.meter,
      },
      {
        name: 'elevation_uncertainty',
        description: |||
          DEA Intertidal Elevation Uncertainty provides a measure of the quality of each modelled elevation value in metre units. Uncertainty is calculated by assessing how cleanly the modelled elevation separates satellite observations into dry and wet observations. This is achieved by identifying satellite observations that were misclassified by the modelled elevation (for instance, pixels that were observed as wet at tide heights lower than the modelled elevation, or alternately, observed as dry at higher tide heights). The spread of tide heights from these misclassified observations is summarised using a robust Median Absolute Deviation (MAD) statistic, and reported as 0.5 x MAD to represent one-sided uncertainty bounds 
          (i.e. ± uncertainty on either side of the pixel's elevation). Common causes of high elevation uncertainty can be poor tidal model performance, rapidly changing intertida morphology, or noisy underlying satellite data.
          [Band details](https://knowledge.dea.ga.gov.au/data/product/dea-intertidal/?tab=details#core-product-layers)
        |||,
        'gee:units': units.meter,
      },
      {
        name: 'exposure',
        description: |||
          DEA Intertidal Exposure models the percentage of time that any intertidal pixel of known elevation is exposed from tidal inundation. Exposure is calculated by comparing the pixel elevation back against a high temporal resolution model of tide heights for that location, based on the Ensemble Tidal Modelling approach. Exposure percentage is calculated as the fraction of exposed observations relative to the total number of observations generated in the high temporal resolution tidal model for the 3-year product epoch.
          [Band details](https://knowledge.dea.ga.gov.au/data/product/dea-intertidal/?tab=details#core-product-layers)
        |||,
        'gee:units': units.meter,
      },
    ],
    elevation: {minimum: -5, maximum: 5, 'gee:estimated_range': true},
    elevation_uncertainty: {minimum: 0, maximum: 1.0, 'gee:estimated_range': true},
    exposure: {
      minimum: 0, maximum: 100, 'gee:estimated_range': false},
    'gee:visualizations': [
      {
        display_name: 'DEA Intertidal',
        lookat: {lon: 133.88, lat: -23.70, zoom: 5},
        image_visualization: {
          band_vis: {
            min: [-5.0],
            max: [3.9],
            palette: [
              '440154', '471365', '482475', '463480', '414487', '3b528b',
              '355f8d', '2f6c8e', '2a788e', '25848e', '21918c', '1e9c89',
              '22a884', '2fb47c', '44bf70', '5ec962', '7ad151', '9bd93c',
              'bddf26', 'dfe318', 'fde725',
            ],
            bands: ['elevation']}},
      },
    ],
  },
  'sci:doi': '10.1016/j.ecss.2019.03.006',
  'sci:citation': |||
    Bishop-Taylor, R., Sagar, S., Lymburner, L., & Beaman, R. J. (2019).
    Between the tides: Modelling the elevation of Australia's exposed intertidal
    zone at continental scale.  Estuarine, Coastal and Shelf Science, 223,
    115-128.
    [doi:10.1016/j.ecss.2019.03.006](https://doi.org/10.1016/j.ecss.2019.03.006)
  |||,
  'gee:terms_of_use': ee.gee_terms_of_use(license),
}
