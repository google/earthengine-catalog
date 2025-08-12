Produced by Land &#38;

Carbon Lab Global Pasture Watch initiative, the current dataset provides 
Gross Primary Productivity (GPP) values globally at 30-m spatial resolution between 2000—2024. 
GPP values are modeled via a light use efficiency (LUE) approach, 
where [GLAD Landsat ARD (collection-2)](https://glad.umd.edu/ard/home) are aggregated every two months 
([Consoli et al., 2024](https://peerj.com/articles/18585/)) and combined with 1-km MODIS 
temperature data and 1° CERES Photosynthetically Active Radiation (PAR). 

### REVISE
The annual Uncalibrated EO-based GPP (UGPP) maps offer yearly estimates of Gross Primary Production (GPP) 
where the maximum light use efficiency (LUEmax) is set to 1 gC/m²/year/MJ for all land cover types. 
This approach provides flexibility for users to later calibrate the GPP values according to specific 
land cover maps or regional conditions. Please refer to the following tutorial in Google Colab on 
how to calibrate the GPP map using a land cover map. The UGPP values are calculated by averaging 
bi-monthly estimations and accumulating them over the full 365-day period. 

These annual UGPP maps, expressed in units of gC/m²/year, are processed and available 
on Google Earth Engine (GEE) via:

Global annual GPP maps are available considering a land cover independent productivity, 
so called uncalibrated GPP, and GPP maps calibrated for grasslands to provide a 
comprehensive view of ecosystem productivity across various land cover types and 
specifically within grasslands.

**Limitations:** TODO.

**For more information see [Isik et. al, 2025](https://doi.org/10.7717/peerj.19774),
[Zenodo](https://doi.org/10.5281/zenodo.15675358) and 
[https://github.com/wri/global-pasture-watch](https://github.com/wri/global-pasture-watch)**