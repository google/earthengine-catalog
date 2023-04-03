var mean_0_20 =
'<RasterSymbolizer>' +
 '<ColorMap type="ramp">' +
  '<ColorMapEntry color="#00204D" label="0-7" opacity="1" quantity="7"/>' +
  '<ColorMapEntry color="#002D6C" label="7-9" opacity="1" quantity="9"/>' +
  '<ColorMapEntry color="#16396D" label="9-10" opacity="1" quantity="10"/>' +
  '<ColorMapEntry color="#36476B" label="10-11" opacity="1" quantity="11"/>' +
  '<ColorMapEntry color="#4B546C" label="11-12" opacity="1" quantity="12"/>' +
  '<ColorMapEntry color="#5C616E" label="12-13" opacity="1" quantity="13"/>' +
  '<ColorMapEntry color="#6C6E72" label="13-14" opacity="1" quantity="14"/>' +
  '<ColorMapEntry color="#7C7B78" label="14-15" opacity="1" quantity="15"/>' +
  '<ColorMapEntry color="#8E8A79" label="15-16" opacity="1" quantity="16"/>' +
  '<ColorMapEntry color="#A09877" label="16-17" opacity="1" quantity="17"/>' +
  '<ColorMapEntry color="#B3A772" label="17-18" opacity="1" quantity="18"/>' +
  '<ColorMapEntry color="#C6B66B" label="18-19" opacity="1" quantity="19"/>' +
  '<ColorMapEntry color="#DBC761" label="19-20" opacity="1" quantity="20"/>' +
  '<ColorMapEntry color="#F0D852" label="20-22" opacity="1" quantity="22"/>' +
  '<ColorMapEntry color="#FFEA46" label="22-70" opacity="1" quantity="24"/>' +
 '</ColorMap>' +
 '<ContrastEnhancement/>' +
'</RasterSymbolizer>';

var mean_20_50 =
'<RasterSymbolizer>' +
 '<ColorMap type="ramp">' +
  '<ColorMapEntry color="#00204D" label="0-7" opacity="1" quantity="7"/>' +
  '<ColorMapEntry color="#002D6C" label="7-9" opacity="1" quantity="9"/>' +
  '<ColorMapEntry color="#16396D" label="9-10" opacity="1" quantity="10"/>' +
  '<ColorMapEntry color="#36476B" label="10-11" opacity="1" quantity="11"/>' +
  '<ColorMapEntry color="#4B546C" label="11-12" opacity="1" quantity="12"/>' +
  '<ColorMapEntry color="#5C616E" label="12-13" opacity="1" quantity="13"/>' +
  '<ColorMapEntry color="#6C6E72" label="13-14" opacity="1" quantity="14"/>' +
  '<ColorMapEntry color="#7C7B78" label="14-15" opacity="1" quantity="15"/>' +
  '<ColorMapEntry color="#8E8A79" label="15-16" opacity="1" quantity="16"/>' +
  '<ColorMapEntry color="#A09877" label="16-17" opacity="1" quantity="17"/>' +
  '<ColorMapEntry color="#B3A772" label="17-18" opacity="1" quantity="18"/>' +
  '<ColorMapEntry color="#C6B66B" label="18-19" opacity="1" quantity="19"/>' +
  '<ColorMapEntry color="#DBC761" label="19-20" opacity="1" quantity="20"/>' +
  '<ColorMapEntry color="#F0D852" label="20-22" opacity="1" quantity="22"/>' +
  '<ColorMapEntry color="#FFEA46" label="22-70" opacity="1" quantity="24"/>' +
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
  '<ColorMapEntry color="#440154" label="high" opacity="1" quantity="4.19000000000005"/>' +
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
  '<ColorMapEntry color="#440154" label="high" opacity="1" quantity="4.19000000000005"/>' +
 '</ColorMap>' +
 '<ContrastEnhancement/>' +
'</RasterSymbolizer>';

var raw = ee.Image("ISDASOIL/Africa/v1/silt_content");
Map.addLayer(
    raw.select(0).sldStyle(mean_0_20), {},
    "Silt content, mean visualization, 0-20 cm");
Map.addLayer(
    raw.select(1).sldStyle(mean_20_50), {},
    "Silt content, mean visualization, 20-50 cm");
Map.addLayer(
    raw.select(2).sldStyle(stdev_0_20), {},
    "Silt content, stdev visualization, 0-20 cm");
Map.addLayer(
    raw.select(3).sldStyle(stdev_20_50), {},
    "Silt content, stdev visualization, 20-50 cm");

var converted = raw.divide(10).exp().subtract(1);

var visualization = {min: 0, max: 15};

Map.setCenter(25, -3, 2);

Map.addLayer(converted.select(0), visualization, "Silt content, mean, 0-20 cm");
