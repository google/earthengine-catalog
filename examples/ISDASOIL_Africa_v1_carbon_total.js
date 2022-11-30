var mean_0_20 =
'<RasterSymbolizer>' +
 '<ColorMap type="ramp">' +
  '<ColorMapEntry color="#000004" label="0-2" opacity="1" quantity="11"/>' +
  '<ColorMapEntry color="#0C0927" label="2-5.7" opacity="1" quantity="19"/>' +
  '<ColorMapEntry color="#231151" label="5.7-10" opacity="1" quantity="24"/>' +
  '<ColorMapEntry color="#410F75" label="10-12.5" opacity="1" quantity="26"/>' +
  '<ColorMapEntry color="#5F187F" label="12.5-13.9" opacity="1" quantity="27"/>' +
  '<ColorMapEntry color="#7B2382" label="13.9-15.4" opacity="1" quantity="28"/>' +
  '<ColorMapEntry color="#982D80" label="15.4-17.2" opacity="1" quantity="29"/>' +
  '<ColorMapEntry color="#B63679" label="17.2-19.1" opacity="1" quantity="30"/>' +
  '<ColorMapEntry color="#D3436E" label="19.1-21.2" opacity="1" quantity="31"/>' +
  '<ColorMapEntry color="#EB5760" label="21.2-23.5" opacity="1" quantity="32"/>' +
  '<ColorMapEntry color="#F8765C" label="23.5-26.1" opacity="1" quantity="33"/>' +
  '<ColorMapEntry color="#FD9969" label="26.1-29" opacity="1" quantity="34"/>' +
  '<ColorMapEntry color="#FEBA80" label="29-32.1" opacity="1" quantity="35"/>' +
  '<ColorMapEntry color="#FDDC9E" label="32.1-35.6" opacity="1" quantity="36"/>' +
  '<ColorMapEntry color="#FCFDBF" label="35.6-40" opacity="1" quantity="39"/>' +
 '</ColorMap>' +
 '<ContrastEnhancement/>' +
'</RasterSymbolizer>';

var mean_20_50 =
'<RasterSymbolizer>' +
 '<ColorMap type="ramp">' +
  '<ColorMapEntry color="#000004" label="0-2" opacity="1" quantity="11"/>' +
  '<ColorMapEntry color="#0C0927" label="2-5.7" opacity="1" quantity="19"/>' +
  '<ColorMapEntry color="#231151" label="5.7-10" opacity="1" quantity="24"/>' +
  '<ColorMapEntry color="#410F75" label="10-12.5" opacity="1" quantity="26"/>' +
  '<ColorMapEntry color="#5F187F" label="12.5-13.9" opacity="1" quantity="27"/>' +
  '<ColorMapEntry color="#7B2382" label="13.9-15.4" opacity="1" quantity="28"/>' +
  '<ColorMapEntry color="#982D80" label="15.4-17.2" opacity="1" quantity="29"/>' +
  '<ColorMapEntry color="#B63679" label="17.2-19.1" opacity="1" quantity="30"/>' +
  '<ColorMapEntry color="#D3436E" label="19.1-21.2" opacity="1" quantity="31"/>' +
  '<ColorMapEntry color="#EB5760" label="21.2-23.5" opacity="1" quantity="32"/>' +
  '<ColorMapEntry color="#F8765C" label="23.5-26.1" opacity="1" quantity="33"/>' +
  '<ColorMapEntry color="#FD9969" label="26.1-29" opacity="1" quantity="34"/>' +
  '<ColorMapEntry color="#FEBA80" label="29-32.1" opacity="1" quantity="35"/>' +
  '<ColorMapEntry color="#FDDC9E" label="32.1-35.6" opacity="1" quantity="36"/>' +
  '<ColorMapEntry color="#FCFDBF" label="35.6-40" opacity="1" quantity="39"/>' +
 '</ColorMap>' +
 '<ContrastEnhancement/>' +
'</RasterSymbolizer>';

var stdev_0_20 =
'<RasterSymbolizer>' +
 '<ColorMap type="ramp">' +
  '<ColorMapEntry color="#fde725" label="low" opacity="1" quantity="1"/>' +
  '<ColorMapEntry color="#5dc962" label=" " opacity="1" quantity="3"/>' +
  '<ColorMapEntry color="#20908d" label=" " opacity="1" quantity="4"/>' +
  '<ColorMapEntry color="#3a528b" label=" " opacity="1" quantity="5"/>' +
  '<ColorMapEntry color="#440154" label="high" opacity="1" quantity="6"/>' +
 '</ColorMap>' +
 '<ContrastEnhancement/>' +
'</RasterSymbolizer>';

var stdev_20_50 =
'<RasterSymbolizer>' +
 '<ColorMap type="ramp">' +
  '<ColorMapEntry color="#fde725" label="low" opacity="1" quantity="1"/>' +
  '<ColorMapEntry color="#5dc962" label=" " opacity="1" quantity="3"/>' +
  '<ColorMapEntry color="#20908d" label=" " opacity="1" quantity="4"/>' +
  '<ColorMapEntry color="#3a528b" label=" " opacity="1" quantity="5"/>' +
  '<ColorMapEntry color="#440154" label="high" opacity="1" quantity="6"/>' +
 '</ColorMap>' +
 '<ContrastEnhancement/>' +
'</RasterSymbolizer>';

var raw = ee.Image("ISDASOIL/Africa/v1/carbon_total");
Map.addLayer(
    raw.select(0).sldStyle(mean_0_20), {},
    "Carbon, total, mean visualization, 0-20 cm");
Map.addLayer(
    raw.select(1).sldStyle(mean_20_50), {},
    "Carbon, total, mean visualization, 20-50 cm");
Map.addLayer(
    raw.select(2).sldStyle(stdev_0_20), {},
    "Carbon, total, stdev visualization, 0-20 cm");
Map.addLayer(
    raw.select(3).sldStyle(stdev_20_50), {},
    "Carbon, total, stdev visualization, 20-50 cm");

var converted = raw.divide(10).exp().subtract(1);

var visualization = {min: 0, max: 60};

Map.setCenter(25, -3, 2);

Map.addLayer(converted.select(0), visualization, "Carbon, total, mean, 0-20 cm");
