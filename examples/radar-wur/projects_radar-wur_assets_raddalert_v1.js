//Accessing RADD forest disturbance alert (Reiche et al.,2021)
//Website: http://radd-alert.wur.nl
//Citation: Reiche et al. (2021): Forest disturbance alerts for the Congo Basin using Sentinel-1, ERL.
//Lisence: CC-BY-4.0

//---------------------------
//Access RADD image collection
//---------------------------
var radd = ee.ImageCollection('projects/radar-wur/raddalert/v1');
var geography = 'sa' // 'ca' (central america), 'sa' (south america), 'africa' (africa), 'asia' (asia & pacific)

print('RADD image collection:', radd)

//----------------------------------------
//Forest baseline 
//Primary humid tropical forest mask 2001 from Turubanova et al (2018) with annual (Africa: 2001-2018; Asia: 2001 - 2019) forest loss (Hansen et al 2013) and mangroves (Bunting et al 2018) removed
//----------------------------------------
var forest_baseline = ee.Image(radd.filterMetadata('layer','contains','forest_baseline')
                            .filterMetadata('geography','equals',geography).first())

print('Forest baseline '+ geography + ':',  forest_baseline)

Map.addLayer(forest_baseline, {palette:['black'], opacity: 0.3},'Forest baseline')

//-----------------
//RADD alert
//-----------------
var radd_alert =  ee.Image(radd.filterMetadata('layer','contains','alert')
                            .filterMetadata('geography','equals',geography)
                            .sort('system:time_end', false).first());

print('RADD alert '+ geography+':',radd_alert)

//RADD alert: 2 = unconfirmed (low confidence) alert; 3 = confirmed (high confidence) alert
Map.addLayer(radd_alert.select('Alert'), {min:2,max:3,palette:['blue','coral']}, 'RADD alert')

//RADD alert date: YYDOY (Year-Year-Day-Of-Year)
var todaysdate = ee.Number.parse(ee.Date(Date.now()).format('yyDDD')) // get today's date for visualization
Map.addLayer(radd_alert.select('Date'), {min:19000,max: todaysdate.getInfo(), palette: ['ffffcc','800026']}, 'RADD alert date')

Map.setOptions('Satellite');

if (geography =='ca') {Map.setCenter(-89.11, 16.91,12)}
if (geography =='sa') {Map.setCenter(-75.5,-6.5,12)}
if (geography =='africa') {Map.setCenter(16,4,12)}
if (geography =='asia') {Map.setCenter(133.1,-3.2,12)}
