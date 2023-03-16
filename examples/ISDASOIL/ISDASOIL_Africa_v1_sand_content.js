var mean_0_20 =
'<RasterSymbolizer>' +
 '<ColorMap type="ramp">' +
  '<ColorMapEntry color="#00204D" label="0-31" opacity="1" quantity="31"/>' +
  '<ColorMapEntry color="#002D6C" label="31-39" opacity="1" quantity="39"/>' +
  '<ColorMapEntry color="#16396D" label="39-43" opacity="1" quantity="43"/>' +
  '<ColorMapEntry color="#36476B" label="43-46" opacity="1" quantity="46"/>' +
  '<ColorMapEntry color="#4B546C" label="46-49" opacity="1" quantity="49"/>' +
  '<ColorMapEntry color="#5C616E" label="49-52" opacity="1" quantity="52"/>' +
  '<ColorMapEntry color="#6C6E72" label="52-54" opacity="1" quantity="54"/>' +
  '<ColorMapEntry color="#7C7B78" label="54-56" opacity="1" quantity="56"/>' +
  '<ColorMapEntry color="#8E8A79" label="56-58" opacity="1" quantity="58"/>' +
  '<ColorMapEntry color="#A09877" label="58-60" opacity="1" quantity="60"/>' +
  '<ColorMapEntry color="#B3A772" label="60-63" opacity="1" quantity="63"/>' +
  '<ColorMapEntry color="#C6B66B" label="63-65" opacity="1" quantity="65"/>' +
  '<ColorMapEntry color="#DBC761" label="65-68" opacity="1" quantity="68"/>' +
  '<ColorMapEntry color="#F0D852" label="68-71" opacity="1" quantity="71"/>' +
  '<ColorMapEntry color="#FFEA46" label="71-100" opacity="1" quantity="75"/>' +
 '</ColorMap>' +
 '<ContrastEnhancement/>' +
'</RasterSymbolizer>';

var mean_20_50 =
'<RasterSymbolizer>' +
 '<ColorMap type="ramp">' +
  '<ColorMapEntry color="#00204D" label="0-31" opacity="1" quantity="31"/>' +
  '<ColorMapEntry color="#002D6C" label="31-39" opacity="1" quantity="39"/>' +
  '<ColorMapEntry color="#16396D" label="39-43" opacity="1" quantity="43"/>' +
  '<ColorMapEntry color="#36476B" label="43-46" opacity="1" quantity="46"/>' +
  '<ColorMapEntry color="#4B546C" label="46-49" opacity="1" quantity="49"/>' +
  '<ColorMapEntry color="#5C616E" label="49-52" opacity="1" quantity="52"/>' +
  '<ColorMapEntry color="#6C6E72" label="52-54" opacity="1" quantity="54"/>' +
  '<ColorMapEntry color="#7C7B78" label="54-56" opacity="1" quantity="56"/>' +
  '<ColorMapEntry color="#8E8A79" label="56-58" opacity="1" quantity="58"/>' +
  '<ColorMapEntry color="#A09877" label="58-60" opacity="1" quantity="60"/>' +
  '<ColorMapEntry color="#B3A772" label="60-63" opacity="1" quantity="63"/>' +
  '<ColorMapEntry color="#C6B66B" label="63-65" opacity="1" quantity="65"/>' +
  '<ColorMapEntry color="#DBC761" label="65-68" opacity="1" quantity="68"/>' +
  '<ColorMapEntry color="#F0D852" label="68-71" opacity="1" quantity="71"/>' +
  '<ColorMapEntry color="#FFEA46" label="71-100" opacity="1" quantity="75"/>' +
 '</ColorMap>' +
 '<ContrastEnhancement/>' +
'</RasterSymbolizer>';

var stdev_0_20 =
'<RasterSymbolizer>' +
 '<ColorMap type="ramp">' +
  '<ColorMapEntry color="#fde725" label="low" opacity="1" quantity="2"/>' +
  '<ColorMapEntry color="#5dc962" label=" " opacity="1" quantity="3"/>' +
  '<ColorMapEntry color="#20908d" label=" " opacity="1" quantity="4"/>' +
  '<ColorMapEntry color="#3a528b" label=" " opacity="1" quantity="6"/>' +
  '<ColorMapEntry color="#440154" label="high" opacity="1" quantity="7"/>' +
 '</ColorMap>' +
 '<ContrastEnhancement/>' +
'</RasterSymbolizer>';

var stdev_20_50 =
'<RasterSymbolizer>' +
 '<ColorMap type="ramp">' +
  '<ColorMapEntry color="#fde725" label="low" opacity="1" quantity="2"/>' +
  '<ColorMapEntry color="#5dc962" label=" " opacity="1" quantity="3"/>' +
  '<ColorMapEntry color="#20908d" label=" " opacity="1" quantity="4"/>' +
  '<ColorMapEntry color="#3a528b" label=" " opacity="1" quantity="6"/>' +
  '<ColorMapEntry color="#440154" label="high" opacity="1" quantity="7"/>' +
 '</ColorMap>' +
 '<ContrastEnhancement/>' +
'</RasterSymbolizer>';
var raw = ee.Image("ISDASOIL/Africa/v1/sand_content");
Map.addLayer(
    raw.select(0).sldStyle(mean_0_20), {},
    "Sand content, mean visualization, 0-20 cm");
Map.addLayer(
    raw.select(1).sldStyle(mean_20_50), {},
    "Sand content, mean visualization, 20-50 cm");
Map.addLayer(
    raw.select(2).sldStyle(stdev_0_20), {},
    "Sand content, stdev visualization, 0-20 cm");
Map.addLayer(
    raw.select(3).sldStyle(stdev_20_50), {},
    "Sand content, stdev visualization, 20-50 cm");

var converted = raw.divide(10).exp().subtract(1);

var visualization = {min: 0, max: 3000};

Map.setCenter(25, -3, 2);

Map.addLayer(converted.select(0), visualization, "Sand content, mean, 0-20 cm");
