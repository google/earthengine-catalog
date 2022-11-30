var mean_0_20 =
'<RasterSymbolizer>' +
 '<ColorMap type="ramp">' +
  '<ColorMapEntry color="#0D0887" label="0-65.7" opacity="1" quantity="42"/>' +
  '<ColorMapEntry color="#350498" label="65.7-120.5" opacity="1" quantity="48"/>' +
  '<ColorMapEntry color="#5402A3" label="120.5-163" opacity="1" quantity="51"/>' +
  '<ColorMapEntry color="#7000A8" label="163-199.3" opacity="1" quantity="53"/>' +
  '<ColorMapEntry color="#8B0AA5" label="199.3-269.4" opacity="1" quantity="56"/>' +
  '<ColorMapEntry color="#A31E9A" label="269.4-329.3" opacity="1" quantity="58"/>' +
  '<ColorMapEntry color="#B93289" label="329.3-402.4" opacity="1" quantity="60"/>' +
  '<ColorMapEntry color="#CC4678" label="402.4-491.7" opacity="1" quantity="62"/>' +
  '<ColorMapEntry color="#DB5C68" label="491.7-600.8" opacity="1" quantity="64"/>' +
  '<ColorMapEntry color="#E97158" label="600.8-664.1" opacity="1" quantity="65"/>' +
  '<ColorMapEntry color="#F48849" label="664.1-811.4" opacity="1" quantity="67"/>' +
  '<ColorMapEntry color="#FBA139" label="811.4-896.8" opacity="1" quantity="68"/>' +
  '<ColorMapEntry color="#FEBC2A" label="896.8-1095.6" opacity="1" quantity="70"/>' +
  '<ColorMapEntry color="#FADA24" label="1095.6-1479.3" opacity="1" quantity="73"/>' +
  '<ColorMapEntry color="#F0F921" label="1479.3-12000" opacity="1" quantity="77"/>' +
 '</ColorMap>' +
 '<ContrastEnhancement/>' +
'</RasterSymbolizer>';

var mean_20_50 =
'<RasterSymbolizer>' +
 '<ColorMap type="ramp">' +
  '<ColorMapEntry color="#0D0887" label="0-65.7" opacity="1" quantity="42"/>' +
  '<ColorMapEntry color="#350498" label="65.7-120.5" opacity="1" quantity="48"/>' +
  '<ColorMapEntry color="#5402A3" label="120.5-163" opacity="1" quantity="51"/>' +
  '<ColorMapEntry color="#7000A8" label="163-199.3" opacity="1" quantity="53"/>' +
  '<ColorMapEntry color="#8B0AA5" label="199.3-269.4" opacity="1" quantity="56"/>' +
  '<ColorMapEntry color="#A31E9A" label="269.4-329.3" opacity="1" quantity="58"/>' +
  '<ColorMapEntry color="#B93289" label="329.3-402.4" opacity="1" quantity="60"/>' +
  '<ColorMapEntry color="#CC4678" label="402.4-491.7" opacity="1" quantity="62"/>' +
  '<ColorMapEntry color="#DB5C68" label="491.7-600.8" opacity="1" quantity="64"/>' +
  '<ColorMapEntry color="#E97158" label="600.8-664.1" opacity="1" quantity="65"/>' +
  '<ColorMapEntry color="#F48849" label="664.1-811.4" opacity="1" quantity="67"/>' +
  '<ColorMapEntry color="#FBA139" label="811.4-896.8" opacity="1" quantity="68"/>' +
  '<ColorMapEntry color="#FEBC2A" label="896.8-1095.6" opacity="1" quantity="70"/>' +
  '<ColorMapEntry color="#FADA24" label="1095.6-1479.3" opacity="1" quantity="73"/>' +
  '<ColorMapEntry color="#F0F921" label="1479.3-12000" opacity="1" quantity="77"/>' +
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

var raw = ee.Image("ISDASOIL/Africa/v1/calcium_extractable");
Map.addLayer(
    raw.select(0).sldStyle(mean_0_20), {},
    "Calcium, extractable, mean visualization, 0-20 cm");
Map.addLayer(
    raw.select(1).sldStyle(mean_20_50), {},
    "Calcium, extractable, mean visualization, 20-50 cm");
Map.addLayer(
    raw.select(2).sldStyle(stdev_0_20), {},
    "Calcium, extractable, stdev visualization, 0-20 cm");
Map.addLayer(
    raw.select(3).sldStyle(stdev_20_50), {},
    "Calcium, extractable, stdev visualization, 20-50 cm");

var converted = raw.divide(10).exp().subtract(1);

var visualization = {min: 100, max: 2000};

Map.setCenter(25, -3, 2);

Map.addLayer(converted.select(0), visualization, "Calcium, extractable, mean, 0-20 cm");
