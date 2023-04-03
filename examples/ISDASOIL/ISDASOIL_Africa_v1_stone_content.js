var mean_0_20 =
'<RasterSymbolizer>' +
 '<ColorMap type="ramp">' +
  '<ColorMapEntry color="#00204D" label="0-0.1" opacity="1" quantity="1"/>' +
  '<ColorMapEntry color="#002D6C" label="0.1-0.3" opacity="1" quantity="3"/>' +
  '<ColorMapEntry color="#16396D" label="0.3-0.5" opacity="1" quantity="4"/>' +
  '<ColorMapEntry color="#36476B" label="0.5-0.6" opacity="1" quantity="5"/>' +
  '<ColorMapEntry color="#4B546C" label="0.6-0.8" opacity="1" quantity="6"/>' +
  '<ColorMapEntry color="#5C616E" label="0.8-1" opacity="1" quantity="7"/>' +
  '<ColorMapEntry color="#6C6E72" label="1-1.2" opacity="1" quantity="8"/>' +
  '<ColorMapEntry color="#7C7B78" label="1.2-1.5" opacity="1" quantity="9"/>' +
  '<ColorMapEntry color="#8E8A79" label="1.5-1.7" opacity="1" quantity="10"/>' +
  '<ColorMapEntry color="#A09877" label="1.7-2" opacity="1" quantity="11"/>' +
  '<ColorMapEntry color="#B3A772" label="2-2.3" opacity="1" quantity="12"/>' +
  '<ColorMapEntry color="#C6B66B" label="2.3-2.7" opacity="1" quantity="13"/>' +
  '<ColorMapEntry color="#DBC761" label="2.7-3.1" opacity="1" quantity="14"/>' +
  '<ColorMapEntry color="#F0D852" label="3.1-3.5" opacity="1" quantity="15"/>' +
  '<ColorMapEntry color="#FFEA46" label="3.5-80" opacity="1" quantity="16"/>' +
 '</ColorMap>' +
 '<ContrastEnhancement/>' +
'</RasterSymbolizer>';

var mean_20_50 =
'<RasterSymbolizer>' +
 '<ColorMap type="ramp">' +
  '<ColorMapEntry color="#00204D" label="0-0.1" opacity="1" quantity="1"/>' +
  '<ColorMapEntry color="#002D6C" label="0.1-0.3" opacity="1" quantity="3"/>' +
  '<ColorMapEntry color="#16396D" label="0.3-0.5" opacity="1" quantity="4"/>' +
  '<ColorMapEntry color="#36476B" label="0.5-0.6" opacity="1" quantity="5"/>' +
  '<ColorMapEntry color="#4B546C" label="0.6-0.8" opacity="1" quantity="6"/>' +
  '<ColorMapEntry color="#5C616E" label="0.8-1" opacity="1" quantity="7"/>' +
  '<ColorMapEntry color="#6C6E72" label="1-1.2" opacity="1" quantity="8"/>' +
  '<ColorMapEntry color="#7C7B78" label="1.2-1.5" opacity="1" quantity="9"/>' +
  '<ColorMapEntry color="#8E8A79" label="1.5-1.7" opacity="1" quantity="10"/>' +
  '<ColorMapEntry color="#A09877" label="1.7-2" opacity="1" quantity="11"/>' +
  '<ColorMapEntry color="#B3A772" label="2-2.3" opacity="1" quantity="12"/>' +
  '<ColorMapEntry color="#C6B66B" label="2.3-2.7" opacity="1" quantity="13"/>' +
  '<ColorMapEntry color="#DBC761" label="2.7-3.1" opacity="1" quantity="14"/>' +
  '<ColorMapEntry color="#F0D852" label="3.1-3.5" opacity="1" quantity="15"/>' +
  '<ColorMapEntry color="#FFEA46" label="3.5-80" opacity="1" quantity="16"/>' +
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

var raw = ee.Image("ISDASOIL/Africa/v1/stone_content");
Map.addLayer(
    raw.select(0).sldStyle(mean_0_20), {},
    "Stone content, mean visualization, 0-20 cm");
Map.addLayer(
    raw.select(1).sldStyle(mean_20_50), {},
    "Stone content, mean visualization, 20-50 cm");
Map.addLayer(
    raw.select(2).sldStyle(stdev_0_20), {},
    "Stone content, stdev visualization, 0-20 cm");
Map.addLayer(
    raw.select(3).sldStyle(stdev_20_50), {},
    "Stone content, stdev visualization, 20-50 cm");

var converted = raw.divide(10).exp().subtract(1);

var visualization = {min: 0, max: 6};

Map.setCenter(25, -3, 2);

Map.addLayer(converted.select(0), visualization, "Stone content, mean, 0-20 cm");
