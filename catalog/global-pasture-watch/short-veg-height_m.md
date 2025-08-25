Produced by Land &#38; Carbon Lab Global Pasture Watch initiative, the current dataset provides 
**median vegetation height** values (50th percentile) globally at 30-m spatial resolution from 2000 onwards. 
The dataset is based on **ICESat-2 ATL08** median height of vegetation returns and modeled via Machine Learning 
(ensemble Gradient Boosted Trees) using the [**GLAD Landsat ARD** (collection-2)](https://glad.umd.edu/ard/home) 
aggregated every two months (see [Consoli et al., 2024](https://peerj.com/articles/18585/)) and combined with 
additional covariates, including **terrain elevation** ([GEDTM30](https://doi.org/10.7717/peerj.19673)) and **geometric mean temperature**. 

Originally designed for supporting the monitoring of **open ecosystems** (grasslands, open shrublands, savannas, tundra),
the dataset comprises the entire Earth's landmass, thus median height values on forest ecosystems 
should not be interpreted as top of canopy. For comparison with other existing canopy height product access 
the app [GPW Height Comparison Toolkit (GPW-HCT)](https://gpw-lapig.projects.earthengine.app/view/hct).

Estimate of **90% prediction intervals** values (5th & 95th) area available in [OpenLandMap STAC](https://stac.openlandmap.org/gpw_gsvh-30m/collection.json).

**Limitations:** 

- **Vegetation heterogeneity**: In landscapes with scattered shrubs, the 30−m median height can be skewed upward 
by a small amount of woody cover. Users focused on herbaceous biomass should consider using fractional cover maps to 
address sub-pixel mixtures. Future versions may incorporate ICESat-2's vertical structure information for a better 
separation of woody cover.

- **Sub-annual and seasonal patterns**: Current ICESat-2 data density is insufficient to map seasonal height changes common 
in grassy ecosystems. Increased Lidar acquisitions or denser sampling from future missions are needed to capture more frequent snapshots, 
which would improve monitoring of intra-annual changes and disturbances, including grazing, fire, harvesting.

- **Data restrictions and uncertainty**: The training data was restricted to strong-beam, night-time measurements to minimize signal noise, 
and additional filters were applied, but this does not fully account for all sources of data uncertainty on ICESat-2 mission. Furthermore, 
cloud cover and smoke hinder signal penetration, increasing uncertainty of vegetation returns.

- **Difficulty detecting very short vegetation**: Lidar sensors, including ICESat-2, struggle to accurately measure very low canopies, 
especially with sparse cover or partial ground occlusion. Originally, the training data does not identify vegetation less than 50 cm 
from the ground surface, which may lead to overestimation of height in the shortest or most sparse land covers, such as wetland saltpans. 

- **Underestimation of maximum heights**: The trained ML model exhibited a tendency toward the mean, 
which resulted in overly narrow and optimistic [prediction intervals](https://stac.openlandmap.org/gpw_gsvh-30m/collection.json). 
Due to the underestimation of vegetation height in the upper extremes, care should be taken when interpreting absolute values in 
regions with very tall forests, but relative patterns and trends are still informative.

- **Limited independent validation**: While validated against ICESat-2 data (testing set), broader validation 
using airborne or drone Lidar would be necessary for assessing the quality of the dataset at regional level.

**For more information see [Hunter et. al, 2025](https://doi.org/10.1038/s41597-025-05739-6),
[Zenodo](https://doi.org/10.5281/zenodo.15198654) and 
[Global Pasture Watch GitHub site](https://github.com/wri/global-pasture-watch)**