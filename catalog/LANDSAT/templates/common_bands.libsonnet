local gsd = 30.0;

local qa_pixel = {
  name: 'QA_PIXEL',
  description: |||
    Landsat Collection 2 QA Bitmask
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
            description: 'cloud dilation',
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
            description: 'Cloud is not dilated or no cloud',
          },
          {
            value: 1,
            description: 'cloud dilation',
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
        bit_count: 2,
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
    total_bit_count: 9,
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
  common_bands_mss: [qa_pixel, qa_radsat_mss],
  common_bands_tm_etm: [qa_pixel, qa_radsat_tm_etm] + angle_bands_list,
  common_bands_oli_tirs: [qa_pixel, qa_radsat_oli_tirs] + angle_bands_list,
}
