local ee = import 'earthengine.libsonnet';
local ee_const = import 'earthengine_const.libsonnet';
local spdx = import 'spdx.libsonnet';
local units = import 'units.libsonnet';

{
  description: |||
    The WRI Aqueduct future annual dataset provides future projections of water
    supply, demand, stress, depletion, and variability based on CMIP6 climate
    projections for 3 milestone years: 2030, 2050, and 2080. This dataset can be
    used to anticipate and adapt to future water challenges which will be useful
    for water resource management, infrastructure development and climate change
    adaptation.
  |||,
  scenarios_dict : [
    {
      name: 'bau',
      description: 'business as usual',
    },
    {
      name: 'opt',
      description: 'optimistic',
    },
    {
      name: 'pes',
      description: 'pessimistic',
    },
  ],
  years_dict : [
    {
      name : '30',
      description: '2030',
    },
    {
      name : '50',
      description: '2050',
    },
    {
      name : '80',
      description: '2080',
    },
  ],
  indicators_dict : [
    {
      name : 'ba',
      description: 'Available blue water',
    },
    {
      name : 'ww',
      description: 'Gross water demand',
    },
    {
      name : 'ws',
      description: 'Water stress',
    },
    {
      name : 'wd',
      description: 'Baseline water depletion',
    },
    {
      name : 'iv',
      description: 'Interannual variability',
    },
    {
      name : 'sv',
      description: 'Seasonal variability',
    },
  ],
  identifiers: [
    {
      name: 'pfaf_id',
      description: 'Six digit Pfafstetter code for the [hydrological basin](https://hydrosheds.org/page/hydrobasins)',
      type: ee_const.var_type.int
    },
    {
      name: 'fid',
      description: 'Feature Id',
      type: ee_const.var_type.int
    },
  ],
}