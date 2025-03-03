local id = 'NASA/HLS/HLSS30/v002';
local subdir = 'NASA';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';
local units = import 'units.libsonnet';
local hls = import 'NASA_HLS_v2.libsonnet';

local license = spdx.proprietary;

local basename = std.strReplace(id, '/', '_');
local base_filename = basename + '.json';
local self_ee_catalog_url = ee_const.ee_catalog_url + basename;

{
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.collection,
  stac_extensions: [
    ee_const.ext_sci,
    ee_const.ext_ver,
  ],
  id: id,
  title: 'HLSS30: HLS Sentinel-2 Multi-spectral Instrument Surface Reflectance Daily Global 30m',
  version: hls.version,
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    The Harmonized Landsat Sentinel-2 (HLS) project provides consistent surface
    reflectance data from the Operational Land Imager (OLI) aboard the joint
    NASA/USGS Landsat 8 satellite and the Multi-Spectral Instrument (MSI) aboard
    Europe's Copernicus Sentinel-2A satellites. The combined
    measurement enables global observations of the land every 2-3 days at
    30-meter (m) spatial resolution.
  ||| + hls.common_description + |||

    * [General Documentation](https://lpdaac.usgs.gov/products/hlss30v002/)
    * L30 catalog link: [NASA/HLS/HLSL30/v002](NASA_HLS_HLSL30_v002)

    Note: The historical assets are currently being ingested and this process
    is expected to finish in 2025.
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    {
      rel: ee_const.rel.cite_as,
      href: 'https://doi.org/10.5067/HLS/HLSS30.002',
    },
  ],
  'gee:categories': ['satellite-imagery'],
  keywords: hls.keywords,
  providers: [
    ee.producer_provider('NASA LP DAAC', 'https://lpdaac.usgs.gov/products/hlss30v002/'),
    ee.host_provider(self_ee_catalog_url),
  ],
  'gee:provider_ids': [
    'C2021957295-LPCLOUD',
  ],
  extent: ee.extent_global('2015-11-28T00:00:00Z', null),
  summaries: {
    gsd: hls.gsd,
    instruments: hls.instruments,
    'gee:schema': [
      {
        name: 'PRODUCT_URI',
        description: |||
          The input L1C granule URI, for processing backtracing.
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'MGRS_TILE_ID',
        description: |||
          The MGRS tile identifier that corresponds to the spatial grid 
          of the observation.
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'SENSING_TIME',
        description: |||
          The timestamp of when the observation was acquired.
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'ADD_OFFSET',
        description: |||
          Value added to the spectral data before they are scaled to int16
          reflectance data.
        |||,
        type: ee_const.var_type.double,
      },
      {
        name: 'REF_SCALE_FACTOR',
        description: |||
          Multiplier to be applied to the int16 reflectance data to get the
          unscaled reflectance.
        |||,
        type: ee_const.var_type.double,
      },
      {
        name: 'ANG_SCALE_FACTOR',
        description: |||
          Multiplier to be applied to the uint16 angle bands to get the angle
          in degrees.
        |||,
        type: ee_const.var_type.double,
      },
      {
        name: 'MSI_BAND_01_BANDPASS_ADJUSTMENT_SLOPE',
        description: |||
          The slope applied to the Sentinel-2 B01 reflectance in the
          linear bandpass adjustment.
        |||,
        type: ee_const.var_type.double,
      },
      {
        name: 'MSI_BAND_01_BANDPASS_ADJUSTMENT_OFFSET',
        description: |||
          The offset applied to the Sentinel-2 B01 reflectance in the
          linear bandpass adjustment.
        |||,
        type: ee_const.var_type.double,
      },
      {
        name: 'MSI_BAND_02_BANDPASS_ADJUSTMENT_SLOPE',
        description: |||
          The slope applied to the Sentinel-2 B02 reflectance in the
          linear bandpass adjustment.
        |||,
        type: ee_const.var_type.double,
      },
            {
        name: 'MSI_BAND_02_BANDPASS_ADJUSTMENT_OFFSET',
        description: |||
          The offset applied to the Sentinel-2 B02 reflectance in the
          linear bandpass adjustment.
        |||,
        type: ee_const.var_type.double,
      },
      {
        name: 'MSI_BAND_03_BANDPASS_ADJUSTMENT_SLOPE',
        description: |||
          The slope applied to the Sentinel-2 B03 reflectance in the
          linear bandpass adjustment.
        |||,
        type: ee_const.var_type.double,
      },
      {
        name: 'MSI_BAND_03_BANDPASS_ADJUSTMENT_OFFSET',
        description: |||
          The offset applied to the Sentinel-2 B03 reflectance in the
          linear bandpass adjustment.
        |||,
        type: ee_const.var_type.double,
      },
      {
        name: 'MSI_BAND_04_BANDPASS_ADJUSTMENT_SLOPE',
        description: |||
          The slope applied to the Sentinel-2 B04 reflectance in the
          linear bandpass adjustment.
        |||,
        type: ee_const.var_type.double,
      },
      {
        name: 'MSI_BAND_04_BANDPASS_ADJUSTMENT_OFFSET',
        description: |||
          The offset applied to the Sentinel-2 B04 reflectance in the
          linear bandpass adjustment.
        |||,
        type: ee_const.var_type.double,
      },
      {
        name: 'MSI_BAND_11_BANDPASS_ADJUSTMENT_SLOPE',
        description: |||
          The slope applied to the Sentinel-2 B11 reflectance in the
          linear bandpass adjustment.
        |||,
        type: ee_const.var_type.double,
      },
      {
        name: 'MSI_BAND_11_BANDPASS_ADJUSTMENT_OFFSET',
        description: |||
          The offset applied to the Sentinel-2 B11 reflectance in the
          linear bandpass adjustment.
        |||,
        type: ee_const.var_type.double,
      },
      {
        name: 'MSI_BAND_12_BANDPASS_ADJUSTMENT_SLOPE',
        description: |||
          The slope applied to the Sentinel-2 B12 reflectance in the
          linear bandpass adjustment.
        |||,
        type: ee_const.var_type.double,
      },
      {
        name: 'MSI_BAND_12_BANDPASS_ADJUSTMENT_OFFSET',
        description: |||
          The offset applied to the Sentinel-2 B12 reflectance in the
          linear bandpass adjustment.
        |||,
        type: ee_const.var_type.double,
      },
      {
        name: 'MSI_BAND_8A_BANDPASS_ADJUSTMENT_SLOPE',
        description: |||
          The slope applied to the Sentinel-2 B08A reflectance in the
          linear bandpass adjustment.
        |||,
        type: ee_const.var_type.double,
      },
      {
        name: 'AROP_AVE_XSHIFT',
        description: |||
          AROP-derived average coordinate shift in X direction relative to the
          reference image. Populated only for Sentinel-2 L1C data prior to
          processing baseline 2.04.
        |||,
        type: ee_const.var_type.double,
      },
      {
        name: 'AROP_AVE_YSHIFT',
        description: |||
          AROP-derived average coordinate shift in Y direction relative to the
          reference image. Populated only for Sentinel-2 L1C data prior to
          processing baseline 2.04.
        |||,
        type: ee_const.var_type.double,
      },
      {
        name: 'AROP_NCP',
        description: |||
          Number of control points identified by AROP. Populated only for
          Sentinel-2 L1C data prior to processing baseline 2.04.
        |||,
        type: ee_const.var_type.double,
      },
      {
        name: 'AROP_RMSE',
        description: |||
          Root mean squared error in AROP model fitting. Populated only for
          Sentinel-2 L1C data prior to processing baseline 2.04
        |||,
        type: ee_const.var_type.double,
      },
      {
        name: 'AROP_S2_REFIMG',
        description: |||
          Geolocation reference image name. Populated only for Sentinel-2 L1C
          data prior to processing baseline 2.04.
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'ACCODE',
        description: |||
          The version of LaSRC used by HLS for S30.
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'PROCESSING_BASELINE',
        description: |||
          List of baseline versions of processing applied to the product.
        |||,
        type: ee_const.var_type.string_list,
      },
    ] + hls.common_properties,
    'eo:bands': hls.rgb_bands + [
      {
        name: 'B5',
        description: 'Red-Edge 1',
      },
      {
        name: 'B6',
        description: 'Red-Edge 2',
      },
      {
        name: 'B7',
        description: 'Red-Edge 3',
      },
      {
        name: 'B8',
        description: 'NIR Broad',
      },
      {
        name: 'B8A',
        description: 'NIR Narrow',
      },
      {
        name: 'B9',
        description: 'Water vapor',
      },
      {
        name: 'B10',
        description: 'Cirrus',
      },
      {
        name: 'B11',
        description: 'SWIR 1',
      },
      {
        name: 'B12',
        description: 'SWIR 2',
      },
    ] + hls.qa_bands,
    'gee:visualizations': [
      {
        display_name: 'HLS S30 RGB bands',
        lookat: {
          lat: 29.19,
          lon: -109.53,
          zoom: 12,
        },
        image_visualization: {
          band_vis: {
            min: [
              0.01,
            ],
            max: [
              0.18,
            ],
            bands: ['B4', 'B3', 'B2'],
          },
        },
      },
    ],
  },
  'sci:citation': hls.citation,
  'gee:terms_of_use': hls.terms_of_use,
}
