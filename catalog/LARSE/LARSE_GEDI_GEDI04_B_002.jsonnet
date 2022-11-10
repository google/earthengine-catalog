local id = 'LARSE/GEDI/GEDI04_B_002';
local subdir = 'LARSE';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local gedi_l2a = import 'gedi_l2a.libsonnet';
local gedi = importstr 'gedi.md';

local basename = std.strReplace(id, '/', '_');
local base_filename = basename + '.json';
local self_ee_catalog_url = ee_const.ee_catalog_url + basename;

{
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.collection,
  stac_extensions: [
    ee_const.ext_eo,
    ee_const.ext_sci,
    ee_const.ext_ver,
  ],
  id: id,
  title: 'GEDI L4B Gridded Aboveground Biomass Density (Version 2)',
  version: '2',
  'gee:type': ee_const.gee_type.image,
  description: |||
    This Global Ecosystem Dynamics Investigation (GEDI) L4B product provides
    1 km x 1 km estimates of mean aboveground biomass density (AGBD) based on
    observations from mission week 19 starting on 2019-04-18 to mission
    week 138 ending on 2021-08-04. The GEDI L4A Footprint Biomass product
    converts each high-quality waveform to an AGBD prediction, and the
    L4B product uses the sample present within the borders of each 1 km cell to
    statistically infer mean AGBD.

    Please see [User Guide](https://daac.ornl.gov/GEDI/guides/GEDI_L4B_Gridded_Biomass.html)
    for more information.
  ||| + gedi,
  license: gedi_l2a.license,
  links: ee.standardLinks(subdir, id),
  keywords: gedi_l2a.keywords,
  providers: gedi_l2a.providers('', self_ee_catalog_url),
  extent: ee.extent(-180,
                    -52.0,
                    180,
                    52.0,
                    '2019-04-18T00:00:00Z',
                    '2021-08-04T00:00:00Z'),
  summaries: {
    gsd: [
      1000.0,
    ],
    'eo:bands': [
      {
        name: 'MU',
        description: |||
          Mean aboveground biomass density (MU): Estimated mean AGBD for the
          1 km grid cell, including forest and non-forest.
        |||,
        'gee:units': 'Mg ha^-1'
      },
      {
        name: 'V1',
        description: |||
          Variance component 1 (V1): Uncertainty in the estimate of mean
          biomass due to the field-to-GEDI model used in L4A.
        |||,
      },
      {
        name: 'V2',
        description: |||
          Variance component 2 (V2)

          * If Mode of Inference = 1,
            this is the uncertainty due to GEDI&apos;s sampling of the 1 km cell.
          * If Mode of Inference = 2,
            this is uncertainty owing to the model predicting biomass using
            wall-to-wall data, calibrated with the L4A footprint product.
        |||,
      },
      {
        name: 'SE',
        description: |||
          Mean aboveground biomass density standard error (SE): Standard Error
          of the mean estimate, combining sampling and modeling uncertainty.
        |||,
        'gee:units': 'Mg ha^-1'
      },
      {
        name: 'PE',
        description: |||
          Standard error as a fraction of the estimated mean AGBD (PE).
          If >100%, the cell values are truncated to 100.
        |||,
        'gee:units': 'Percent'
      },
      {
        name: 'NC',
        description: |||
          Number of clusters (NC): Number of unique GEDI ground tracks with at
          least one high-quality waveform intersecting the grid cell.
        |||,
      },
      {
        name: 'NS',
        description: |||
          Number of samples (NS): Total number of high-quality waveforms across
          all ground tracks within the grid cell.
        |||,
      },
      {
        name: 'QF',
        description: |||
          Quality flag (QF)

          * 0=Outside the GEDI domain
          * 1=Land surface
          * 2=Land surface and meets GEDI mission L1 requirement
          (Percent standard error <20% or Standard Error < 20 Mg ha-1)
        |||,
      },
      {
        name: 'PS',
        description: |||
          Prediction stratum (PS) determined by plant functional type and
          continent. PS is associated with an L4A model parameter covariance
          matrix that contributes to the Model Error Variance (Table 2).
        |||,
      },
      {
        name: 'MI',
        description: |||
          Mode of interference (MI): Method used for a particular cell.
          Until mission completion, only those cells where hybrid inference
          is possible will be populated with a mean biomass value.

          * 0=None applied
          * 1=Hybrid Model-Based
          * 2=Generalized Hierarchical Model-Based
        |||,
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Mean biomass',
        lookat: {
          lat: 2,
          lon: 48.5,
          zoom: 10,
        },
        image_visualization: {
          band_vis: {
            min: [
              1.0,
            ],
            max: [
              60.0,
            ],
            palette: [
              'darkred',
              'red',
              'orange',
              'green',
              'darkgreen',
            ],
            bands: [
              'MU',
            ],
          },
        },
      },
    ],
  },
  'sci:doi': '10.3334/ORNLDAAC/2017',
  'sci:citation': |||
    Dubayah, R.O., J. Armston, S.P. Healey, Z. Yang, P.L. Patterson, S. Saarela,
    G. Stahl, L. Duncanson, and J.R. Kellner. 2022. GEDI L4B Gridded Aboveground
    Biomass Density, Version 2. ORNL DAAC, Oak Ridge, Tennessee, USA.
    [doi:10.3334/ORNLDAAC/2017](https://doi.org/10.3334/ORNLDAAC/2017)
  |||,
  'gee:terms_of_use': gedi_l2a.terms_of_use,
}
