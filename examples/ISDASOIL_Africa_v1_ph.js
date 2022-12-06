var mean_0_20 =
'<RasterSymbolizer>' +
 '<ColorMap type="ramp">' +
  '<ColorMapEntry color="#CC0000" label="3.5-4.6" opacity="1" quantity="46"/>' +
  '<ColorMapEntry color="#FF0000" label="4.6-4.9" opacity="1" quantity="49"/>' +
  '<ColorMapEntry color="#FF5500" label="4.9-5.2" opacity="1" quantity="52"/>' +
  '<ColorMapEntry color="#FFAA00" label="5.2-5.4" opacity="1" quantity="54"/>' +
  '<ColorMapEntry color="#FFFF00" label="5.4-5.5" opacity="1" quantity="55"/>' +
  '<ColorMapEntry color="#D4FF2B" label="5.5-5.6" opacity="1" quantity="56"/>' +
  '<ColorMapEntry color="#AAFF55" label="5.6-5.7" opacity="1" quantity="57"/>' +
  '<ColorMapEntry color="#80FF80" label="5.7-5.9" opacity="1" quantity="59"/>' +
  '<ColorMapEntry color="#55FFAA" label="5.9-6" opacity="1" quantity="60"/>' +
  '<ColorMapEntry color="#2BFFD5" label="6-6.2" opacity="1" quantity="62"/>' +
  '<ColorMapEntry color="#00FFFF" label="6.2-6.3" opacity="1" quantity="63"/>' +
  '<ColorMapEntry color="#00AAFF" label="6.3-6.6" opacity="1" quantity="66"/>' +
  '<ColorMapEntry color="#0055FF" label="6.6-6.8" opacity="1" quantity="68"/>' +
  '<ColorMapEntry color="#0000FF" label="6.8-7.1" opacity="1" quantity="71"/>' +
  '<ColorMapEntry color="#0000CC" label="7.1-10.5" opacity="1" quantity="76"/>' +
 '</ColorMap>' +
 '<ContrastEnhancement/>' +
'</RasterSymbolizer>';

var mean_20_50 =
'<RasterSymbolizer>' +
 '<ColorMap type="ramp">' +
  '<ColorMapEntry color="#CC0000" label="3.5-4.6" opacity="1" quantity="46"/>' +
  '<ColorMapEntry color="#FF0000" label="4.6-4.9" opacity="1" quantity="49"/>' +
  '<ColorMapEntry color="#FF5500" label="4.9-5.2" opacity="1" quantity="52"/>' +
  '<ColorMapEntry color="#FFAA00" label="5.2-5.4" opacity="1" quantity="54"/>' +
  '<ColorMapEntry color="#FFFF00" label="5.4-5.5" opacity="1" quantity="55"/>' +
  '<ColorMapEntry color="#D4FF2B" label="5.5-5.6" opacity="1" quantity="56"/>' +
  '<ColorMapEntry color="#AAFF55" label="5.6-5.7" opacity="1" quantity="57"/>' +
  '<ColorMapEntry color="#80FF80" label="5.7-5.9" opacity="1" quantity="59"/>' +
  '<ColorMapEntry color="#55FFAA" label="5.9-6" opacity="1" quantity="60"/>' +
  '<ColorMapEntry color="#2BFFD5" label="6-6.2" opacity="1" quantity="62"/>' +
  '<ColorMapEntry color="#00FFFF" label="6.2-6.3" opacity="1" quantity="63"/>' +
  '<ColorMapEntry color="#00AAFF" label="6.3-6.6" opacity="1" quantity="66"/>' +
  '<ColorMapEntry color="#0055FF" label="6.6-6.8" opacity="1" quantity="68"/>' +
  '<ColorMapEntry color="#0000FF" label="6.8-7.1" opacity="1" quantity="71"/>' +
  '<ColorMapEntry color="#0000CC" label="7.1-10.5" opacity="1" quantity="76"/>' +
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
var raw = ee.Image("ISDASOIL/Africa/v1/ph");
Map.addLayer(
    raw.select(0).sldStyle(mean_0_20), {},
    "ph, mean visualization, 0-20 cm");
Map.addLayer(
    raw.select(1).sldStyle(mean_20_50), {},
    "ph, mean visualization, 20-50 cm");
Map.addLayer(
    raw.select(2).sldStyle(stdev_0_20), {},
    "ph, stdev visualization, 0-20 cm");
Map.addLayer(
    raw.select(3).sldStyle(stdev_20_50), {},
    "ph, stdev visualization, 20-50 cm");

var converted = raw.divide(10);

var visualization = {min: 4, max: 8};

Map.setCenter(25, -3, 2);

Map.addLayer(converted.select(0), visualization, "ph, mean, 0-20 cm");
