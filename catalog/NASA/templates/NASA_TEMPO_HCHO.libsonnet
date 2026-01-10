local subdir = 'NASA';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';
local units = import 'units.libsonnet';

local license = spdx.proprietary;

local self_ee_catalog_url(id) =
  ee_const.ee_catalog_url + std.strReplace(id, '/', '_');

{
  nasa_tempo_hcho_collection(cfg)::
    {
      stac_version: ee_const.stac_version,
      type: ee_const.stac_type.collection,
      stac_extensions: [
        ee_const.ext_sci,
        ee_const.ext_ver,
      ],
      id: cfg.id,
      title: 'TEMPO gridded HCHO' + cfg.qa_title +
             ' vertical columns V03',
      version: 'V03',
      'gee:type': ee_const.gee_type.image_collection,
      description: |||
        Formaldehyde Level 3 collection provides trace gas information on a
        regular grid covering the TEMPO field of regard for nominal TEMPO
        observations. Level 3 files are derived by combining information from
        all Level 2 files constituting a TEMPO East-West scan cycle. The
        rasters contain information on formaldehyde vertical columns,
        ancillary data used in air mass factor calculations and reference sector
        or de-striping corrections, and retrieval quality flags.
        The re-gridding algorithm uses an area-weighted approach.
      ||| + cfg.qa_description + cfg.qa_or_raw_link +
      |||
        * [General Documentation](https://asdc.larc.nasa.gov/documents/tempo/guide/TEMPO_Level-2-3_trace_gas_clouds_user_guide_V1.2.pdf)
      |||,
      license: license.id,
      links: ee.standardLinks(subdir, cfg.id) + [
        {
          rel: ee_const.rel.cite_as,
          href: 'https://doi.org/10.5067/IS-40e/TEMPO/HCHO_L3.003',
        },
      ],
      'gee:categories': ['satellite-imagery'],
      keywords: [
        'air_quality',
        'nasa',
        'formaldehyde',
        'pollution',
        'tropomi',
        'tempo',
      ],
      providers: (
        if cfg.qa_description == '' then
          [ee.producer_provider('NASA ASDC', 'https://asdc.larc.nasa.gov/')]
        else
          [
            ee.producer_provider(
              'QA Filtered: Google and NASA ASDC',
              'https://asdc.larc.nasa.gov/'
            ),
          ]
      ) + [
        ee.host_provider(self_ee_catalog_url(cfg.id)),
      ],
      'gee:provider_ids': [
        'C2930761273-LARC_CLOUD',
      ],
      extent: ee.extent_global('2023-08-01T00:00:00Z', null),
      summaries: {
        gsd: [
          2226,
        ],
        instruments: [
          'TEMPO',
        ],
        'eo:bands': [
          {
            name: 'weight',
            description: |||
              Sum of Level 2 pixel overlap areas. Represents the weighting
              factor for each grid cell, indicating the fraction of the grid
              cell area with valid data.
            |||,
            'gee:units': units.square_km,
          },
          {
            name: 'vertical_column',
            description: 'HCHO vertical column',
            'gee:units': units.molecules_per_cm2,
          },
          {
            name: 'vertical_column_uncertainty',
            description: |||
              HCHO vertical column uncertainty
            |||,
            'gee:units': units.molecules_per_cm2,
          },
          {
            name: 'main_data_quality_flag',
            description: if cfg.quality_flag_desc != ''
              then cfg.quality_flag_desc else
              |||
                Main data quality flag. Provides an overall assessment of the
                data quality
              |||,
            'gee:units': units.dimensionless,

            [if cfg.quality_flag_desc == '' then 'gee:classes']: [
              {
                value: 0,
                description: 'good',
              },
              {
                value: 1,
                description: 'suspect',
              },
              {
                value: 2,
                description: 'bad',
              },
            ],
          },
          {
            name: 'num_vertical_column_samples',
            description: 'Number of vertical column samples',
            'gee:units': units.dimensionless,
          },
          {
            name: 'min_vertical_column_sample',
            description: 'Smallest vertical column sample',
            'gee:units': units.molecules_per_cm2,
          },
          {
            name: 'max_vertical_column_sample',
            description: 'Largest vertical column sample',
            'gee:units': units.molecules_per_cm2,
          },
          {
            name: 'solar_zenith_angle',
            description:
              if cfg.solar_zenith_angle_desc != ''
              then cfg.solar_zenith_angle_desc
              else 'Solar zenith angle at pixel center',
            'gee:units': units.degree,
          },
          {
            name: 'viewing_zenith_angle',
            description: 'Viewing zenith angle at pixel center',
            'gee:units': units.degree,
          },
          {
            name: 'relative_azimuth_angle',
            description: 'Relative azimuth angle at pixel center',
            'gee:units': units.degree,
          },
          {
            name: 'surface_pressure',
            description: 'Surface pressure',
            'gee:units': units.hectopascal,
          },
          {
            name: 'terrain_height',
            description: 'Terrain height',
            'gee:units': units.meter,
          },
          {
            name: 'snow_ice_fraction',
            description: |||
              Fraction of pixel area covered by snow and/or ice
            |||,
            'gee:units': units.dimensionless,
          },
          {
            name: 'fitted_slant_column',
            description: 'HCHO fitted slant column',
            'gee:units': units.molecules_per_cm2,
          },
          {
            name: 'fitted_slant_column_uncertainty',
            description: 'HCHO fitted slant column uncertainty',
            'gee:units': units.molecules_per_cm2,
          },
          {
            name: 'albedo',
            description: 'Surface albedo',
            'gee:units': units.dimensionless,
          },
          {
            name: 'amf',
            description: 'HCHO air mass factor',
            'gee:units': units.dimensionless,
          },
          {
            name: 'eff_cloud_fraction',
            description:
              if cfg.effective_cloud_fraction_desc != ''
              then cfg.effective_cloud_fraction_desc
              else 'Effective cloud fraction',
            'gee:units': units.dimensionless,
          },
          {
            name: 'amf_cloud_fraction',
            description: |||
              Cloud radiance fraction for AMF calculation
            |||,
            'gee:units': units.dimensionless,
          },
          {
            name: 'amf_cloud_pressure',
            description: 'Cloud pressure for AMF calculation',
            'gee:units': units.hectopascal,
          },
        ],
        'gee:visualizations': [
          {
            display_name: 'HCHO',
            lookat: {
              lat: 35,
              lon: -95,
              zoom: 3,
            },
            image_visualization: {
              band_vis: {
                min: [0],
                max: [1.5e16],
                bands: ['vertical_column'],
                palette: [
                  '000080',
                  '0000D9',
                  '4000FF',
                  '8000FF',
                  '0080FF',
                  '00D9FF',
                  '80FFFF',
                  'FF8080',
                  'D90000',
                  '800000',
                ],
              },
            },
          },
        ],
      },
      'sci:citation': |||
        NASA/LARC/SD/ASDC. (n.d.). TEMPO gridded HCHO vertical columns V03
        (PROVISIONAL) [Data set]. NASA Langley
        Atmospheric Science Data Center DAAC.
        Retrieved from https://doi.org/10.5067/IS-40e/TEMPO/HCHO_L3.003
      |||,
      'gee:terms_of_use': |||
        This dataset is in the public domain and is available
        without restriction on use and distribution. See [NASA's
        Earth Science Data & Information Policy](https://www.earthdata.nasa.gov/engage/open-data-services-and-software/data-and-information-policy)
        for additional information.
      |||,
    },
}
