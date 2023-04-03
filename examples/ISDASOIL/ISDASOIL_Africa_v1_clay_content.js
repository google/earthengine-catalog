var mean_0_20 =
'<RasterSymbolizer>' +
 '<ColorMap type="ramp">' +
  '<ColorMapEntry color="#00204D" label="0-8" opacity="1" quantity="8"/>' +
  '<ColorMapEntry color="#002D6C" label="8-14" opacity="1" quantity="14"/>' +
  '<ColorMapEntry color="#16396D" label="14-17" opacity="1" quantity="17"/>' +
  '<ColorMapEntry color="#36476B" label="17-19" opacity="1" quantity="19"/>' +
  '<ColorMapEntry color="#4B546C" label="19-21" opacity="1" quantity="21"/>' +
  '<ColorMapEntry color="#5C616E" label="21-22" opacity="1" quantity="22"/>' +
  '<ColorMapEntry color="#6C6E72" label="22-24" opacity="1" quantity="24"/>' +
  '<ColorMapEntry color="#7C7B78" label="24-25" opacity="1" quantity="25"/>' +
  '<ColorMapEntry color="#8E8A79" label="25-26" opacity="1" quantity="26"/>' +
  '<ColorMapEntry color="#A09877" label="26-28" opacity="1" quantity="28"/>' +
  '<ColorMapEntry color="#B3A772" label="28-30" opacity="1" quantity="30"/>' +
  '<ColorMapEntry color="#C6B66B" label="30-31" opacity="1" quantity="31"/>' +
  '<ColorMapEntry color="#DBC761" label="31-33" opacity="1" quantity="33"/>' +
  '<ColorMapEntry color="#F0D852" label="33-36" opacity="1" quantity="36"/>' +
  '<ColorMapEntry color="#FFEA46" label="36-70" opacity="1" quantity="40"/>' +
 '</ColorMap>' +
 '<ContrastEnhancement/>' +
'</RasterSymbolizer>';

var mean_20_50 =
'<RasterSymbolizer>' +
 '<ColorMap type="ramp">' +
  '<ColorMapEntry color="#00204D" label="0-8" opacity="1" quantity="8"/>' +
  '<ColorMapEntry color="#002D6C" label="8-14" opacity="1" quantity="14"/>' +
  '<ColorMapEntry color="#16396D" label="14-17" opacity="1" quantity="17"/>' +
  '<ColorMapEntry color="#36476B" label="17-19" opacity="1" quantity="19"/>' +
  '<ColorMapEntry color="#4B546C" label="19-21" opacity="1" quantity="21"/>' +
  '<ColorMapEntry color="#5C616E" label="21-22" opacity="1" quantity="22"/>' +
  '<ColorMapEntry color="#6C6E72" label="22-24" opacity="1" quantity="24"/>' +
  '<ColorMapEntry color="#7C7B78" label="24-25" opacity="1" quantity="25"/>' +
  '<ColorMapEntry color="#8E8A79" label="25-26" opacity="1" quantity="26"/>' +
  '<ColorMapEntry color="#A09877" label="26-28" opacity="1" quantity="28"/>' +
  '<ColorMapEntry color="#B3A772" label="28-30" opacity="1" quantity="30"/>' +
  '<ColorMapEntry color="#C6B66B" label="30-31" opacity="1" quantity="31"/>' +
  '<ColorMapEntry color="#DBC761" label="31-33" opacity="1" quantity="33"/>' +
  '<ColorMapEntry color="#F0D852" label="33-36" opacity="1" quantity="36"/>' +
  '<ColorMapEntry color="#FFEA46" label="36-70" opacity="1" quantity="40"/>' +
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

var raw = ee.Image("ISDASOIL/Africa/v1/clay_content");
Map.addLayer(
    raw.select(0).sldStyle(mean_0_20), {},
    "Clay content, mean visualization, 0-20 cm");
Map.addLayer(
    raw.select(1).sldStyle(mean_20_50), {},
    "Clay content, mean visualization, 20-50 cm");
Map.addLayer(
    raw.select(2).sldStyle(stdev_0_20), {},
    "Clay content, stdev visualization, 0-20 cm");
Map.addLayer(
    raw.select(3).sldStyle(stdev_20_50), {},
    "Clay content, stdev visualization, 20-50 cm");

var converted = raw.divide(10).exp().subtract(1);

var visualization = {min: 0, max: 50};

Map.setCenter(25, -3, 2);

Map.addLayer(converted.select(0), visualization, "Clay content, mean, 0-20 cm");
