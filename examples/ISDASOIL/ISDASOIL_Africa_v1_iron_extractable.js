var mean_0_20 =
'<RasterSymbolizer>' +
 '<ColorMap type="ramp">' +
  '<ColorMapEntry color="#0D0887" label="0-6.4" opacity="1" quantity="20"/>' +
  '<ColorMapEntry color="#350498" label="6.4-13.9" opacity="1" quantity="27"/>' +
  '<ColorMapEntry color="#5402A3" label="13.9-29" opacity="1" quantity="34"/>' +
  '<ColorMapEntry color="#7000A8" label="29-35.6" opacity="1" quantity="36"/>' +
  '<ColorMapEntry color="#8B0AA5" label="35.6-43.7" opacity="1" quantity="38"/>' +
  '<ColorMapEntry color="#A31E9A" label="43.7-48.4" opacity="1" quantity="39"/>' +
  '<ColorMapEntry color="#B93289" label="48.4-53.6" opacity="1" quantity="40"/>' +
  '<ColorMapEntry color="#CC4678" label="53.6-59.3" opacity="1" quantity="41"/>' +
  '<ColorMapEntry color="#DB5C68" label="59.3-65.7" opacity="1" quantity="42"/>' +
  '<ColorMapEntry color="#E97158" label="65.7-72.7" opacity="1" quantity="43"/>' +
  '<ColorMapEntry color="#F48849" label="72.7-80.5" opacity="1" quantity="44"/>' +
  '<ColorMapEntry color="#FBA139" label="80.5-89" opacity="1" quantity="45"/>' +
  '<ColorMapEntry color="#FEBC2A" label="89-98.5" opacity="1" quantity="46"/>' +
  '<ColorMapEntry color="#FADA24" label="98.5-108.9" opacity="1" quantity="47"/>' +
  '<ColorMapEntry color="#F0F921" label="108.9-1200" opacity="1" quantity="48"/>' +
 '</ColorMap>' +
 '<ContrastEnhancement/>' +
'</RasterSymbolizer>';

var mean_20_50 =
'<RasterSymbolizer>' +
 '<ColorMap type="ramp">' +
  '<ColorMapEntry color="#0D0887" label="0-6.4" opacity="1" quantity="20"/>' +
  '<ColorMapEntry color="#350498" label="6.4-13.9" opacity="1" quantity="27"/>' +
  '<ColorMapEntry color="#5402A3" label="13.9-29" opacity="1" quantity="34"/>' +
  '<ColorMapEntry color="#7000A8" label="29-35.6" opacity="1" quantity="36"/>' +
  '<ColorMapEntry color="#8B0AA5" label="35.6-43.7" opacity="1" quantity="38"/>' +
  '<ColorMapEntry color="#A31E9A" label="43.7-48.4" opacity="1" quantity="39"/>' +
  '<ColorMapEntry color="#B93289" label="48.4-53.6" opacity="1" quantity="40"/>' +
  '<ColorMapEntry color="#CC4678" label="53.6-59.3" opacity="1" quantity="41"/>' +
  '<ColorMapEntry color="#DB5C68" label="59.3-65.7" opacity="1" quantity="42"/>' +
  '<ColorMapEntry color="#E97158" label="65.7-72.7" opacity="1" quantity="43"/>' +
  '<ColorMapEntry color="#F48849" label="72.7-80.5" opacity="1" quantity="44"/>' +
  '<ColorMapEntry color="#FBA139" label="80.5-89" opacity="1" quantity="45"/>' +
  '<ColorMapEntry color="#FEBC2A" label="89-98.5" opacity="1" quantity="46"/>' +
  '<ColorMapEntry color="#FADA24" label="98.5-108.9" opacity="1" quantity="47"/>' +
  '<ColorMapEntry color="#F0F921" label="108.9-1200" opacity="1" quantity="48"/>' +
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
  '<ColorMapEntry color="#440154" label="high" opacity="1" quantity="6"/>' +
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
  '<ColorMapEntry color="#440154" label="high" opacity="1" quantity="6"/>' +
 '</ColorMap>' +
 '<ContrastEnhancement/>' +
'</RasterSymbolizer>';

var raw = ee.Image("ISDASOIL/Africa/v1/iron_extractable");
Map.addLayer(
    raw.select(0).sldStyle(mean_0_20), {},
    "Iron, extractable, mean visualization, 0-20 cm");
Map.addLayer(
    raw.select(1).sldStyle(mean_20_50), {},
    "Iron, extractable, mean visualization, 20-50 cm");
Map.addLayer(
    raw.select(2).sldStyle(stdev_0_20), {},
    "Iron, extractable, stdev visualization, 0-20 cm");
Map.addLayer(
    raw.select(3).sldStyle(stdev_20_50), {},
    "Iron, extractable, stdev visualization, 20-50 cm");

var converted = raw.divide(10).exp().subtract(1);

var visualization = {min: 0, max: 140};

Map.setCenter(25, -3, 2);

Map.addLayer(converted.select(0), visualization, "Iron, extractable, mean, 0-20 cm");
