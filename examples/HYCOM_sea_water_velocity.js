var velocity = ee.Image('HYCOM/sea_water_velocity/2014040700').divide(1000);

// Compute speed from velocity.
Map.addLayer(
    velocity.select('velocity_u_0').hypot(velocity.select('velocity_v_0')));

Map.setCenter(-60, 33, 5);
