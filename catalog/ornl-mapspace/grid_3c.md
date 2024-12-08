# Three-class global POI-based land use

The three-class global POI-based land use dataset classifies land use into three classes: `residential`, `non-residential` and `open space`.

The methodologies used to generate this dataset are described in this paper [Fan & Thakur, 2023](https://doi.org/10.1080/17538947.2023.2174607).

**Limitations:** The POI data are not collected for US and Greenland. As a result, the land use result does not cover these two regions. The training dataset used to train the land use classification model are based on OpenStreetMap land use polygons. Some regions have better training data samples than other regions. As a result, the land use classification model accuracy are not the same across the globe. In the future, we will further improve the both the POI data and training data coverage for regions that have limited coverages.

**For more information see [MapSpace Program Website](http://mapspace.ornl.gov/).**
