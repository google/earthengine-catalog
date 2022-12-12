var dataset = ee.Image('WRI/GFW/FORMA/alerts');
var formaAlerts = dataset.select('alert_delta');
var formaAlertsVis = {
  min: 25.0,
  max: 75.0,
  palette: ['d65898', 'da68a2'],
};
Map.setCenter(6.746, 46.529, 6);
Map.addLayer(formaAlerts, formaAlertsVis, 'FORMA Alerts');