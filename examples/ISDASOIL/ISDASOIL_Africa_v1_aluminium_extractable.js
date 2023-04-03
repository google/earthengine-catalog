var mean_0_20 =
'<RasterSymbolizer>' +
 '<ColorMap type="ramp">' +
  '<ColorMapEntry color="#000004" label="0-21.2" opacity="1" quantity="31"/>' +
  '<ColorMapEntry color="#0C0927" label="21.2-35.6" opacity="1" quantity="36"/>' +
  '<ColorMapEntry color="#231151" label="35.6-53.6" opacity="1" quantity="40"/>' +
  '<ColorMapEntry color="#410F75" label="53.6-65.7" opacity="1" quantity="42"/>' +
  '<ColorMapEntry color="#5F187F" label="65.7-72.7" opacity="1" quantity="43"/>' +
  '<ColorMapEntry color="#7B2382" label="72.7-80.5" opacity="1" quantity="44"/>' +
  '<ColorMapEntry color="#982D80" label="80.5-89" opacity="1" quantity="45"/>' +
  '<ColorMapEntry color="#B63679" label="89-98.5" opacity="1" quantity="46"/>' +
  '<ColorMapEntry color="#D3436E" label="98.5-108.9" opacity="1" quantity="47"/>' +
  '<ColorMapEntry color="#EB5760" label="108.9-120.5" opacity="1" quantity="48"/>' +
  '<ColorMapEntry color="#F8765C" label="120.5-133.3" opacity="1" quantity="49"/>' +
  '<ColorMapEntry color="#FD9969" label="133.3-147.4" opacity="1" quantity="50"/>' +
  '<ColorMapEntry color="#FEBA80" label="147.4-163" opacity="1" quantity="51"/>' +
  '<ColorMapEntry color="#FDDC9E" label="163-199.3" opacity="1" quantity="53"/>' +
  '<ColorMapEntry color="#FCFDBF" label="199.3-1800" opacity="1" quantity="55"/>' +
 '</ColorMap>' +
 '<ContrastEnhancement/>' +
'</RasterSymbolizer>';

var mean_20_50 =
'<RasterSymbolizer>' +
 '<ColorMap type="ramp">' +
  '<ColorMapEntry color="#000004" label="0-21.2" opacity="1" quantity="31"/>' +
  '<ColorMapEntry color="#0C0927" label="21.2-35.6" opacity="1" quantity="36"/>' +
  '<ColorMapEntry color="#231151" label="35.6-53.6" opacity="1" quantity="40"/>' +
  '<ColorMapEntry color="#410F75" label="53.6-65.7" opacity="1" quantity="42"/>' +
  '<ColorMapEntry color="#5F187F" label="65.7-72.7" opacity="1" quantity="43"/>' +
  '<ColorMapEntry color="#7B2382" label="72.7-80.5" opacity="1" quantity="44"/>' +
  '<ColorMapEntry color="#982D80" label="80.5-89" opacity="1" quantity="45"/>' +
  '<ColorMapEntry color="#B63679" label="89-98.5" opacity="1" quantity="46"/>' +
  '<ColorMapEntry color="#D3436E" label="98.5-108.9" opacity="1" quantity="47"/>' +
  '<ColorMapEntry color="#EB5760" label="108.9-120.5" opacity="1" quantity="48"/>' +
  '<ColorMapEntry color="#F8765C" label="120.5-133.3" opacity="1" quantity="49"/>' +
  '<ColorMapEntry color="#FD9969" label="133.3-147.4" opacity="1" quantity="50"/>' +
  '<ColorMapEntry color="#FEBA80" label="147.4-163" opacity="1" quantity="51"/>' +
  '<ColorMapEntry color="#FDDC9E" label="163-199.3" opacity="1" quantity="53"/>' +
  '<ColorMapEntry color="#FCFDBF" label="199.3-1800" opacity="1" quantity="55"/>' +
 '</ColorMap>' +
 '<ContrastEnhancement/>' +
'</RasterSymbolizer>';

var stdev_0_20 =
'<RasterSymbolizer>' +
 '<ColorMap type="ramp">' +
  '<ColorMapEntry color="#fde725" label="low" opacity="1" quantity="5"/>' +
  '<ColorMapEntry color="#5dc962" label=" " opacity="1" quantity="9"/>' +
  '<ColorMapEntry color="#20908d" label=" " opacity="1" quantity="10"/>' +
  '<ColorMapEntry color="#3a528b" label=" " opacity="1" quantity="12"/>' +
  '<ColorMapEntry color="#440154" label="high" opacity="1" quantity="14"/>' +
 '</ColorMap>' +
 '<ContrastEnhancement/>' +
'</RasterSymbolizer>';

var stdev_20_50 =
'<RasterSymbolizer>' +
 '<ColorMap type="ramp">' +
  '<ColorMapEntry color="#fde725" label="low" opacity="1" quantity="5"/>' +
  '<ColorMapEntry color="#5dc962" label=" " opacity="1" quantity="9"/>' +
  '<ColorMapEntry color="#20908d" label=" " opacity="1" quantity="10"/>' +
  '<ColorMapEntry color="#3a528b" label=" " opacity="1" quantity="12"/>' +
  '<ColorMapEntry color="#440154" label="high" opacity="1" quantity="14"/>' +
 '</ColorMap>' +
 '<ContrastEnhancement/>' +
'</RasterSymbolizer>';

Map.setCenter(25, -3, 2);

var raw = ee.Image("ISDASOIL/Africa/v1/aluminium_extractable");
Map.addLayer(
    raw.select(0).sldStyle(mean_0_20), {},
    "Aluminium, extractable, mean visualization, 0-20 cm");
Map.addLayer(
    raw.select(1).sldStyle(mean_20_50), {},
    "Aluminium, extractable, mean visualization, 20-50 cm");
Map.addLayer(
    raw.select(2).sldStyle(stdev_0_20), {},
    "Aluminium, extractable, stdev visualization, 0-20 cm");
Map.addLayer(
    raw.select(3).sldStyle(stdev_20_50), {},
    "Aluminium, extractable, stdev visualization, 20-50 cm");

var converted = raw.divide(10).exp().subtract(1);
Map.addLayer(
    converted.select(0), {min: 0, max: 100},
    "Aluminium, extractable, mean, 0-20 cm");
