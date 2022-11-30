var mean_0_20 =
'<RasterSymbolizer>' +
 '<ColorMap type="ramp">' +
  '<ColorMapEntry color="#000004" label="0-0.2" opacity="1" quantity="20"/>' +
  '<ColorMapEntry color="#0C0927" label="0.2-0.3" opacity="1" quantity="30"/>' +
  '<ColorMapEntry color="#231151" label="0.3-0.4" opacity="1" quantity="36"/>' +
  '<ColorMapEntry color="#410F75" label="0.4-0.5" opacity="1" quantity="43"/>' +
  '<ColorMapEntry color="#5F187F" label="0.5-0.6" opacity="1" quantity="48"/>' +
  '<ColorMapEntry color="#7B2382" label="0.6-0.7" opacity="1" quantity="52"/>' +
  '<ColorMapEntry color="#982D80" label="0.7-0.8" opacity="1" quantity="58"/>' +
  '<ColorMapEntry color="#B63679" label="0.8-0.9" opacity="1" quantity="64"/>' +
  '<ColorMapEntry color="#D3436E" label="0.9-1" opacity="1" quantity="67"/>' +
  '<ColorMapEntry color="#EB5760" label="1-1.1" opacity="1" quantity="75"/>' +
  '<ColorMapEntry color="#F8765C" label="1.1-1.2" opacity="1" quantity="79"/>' +
  '<ColorMapEntry color="#FD9969" label="1.2-1.3" opacity="1" quantity="83"/>' +
  '<ColorMapEntry color="#FEBA80" label="1.3-1.4" opacity="1" quantity="89"/>' +
  '<ColorMapEntry color="#FDDC9E" label="1.4-1.5" opacity="1" quantity="93"/>' +
  '<ColorMapEntry color="#FCFDBF" label="1.5-10" opacity="1" quantity="99"/>' +
 '</ColorMap>' +
 '<ContrastEnhancement/>' +
'</RasterSymbolizer>';

var mean_20_50 =
'<RasterSymbolizer>' +
 '<ColorMap type="ramp">' +
  '<ColorMapEntry color="#000004" label="0-0.2" opacity="1" quantity="20"/>' +
  '<ColorMapEntry color="#0C0927" label="0.2-0.3" opacity="1" quantity="30"/>' +
  '<ColorMapEntry color="#231151" label="0.3-0.4" opacity="1" quantity="36"/>' +
  '<ColorMapEntry color="#410F75" label="0.4-0.5" opacity="1" quantity="43"/>' +
  '<ColorMapEntry color="#5F187F" label="0.5-0.6" opacity="1" quantity="48"/>' +
  '<ColorMapEntry color="#7B2382" label="0.6-0.7" opacity="1" quantity="52"/>' +
  '<ColorMapEntry color="#982D80" label="0.7-0.8" opacity="1" quantity="58"/>' +
  '<ColorMapEntry color="#B63679" label="0.8-0.9" opacity="1" quantity="64"/>' +
  '<ColorMapEntry color="#D3436E" label="0.9-1" opacity="1" quantity="67"/>' +
  '<ColorMapEntry color="#EB5760" label="1-1.1" opacity="1" quantity="75"/>' +
  '<ColorMapEntry color="#F8765C" label="1.1-1.2" opacity="1" quantity="79"/>' +
  '<ColorMapEntry color="#FD9969" label="1.2-1.3" opacity="1" quantity="83"/>' +
  '<ColorMapEntry color="#FEBA80" label="1.3-1.4" opacity="1" quantity="89"/>' +
  '<ColorMapEntry color="#FDDC9E" label="1.4-1.5" opacity="1" quantity="93"/>' +
  '<ColorMapEntry color="#FCFDBF" label="1.5-10" opacity="1" quantity="99"/>' +
 '</ColorMap>' +
 '<ContrastEnhancement/>' +
'</RasterSymbolizer>';

var stdev_0_20 =
'<RasterSymbolizer>' +
 '<ColorMap type="ramp">' +
  '<ColorMapEntry color="#fde725" label="low" opacity="1" quantity="1"/>' +
  '<ColorMapEntry color="#5dc962" label=" " opacity="1" quantity="8"/>' +
  '<ColorMapEntry color="#20908d" label=" " opacity="1" quantity="10"/>' +
  '<ColorMapEntry color="#3a528b" label=" " opacity="1" quantity="14"/>' +
  '<ColorMapEntry color="#440154" label="high" opacity="1" quantity="60"/>' +
 '</ColorMap>' +
 '<ContrastEnhancement/>' +
'</RasterSymbolizer>';

var stdev_20_50 =
'<RasterSymbolizer>' +
 '<ColorMap type="ramp">' +
  '<ColorMapEntry color="#fde725" label="low" opacity="1" quantity="1"/>' +
  '<ColorMapEntry color="#5dc962" label=" " opacity="1" quantity="8"/>' +
  '<ColorMapEntry color="#20908d" label=" " opacity="1" quantity="10"/>' +
  '<ColorMapEntry color="#3a528b" label=" " opacity="1" quantity="14"/>' +
  '<ColorMapEntry color="#440154" label="high" opacity="1" quantity="60"/>' +
 '</ColorMap>' +
 '<ContrastEnhancement/>' +
'</RasterSymbolizer>';

var raw = ee.Image("ISDASOIL/Africa/v1/nitrogen_total");
Map.addLayer(
    raw.select(0).sldStyle(mean_0_20), {},
    "Nitrogen, total, mean visualization, 0-20 cm");
Map.addLayer(
    raw.select(1).sldStyle(mean_20_50), {},
    "Nitrogen, total, mean visualization, 20-50 cm");
Map.addLayer(
    raw.select(2).sldStyle(stdev_0_20), {},
    "Nitrogen, total, stdev visualization, 0-20 cm");
Map.addLayer(
    raw.select(3).sldStyle(stdev_20_50), {},
    "Nitrogen, total, stdev visualization, 20-50 cm");

var converted = raw.divide(100).exp().subtract(1);

var visualization = {min: 0, max: 10000};

Map.setCenter(25, -3, 2);

Map.addLayer(converted.select(0), visualization, "Nitrogen, total, mean, 0-20 cm");
