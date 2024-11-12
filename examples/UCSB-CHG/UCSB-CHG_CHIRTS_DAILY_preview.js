var image = ee.Image('UCSB-CHG/CHIRTS/DAILY/1992_05_12');
var max_temperature = image.select('maximum_temperature');

// Define the region of interest to cover the USA.
var areaOfInterest = ee.Geometry.Rectangle([98, 27, 105, 21]);

var visParams = {
    min: 10,
    max: 40,
    palette: ['darkblue', 'blue', 'cyan', 'green', 'yellow', 'orange', 'red', 'darkred']
};

var final_image = max_temperature.visualize(visParams);

Map.setCenter(98, 27, 5);
Map.addLayer(final_image, {}, 'Max Temperature USA');

// Create a 256x256 thumbnail for the USA region.
print(ui.Thumbnail({
    image: final_image,
    params: {
        dimensions: [256, 256],
        region: areaOfInterest,
        format: 'png'
    }
}));
