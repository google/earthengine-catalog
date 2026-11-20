var rectangle = ee.Geometry.Rectangle([-80.0, -20.0, -40.0, 10.0]);

var filterIndex =
    ee.FeatureCollection('LARSE/GEDI/GEDI02_B_003_INDEX')
        .filter(
            'time_start > "2024-08-10T00:00:00Z" && ' +
            'time_end < "2024-08-12T00:00:00Z"')
        .filterBounds(rectangle);

Map.setCenter(-60.0, -5.0, 4);
Map.addLayer(filterIndex, {}, 'GEDI L2B V003 Index');
