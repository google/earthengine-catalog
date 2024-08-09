local gsd = 30.0;

// See
// https://d9-wret.s3.us-west-2.amazonaws.com/assets/palladium/production/s3fs-public/atoms/files/LSDS-1416_LandsatMSS-C2-L1-DFCB-v3.pdf
// https://d9-wret.s3.us-west-2.amazonaws.com/assets/palladium/production/s3fs-public/atoms/files/LSDS-1415_Landsat4-5-TM-C2-L1-DFCB-v3.pdf
// https://d9-wret.s3.us-west-2.amazonaws.com/assets/palladium/production/s3fs-public/atoms/files/LSDS-1414_Landsat7ETM-C2-L1-DFCB-v3.pdf
// https://d9-wret.s3.us-west-2.amazonaws.com/assets/palladium/production/s3fs-public/media/files/LSDS-1619_Landsat8-9-Collection2-Level2-Science-Product-Guide-v6.pdf

local qa_pixel_mss = {
  name: 'QA_PIXEL',
  description: |||
    Landsat Collection 2 MSS QA Bitmask
  |||,
  gsd: gsd,
  'gee:bitmask': {
    bitmask_parts: [
      {
        description: 'Fill',
        bit_count: 1,
        values: [
          {
            value: 0,
            description: 'Image data',
          },
          {
            value: 1,
            description: 'Fill data',
          },
        ],
        first_bit: 0,
      },
      {
        description: 'Unused',
        first_bit: 1,
        bit_count: 2,
      },
      {
        description: 'Cloud',
        first_bit: 3,
        bit_count: 1,
        values: [
          {
            value: 0,
            description: 'Not likely to exist',
          },
          {
            value: 1,
            description: 'Likely to exist',
          },
        ],
      },
      {
        description: 'Unused',
        first_bit: 4,
        bit_count: 4,
      },
      {
        description: 'Cloud Confidence',
        first_bit: 8,
        bit_count: 2,
        values: [
          {
            value: 0,
            description: 'No confidence level set',
          },
          {
            value: 1,
            description: 'Low confidence',
          },
          {
            value: 2,
            description: 'Unused',
          },
          {
            value: 3,
            description: 'High confidence',
          },
        ],
      },
    ],
    total_bit_count: 10,
  },
};


local qa_pixel_tm_etm = {
  name: 'QA_PIXEL',
  description: |||
    Landsat Collection 2 TM/ETM QA Bitmask
  |||,
  gsd: gsd,
  'gee:bitmask': {
    bitmask_parts: [
      {
        description: 'Fill',
        bit_count: 1,
        values: [
          {
            value: 0,
            description: 'Image data',
          },
          {
            value: 1,
            description: 'Fill data',
          },
        ],
        first_bit: 0,
      },
      {
        description: 'Dilated Cloud',
        first_bit: 1,
        bit_count: 1,
        values: [
          {
            value: 0,
            description: 'Cloud is not dilated or no cloud',
          },
          {
            value: 1,
            description: 'Cloud dilation',
          },
        ],
      },
      {
        description: 'Unused',
        first_bit: 2,
        bit_count: 1,
      },
      {
        description: 'Cloud',
        first_bit: 3,
        bit_count: 1,
        values: [
          {
            value: 0,
            description: 'Cloud confidence is not high',
          },
          {
            value: 1,
            description: 'High confidence cloud',
          },
        ],
      },
      {
        description: 'Cloud Shadow',
        first_bit: 4,
        bit_count: 1,
        values: [
          {
            value: 0,
            description: 'Cloud Shadow Confidence is not high',
          },
          {
            value: 1,
            description: 'High confidence cloud shadow',
          },
        ],
      },
      {
        description: 'Snow',
        first_bit: 5,
        bit_count: 1,
        values: [
          {
            value: 0,
            description: 'Snow/Ice Confidence is not high',
          },
          {
            value: 1,
            description: 'High confidence snow cover',
          },
        ],
      },
      {
        description: 'Clear',
        first_bit: 6,
        bit_count: 1,
        values: [
          {
            value: 0,
            description: 'Cloud or Dilated Cloud bits are set',
          },
          {
            value: 1,
            description: 'Cloud and Dilated Cloud bits are not set',
          },
        ],
      },
      {
        description: 'Water',
        first_bit: 7,
        bit_count: 1,
        values: [
          {
            value: 0,
            description: 'Land or cloud',
          },
          {
            value: 1,
            description: 'Water',
          },
        ],
      },
      {
        description: 'Cloud Confidence',
        first_bit: 8,
        bit_count: 2,
        values: [
          {
            value: 0,
            description: 'No confidence level set',
          },
          {
            value: 1,
            description: 'Low confidence',
          },
          {
            value: 2,
            description: 'Medium confidence',
          },
          {
            value: 3,
            description: 'High confidence',
          },
        ],
      },
      {
        description: 'Cloud Shadow Confidence',
        first_bit: 10,
        bit_count: 2,
        values: [
          {
            value: 0,
            description: 'No confidence level set',
          },
          {
            value: 1,
            description: 'Low confidence',
          },
          {
            value: 2,
            description: 'Reserved',
          },
          {
            value: 3,
            description: 'High confidence',
          },
        ],
      },
      {
        description: 'Snow / Ice Confidence',
        first_bit: 12,
        bit_count: 2,
        values: [
          {
            value: 0,
            description: 'No confidence level set',
          },
          {
            value: 1,
            description: 'Low confidence',
          },
          {
            value: 2,
            description: 'Reserved',
          },
          {
            value: 3,
            description: 'High confidence',
          },
        ],
      },
      {
        description: 'Unused',
        first_bit: 14,
        bit_count: 2,
      },
    ],
    total_bit_count: 16,
  },
};

local qa_pixel_oli_tirs = {
  name: 'QA_PIXEL',
  description: |||
    Landsat Collection 2 OLI/TIRS QA Bitmask
  |||,
  gsd: gsd,
  'gee:bitmask': {
    bitmask_parts: [
      {
        description: 'Fill',
        bit_count: 1,
        values: [
          {
            value: 0,
            description: 'Image data',
          },
          {
            value: 1,
            description: 'Fill data',
          },
        ],
        first_bit: 0,
      },
      {
        description: 'Dilated Cloud',
        first_bit: 1,
        bit_count: 1,
        values: [
          {
            value: 0,
            description: 'Cloud is not dilated or no cloud',
          },
          {
            value: 1,
            description: 'Cloud dilation',
          },
        ],
      },
      {
        description: 'Cirrus',
        first_bit: 2,
        bit_count: 1,
        values: [
          {
            value: 0,
            description: 'Cirrus Confidence: no confidence level set or Low Confidence',
          },
          {
            value: 1,
            description: 'High confidence cirrus',
          },
        ],
      },
      {
        description: 'Cloud',
        first_bit: 3,
        bit_count: 1,
        values: [
          {
            value: 0,
            description: 'Cloud confidence is not high',
          },
          {
            value: 1,
            description: 'High confidence cloud',
          },
        ],
      },
      {
        description: 'Cloud Shadow',
        first_bit: 4,
        bit_count: 1,
        values: [
          {
            value: 0,
            description: 'Cloud Shadow Confidence is not high',
          },
          {
            value: 1,
            description: 'High confidence cloud shadow',
          },
        ],
      },
      {
        description: 'Snow',
        first_bit: 5,
        bit_count: 1,
        values: [
          {
            value: 0,
            description: 'Snow/Ice Confidence is not high',
          },
          {
            value: 1,
            description: 'High confidence snow cover',
          },
        ],
      },
      {
        description: 'Clear',
        first_bit: 6,
        bit_count: 1,
        values: [
          {
            value: 0,
            description: 'Cloud or Dilated Cloud bits are set',
          },
          {
            value: 1,
            description: 'Cloud and Dilated Cloud bits are not set',
          },
        ],
      },
      {
        description: 'Water',
        first_bit: 7,
        bit_count: 1,
        values: [
          {
            value: 0,
            description: 'Land or cloud',
          },
          {
            value: 1,
            description: 'Water',
          },
        ],
      },
      {
        description: 'Cloud Confidence',
        first_bit: 8,
        bit_count: 2,
        values: [
          {
            value: 0,
            description: 'No confidence level set',
          },
          {
            value: 1,
            description: 'Low confidence',
          },
          {
            value: 2,
            description: 'Medium confidence',
          },
          {
            value: 3,
            description: 'High confidence',
          },
        ],
      },
      {
        description: 'Cloud Shadow Confidence',
        first_bit: 10,
        bit_count: 2,
        values: [
          {
            value: 0,
            description: 'No confidence level set',
          },
          {
            value: 1,
            description: 'Low confidence',
          },
          {
            value: 2,
            description: 'Reserved',
          },
          {
            value: 3,
            description: 'High confidence',
          },
        ],
      },
      {
        description: 'Snow / Ice Confidence',
        first_bit: 12,
        bit_count: 2,
        values: [
          {
            value: 0,
            description: 'No confidence level set',
          },
          {
            value: 1,
            description: 'Low confidence',
          },
          {
            value: 2,
            description: 'Reserved',
          },
          {
            value: 3,
            description: 'High confidence',
          },
        ],
      },
      {
        description: 'Cirrus Confidence',
        first_bit: 14,
        bit_count: 2,
        values: [
          {
            value: 0,
            description: 'No confidence level set',
          },
          {
            value: 1,
            description: 'Low confidence',
          },
          {
            value: 2,
            description: 'Reserved',
          },
          {
            value: 3,
            description: 'High confidence',
          },
        ],
      },
    ],
    total_bit_count: 16,
  },
};

// See https://www.usgs.gov/landsat-missions/landsat-collection-2-quality-assessment-bands

local qa_radsat_mss = {
  name: 'QA_RADSAT',
  gsd: gsd,
  description: 'Radiometric saturation QA',
  'gee:bitmask': {
    bitmask_parts: [
      {
        description: 'Band 1 data saturated',
        bit_count: 1,
        first_bit: 0,
      },
      {
        description: 'Band 2 data saturated',
        first_bit: 1,
        bit_count: 1,
      },
      {
        description: 'Band 3 data saturated',
        first_bit: 2,
        bit_count: 1,
      },
      {
        description: 'Band 4 data saturated',
        first_bit: 3,
        bit_count: 1,
      },
      {
        description: 'Band 5 data saturated',
        first_bit: 4,
        bit_count: 1,
      },
      {
        description: 'Band 6 data saturated',
        first_bit: 5,
        bit_count: 1,
      },
      {
        description: 'Unused',
        first_bit: 6,
        bit_count: 3,
      },
      {
        description: 'Dropped pixel',
        first_bit: 9,
        bit_count: 1,
        values: [
          {
            value: 0,
            description: 'Pixel present',
          },
          {
            value: 1,
            description: 'Detector does not have a value',
          },
        ],
      },
    ],
    total_bit_count: 10,
  },
};


local qa_radsat_tm_etm = {
  name: 'QA_RADSAT',
  gsd: gsd,
  description: 'Radiometric saturation QA',
  'gee:bitmask': {
    bitmask_parts: [
      {
        description: 'Band 1 data saturated',
        bit_count: 1,
        first_bit: 0,
      },
      {
        description: 'Band 2 data saturated',
        first_bit: 1,
        bit_count: 1,
      },
      {
        description: 'Band 3 data saturated',
        first_bit: 2,
        bit_count: 1,
      },
      {
        description: 'Band 4 data saturated',
        first_bit: 3,
        bit_count: 1,
      },
      {
        description: 'Band 5 data saturated',
        first_bit: 4,
        bit_count: 1,
      },
      {
        description: 'Band 6L data saturated',
        first_bit: 5,
        bit_count: 1,
      },
      {
        description: 'Band 7 data saturated',
        first_bit: 6,
        bit_count: 1,
      },
      {
        description: 'Unused',
        first_bit: 7,
        bit_count: 1,
      },
      {
        description: 'Band 6H data saturated',
        first_bit: 8,
        bit_count: 1,
      },
      {
        description: 'Dropped pixel',
        first_bit: 9,
        bit_count: 1,
        values: [
          {
            value: 0,
            description: 'Pixel present',
          },
          {
            value: 1,
            description: 'Detector does not have a value',
          },
        ],
      },
    ],
    total_bit_count: 10,
  },
};


local qa_radsat_oli_tirs = {
  name: 'QA_RADSAT',
  gsd: gsd,
  description: 'Radiometric saturation QA',
  'gee:bitmask': {
    bitmask_parts: [
      {
        description: 'Band 1 data saturated',
        bit_count: 1,
        first_bit: 0,
      },
      {
        description: 'Band 2 data saturated',
        first_bit: 1,
        bit_count: 1,
      },
      {
        description: 'Band 3 data saturated',
        first_bit: 2,
        bit_count: 1,
      },
      {
        description: 'Band 4 data saturated',
        first_bit: 3,
        bit_count: 1,
      },
      {
        description: 'Band 5 data saturated',
        first_bit: 4,
        bit_count: 1,
      },
      {
        description: 'Band 6 data saturated',
        first_bit: 5,
        bit_count: 1,
      },
      {
        description: 'Band 7 data saturated',
        first_bit: 6,
        bit_count: 1,
      },
      {
        description: 'Unused',
        first_bit: 7,
        bit_count: 1,
      },
      {
        description: 'Band 9 data saturated',
        first_bit: 8,
        bit_count: 1,
      },
      {
        description: 'Unused',
        first_bit: 9,
        bit_count: 2,
      },
      {
        description: 'Terrian occlusion',
        first_bit: 11,
        bit_count: 1,
        values: [
          {
            value: 0,
            description: 'No terrain occlusion',
          },
          {
            value: 1,
            description: 'Terrain occlusion',
          },
        ],
      },
    ],
    total_bit_count: 12,
  },
};

local angle_bands_list = [
  {
    name: 'SAA',
    description: 'Solar Azimuth Angle',
    gsd: gsd,
  },
  {
    name: 'SZA',
    description: 'Solar Zenith Angle',
    gsd: gsd,
  },
  {
    name: 'VAA',
    description: 'View Azimuth Angle',
    gsd: gsd,
  },
  {
    name: 'VZA',
    description: 'View Zenith Angle',
    gsd: gsd,
  },
];

{
  common_bands_mss: [qa_pixel_mss, qa_radsat_mss],
  common_bands_tm_etm: [qa_pixel_tm_etm, qa_radsat_tm_etm] + angle_bands_list,
  common_bands_oli_tirs: [qa_pixel_oli_tirs, qa_radsat_oli_tirs] + angle_bands_list,
}
