var globathy = ee.Image(
  "projects/sat-io/open-datasets/GLOBathy/GLOBathy_bathymetry"
);

var palettes = require("users/samapriya/utils:palettes");

// Use these visualization parameters, customized by location.
var visParams = { min: 1, max: 700, palette: palettes.extra.blkred };

// Note that the visualization image doesn't require visualization parameters.
Map.addLayer(globathy, visParams, "Globathy Bathymetry (m)");
