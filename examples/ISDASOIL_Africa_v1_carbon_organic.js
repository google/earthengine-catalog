var mean_0_20 =
'<RasterSymbolizer>' +
 '<ColorMap type="ramp">' +
  '<ColorMapEntry color="#000004" label="0-2.3" opacity="1" quantity="12"/>' +
  '<ColorMapEntry color="#0C0927" label="2.3-3.5" opacity="1" quantity="15"/>' +
  '<ColorMapEntry color="#231151" label="3.5-4" opacity="1" quantity="16"/>' +
  '<ColorMapEntry color="#410F75" label="4-4.5" opacity="1" quantity="17"/>' +
  '<ColorMapEntry color="#5F187F" label="4.5-5" opacity="1" quantity="18"/>' +
  '<ColorMapEntry color="#7B2382" label="5-5.7" opacity="1" quantity="19"/>' +
  '<ColorMapEntry color="#982D80" label="5.7-6.4" opacity="1" quantity="20"/>' +
  '<ColorMapEntry color="#B63679" label="6.4-7.2" opacity="1" quantity="21"/>' +
  '<ColorMapEntry color="#D3436E" label="7.2-8" opacity="1" quantity="22"/>' +
  '<ColorMapEntry color="#EB5760" label="8-9" opacity="1" quantity="23"/>' +
  '<ColorMapEntry color="#F8765C" label="9-10" opacity="1" quantity="24"/>' +
  '<ColorMapEntry color="#FD9969" label="10-11.2" opacity="1" quantity="25"/>' +
  '<ColorMapEntry color="#FEBA80" label="11.2-12.5" opacity="1" quantity="26"/>' +
  '<ColorMapEntry color="#FDDC9E" label="12.5-13.9" opacity="1" quantity="27"/>' +
  '<ColorMapEntry color="#FCFDBF" label="13.9-40" opacity="1" quantity="28"/>' +
 '</ColorMap>' +
 '<ContrastEnhancement/>' +
'</RasterSymbolizer>';

var mean_20_50 =
'<RasterSymbolizer>' +
 '<ColorMap type="ramp">' +
  '<ColorMapEntry color="#000004" label="0-2.3" opacity="1" quantity="12"/>' +
  '<ColorMapEntry color="#0C0927" label="2.3-3.5" opacity="1" quantity="15"/>' +
  '<ColorMapEntry color="#231151" label="3.5-4" opacity="1" quantity="16"/>' +
  '<ColorMapEntry color="#410F75" label="4-4.5" opacity="1" quantity="17"/>' +
  '<ColorMapEntry color="#5F187F" label="4.5-5" opacity="1" quantity="18"/>' +
  '<ColorMapEntry color="#7B2382" label="5-5.7" opacity="1" quantity="19"/>' +
  '<ColorMapEntry color="#982D80" label="5.7-6.4" opacity="1" quantity="20"/>' +
  '<ColorMapEntry color="#B63679" label="6.4-7.2" opacity="1" quantity="21"/>' +
  '<ColorMapEntry color="#D3436E" label="7.2-8" opacity="1" quantity="22"/>' +
  '<ColorMapEntry color="#EB5760" label="8-9" opacity="1" quantity="23"/>' +
  '<ColorMapEntry color="#F8765C" label="9-10" opacity="1" quantity="24"/>' +
  '<ColorMapEntry color="#FD9969" label="10-11.2" opacity="1" quantity="25"/>' +
  '<ColorMapEntry color="#FEBA80" label="11.2-12.5" opacity="1" quantity="26"/>' +
  '<ColorMapEntry color="#FDDC9E" label="12.5-13.9" opacity="1" quantity="27"/>' +
  '<ColorMapEntry color="#FCFDBF" label="13.9-40" opacity="1" quantity="28"/>' +
 '</ColorMap>' +
 '<ContrastEnhancement/>' +
'</RasterSymbolizer>';

var stdev_0_20 =
'<RasterSymbolizer>' +
 '<ColorMap type="ramp">' +
  '<ColorMapEntry color="#fde725" label="low" opacity="1" quantity="1"/>' +
  '<ColorMapEntry color="#5dc962" label=" " opacity="1" quantity="2"/>' +
  '<ColorMapEntry color="#20908d" label=" " opacity="1" quantity="3"/>' +
  '<ColorMapEntry color="#3a528b" label=" " opacity="1" quantity="4"/>' +
  '<ColorMapEntry color="#440154" label="high" opacity="1" quantity="5"/>' +
 '</ColorMap>' +
 '<ContrastEnhancement/>' +
'</RasterSymbolizer>';

var stdev_20_50 =
'<RasterSymbolizer>' +
 '<ColorMap type="ramp">' +
  '<ColorMapEntry color="#fde725" label="low" opacity="1" quantity="1"/>' +
  '<ColorMapEntry color="#5dc962" label=" " opacity="1" quantity="2"/>' +
  '<ColorMapEntry color="#20908d" label=" " opacity="1" quantity="3"/>' +
  '<ColorMapEntry color="#3a528b" label=" " opacity="1" quantity="4"/>' +
  '<ColorMapEntry color="#440154" label="high" opacity="1" quantity="5"/>' +
 '</ColorMap>' +
 '<ContrastEnhancement/>' +
'</RasterSymbolizer>';

var raw = ee.Image("ISDASOIL/Africa/v1/carbon_organic");
Map.addLayer(
    raw.select(0).sldStyle(mean_0_20), {},
    "Carbon, organic, mean visualization, 0-20 cm");
Map.addLayer(
    raw.select(1).sldStyle(mean_20_50), {},
    "Carbon, organic, mean visualization, 20-50 cm");
Map.addLayer(
    raw.select(2).sldStyle(stdev_0_20), {},
    "Carbon, organic, stdev visualization, 0-20 cm");
Map.addLayer(
    raw.select(3).sldStyle(stdev_20_50), {},
    "Carbon, organic, stdev visualization, 20-50 cm");

var converted = raw.divide(10).exp().subtract(1);

var visualization = {min: 0, max: 20};

Map.setCenter(25, -3, 2);

Map.addLayer(converted.select(0), visualization, "Carbon, organic, mean, 0-20 cm");
