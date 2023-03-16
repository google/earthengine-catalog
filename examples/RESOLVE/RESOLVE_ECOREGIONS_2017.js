var ecoRegions = ee.FeatureCollection("RESOLVE/ECOREGIONS/2017");

// patch updated colors
var colorUpdates = [
{ECO_ID: 204, COLOR: '#B3493B'},
{ECO_ID: 245, COLOR: '#267400'},
{ECO_ID: 259, COLOR: '#004600'},
{ECO_ID: 286, COLOR: '#82F178'},
{ECO_ID: 316, COLOR: '#E600AA'},
{ECO_ID: 453, COLOR: '#5AA500'},
{ECO_ID: 317, COLOR: '#FDA87F'},
{ECO_ID: 763, COLOR: '#A93800'},
];

// loop over all other features and create a new style property for styling
// later on
var ecoRegions = ecoRegions.map(function(f) {
  var color = f.get('COLOR');
  return f.set({style: {color: color, width: 0}});
});

// make styled features for the regions we need to update colors for,
// then strip them from the main asset and merge in the new feature
for (var i=0; i < colorUpdates.length; i++) {
  colorUpdates[i].layer = ecoRegions
      .filterMetadata('ECO_ID','equals',colorUpdates[i].ECO_ID)
      .map(function(f) {
        return f.set({style: {color: colorUpdates[i].COLOR, width: 0}});
      });

  ecoRegions = ecoRegions
      .filterMetadata('ECO_ID','not_equals',colorUpdates[i].ECO_ID)
      .merge(colorUpdates[i].layer);
}

// use style property to color shapes
var imageRGB = ecoRegions.style({styleProperty: 'style'});

Map.setCenter(16, 49, 4);
Map.addLayer(imageRGB, {}, 'RESOLVE/ECOREGIONS/2017');
