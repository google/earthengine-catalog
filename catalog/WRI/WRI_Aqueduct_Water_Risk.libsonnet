local ee = import 'earthengine.libsonnet';
local ee_const = import 'earthengine_const.libsonnet';
local spdx = import 'spdx.libsonnet';
local units = import 'units.libsonnet';

{
  description: |||
    Aqueduct 4.0 is the latest iteration of WRI's water risk framework designed
    to translate complex hydrological data into intuitive indicators of water
    related risk. This dataset has curated 13 water risk indicators for
    quantity, quality and reputational concerns into a comprehensive framework.
    For 5 of the 13 indicators, a global hydrological model called PCR-GLOBWB 2
    has been used to generate novel datasets on sub-basic water supply.
    The PCR-GLOBWB 2 model is also used to project future sub-basin water
    conditions using CMIP6 climate forcings. The projections center around
    three periods (2030, 2050, and 2080) under three future scenarios
    (business-as-usual SSP 3 RCP 7.0, optimistic SSP 1 RCP 2.6, and
    pessimistic SSP 5 RCP 8.5).

    The water risk indicators have been aggregated by category (quantity,
    quality, reputational, and overall) into composite risk scores using
    sector-specific weighting schemes. In addition, select sub-basin scores have
    been aggregated into country and provincial administrative boundaries using
    a weighted average approach, where sub-basins with more demand have a higher
    influence over the final administrative score.

  |||,
  description_footer: |||
    This [technical note](https://www.wri.org/research/aqueduct-40-updated-decision-relevant-global-water-risk-indicators)
    explains in detail the framework, methodology, and data used
    in developing Aqueduct Floods.
  |||,
  keywords: [
    'monitoring',
    'wri',
    'aqueduct',
    'flood',
  ],
  terms_of_use: |||
    The WRI datasets are available without restriction
    on use or distribution. WRI does request that the
    user give proper attribution and identify WRI, where applicable,
    as the source of the data. For more information check
    [WRI's open data commitment](https://www.wri.org/data/open-data-commitment),
  |||,
}