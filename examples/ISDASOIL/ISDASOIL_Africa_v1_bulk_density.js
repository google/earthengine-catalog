var mean_0_20 =
'<RasterSymbolizer>' +
 '<ColorMap type="ramp">' +
  '<ColorMapEntry color="#00204D" label="0.8-1.05" opacity="1" quantity="105"/>' +
  '<ColorMapEntry color="#002D6C" label="1.05-1.19" opacity="1" quantity="119"/>' +
  '<ColorMapEntry color="#16396D" label="1.19-1.23" opacity="1" quantity="123"/>' +
  '<ColorMapEntry color="#36476B" label="1.23-1.25" opacity="1" quantity="125"/>' +
  '<ColorMapEntry color="#4B546C" label="1.25-1.28" opacity="1" quantity="128"/>' +
  '<ColorMapEntry color="#5C616E" label="1.28-1.31" opacity="1" quantity="131"/>' +
  '<ColorMapEntry color="#6C6E72" label="1.31-1.34" opacity="1" quantity="134"/>' +
  '<ColorMapEntry color="#7C7B78" label="1.34-1.36" opacity="1" quantity="136"/>' +
  '<ColorMapEntry color="#8E8A79" label="1.36-1.38" opacity="1" quantity="138"/>' +
  '<ColorMapEntry color="#A09877" label="1.38-1.41" opacity="1" quantity="141"/>' +
  '<ColorMapEntry color="#B3A772" label="1.41-1.43" opacity="1" quantity="143"/>' +
  '<ColorMapEntry color="#C6B66B" label="1.43-1.45" opacity="1" quantity="145"/>' +
  '<ColorMapEntry color="#DBC761" label="1.45-1.48" opacity="1" quantity="148"/>' +
  '<ColorMapEntry color="#F0D852" label="1.48-1.51" opacity="1" quantity="151"/>' +
  '<ColorMapEntry color="#FFEA46" label="1.51-1.85" opacity="1" quantity="154"/>' +
 '</ColorMap>' +
 '<ContrastEnhancement/>' +
'</RasterSymbolizer>';

var mean_20_50 =
'<RasterSymbolizer>' +
 '<ColorMap type="ramp">' +
  '<ColorMapEntry color="#00204D" label="0.8-1.05" opacity="1" quantity="105"/>' +
  '<ColorMapEntry color="#002D6C" label="1.05-1.19" opacity="1" quantity="119"/>' +
  '<ColorMapEntry color="#16396D" label="1.19-1.23" opacity="1" quantity="123"/>' +
  '<ColorMapEntry color="#36476B" label="1.23-1.25" opacity="1" quantity="125"/>' +
  '<ColorMapEntry color="#4B546C" label="1.25-1.28" opacity="1" quantity="128"/>' +
  '<ColorMapEntry color="#5C616E" label="1.28-1.31" opacity="1" quantity="131"/>' +
  '<ColorMapEntry color="#6C6E72" label="1.31-1.34" opacity="1" quantity="134"/>' +
  '<ColorMapEntry color="#7C7B78" label="1.34-1.36" opacity="1" quantity="136"/>' +
  '<ColorMapEntry color="#8E8A79" label="1.36-1.38" opacity="1" quantity="138"/>' +
  '<ColorMapEntry color="#A09877" label="1.38-1.41" opacity="1" quantity="141"/>' +
  '<ColorMapEntry color="#B3A772" label="1.41-1.43" opacity="1" quantity="143"/>' +
  '<ColorMapEntry color="#C6B66B" label="1.43-1.45" opacity="1" quantity="145"/>' +
  '<ColorMapEntry color="#DBC761" label="1.45-1.48" opacity="1" quantity="148"/>' +
  '<ColorMapEntry color="#F0D852" label="1.48-1.51" opacity="1" quantity="151"/>' +
  '<ColorMapEntry color="#FFEA46" label="1.51-1.85" opacity="1" quantity="154"/>' +
 '</ColorMap>' +
 '<ContrastEnhancement/>' +
'</RasterSymbolizer>';

var stdev_0_20 =
'<RasterSymbolizer>' +
 '<ColorMap type="ramp">' +
  '<ColorMapEntry color="#fde725" label="low" opacity="1" quantity="2"/>' +
  '<ColorMapEntry color="#5dc962" label=" " opacity="1" quantity="4"/>' +
  '<ColorMapEntry color="#20908d" label=" " opacity="1" quantity="5"/>' +
  '<ColorMapEntry color="#3a528b" label=" " opacity="1" quantity="7"/>' +
  '<ColorMapEntry color="#440154" label="high" opacity="1" quantity="9"/>' +
 '</ColorMap>' +
 '<ContrastEnhancement/>' +
'</RasterSymbolizer>';

var stdev_20_50 =
'<RasterSymbolizer>' +
 '<ColorMap type="ramp">' +
  '<ColorMapEntry color="#fde725" label="low" opacity="1" quantity="2"/>' +
  '<ColorMapEntry color="#5dc962" label=" " opacity="1" quantity="4"/>' +
  '<ColorMapEntry color="#20908d" label=" " opacity="1" quantity="5"/>' +
  '<ColorMapEntry color="#3a528b" label=" " opacity="1" quantity="7"/>' +
  '<ColorMapEntry color="#440154" label="high" opacity="1" quantity="9"/>' +
 '</ColorMap>' +
 '<ContrastEnhancement/>' +
'</RasterSymbolizer>';

var raw = ee.Image("ISDASOIL/Africa/v1/bulk_density");
Map.addLayer(
    raw.select(0).sldStyle(mean_0_20), {},
    "Bulk density, mean visualization, 0-20 cm");
Map.addLayer(
    raw.select(1).sldStyle(mean_20_50), {},
    "Bulk density, mean visualization, 20-50 cm");
Map.addLayer(
    raw.select(2).sldStyle(stdev_0_20), {},
    "Bulk density, stdev visualization, 0-20 cm");
Map.addLayer(
    raw.select(3).sldStyle(stdev_20_50), {},
    "Bulk density, stdev visualization, 20-50 cm");

var converted = raw.divide(100)

var visualization = {min: 1, max: 1.5};

Map.setCenter(25, -3, 2);

Map.addLayer(converted.select(0), visualization, "Bulk density, mean, 0-20 cm");
