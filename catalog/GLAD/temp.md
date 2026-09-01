Global maps derived from all Landsat scenes 1999-2025 highlight the changes in open surface water extent during this period. Water and land are mapped in every Landsat scene with cloud, shadow, and ice masked out. The percent of valid observations identified as water are calculated per month. These monthly water percentages are then aggregated by year (annual water percent) and interannual dynamics are mapped both as a three band image highlighting the dynamics types and intensities and as a discrete classification of dynamic type.

    By evaluating the entire time-series, rather than just a start and end year or by epoch, areas that are interannually variable going back and forth between land and water majority states on the annual scale are mapped as wet period, dry period, or high frequency change (changing majority state three or more times). In the 3-band dynamics summary layer, the annual time-series is converted to three points that best describe the annual water percent curve.

    For more details please see the publication: [https://doi.org/10.1016/j.rse.2020.111792](https://doi.org/10.1016/j.rse.2020.111792). Explore the dataset in an Earth Engine App: [https://glad.earthengine.app/view/surface-water-dynamics](https://glad.earthengine.app/view/surface-water-dynamics)

    Note that the percent layers correspond to the temporal percent of the period not the spatial percent of open water coverage and have values of 0-100% and 255 as no data.

    GLAD surface water datasets available:
    - R-G-B interannual dynamics maps
    - interannual stable and change classes
    - annual water percent
    - monthly mean water percent
    - individual month water percent

    **_Interannual stable and change classes_**
    Land: 1 (all years mapped ≤10% water)
    Permanent water: 2 (all years mapped ≥90% water)
    Water gain: 3 (gain of ≥50%)
    Water loss: 4 (loss of ≥50%)
    Dry period: 5 (water to land to water majority states with variation ≥50%)
    Wet period: 6 (land to water to land majority states with variation ≥50%)
    Stable seasonal: 7 (variation <50% and mean annual percent 11-89% or variation ≥33%)
    High interannual variability: 8 (three or more transitions between land and water majority states with variation ≥50%)
    Probable permanent land: 10 (mean annual percent ≤10% and variation <33%)
    Probable permanent water: 11 (mean annual percent ≥90% and variation <33%)
    Sparse data: 12 (less than half the years have data or a total scene observation count less than 1.5 times the number of years)
    No data: 0
