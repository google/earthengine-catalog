local ee = import 'earthengine.libsonnet';
local ee_const = import 'earthengine_const.libsonnet';
local spdx = import 'spdx.libsonnet';
local units = import 'units.libsonnet';

{
  description: |||
    The WRI Aqueduct baseline annual dataset provides a comprehensive overview
    of water-related risks on an annual basis which includes indicators such as
    baseline water stress, baseline water depletion and interannual variability.
    This annual data is essential for understanding long-term trends in water
    risk, assessing the cumulative impacts of human activities on water
    resources, and developing long-term water management strategies.

  |||,
  indicators_desc_dict : [
    {
      name: 'bws',
      description: 'Baseline water stress',
    },
    {
      name: 'bwd',
      description: 'Baseline water depletion',
    },
    {
      name: 'iav',
      description: 'Interannual variability',
    },
    {
      name: 'sev',
      description: 'Seasonal variability',
    },
    {
      name: 'gtd',
      description: 'Groundwater table decline',
    },
    {
      name: 'rfr',
      description: 'Riverine flood risk',
    },
    {
      name: 'cfr',
      description: 'Coastal flood risk',
    },
    {
      name: 'drr',
      description: 'Drought risk',
    },
    {
      name: 'ucw',
      description: 'Untreated connected wastewater',
    },
    {
      name: 'udw',
      description: 'Unimproved/no drinking water',
    },
    {
      name: 'usa',
      description: 'Unimproved/no sanitation',
    },
    {
      name: 'cep',
      description: 'Coastal eutrophication potential',
    },
    {
      name: 'rri',
      description: 'Peak RepRisk country ESG risk index',
    },
  ],
  weighting_scheme_desc_dict : [
    {
      name : 'def',
      description: 'Default weighting scheme',
    },
    {
      name : 'agr',
      description: 'Agriculture weighting scheme',
    },
    {
      name : 'che',
      description: 'Chemicals weighting scheme',
    },
    {
      name : 'con',
      description: 'Construction materials weighting scheme',
    },
    {
      name : 'elp',
      description: 'Electric power weighting scheme',
    },
    {
      name : 'fnb',
      description: 'Food & beverage weighting scheme',
    },
    {
      name : 'min',
      description: 'Mining weighting scheme',
    },
    {
      name : 'ong',
      description: 'Oil & gas weighting scheme',
    },
    {
      name : 'smc',
      description: 'Semiconductor weighting scheme',
    },
    {
      name : 'tex',
      description: 'Textile weighting scheme',
    },
  ],
  groups_desc_dict : [
    {
      name : 'qan',
      description: 'physical risk quantity group',
    },
    {
      name : 'qal',
      description: 'physical risk quality group',
    },
    {
      name : 'rrr',
      description: 'regulatory and reputational risk group',
    },
    {
      name : 'tot',
      description: 'total, overall water risk group',
    },
  ],
  // baseline annual identifiers - 9
  identifiers: [
    {
      name: 'aq30_id',
      description: 'Unique identifier in numeric format',
      type: ee_const.var_type.int
    },
    {
      name: 'aqid',
      description: 'Identifier for groundwater aquifers based on WHYMAP',
      type: ee_const.var_type.int
    },
    {
      name: 'area_km2',
      description: |||
        Area of the geometry in km2 (union of sub-basin, province and
        groundwater aquifer)
      |||,
      type: ee_const.var_type.double
    },
    {
      name: 'gid_0',
      description: 'ISO A3 country code based on [GADM](https://gadm.org/data.html)',
      type: ee_const.var_type.string
    },
    {
      name: 'gid_1',
      description: |||
        Identifier for sub-national units based on the [GADM](https://gadm.org/data.html)
        dataset. It contains the ISO A3 country code, followed by numeric values
        separated by underscores for each sub-national unit.
      |||,
      type: ee_const.var_type.string
    },
    {
      name: 'name_0',
      description: 'National or political entity name based on [GADM](https://gadm.org/data.html)',
      type: ee_const.var_type.string
    },
    {
      name: 'name_1',
      description: 'Sub-national or political entity name based on [GADM](https://gadm.org/data.html)',
      type: ee_const.var_type.string
    },
    {
      name: 'pfaf_id',
      description: 'Six digit Pfafstetter code for the [hydrological basin](https://hydrosheds.org/page/hydrobasins)',
      type: ee_const.var_type.int
    },
    {
      name: 'string_id',
      description: |||
        Unique string for each geometry. Geometries are the union of
        hydrological basins, provinces and groundwater aquifers. The string_id
        is a combination of pfaf_id-gid_1-aqid. See the description of those
        columns.
      |||,
      type: ee_const.var_type.string
    },
  ],
}