Produced by Land &#38;
Carbon Lab Global Pasture Watch initiative, the mapped grassland extent
includes any land cover type, which contains at least 30% of dry or wet
low vegetation, dominated by grasses and forbs (less than 3 meters) 
and a:

- maximum of 50% tree canopy cover (greater than 5 meters),
- maximum of 70% of other woody vegetation (scrubs and open shrubland), and
- maximum of 50% active cropland cover in mosaic landscapes of cropland
 &#38; other vegetation.

The grassland extent is classified into two classes:
- **Cultivated grassland**: Areas where grasses and other forage plants have
been intentionally planted and managed, as well as areas of native 
grassland-type vegetation where they clearly exhibit active and
heavy management for specific human-directed uses, such as directed
grazing of livestock.
- **Natural/Semi-natural grassland**: Relatively undisturbed native
grasslands/short-height vegetation, such as steppes and tundra, 
as well as areas that have experienced varying degrees of human 
activity in the past, which may contain a mix of native and 
introduced species due to historical land use and natural processes. 
In general, they exhibit natural-looking patterns of varied vegetation 
and clearly ordered hydrological relationships throughout the landscape.

The implemented methodology considered [GLAD Landsat ARD-2 images 
](https://glad.umd.edu/ard) (processed into cloud-free bi-monthly 
aggregates, see [Consoli et al, 2024](https://doi.org/10.7717/peerj.18585)
), accompanied by climatic, landform and proximity covariates, 
spatiotemporal machine learning (per-class Random Forest) and over 
2.3 million reference samples (visually interpreted in Very High 
Resolution imagery). Custom probability thresholds (based on five-fold 
spatial cross-validation and balanced precision and recall values) 
were used to derive dominant class maps, 0.32 and 0.42 for 
cultivated and natural/semi-natural grassland probability thresholds, respectively.

**Limitations:** Grassland extent is partly under-predicted in southeastern
Africa (Zimbabwe and Mozambique) and in eastern Australia (shrublands and
woodlands of the Mulga ecoregion). Cropland is misclassified as grassland
in parts of northern Africa, the Arabian Peninsula, Western Australia, 
New Zealand, the center of Bolivia, and Mato Grosso state (Brazil). Due 
to the Landsat 7 SLC failure, regular stripes of grassland probabilities 
are visible at parcel-level, particularly in the year 2012. The usage of 
coarser resolution layers (accessibility maps and MODIS products) 
introduced curvilinear macroscopic errors (due to the downscaling 
strategy based on cubicspline) in Uruguay, Southwest Argentina, South 
of Angola and in the Sahel region in Africa. Users need to be aware 
of the limitations and known issues; whilst considering them 
carefully to ensure appropriate use of maps at this initial prediction 
stage. GPW is working actively to collect systematic feedback via the [Geo-Wiki 
platform](https://www.geo-wiki.org), validate the current version 
and improve future versions of the dataset.

**For more information see [Parente et. al, 2024](http://doi.org/10.1038/s41597-024-04139-6),
[Zenodo](https://zenodo.org/records/13890401) and 
[Global Pasture Watch GitHub site](https://github.com/wri/global-pasture-watch)**