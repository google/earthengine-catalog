{
  bands: [
    {
      name: 'Date_Mid_Greenup_Phase',
      description: 'Date at a mid-greenup phase',
    },
    {
      name: 'Date_Mid_Senescence_Phase',
      description: 'Date at a mid-senescence phase',
    },
    {
      name: 'EVI2_Growing_Season_Area',
      description: 'Integrated EVI2 during a growing season',
    },
    {
      name: 'EVI2_Onset_Greenness_Increase',
      description: 'EVI2 value at greenup onset',
    },
    {
      name: 'EVI2_Onset_Greenness_Maximum',
      description: 'EVI2 value at maturity onset',
    },
    {
      name: 'GLSP_QC',
      description: 'Global Land Surface Phenology Quality Control',
      bitmask: {
        bitmask_parts: [
          {
            description: 'Mandatory Quality',
            bit_count: 3,
            values: [
              {
                description: 'processed, good quality',
                value: 0,
              },
              {
                value: 1,
                description: 'processed, other quality',
              },
              {
                value: 2,
                description: 'processed, backup algorithm',
              },
              {
                value: 3,
                description: 'not processed, bad quality',
              },
              {
                value: 4,
                description: 'not processed, other',
              },
            ],
            first_bit: 0,
          },
          {
            description: 'TBD',
            bit_count: 2,
            first_bit: 3,
          },
          {
            description: 'Land/Water mask',
            bit_count: 3,
            values: [
              {
                description: 'Shallow ocean',
                value: 0,
              },
              {
                value: 1,
                description: 'Land (Nothing else but land)',
              },
              {
                value: 2,
                description: 'Ocean coastlines and lake shorelines',
              },
              {
                value: 3,
                description: 'Shallow inland water',
              },
              {
                value: 4,
                description: 'Ephemeral water',
              },
              {
                value: 5,
                description: 'Deep inland water',
              },
              {
                value: 6,
                description: 'Moderate or continental ocean',
              },
              {
                value: 7,
                description: 'Deep ocean',
              },
            ],
            first_bit: 5,
          },
        ],
        total_bit_count: 8,
      },
    },
    {
      name: 'Greenness_Agreement_Growing_Season',
      description: 'EVI2 agreement between modeled values and raw observations',
    },
    {
      name: 'Growing_Season_Length',
      description: 'Growing Season Length',
    },
    {
      name: 'Onset_Greenness_Decrease',
      description: 'Date at which canopy greenness begins to decrease',
    },
    {
      name: 'Onset_Greenness_Increase',
      description: 'Date of onset of greenness increase',
    },
    {
      name: 'Onset_Greenness_Maximum',
      description: 'Date at which canopy greenness approaches its seasonal maximum',
    },
    {
      name: 'Onset_Greenness_Minimum',
      description: 'Date at which canopy greenness reaches a minimum',
    },
    {
      name: 'PGQ_Growing_Season',
      description: 'Proportion of good quality of VIIRS observations during a vegetation growing season',
    },
    {
      name: 'PGQ_Onset_Greenness_Decrease',
      description: 'Proportion of good quality around senescence onset',
    },
    {
      name: 'PGQ_Onset_Greenness_Increase',
      description: 'Proportion of good quality around greenup onset',
    },
    {
      name: 'PGQ_Onset_Greenness_Maximum',
      description: 'Proportion of good quality around maturity onset',
    },
    {
      name: 'PGQ_Onset_Greenness_Minimum',
      description: 'Proportion of good quality around dormancy onset',
    },
    {
      name: 'Rate_Greenness_Decrease',
      description: 'Rates of change in EVI2 values during a senescence phase',
    },
    {
      name: 'Rate_Greenness_Increase',
      description: 'Rates of change in EVI2 values during a greenup phase',
    },
  ]
}
