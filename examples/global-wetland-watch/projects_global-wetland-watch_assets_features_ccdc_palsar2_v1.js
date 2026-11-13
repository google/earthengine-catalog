var dataset = ee.ImageCollection('projects/global-wetland-watch/assets/features/ccdc/palsar2/v1');
var ccdc = dataset.mosaic();

// Segment containing date t (fractional year); the last segment if t is later.
var t = 2020.5;
var tStart = ccdc.select('tStart');
var tEnd = ccdc.select('tEnd');
var segment = tStart.lte(t).and(tEnd.gte(t)).arrayArgmax().arrayGet([0])
    .where(tEnd.arrayGet([-1]).lte(t), tEnd.arrayArgmax().arrayGet([0]));

// Harmonic coefficients of that segment, in the order
// [offset, t, cos, sin, cos2, sin2, cos3, sin3].
function coefs(pol) {
  return ccdc.select(pol + '_coefs').arraySlice(0, segment, segment.add(1)).arrayProject([1]);
}

// Annual sine, annual cosine and semi-annual cosine of HH backscatter as RGB:
// colors show the timing and strength of seasonal change, such as flooding.
var hh = coefs('HH');
var seasonal = ee.Image.cat([hh.arrayGet([3]), hh.arrayGet([2]), hh.arrayGet([4])])
    .rename(['HH_sin', 'HH_cos', 'HH_cos2']);

// Predicted HH and HV backscatter (dB) at date t.
var w = 2 * Math.PI * t;
var covariates = ee.Image.constant([1, t, Math.cos(w), Math.sin(w), Math.cos(2 * w),
                                    Math.sin(2 * w), Math.cos(3 * w), Math.sin(3 * w)])
    .toArray();
function predict(pol) {
  return coefs(pol).multiply(covariates).arrayReduce(ee.Reducer.sum(), [0]).arrayGet([0])
      .rename(pol);
}
var predicted = predict('HH').addBands(predict('HV'));

// Sites of interest [lon, lat, zoom]. Change the line below to visit another site,
// e.g. SITES.tonleSap.
var SITES = {
  sudd: [30.5, 7.5, 9],          // Sudd wetland, South Sudan
  tonleSap: [104.0, 12.9, 9],    // Tonle Sap, Cambodia
  mamiraua: [-64.8, -2.5, 9],    // Amazon floodplain, Mamiraua Reserve, Brazil
  congo: [18.0, -0.8, 9],        // Cuvette Centrale, Congo
};
var site = SITES.sudd;

Map.setCenter(site[0], site[1], site[2]);
Map.addLayer(predicted, {bands: ['HH', 'HV', 'HH'], min: [-15, -25, -15], max: [-5, -10, -5]},
             'Predicted HH/HV/HH (mid-2020)', false);
Map.addLayer(seasonal, {min: [-1.5, -2, -1], max: [2, 1, 1]},
             'HH seasonal coefficients (sin, cos, cos2)');
