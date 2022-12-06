var fvLayer = ui.Map.FeatureViewLayer('WRI/GPPD/power_plants_FeatureView');

var visParams = {
  opacity: 0.65,
  color: {
    property: 'fuel1',
    categories: [
      ['Coal', '000000'],
      ['Oil', '593704'],
      ['Gas', 'BC80BD'],
      ['Hydro', '0565A6'],
      ['Nuclear', 'E31A1C'],
      ['Solar', 'FF7F00'],
      ['Waste', '6A3D9A'],
      ['Wind', '5CA2D1'],
      ['Geothermal', 'FDBF6F'],
      ['Biomass', '229A00']
    ],
    defaultValue: 'FFFFFF'
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
