// Load the collection using the BigQuery connector.
var inaturalist = ee.FeatureCollection.loadBigQueryTable(
  'earth-engine-public-data.inaturalist_open_range_map.multispecies_latest'
)

Map.setCenter(25, 0, 3);

// Create a dictionary to map each species name to a specific color.
var palette = {
  'Panthera leo': '#E4004B',           // Lion
  'Loxodonta africana': '#ED775A',     // African bush elephant
  'Giraffa camelopardalis': '#FAD691', // Giraffe
  'Acinonyx jubatus': '#C9CDCF'        // Cheetah
};

for (var name in palette) {
  var species = inaturalist.filter(ee.Filter.eq('name', name));
  Map.addLayer(species, {color: palette[name]}, name);
}
