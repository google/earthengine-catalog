[GOES](https://www.goes.noaa.gov) satellites are geostationary weather
satellites run by NOAA.

Bands 1-6 are reflective. The dimensionless "reflectance factor" quantity is
normalized by the solar zenith angle. These bands support the characterization
of clouds, vegetation, snow/ice, and aerosols. Bands 7-16 are emissive. The
brightness temperature at the Top-Of-Atmosphere (TOA) is measured in
Kelvin. These bands support the characterization of the surface, clouds, water
vapor, ozone, volcanic ash, and dust based on emissive properties.

The ABI L2 product is used at the basis for all derived products such as the
Fire / Hotspot detection.

GOES file names use the Julian day of the year.  Useful commands:

    # Calendar date to Julian day
    date -d "2019-11-15" +%j

    # Julian day to calendar date:
    year=2019; day=316; date -d "$day days $year-01-01" +%Y%m%d

Data types: (C: CONUS == Continental US, F: Full-disk, M: Mesoscale)

Product    | Description
:------    | :----------------------------------------------
ACHA[CFM]  | AWG Cloud Height Algorithm
ACM[CFM]   | ABI Cloud Mask
ACTP[CFM]  | Cloud Top Phase
CMIP[CFM]  | Cloud and Moisture Imagery
COD[CF]    | Cloud Optical Depth
DMW[CFM]   | Derived Motion Winds (vectors)
FDC[CF]    | Fire
LCFA       | GLM Lightning Cluster-Filter Algorithm (points)
MCMIP[CFM] | Multichannel CMIP
Rad[CFM]   | Radiance in 16 bands

Band, Center wavelen microns, Nickname, Classification, Function:

Channel | Wavelength | Description         | Code    | Use
:------ | :--------- | :------------------ | :------ | :------------------------------------
C01     | 0.47       | Blue                | V       | Aerosols
C01     | 0.47       | Blue                | V       | Aerosols
C02     | 0.64       | Red                 | V       | Clouds
C03     | 0.87       | Veggie              | Near-IR | Veg
C04     | 1.38       | Cirrus              | Near-IR | Cirrus
C05     | 1.61       | Snow/Ice            | Near-IR | Snow/ice discrim, cloud phase
C06     | 2.25       | Cloud Particle Size | Near-IR | Cloud particle size, snow cloud phase
C07     | 3.90       | Shortwave Window    | IR      | Fog, stratus, fire, volcanism
C08     | 6.90       | Upper Tropo Vapor   | IR      | Various atmospheric features
C09     | 6.95       | Mid Tropo Vapor     | IR      | Water vapor features
C10     | 7.34       | Lower Tropo Vapor   | IR      | Water vapor features
C11     | 8.50       | Cloud-Top Phase     | IR      | Cloud-top phase
C12     | 9.61       | Ozone               | IR      | Total column ozone
C13     | 10.35      | Clean IR            | IR      | Clouds
C14     | 11.20      | IR Longwave Window  | IR      | Clouds
C15     | 12.30      | Dirty IR            | IR      | Clouds
C16     | 13.30      | CO                  | IR      | Air temperature, clouds

- [goes-r-series-satellites](https://www.ncdc.noaa.gov/data-access/satellite-data/goes-r-series-satellites)
- [GOES R SERIES PRODUCT DEFINITION AND USERS' GUIDE, VOLUME 1 - MAIN](https://www.goes-r.gov/users/docs/PUG-main-vol1.pdf)
- [GOES-16 Band Reference Guide](https://www.weather.gov/media/crp/GOES_16_Guides_FINALBIS.pdf)
- Wikipedia:
  - [GOES](https://en.wikipedia.org/wiki/Geostationary_Operational_Environmental_Satellite)
  - [GOES-R / GOES-16](https://en.wikipedia.org/wiki/GOES-16)
  - [GOES-S / GOES-17](https://en.wikipedia.org/wiki/GOES-17)
  - [GOES-T / GOES-18](https://en.wikipedia.org/wiki/GOES-T) Launched 2022-Mar-01.  Not yet operational.
- Google Cloud Public Data Pages
  - [goes-16](https://console.cloud.google.com/marketplace/details/noaa-public/goes-16)
  - [goes-17](https://console.cloud.google.com/marketplace/details/noaa-public/goes-17)
- Original data GCS buckets:
  - [gcp-public-data-goes-16](https://console.cloud.google.com/storage/browser/gcp-public-data-goes-16)
  - [gcp-public-data-goes-17](https://console.cloud.google.com/storage/browser/gcp-public-data-goes-17)
