

Area emissions are estimated from observed XCH4 using a geostatistical inverse
model framework (see ["MethaneAIR L4 Area Sources"](EDF_MethaneSAT_MethaneAIR_L4area) dataset). An atmospheric transport model - 
the Stochastic Time-Inverted Lagrangian Transport model, "STILT";
[Lin et al. (2003)](https://doi.org/10.1029/2002JD003161),
[Fasoli et al. (2018)](https://doi.org/10.5194/gmd-11-2813-2018); driven by
meteorological data from the NOAA High-Resolution Rapid Refresh Model "HRRR" -
is used to link variations in observed XCH4 to potential upwind sources. A
hierarchical approach is used to separate XCH4 variations due to area emissions
from those due to point source emissions or inflow across the domain boundary
(the "background" concentration). Point source emissions are determined
individually (see ["MethaneAIR L4 Point Sources"](EDF_MethaneSAT_MethaneAIR_L4point) dataset) and pre-subtracted from the observed XCH4. An inverse model is then
used to estimate XCH4 inflow across the boundary domain. Finally, area emissions
are estimated using a geostatistical inverse model with an enforced non-negative solution. Total emissions are the sum of area and point source emissions.