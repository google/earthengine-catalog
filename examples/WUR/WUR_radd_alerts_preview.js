// Define Radd alerts IC
var radd = ee.ImageCollection('projects/radar-wur/raddalert/v1');
var geography = 'africa'
var radd_alert =  ee.Image(radd.filterMetadata('layer','contains','alert')
                            .filterMetadata('geography','equals',geography)
                            .sort('system:time_end', false).first());
                            

// Define Roi
var areaOfInterest =  ee.Geometry.Polygon(
        [[[15.944530137140882, 4.021414579571982],
          [15.944530137140882, 3.866942794015676],
          [16.108638413508068, 3.866942794015676],
          [16.108638413508068, 4.021414579571982]]], null, false);
          

var visParams = {
  dimensions: [256, 256], // Width and height of the thumbnail image.
  region: areaOfInterest,
  format: 'png'
};

var image = radd_alert.select('Date').visualize({min:19000,max:23000,palette: ['ffffcc','800026']});

print(ui.Thumbnail({image: image, params: visParams}));
