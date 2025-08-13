Produced by Land &#38; Carbon Lab Global Pasture Watch initiative, the current dataset provides 
Gross Primary Productivity (GPP) values globally at 30-m spatial resolution between 2000—2024. 
GPP values are modeled via a light use efficiency (LUE) approach, 
where [GLAD Landsat ARD (collection-2)](https://glad.umd.edu/ard/home) are aggregated every two months 
([Consoli et al., 2024](https://peerj.com/articles/18585/)) and combined with 1-km MODIS 
temperature data and 1° CERES Photosynthetically Active Radiation (PAR). 

To keep the dataset flexible, the maximum light use efficiency (LUEmax) is set to 1 gC/m²/day/MJ 
for all land cover types, allowing the users to later calibrate the 
GPP values according to specific land cover maps or regional conditions.

Bi-monthly uncalibrated Gross Primary Productivity (uGPP) values (available in [OpenLandMap STAC](https://stac.openlandmap.org/gpw_ugpp.daily-30m/collection.json))
are averated by each year and accumulated over the full 365-day period to produce
global annual uGPP values, expressed in units of gC/m²/year.

**Limitations:** Cloud cover, snow, and atmospheric artifacts can cause data gaps in satellite imagery inputs, 
which affects the quality of GPP values. While gap-filling techniques can help, they may introduce their 
own issues, such as stripe effects from sensor malfunctions (Landsat 7 Scan Line Corrector failure) or 
errors from the reconstruction algorithms ([Consoli et al., 2024](https://peerj.com/articles/18585/)). 
These artifacts can disrupt the spatial continuity of GPP values. Additionally, the limited 
temporal resolution of bimonthly GPP estimations may miss key growth periods or a plant's 
rapid responses to environmental changes, making it difficult to accurately capture productivity 
peaks and seasonal variation

**For more information see [Isik et. al, 2025](https://doi.org/10.7717/peerj.19774),
[Zenodo](https://doi.org/10.5281/zenodo.15675358) and 
[https://github.com/wri/global-pasture-watch](https://github.com/wri/global-pasture-watch)**