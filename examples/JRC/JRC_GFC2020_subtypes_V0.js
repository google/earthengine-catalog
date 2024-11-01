function rgb(r, g, b) {
  var bin = r << 16 | g << 8 | b;
  return (function(h) {
    return new Array(7 - h.length).join('0') + h;
  })(bin.toString(16).toUpperCase());
}
var PALETTE =
    [
      rgb(255, 255, 255), rgb(120, 198, 121), rgb(0, 0, 0),    rgb(0, 0, 0),
      rgb(0, 0, 0),       rgb(0, 0, 0),       rgb(0, 0, 0),    rgb(0, 0, 0),
      rgb(0, 0, 0),       rgb(0, 0, 0),       rgb(0, 104, 55), rgb(0, 0, 0),
      rgb(0, 0, 0),       rgb(0, 0, 0),       rgb(0, 0, 0),    rgb(0, 0, 0),
      rgb(0, 0, 0),       rgb(0, 0, 0),       rgb(0, 0, 0),    rgb(0, 0, 0),
      rgb(204, 102, 0)
    ]

    //**Legend
    // value 1 - Naturally regenerating forest
    // value 10 - Primary forest
    // value 20 - Planted/Plantation forest
    var GFT2020 = ee.ImageCollection('JRC/GFC2020_subtypes/V0').mosaic()
GFT2020 = GFT2020.updateMask(GFT2020.gte(1))
Map.addLayer(
    GFT2020, {min: 0, max: 20, palette: PALETTE},
    'EC JRC Global forest types 2020 – V0')
