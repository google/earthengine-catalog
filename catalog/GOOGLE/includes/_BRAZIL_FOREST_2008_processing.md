

### Processing methodology

Please see the [methodology guide](/earth-engine/guides/spot_brazil_forest_imagery_dataset_2008_v1) for an in-depth description of the processing, including:

* **Radiometric calibration:** Raw digital numbers were converted to TOA reflectance using band-specific physical gain and bias metadata, normalized by solar irradiance and Earth-Sun distance.
* **Radiometric normalization:** To minimize inter-image radiometric discontinuities pixel values were adjusted via histogram matching to a consistent Landsat 2008 mosaic target.
* **Edge refinement:** Google applied a 2.5-pixel focal minimum erosion to image masks to remove lossy compression artifacts present in the source data.
* **Cloud masking:** Trained surveyors manually delineated polygons around clouds and shadows, which were converted to a mask to ensure that only the most useful pixels are included in the composite.
* **Automated misregistration correction:** Select scenes were coregistered using the `ee.Image.register` algorithm against a 2008-era Landsat reference composite.
* **Composition:** The final mosaic prioritizes the highest resolution pixels available, layering SPOT 5 imagery (10 m) on top of SPOT 4 and 2\.
