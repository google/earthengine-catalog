var mean_0_200 =
'<RasterSymbolizer>' +
 '<ColorMap type="ramp">' +
  '<ColorMapEntry color="#00204D" label="0-13" opacity="1" quantity="13"/>' +
  '<ColorMapEntry color="#002D6C" label="13-26" opacity="1" quantity="26"/>' +
  '<ColorMapEntry color="#16396D" label="26-39" opacity="1" quantity="39"/>' +
  '<ColorMapEntry color="#36476B" label="39-52" opacity="1" quantity="52"/>' +
  '<ColorMapEntry color="#4B546C" label="52-65" opacity="1" quantity="65"/>' +
  '<ColorMapEntry color="#5C616E" label="65-78" opacity="1" quantity="78"/>' +
  '<ColorMapEntry color="#6C6E72" label="78-91" opacity="1" quantity="91"/>' +
  '<ColorMapEntry color="#7C7B78" label="91-104" opacity="1" quantity="104"/>' +
  '<ColorMapEntry color="#8E8A79" label="104-117" opacity="1" quantity="117"/>' +
  '<ColorMapEntry color="#A09877" label="117-130" opacity="1" quantity="130"/>' +
  '<ColorMapEntry color="#B3A772" label="130-143" opacity="1" quantity="143"/>' +
  '<ColorMapEntry color="#C6B66B" label="143-156" opacity="1" quantity="156"/>' +
  '<ColorMapEntry color="#DBC761" label="156-169" opacity="1" quantity="169"/>' +
  '<ColorMapEntry color="#F0D852" label="169-182" opacity="1" quantity="182"/>' +
  '<ColorMapEntry color="#FFEA46" label="182-200" opacity="1" quantity="195"/>' +
 '</ColorMap>' +
 '<ContrastEnhancement/>' +
'</RasterSymbolizer>';

var stdev_0_200 =
'<RasterSymbolizer>' +
 '<ColorMap type="ramp">' +
  '<ColorMapEntry color="#fde725" label="low" opacity="1" quantity="14"/>' +
  '<ColorMapEntry color="#5dc962" label=" " opacity="1" quantity="18"/>' +
  '<ColorMapEntry color="#20908d" label=" " opacity="1" quantity="21"/>' +
  '<ColorMapEntry color="#3a528b" label=" " opacity="1" quantity="22"/>' +
  '<ColorMapEntry color="#440154" label="high" opacity="1" quantity="25"/>' +
 '</ColorMap>' +
 '<ContrastEnhancement/>' +
'</RasterSymbolizer>';

var raw = ee.Image("ISDASOIL/Africa/v1/bedrock_depth");
Map.addLayer(
    raw.select(0).sldStyle(mean_0_200), {},
    "Bedrock depth, mean visualization, 0-200 cm");
Map.addLayer(
    raw.select(1).sldStyle(stdev_0_200), {},
    "Bedrock depth, stdev visualization, 0-200 cm");

var visualization = {min: 27, max: 200};

Map.setCenter(25, -3, 2);

Map.addLayer(raw.select(0), visualization, "Bedrock depth, mean, 0-200 cm");
