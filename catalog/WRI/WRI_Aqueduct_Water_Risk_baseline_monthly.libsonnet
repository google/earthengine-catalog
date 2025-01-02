local ee = import 'earthengine.libsonnet';
local ee_const = import 'earthengine_const.libsonnet';
local spdx = import 'spdx.libsonnet';
local units = import 'units.libsonnet';

{
  description: |||
    The WRI Aqueduct baseline monthly dataset provides monthly data on key water
    risk indicators which includes indicators such as baseline water stress,
    baseline water depletion and interannual variability.This monthly data
    allows for a more detailed analysis of water risk dynamics throughout the
    year, which is crucial for understanding seasonal water scarcity, planning
    for water management interventions, and adapting to changing water
    availability patterns.

  |||,
  indicators_desc_dict : [
    {
      name: 'bwd',
      description: 'Baseline water depletion',
    },
    {
      name: 'bws',
      description: 'Baseline water stress',
    },
    {
      name: 'iav',
      description: 'Interannual variability',
    },
  ],
  months_desc_dict : [
    {
      name: '01',
      description: 'January',
    },
    {
      name: '02',
      description: 'February',
    },
    {
      name: '03',
      description: 'March',
    },
    {
      name: '04',
      description: 'April',
    },
    {
      name: '05',
      description: 'May',
    },
    {
      name: '06',
      description: 'June',
    },
    {
      name: '07',
      description: 'July',
    },
    {
      name: '08',
      description: 'August',
    },
    {
      name: '09',
      description: 'September',
    },
    {
      name: '10',
      description: 'October',
    },
    {
      name: '11',
      description: 'November',
    },
    {
      name: '12',
      description: 'December',
    },
  ],
  types_desc_dict : [
    {
      name: 'cat',
      description: 'category',
      type: ee_const.var_type.int,
    },
    {
      name: 'label',
      description: 'label',
      type: ee_const.var_type.string,
    },
    {
      name: 'raw',
      description: 'raw value',
      type: ee_const.var_type.double,
    },
    {
      name: 'score',
      description: 'score',
      type: ee_const.var_type.double,
    },
  ],
  // baseline monthly identifiers - 2
  identifiers: [
    {
      name: 'fid_1',
      description: 'Feature Id',
      type: ee_const.var_type.int
    },
    {
      name: 'pfaf_id',
      description: 'Six digit Pfafstetter code for the [hydrological basin](https://hydrosheds.org/page/hydrobasins)',
      type: ee_const.var_type.int
    },
  ],
}