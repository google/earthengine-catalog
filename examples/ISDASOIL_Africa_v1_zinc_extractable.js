var mean_0_20 =
'<RasterSymbolizer>' +
 '<ColorMap type="ramp">' +
  '<ColorMapEntry color="#0D0887" label="0-0.6" opacity="1" quantity="5"/>' +
  '<ColorMapEntry color="#350498" label="0.6-0.8" opacity="1" quantity="6"/>' +
  '<ColorMapEntry color="#5402A3" label="0.8-1" opacity="1" quantity="7"/>' +
  '<ColorMapEntry color="#7000A8" label="1-1.2" opacity="1" quantity="8"/>' +
  '<ColorMapEntry color="#8B0AA5" label="1.2-1.5" opacity="1" quantity="9"/>' +
  '<ColorMapEntry color="#A31E9A" label="1.5-1.7" opacity="1" quantity="10"/>' +
  '<ColorMapEntry color="#B93289" label="1.7-2" opacity="1" quantity="11"/>' +
  '<ColorMapEntry color="#CC4678" label="2-2.3" opacity="1" quantity="12"/>' +
  '<ColorMapEntry color="#DB5C68" label="2.3-2.7" opacity="1" quantity="13"/>' +
  '<ColorMapEntry color="#E97158" label="2.7-3.1" opacity="1" quantity="14"/>' +
  '<ColorMapEntry color="#F48849" label="3.1-3.5" opacity="1" quantity="15"/>' +
  '<ColorMapEntry color="#FBA139" label="3.5-4" opacity="1" quantity="16"/>' +
  '<ColorMapEntry color="#FEBC2A" label="4-4.5" opacity="1" quantity="17"/>' +
  '<ColorMapEntry color="#FADA24" label="4.5-5" opacity="1" quantity="18"/>' +
  '<ColorMapEntry color="#F0F921" label="5-125" opacity="1" quantity="19"/>' +
 '</ColorMap>' +
 '<ContrastEnhancement/>' +
'</RasterSymbolizer>';

var mean_20_50 =
'<RasterSymbolizer>' +
 '<ColorMap type="ramp">' +
  '<ColorMapEntry color="#0D0887" label="0-0.6" opacity="1" quantity="5"/>' +
  '<ColorMapEntry color="#350498" label="0.6-0.8" opacity="1" quantity="6"/>' +
  '<ColorMapEntry color="#5402A3" label="0.8-1" opacity="1" quantity="7"/>' +
  '<ColorMapEntry color="#7000A8" label="1-1.2" opacity="1" quantity="8"/>' +
  '<ColorMapEntry color="#8B0AA5" label="1.2-1.5" opacity="1" quantity="9"/>' +
  '<ColorMapEntry color="#A31E9A" label="1.5-1.7" opacity="1" quantity="10"/>' +
  '<ColorMapEntry color="#B93289" label="1.7-2" opacity="1" quantity="11"/>' +
  '<ColorMapEntry color="#CC4678" label="2-2.3" opacity="1" quantity="12"/>' +
  '<ColorMapEntry color="#DB5C68" label="2.3-2.7" opacity="1" quantity="13"/>' +
  '<ColorMapEntry color="#E97158" label="2.7-3.1" opacity="1" quantity="14"/>' +
  '<ColorMapEntry color="#F48849" label="3.1-3.5" opacity="1" quantity="15"/>' +
  '<ColorMapEntry color="#FBA139" label="3.5-4" opacity="1" quantity="16"/>' +
  '<ColorMapEntry color="#FEBC2A" label="4-4.5" opacity="1" quantity="17"/>' +
  '<ColorMapEntry color="#FADA24" label="4.5-5" opacity="1" quantity="18"/>' +
  '<ColorMapEntry color="#F0F921" label="5-125" opacity="1" quantity="19"/>' +
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

var raw = ee.Image("ISDASOIL/Africa/v1/zinc_extractable");
Map.addLayer(
    raw.select(0).sldStyle(mean_0_20), {},
    "Zinc, extractable, mean visualization, 0-20 cm");
Map.addLayer(
    raw.select(1).sldStyle(mean_20_50), {},
    "Zinc, extractable, mean visualization, 20-50 cm");
Map.addLayer(
    raw.select(2).sldStyle(stdev_0_20), {},
    "Zinc, extractable, stdev visualization, 0-20 cm");
Map.addLayer(
    raw.select(3).sldStyle(stdev_20_50), {},
    "Zinc, extractable, stdev visualization, 20-50 cm");

var converted = raw.divide(10).exp().subtract(1);

var visualization = {min: 0, max: 10};

Map.setCenter(25, -3, 2);

Map.addLayer(converted.select(0), visualization, "Zinc, extractable, mean, 0-20 cm");
