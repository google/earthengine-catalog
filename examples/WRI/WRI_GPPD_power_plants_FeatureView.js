var fvLayer = ui.Map.FeatureViewLayer('WRI/GPPD/power_plants_FeatureView');

var visParams = {
  opacity: 0.65,
  color: {
    property: 'fuel1',
    categories: [
      ['Coal', '000000'],
      ['Oil', '593704'],
      ['Gas', 'bc80bd'],
      ['Hydro', '0565a6'],
      ['Nuclear', 'e31a1c'],
      ['Solar', 'ff7f00'],
      ['Waste', '6a3d9a'],
      ['Wind', '5ca2d1'],
      ['Geothermal', 'fdbf6f'],
      ['Biomass', '229a00']
    ],
    defaultValue: 'ffffff'
  },
  rules: [
    {
      filter: ee.Filter.expression('capacitymw < 500'),
      pointSize: 5,
    },
    {
      filter: ee.Filter.expression('capacitymw >= 500 AND capacitymw < 1000'),
      pointSize: 10,
    },
    {
      filter: ee.Filter.expression('capacitymw >= 1000'),
      pointSize: 15,
    }
  ]
};

fvLayer.setVisParams(visParams);
fvLayer.setName('Power plant (fuel type and capacity)');

Map.setCenter(16, 49, 4);
Map.add(fvLayer);
