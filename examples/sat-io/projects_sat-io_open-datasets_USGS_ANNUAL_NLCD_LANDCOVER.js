var nlcd_landcover = ee.ImageCollection(
  "projects/sat-io/open-datasets/USGS/ANNUAL_NLCD/LANDCOVER"
);

//Zoom somewhere with a lot of change
Map.setCenter(-115.1393, 36.1408, 10);

// Original class values, continuous remapped values, color palette, and simplified class names
var originalClasses = [
  11, 12, 21, 22, 23, 24, 31, 41, 42, 43, 52, 71, 81, 82, 90, 95,
];
var remappedClasses = ee.List.sequence(1, originalClasses.length);
var palette = [
  "#466b9f",
  "#d1def8",
  "#dec5c5",
  "#d99282",
  "#eb0000",
  "#ab0000",
  "#b3ac9f",
  "#68ab5f",
  "#1c5f2c",
  "#b5c58f",
  "#ccb879",
  "#dfdfc2",
  "#dcd939",
  "#ab6c28",
  "#b8d9eb",
  "#6c9fb8",
];
var classNames = [
  "Open Water",
  "Perennial Ice/Snow",
  "Developed, Open Space",
  "Developed, Low Intensity",
  "Developed, Medium Intensity",
  "Developed, High Intensity",
  "Barren Land",
  "Deciduous Forest",
  "Evergreen Forest",
  "Mixed Forest",
  "Shrub/Scrub",
  "Grassland/Herbaceous",
  "Pasture/Hay",
  "Cultivated Crops",
  "Woody Wetlands",
  "Emergent Herbaceous Wetlands",
];

// Function to remap each image's land cover classes and keep the year property
function remapImage(image) {
  var remapped = image.remap(originalClasses, remappedClasses, null);
  return remapped
    .copyProperties(image, ["year"])
    .set("system:time_start", image.get("system:time_start"));
}

// Apply remapping to the entire collection
var remappedCollection = nlcd_landcover.map(remapImage);

// Visualization parameters
var landCoverVis = {
  min: 1,
  max: remappedClasses.length().getInfo(),
  palette: palette,
};

// Add each year's remapped land cover layer to the map
remappedCollection
  .distinct(["year"]) // Ensure unique years
  .aggregate_array("year") // Retrieve all years for mapping
  .evaluate(function (years) {
    years.forEach(function (year) {
      var yearImage = remappedCollection
        .filter(ee.Filter.eq("year", year))
        .first();
      Map.addLayer(yearImage, landCoverVis, "Land Cover " + year);
    });
  });

// Function to create a legend
function createLegend() {
  var legend = ui.Panel({
    style: {
      position: "bottom-left",
      padding: "8px 15px",
    },
  });

  // Legend Title
  legend.add(
    ui.Label({
      value: "Land Cover Legend",
      style: {
        fontWeight: "bold",
        fontSize: "16px",
        margin: "0 0 4px 0",
        padding: "0",
      },
    })
  );

  // Add each color and label to the legend
  for (var i = 0; i < classNames.length; i++) {
    var colorBox = ui.Label({
      style: {
        backgroundColor: palette[i],
        padding: "8px",
        margin: "0 0 4px 0",
      },
    });
    var description = ui.Label({
      value: classNames[i],
      style: { margin: "0 0 4px 6px" },
    });

    // Add color box and description to a row panel
    var row = ui.Panel({
      widgets: [colorBox, description],
      layout: ui.Panel.Layout.Flow("horizontal"),
    });
    legend.add(row);
  }

  // Add legend to the map
  Map.add(legend);
}

// Call the function to create the legend
createLegend();
