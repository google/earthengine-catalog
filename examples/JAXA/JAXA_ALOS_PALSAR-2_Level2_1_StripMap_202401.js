var coll = ee.ImageCollection('JAXA/ALOS/PALSAR-2/Level2_1/StripMap_202401');

var vis = {min: 0, max: 8000};

// Visualize different date ranges
var visualizeDateRange = function(startDate, endDate, layerName) {
  var dateRange = coll.filterDate(startDate, endDate);
  Map.addLayer(dateRange, vis, layerName);
};

visualizeDateRange('2023-06-06', '2023-06-07', 'Before-2023-06-06');
visualizeDateRange('2023-06-12', '2023-06-13', 'Before-2023-06-12');
visualizeDateRange('2022-09-26', '2022-09-27', 'Before-2022-09-26');
visualizeDateRange('2023-12-06', '2023-12-07', 'Before-2023-12-06');
visualizeDateRange('2024-01-01', '2024-01-02', 'After-2024-01-01');
visualizeDateRange('2024-01-02', '2024-01-03', 'After-2024-01-02');
visualizeDateRange('2024-01-03', '2024-01-04', 'After-2024-01-03');
visualizeDateRange('2024-01-08', '2024-01-09', 'After-2024-01-08');

Map.setCenter(137.2228, 37.1204, 8);
