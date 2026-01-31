var radd = ee.ImageCollection('projects/radar-wur/raddalert/v1');
var geography = 'sa' // 'ca' (central america), 'sa' (south america), 'africa' (africa), 'asia' (asia & pacific)


// Add a white background image to the map.
var background = ee.Image(1);
Map.addLayer(background, {min: 0, max: 1});


var forest_baseline = ee.Image(radd.filterMetadata('layer','contains','forest_baseline')
                            .filterMetadata('geography','equals',geography).first())
Map.addLayer(forest_baseline, {palette:['black'], opacity: 0.3},'Forest baseline')
var radd_alert =  ee.Image(radd.filterMetadata('layer','contains','alert')
                            .filterMetadata('geography','equals',geography)
                            .sort('system:time_end', false).first());
Map.addLayer(radd_alert.select('Alert'), {min:2,max:3,palette:['blue','coral']}, 'RADD alert')
Map.addLayer(radd_alert.select('Date'), {min:19000,max:23000, palette: ['ffffcc','800026']}, 'RADD alert date')
if (geography =='ca') {Map.setCenter(-89.11, 16.91,12)}
if (geography =='sa') {Map.setCenter(-75.5,-6.5,12)}
if (geography =='africa') {Map.setCenter(16,4,12)}
if (geography =='asia') {Map.setCenter(133.1,-3.2,12)}
