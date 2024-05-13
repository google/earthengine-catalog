local ee = import 'earthengine.libsonnet';
local units = import 'units.libsonnet';

{
  description: |||
    Visible Infrared Imaging Radiometer Suite (VIIRS) Active Fire detection
    product is based on the instrument's 375m nominal resolution data. Compared
    to other coarser resolution (&ge; 1km) satellite fire detection products, 
    the improved 375 m data provide greater response over fires of relatively
    small areas, as well as improved mapping of large fire perimeters.
    Consequently, the data are well suited for use in support of fire management
    (e.g., near real-time alert systems), as well as other science applications
    requiring improved fire mapping fidelity.

    The data in the near-real-time dataset are not considered to be of science
    quality.

    Additional information can be found [here](https://earthdata.nasa.gov/earth-observation-data/near-real-time/firms).
  |||,
  keywords: [
    'eosdis',
    'fire',
    'firms',
    'geophysical',
    'hotspot',
    'lance',
    'modis',
    'nasa',
    'thermal',
    'viirs',
  ],
  gsd: [375.0],
  bands: [
    {
      name: 'Bright_ti4',
      description: |||
        VIIRS I-4 channel brightness temperature of the fire pixel.
      |||,
      'gee:units': units.kelvin,
    },
    {
      name: 'Bright_ti5',
      description: |||
        VIIRS I-5 Channel brightness temperature of the fire pixel.
      |||,
      'gee:units': units.kelvin,
    },
    {
      name: 'confidence',
      description: |||
        A detection confidence intended to help users gauge the
        quality of individual active fire pixels. The confidence estimate ranges
        between 'low': 0, 'nominal': 1 and 'high': 2 for all fire pixels within
        the fire mask. Low confidence daytime fire pixels are typically
        associated with areas of Sun glint and lower relative temperature
        anomaly (&lt;15 K) in the mid-infrared channel I4. Nominal confidence
        pixels are those free of potential Sun glint contamination during the
        day and marked by strong (&gt;15 K) temperature anomaly in either day or
        nighttime data. High confidence fire pixels are associated with day or
        nighttime saturated pixels.

        Please note: Low confidence nighttime pixels occur only over the
        geographic area extending from 11&deg; E to 110&deg; W and 7&deg; N to
        55&deg; S. This area describes the region of influence of the South
        Atlantic Magnetic Anomaly which can cause spurious brightness
        temperatures in the mid-infrared channel I4 leading to potential false
        positive alarms. These have been removed from the NRT data distributed
        by FIRMS.
      |||,
    },
    {
      name: 'line_number',
      description: 'Line number in the FIRMS CSV file that the pixel came from.',
    },
    {
      name: 'frp',
      description: |||
        FRP depicts the pixel-integrated fire radiative power in megawatts (MW).
        Given the unique spatial and spectral resolution of the data, the VIIRS
        375m fire detection algorithm was customized and tuned to optimize its
        response over small fires while balancing the occurrence of false alarms
        . Frequent saturation of the mid-infrared I4 channel (3.55-3.93 &mu;m)
        driving the detection of active fires requires additional tests and
        procedures to avoid pixel classification errors. As a result, sub-pixel
        fire characterization (e.g., fire radiative power [FRP] retrieval) is
        only viable across small and/or low-intensity fires. Systematic FRP
        retrievals are based on a hybrid approach combining 375 and 750m data.
      |||,
      'gee:units': units.megawatt,
    },
    {
      name: 'acq_epoch',
      description: 'Acquisation timestamp in seconds',
      'gee:units': units.seconds,
    },
    {
      name: 'acq_time',
      description: 'The time of day in seconds since midnight',
      'gee:units': units.seconds,
    },
    {
      name: 'DayNight',
      description: '1= Daytime fire, 0= Nighttime fire',
    },
  ],
  visualizations: [
    {
      display_name: 'Fires',
      lookat: {
        lat: 59.39,
        lon: -113.24,
        zoom: 8,
      },
      image_visualization: {
        band_vis: {
          min: [
            325.0,
          ],
          max: [
            400.0,
          ],
          palette: [
            'yellow',
            'orange',
            'red',
            'white', 
            'darkred'
          ],
          bands: [
            'Bright_ti4',
          ],
        },
      },
    },
  ],
  Bright_ti4: {
    minimum: 250.0,
    maximum: 400.0,
    'gee:estimated_range': true,
  },
  Bright_ti5: {
    minimum: 250.0,
    maximum: 400.0,
    'gee:estimated_range': true,
  },
  confidence: {
    minimum: 0,
    maximum: 2,
    'gee:estimated_range': false,
  },
  line_number: {
    minimum: 1.0,
    maximum: 110000.0,
    'gee:estimated_range': true,
  },
  interval: {
    type: 'cadence',
    unit: 'day',
    interval: 1,
  },
  terms_of_use: |||
    NASA promotes the full and open sharing of all data with the research and
    applications communities, private industry, academia, and the general
    public. Read the [NASA Data and Information Policy]
    (https://www.earthdata.nasa.gov/learn/use-data/data-use-policy).

    If you provide the
    [Land, Atmosphere Near real-time Capability for EOS (LANCE) / Fire Information for Resource Management System (FIRMS)](https://earthdata.nasa.gov/earth-observation-data/near-real-time)
    data to a third party, follow the guidelines in the
    [LANCE Citation, Acknowledgements, and Disclaimer](https://earthdata.nasa.gov/earth-observation-data/near-real-time/citation#ed-lance-disclaimer)
    site and replicate or provide a link to the
    [disclaimer](https://earthdata.nasa.gov/earth-observation-data/near-real-time/citation#ed-lance-disclaimer).
  |||,
}
