var mean_0_20 =
'<RasterSymbolizer>' +
 '<ColorMap type="ramp">' +
  '<ColorMapEntry color="#0D0887" label="0-19.1" opacity="1" quantity="30"/>' +
  '<ColorMapEntry color="#350498" label="19.1-29" opacity="1" quantity="34"/>' +
  '<ColorMapEntry color="#5402A3" label="29-39.4" opacity="1" quantity="37"/>' +
  '<ColorMapEntry color="#7000A8" label="39.4-53.6" opacity="1" quantity="40"/>' +
  '<ColorMapEntry color="#8B0AA5" label="53.6-72.7" opacity="1" quantity="43"/>' +
  '<ColorMapEntry color="#A31E9A" label="72.7-89" opacity="1" quantity="45"/>' +
  '<ColorMapEntry color="#B93289" label="89-108.9" opacity="1" quantity="47"/>' +
  '<ColorMapEntry color="#CC4678" label="108.9-120.5" opacity="1" quantity="48"/>' +
  '<ColorMapEntry color="#DB5C68" label="120.5-133.3" opacity="1" quantity="49"/>' +
  '<ColorMapEntry color="#E97158" label="133.3-163" opacity="1" quantity="51"/>' +
  '<ColorMapEntry color="#F48849" label="163-180.3" opacity="1" quantity="52"/>' +
  '<ColorMapEntry color="#FBA139" label="180.3-220.4" opacity="1" quantity="54"/>' +
  '<ColorMapEntry color="#FEBC2A" label="220.4-243.7" opacity="1" quantity="55"/>' +
  '<ColorMapEntry color="#FADA24" label="243.7-297.9" opacity="1" quantity="57"/>' +
  '<ColorMapEntry color="#F0F921" label="243.7-1200" opacity="1" quantity="60"/>' +
 '</ColorMap>' +
 '<ContrastEnhancement/>' +
'</RasterSymbolizer>';

var mean_20_50 =
'<RasterSymbolizer>' +
 '<ColorMap type="ramp">' +
  '<ColorMapEntry color="#0D0887" label="0-19.1" opacity="1" quantity="30"/>' +
  '<ColorMapEntry color="#350498" label="19.1-29" opacity="1" quantity="34"/>' +
  '<ColorMapEntry color="#5402A3" label="29-39.4" opacity="1" quantity="37"/>' +
  '<ColorMapEntry color="#7000A8" label="39.4-53.6" opacity="1" quantity="40"/>' +
  '<ColorMapEntry color="#8B0AA5" label="53.6-72.7" opacity="1" quantity="43"/>' +
  '<ColorMapEntry color="#A31E9A" label="72.7-89" opacity="1" quantity="45"/>' +
  '<ColorMapEntry color="#B93289" label="89-108.9" opacity="1" quantity="47"/>' +
  '<ColorMapEntry color="#CC4678" label="108.9-120.5" opacity="1" quantity="48"/>' +
  '<ColorMapEntry color="#DB5C68" label="120.5-133.3" opacity="1" quantity="49"/>' +
  '<ColorMapEntry color="#E97158" label="133.3-163" opacity="1" quantity="51"/>' +
  '<ColorMapEntry color="#F48849" label="163-180.3" opacity="1" quantity="52"/>' +
  '<ColorMapEntry color="#FBA139" label="180.3-220.4" opacity="1" quantity="54"/>' +
  '<ColorMapEntry color="#FEBC2A" label="220.4-243.7" opacity="1" quantity="55"/>' +
  '<ColorMapEntry color="#FADA24" label="243.7-297.9" opacity="1" quantity="57"/>' +
  '<ColorMapEntry color="#F0F921" label="243.7-1200" opacity="1" quantity="60"/>' +
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

var raw = ee.Image("ISDASOIL/Africa/v1/magnesium_extractable");
Map.addLayer(
    raw.select(0).sldStyle(mean_0_20), {},
    "Magnesium, extractable, mean visualization, 0-20 cm");
Map.addLayer(
    raw.select(1).sldStyle(mean_20_50), {},
    "Magnesium, extractable, mean visualization, 20-50 cm");
Map.addLayer(
    raw.select(2).sldStyle(stdev_0_20), {},
    "Magnesium, extractable, stdev visualization, 0-20 cm");
Map.addLayer(
    raw.select(3).sldStyle(stdev_20_50), {},
    "Magnesium, extractable, stdev visualization, 20-50 cm");

var converted = raw.divide(10).exp().subtract(1);

var visualization = {min: 0, max: 500};

Map.setCenter(25, -3, 2);

Map.addLayer(converted.select(0), visualization, "Magnesium, extractable, mean, 0-20 cm");
