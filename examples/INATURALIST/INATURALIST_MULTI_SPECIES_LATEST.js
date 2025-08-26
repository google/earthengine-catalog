// Define the query to get the four species.
var query = "SELECT name, geometry FROM " +
    "`earth-engine-public-data.inaturalist_open_range_map.multispecies_latest` " +
    "WHERE name IN ('Panthera leo', 'Loxodonta africana', 'Giraffa camelopardalis', 'Acinonyx jubatus')";

// Load the collection using the BigQuery connector.
var mammals = ee.FeatureCollection.runBigQuery(query);

Map.setCenter(25, 0, 3);

// Create a dictionary to map each species name to a specific color.
var palette = {
  'Panthera leo': '#E4004B',           // Lion
  'Loxodonta africana': '#ED775A',     // African bush elephant
  'Giraffa camelopardalis': '#FAD691', // Giraffe
  'Acinonyx jubatus': '#C9CDCF'        // Cheetah
};

for (var name in palette) {
  var species = mammals.filter(ee.Filter.eq('name', name));
  Map.addLayer(species, {color: palette[name]}, name);
}
