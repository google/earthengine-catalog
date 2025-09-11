{
  description: |||
    Landsat Collection 2 files are publicly available in a [Google Cloud Storage
    bucket](https://console.cloud.google.com/storage/browser/gee-public-data-landsat)
    on requester-pays basis. The files are indexed in a regularly updated
    BigQuery table for ease of analysis:
    [earth-engine-public-data.geo_index.landsat_c2_index](https://console.cloud.google.com/bigquery?project=earth-engine-public-data&earth-engine-public-data!2sgeo_index=&inv=1&invt=Ab4V5A&ws=!1m5!1m4!4m3!1searth-engine-public-data!2sgeo_index!3slandsat_c2_index).

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