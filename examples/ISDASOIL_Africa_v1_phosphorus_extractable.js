var mean_0_20 =
'<RasterSymbolizer>' +
 '<ColorMap type="ramp">' +
  '<ColorMapEntry color="#0D0887" label="0-2.7" opacity="1" quantity="13"/>' +
  '<ColorMapEntry color="#350498" label="2.7-3" opacity="1" quantity="14"/>' +
  '<ColorMapEntry color="#5402A3" label="3-3.5" opacity="1" quantity="15"/>' +
  '<ColorMapEntry color="#7000A8" label="3.5-4" opacity="1" quantity="16"/>' +
  '<ColorMapEntry color="#8B0AA5" label="4-4.5" opacity="1" quantity="17"/>' +
  '<ColorMapEntry color="#A31E9A" label="4.5-5" opacity="1" quantity="18"/>' +
  '<ColorMapEntry color="#B93289" label="5-5.7" opacity="1" quantity="19"/>' +
  '<ColorMapEntry color="#CC4678" label="5.7-6.4" opacity="1" quantity="20"/>' +
  '<ColorMapEntry color="#DB5C68" label="6.4-7.2" opacity="1" quantity="21"/>' +
  '<ColorMapEntry color="#E97158" label="7.2-8" opacity="1" quantity="22"/>' +
  '<ColorMapEntry color="#F48849" label="8-9" opacity="1" quantity="23"/>' +
  '<ColorMapEntry color="#FBA139" label="9-10" opacity="1" quantity="24"/>' +
  '<ColorMapEntry color="#FEBC2A" label="10-11.2" opacity="1" quantity="25"/>' +
  '<ColorMapEntry color="#FADA24" label="11.2-12.5" opacity="1" quantity="26"/>' +
  '<ColorMapEntry color="#F0F921" label="12.5-125" opacity="1" quantity="27"/>' +
 '</ColorMap>' +
 '<ContrastEnhancement/>' +
'</RasterSymbolizer>';

var mean_20_50 =
'<RasterSymbolizer>' +
 '<ColorMap type="ramp">' +
  '<ColorMapEntry color="#0D0887" label="0-2.7" opacity="1" quantity="13"/>' +
  '<ColorMapEntry color="#350498" label="2.7-3" opacity="1" quantity="14"/>' +
  '<ColorMapEntry color="#5402A3" label="3-3.5" opacity="1" quantity="15"/>' +
  '<ColorMapEntry color="#7000A8" label="3.5-4" opacity="1" quantity="16"/>' +
  '<ColorMapEntry color="#8B0AA5" label="4-4.5" opacity="1" quantity="17"/>' +
  '<ColorMapEntry color="#A31E9A" label="4.5-5" opacity="1" quantity="18"/>' +
  '<ColorMapEntry color="#B93289" label="5-5.7" opacity="1" quantity="19"/>' +
  '<ColorMapEntry color="#CC4678" label="5.7-6.4" opacity="1" quantity="20"/>' +
  '<ColorMapEntry color="#DB5C68" label="6.4-7.2" opacity="1" quantity="21"/>' +
  '<ColorMapEntry color="#E97158" label="7.2-8" opacity="1" quantity="22"/>' +
  '<ColorMapEntry color="#F48849" label="8-9" opacity="1" quantity="23"/>' +
  '<ColorMapEntry color="#FBA139" label="9-10" opacity="1" quantity="24"/>' +
  '<ColorMapEntry color="#FEBC2A" label="10-11.2" opacity="1" quantity="25"/>' +
  '<ColorMapEntry color="#FADA24" label="11.2-12.5" opacity="1" quantity="26"/>' +
  '<ColorMapEntry color="#F0F921" label="12.5-125" opacity="1" quantity="27"/>' +
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

var raw = ee.Image("ISDASOIL/Africa/v1/phosphorus_extractable");
Map.addLayer(
    raw.select(0).sldStyle(mean_0_20), {},
    "Phosphorus extractable, mean visualization, 0-20 cm");
Map.addLayer(
    raw.select(1).sldStyle(mean_20_50), {},
    "Phosphorus extractable, mean visualization, 20-50 cm");
Map.addLayer(
    raw.select(2).sldStyle(stdev_0_20), {},
    "Phosphorus extractable, stdev visualization, 0-20 cm");
Map.addLayer(
    raw.select(3).sldStyle(stdev_20_50), {},
    "Phosphorus extractable, stdev visualization, 20-50 cm");

var converted = raw.divide(10).exp().subtract(1);

var visualization = {min: 0, max: 15};

Map.setCenter(25, -3, 2);

Map.addLayer(converted.select(0), visualization, "Phosphorus extractable, mean, 0-20 cm");
