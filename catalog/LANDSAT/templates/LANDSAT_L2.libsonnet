{
  description: |||
    Data provider notes:

    * Data products must contain both optical and thermal data to be
      successfully processed to surface temperature, as ASTER NDVI is
      required to temporally adjust the ASTER GED product to the target Landsat
      scene. Therefore, night time acquisitions cannot be processed to
      surface temperature.

    * A known error exists in the surface temperature retrievals relative
      to clouds and possibly cloud shadows. The characterization of these
      issues has been documented by
      [Cook et al., (2014)](https://doi.org/10.3390/rs61111244).

    * ASTER GED contains areas of missing mean emissivity data required for
      successful ST product generation. If there is missing ASTER GED
      information, there will be missing ST data in those areas.

    * The ASTER GED dataset is created from all clear-sky pixels of ASTER scenes
      acquired from 2000 through 2008. While this dataset has a global spatial
      extent, there are areas missing mean emissivity information due to
      persistent cloud contamination in the ASTER measurements.

    * The USGS further screens unphysical values (emissivity < 0.6) in ASTER
      GED to remove any emissivity underestimation due to undetected clouds. For
      any given pixel with no ASTER GED input or unphysical emissivity value,
      the resulting Landsat ST products have missing pixels. The missing Landsat
      ST pixels will be consistent through time (1982-present) given the static
      nature of ASTER GED mean climatology data. For more information refer to
      [landsat-collection-2-surface-temperature-data-gaps-due-missing](https://www.usgs.gov/landsat-missions/landsat-collection-2-surface-temperature-data-gaps-due-missing-aster-ged)
  |||
}