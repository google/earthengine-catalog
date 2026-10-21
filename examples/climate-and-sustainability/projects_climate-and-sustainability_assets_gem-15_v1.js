// --- Cyclic Color Palette (256 steps) ---
var elevationPalette = [
  '#f985f8', '#fa84f6', '#fb83f3', '#fc82f1', '#fc81ee', '#fd7feb', '#fd7ee8',
  '#fd7ce5', '#fd7ae2', '#fd78de', '#fd76db', '#fc74d7', '#fc72d4', '#fb70d0',
  '#fb6dcc', '#fa6bc8', '#fa69c5', '#f967c1', '#f864bd', '#f762bb', '#f75fb7',
  '#f65db4', '#f55bae', '#f458aa', '#f356a6', '#f254a3', '#f1519f', '#f04f9b',
  '#ef4c97', '#ee4a94', '#ed4890', '#ec468c', '#ea4388', '#e94184', '#e83f81',
  '#e63d7d', '#e53b79', '#e33975', '#e13771', '#e0356a', '#de3366', '#dc3162',
  '#da2f5e', '#d92d5a', '#d72c56', '#d52a52', '#d3284f', '#d1264b', '#cf2447',
  '#cd2343', '#cb213f', '#ca1c3d', '#c81b39', '#c61935', '#c41832', '#c2172e',
  '#c11727', '#bf1724', '#be1721', '#bd171e', '#bc181b', '#bb1919', '#ba1b16',
  '#b91d14', '#b91f11', '#b9210f', '#b9230d', '#b9260c', '#b9290a', '#ba2b08',
  '#ba2e07', '#bb3106', '#bc3306', '#bc3605', '#bd3905', '#be3b05', '#bf3e04',
  '#c04104', '#c14304', '#c24604', '#c34804', '#c44b04', '#c54d04', '#c65004',
  '#c75204', '#c85404', '#c95705', '#ca5905', '#cb5c05', '#cc5e05', '#cd6105',
  '#cd6305', '#ce6505', '#cf6705', '#d06905', '#d16c05', '#d16f05', '#d27105',
  '#d37305', '#d37505', '#d47705', '#d47a05', '#d57c04', '#d57e04', '#d68104',
  '#d68304', '#d78504', '#d78704', '#d88904', '#d88b04', '#d98e04', '#d99005',
  '#d99205', '#d99406', '#da9707', '#da9908', '#da9b0a', '#daa10d', '#d9a20f',
  '#d9a412', '#d8a515', '#d8a718', '#d7a81c', '#d5a91f', '#d4aa23', '#d3ab27',
  '#d1ac2b', '#cfae2f', '#cdb033', '#cbb137', '#c9b23b', '#c6b33f', '#c4b343',
  '#c1b246', '#beb24a', '#bbb14e', '#b8b052', '#b5af55', '#b2ae59', '#afad5c',
  '#acad5f', '#a8ac62', '#a5ab65', '#a1aa68', '#9dab6b', '#99a96e', '#95a871',
  '#91a774', '#8da677', '#89a57a', '#84a47d', '#7fa280', '#7ba183', '#77a086',
  '#729e89', '#6e9d8c', '#699c8f', '#639b92', '#5e9a95', '#599898', '#53979b',
  '#4e969e', '#4894a1', '#4392a4', '#3d90a7', '#388eaa', '#328cad', '#2d8ab0',
  '#2889b3', '#2387b6', '#1f85b9', '#1a83bc', '#1581bf', '#107fc2', '#0e7dc5',
  '#0c7ac8', '#0a78cb', '#0975ce', '#0973d1', '#096fd4', '#096cd7', '#0969da',
  '#0a66dd', '#0b63e0', '#0c60e3', '#0d5de6', '#0e5ae9', '#0f57ec', '#1154ef',
  '#1251f2', '#144ef5', '#154bf8', '#1748fb', '#1946fd', '#1b44ff', '#1d42ff',
  '#2040ff', '#223fff', '#253eff', '#283dff', '#2b3dff', '#2e3dff', '#313eff',
  '#343fff', '#3740ff', '#3a41ff', '#3d43ff', '#4045ff', '#4347ff', '#4649ff',
  '#494bff', '#4b4dff', '#4e4fff', '#5251ff', '#5553ff', '#5855ff', '#5b57ff',
  '#5e59ff', '#615bff', '#635dff', '#665fff', '#6961ff', '#6c63ff', '#6f65ff',
  '#7267ff', '#7569ff', '#786aff', '#7b6cff', '#7e6eff', '#8170ff', '#8471ff',
  '#8773ff', '#8a75ff', '#8d76ff', '#9077ff', '#9378ff', '#9679ff', '#997aff',
  '#9c7bff', '#a07cff', '#a37dff', '#a77eff', '#aa7fff', '#ae80ff', '#b180ff',
  '#b581ff', '#b882ff', '#bc83ff', '#bf84ff', '#c284ff', '#c585ff', '#c885ff',
  '#cb86ff', '#ce86ff', '#d186ff', '#d486ff', '#d786ff', '#da86ff', '#dd87ff',
  '#e087ff', '#e287ff', '#e587ff', '#e886fe', '#ea86fd', '#ec86fc', '#ee86fb',
  '#f086fa', '#f285f9'
];

// --- GEM-15 Collection & Elevation Bands ---
var gem15Collection = ee.ImageCollection(
    'projects/climate-and-sustainability/assets/gem-15_v1');
var gemMosaic = gem15Collection.mosaic();

var dsm = gemMosaic.select('dsm');
var dtm = gemMosaic.select('dtm');
var dsm_50 = gemMosaic.select('dsm_percentile_50');
var dsm_5 = gemMosaic.select('dsm_percentile_5');
var dsm_95 = gemMosaic.select('dsm_percentile_95');
var dsm_std = gemMosaic.select('dsm_std');

// Structural Heightmap (nDSM)
var heightmap = dsm.subtract(dtm);

// --- Base Global DEMs ---
// They are all based on an EGM2008 geoid, whereas GEM-15 is based on EGM96,
// however the visual difference is minimal. Please perform a geoid correction
// for precise altimetric measurements.
var copernicusDem = ee.ImageCollection('COPERNICUS/DEM/GLO30_2024_1').mosaic().select('DEM');
var alosDem = ee.ImageCollection('JAXA/ALOS/AW3D30/V4_1').mosaic().select('DSM');
var nasadem = ee.Image('NASA/NASADEM_HGT/001').select('elevation');

// --- Cyclic Hillshade Visualization Helper ---
// Because GEM-15 tiles span multiple UTM zones, the mosaic does not retain a
// single native projection. Reproject to a metric grid at native resolution
// before computing hillshade.
function visualizeCyclic(image, cycleMax, nativeScale) {
  cycleMax = cycleMax || 100;
  nativeScale = nativeScale || 15;
  var dem = image.select(0);
  var cycle = ee.Image.constant(cycleMax);

  var gridDem = dem.reproject({
    crs: 'EPSG:3857',
    scale: nativeScale
  });

  var cyclic = gridDem.mod(cycle).add(cycle).mod(cycle);
  var rgb = cyclic.visualize({
    min: 0,
    max: cycleMax,
    palette: elevationPalette
  });

  var hs = ee.Terrain.hillshade(gridDem)
                     .divide(255)
                     .multiply(0.6)
                     .add(0.4);

  var hs3Band = ee.Image.cat([
    hs.rename('vis-red'),
    hs.rename('vis-green'),
    hs.rename('vis-blue')
  ]);

  return rgb.multiply(hs3Band).toByte();
}

// --- Viewport Setup ---
Map.setCenter(2.165, 41.395, 14);

// --- Map Layers ---
Map.addLayer(
    visualizeCyclic(nasadem, 100, 30), {},
    'NASADEM 30m (Cyclic 100m + Hillshade)', false);
Map.addLayer(
    visualizeCyclic(alosDem, 100, 30), {},
    'ALOS AW3D30 (Cyclic 100m + Hillshade)', false);
Map.addLayer(
    visualizeCyclic(copernicusDem, 100, 30), {},
    'Copernicus GLO-30 (Cyclic 100m + Hillshade)', true);
Map.addLayer(
    visualizeCyclic(dtm, 100, 15), {},
    'GEM-15 DTM (Cyclic 100m + Hillshade)', true);
Map.addLayer(
    visualizeCyclic(dsm, 100, 15), {},
    'GEM-15 DSM (Cyclic 100m + Hillshade)', true);
Map.addLayer(
    visualizeCyclic(dsm_50, 100, 15), {},
    'GEM-15 DSM 50th Percentile (Cyclic 100m + Hillshade)', false);
Map.addLayer(
    visualizeCyclic(dsm_5, 100, 15), {},
    'GEM-15 DSM 5th Percentile (Cyclic 100m + Hillshade)', false);
Map.addLayer(
    visualizeCyclic(dsm_95, 100, 15), {},
    'GEM-15 DSM 95th Percentile (Cyclic 100m + Hillshade)', false);
Map.addLayer(
    visualizeCyclic(dsm_std, 100, 15), {},
    'GEM-15 DSM Std (Cyclic 100m + Hillshade)', false);
Map.addLayer(
    heightmap, {min: 0, max: 25, palette: ['white', 'darkgreen']},
    'Heightmap (0-25m)', true);