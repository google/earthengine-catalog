import {ACCOUNT_SPEND_DECIMAL_FORMAT} from 'google3/customer_support/cases/companion_apps/billing_assist/companion_app/shared/constants/constants';var dataset = ee.Image('WRI/GFW/FORMA/alerts');
var formaAlerts = dataset.select('alert_delta');
var formaAlertsVis = {
  min: 25,
  max: 75,
  palette: ['d65898', 'da68a2'],
};
Map.setCenter(6.746, 46.529, 6);
Map.addLayer(formaAlerts, formaAlertsVis, 'FORMA Alerts');
