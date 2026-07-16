Map.setCenter(0, 0, 3);

var sld160 =
'<RasterSymbolizer>' +
'  <ColorMap type="ramp">' +
'    <ColorMapEntry color="#a9a9a9" quantity="0" label="0"/>' +
'    <ColorMapEntry color="#ffffd4" quantity="1" label="1"/>' +
'    <ColorMapEntry color="#ffe5a3" quantity="12" label="12"/>' +
'    <ColorMapEntry color="#fec168" quantity="24" label="24"/>' +
'    <ColorMapEntry color="#fe9828" quantity="48" label="48"/>' +
'    <ColorMapEntry color="#f1851f" quantity="64" label="64"/>' +
'    <ColorMapEntry color="#e57116" quantity="72" label="72"/>' +
'    <ColorMapEntry color="#d95f0d" quantity="84" label="84"/>' +
'    <ColorMapEntry color="#ce570c" quantity="96" label="96"/>' +
'    <ColorMapEntry color="#c4500a" quantity="112" label="112"/>' +
'    <ColorMapEntry color="#b94909" quantity="124" label="124"/>' +
'    <ColorMapEntry color="#ae4207" quantity="136" label="136"/>' +
'    <ColorMapEntry color="#a43b05" quantity="148" label="148"/>' +
'    <ColorMapEntry color="#993404" quantity="160" label="160"/>' +
'  </ColorMap>' +
'</RasterSymbolizer>'

var sld10 = 
'<RasterSymbolizer>' +
'  <ColorMap type="ramp">' +
'    <ColorMapEntry color="#a9a9a9" quantity="0" label="0"/>' +
'    <ColorMapEntry color="#ffffd4" quantity="1" label="1"/>' +
'    <ColorMapEntry color="#ffefb5" quantity="2" label="2"/>' +
'    <ColorMapEntry color="#ffde96" quantity="3" label="2"/>' +
'    <ColorMapEntry color="#fec46c" quantity="4" label="4"/>' +
'    <ColorMapEntry color="#fea73f" quantity="5" label="5"/>' +
'    <ColorMapEntry color="#f68c23" quantity="6" label="6"/>' +
'    <ColorMapEntry color="#e67217" quantity="7" label="7"/>' +
'    <ColorMapEntry color="#d25a0c" quantity="8" label="8"/>' +
'    <ColorMapEntry color="#b64708" quantity="9" label="9"/>' +
'    <ColorMapEntry color="#993404" quantity="10" label="10"/>' +
'  </ColorMap>' +
'</RasterSymbolizer>'

var gld = ee.ImageCollection(
  "projects/global-pasture-watch/assets/gld-1km/v1/livestock-headcount-faostat_m"
)

var gld_2000 = gld.filterDate('2000-01-01', '2001-01-01').first();
var gld_2022 = gld.filterDate('2022-01-01', '2023-01-01').first();

Map.addLayer(gld_2000.select('buffalo').sldStyle(sld160), {}, 'Buffalo headcount (2000)', false);
Map.addLayer(gld_2022.select('buffalo').sldStyle(sld160), {}, 'Buffalo headcount (2022)');

Map.addLayer(gld_2000.select('horse').sldStyle(sld10), {}, 'Horse headcount (2000)', false);
Map.addLayer(gld_2022.select('horse').sldStyle(sld10), {}, 'Horse headcount (2022)');

Map.addLayer(gld_2000.select('goat').sldStyle(sld160), {}, 'Goat headcount (2000)', false);
Map.addLayer(gld_2022.select('goat').sldStyle(sld160), {}, 'Goat headcount (2022)');

Map.addLayer(gld_2000.select('sheep').sldStyle(sld160), {}, 'Sheep headcount (2000)', false);
Map.addLayer(gld_2022.select('sheep').sldStyle(sld160), {}, 'Sheep headcount (2022)');

Map.addLayer(gld_2000.select('cattle').sldStyle(sld160), {}, 'Cattle headcount (2000)', false);
Map.addLayer(gld_2022.select('cattle').sldStyle(sld160), {}, 'Cattle headcount (2022)');