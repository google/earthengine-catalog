local units = import 'units.libsonnet';

local uniqueClassDescriptions(band) =
  if !std.objectHas(band, 'gee:classes') then band else
    local classes = band['gee:classes'];
    local descriptions = std.sort([c.description for c in classes]);
    local duplicates = std.set([
      descriptions[i]
      for i in std.range(1, std.length(descriptions) - 1)
      if descriptions[i] == descriptions[i - 1]
    ]);
    band {
      'gee:classes': [
        c {
          description: c.description + (
            if std.setMember(c.description, duplicates) then
              ' (code %d)' % c.value
            else ''
          ),
        }
        for c in classes
      ],
    };

{
  eo_bands: std.map(uniqueClassDescriptions, [
    {
      name: "CBD",
      description: "Forest Canopy Bulk Density (CBD) is the mass of available canopy fuel per unit canopy volume that would burn in a crown fire and values range from 0 to 45.",
      "gee:units": units.density_si,
      "gee:scale": 0.01,
    },
    {
      name: "CBH",
      description: "Forest Canopy Base Height (CBH) describes the lowest point in a stand where there is sufficient available fuel to propagate fire vertically through the canopy.",
      "gee:units": units.meter,
      "gee:scale": 0.1,
    },
    {
      name: "CC",
      description: "Percent cover of the tree canopy in a stand. Binned classes percent cover classes.",
      "gee:units": units.percent,
      "gee:classes": [
        {
          value: 0,
          color: "b0b0b0",
          description: "Non-Forested",
        },
        {
          value: 15,
          color: "eaffbf",
          description: "Tree Cover >= 10 and < 20%",
        },
        {
          value: 25,
          color: "bbe695",
          description: "Tree Cover >= 20 and < 30%",
        },
        {
          value: 35,
          color: "8cc96d",
          description: "Tree Cover >= 30 and < 40%",
        },
        {
          value: 45,
          color: "62b04a",
          description: "Tree Cover >= 40 and < 50%",
        },
        {
          value: 55,
          color: "3b992b",
          description: "Tree Cover >= 50 and < 60%",
        },
        {
          value: 65,
          color: "008000",
          description: "Tree Cover >= 60 and < 70%",
        },
        {
          value: 75,
          color: "0f5c0b",
          description: "Tree Cover >= 70 and < 80%",
        },
        {
          value: 85,
          color: "113d0c",
          description: "Tree Cover >= 80 and < 90%",
        },
        {
          value: 95,
          color: "10240c",
          description: "Tree Cover >= 90 and <= 100%",
        },
      ],
    },
    {
      name: "CFFDRS",
      description: "The Canadian Forest Fire Danger Rating System (CFFDRS) product contains the fuel models used for the Fire Behavior Prediction (FBP) system fuel type inputs. Fuel types are represented as an identifiable association of fuel elements of distinctive species, form, size, arrangement, and continuity.",
      "gee:units": units.dimensionless,
      "gee:classes": [
        {
          value: 1,
          color: "d1ff73",
          description: "Spruce-Lichen Woodland",
        },
        {
          value: 2,
          color: "226633",
          description: "Boreal Spruce",
        },
        {
          value: 3,
          color: "83c795",
          description: "Mature Jack or Lodgepole Pine",
        },
        {
          value: 4,
          color: "70a800",
          description: "Immature Jack or Lodgepole Pine",
        },
        {
          value: 5,
          color: "dfb8e6",
          description: "Red and White Pine",
        },
        {
          value: 6,
          color: "ac66ed",
          description: "Conifer Plantation",
        },
        {
          value: 7,
          color: "700cf2",
          description: "Ponderosa Pine-Douglas-Fir",
        },
        {
          value: 11,
          color: "c4bd97",
          description: "Leafless Aspen",
        },
        {
          value: 12,
          color: "897044",
          description: "Green Aspen (with BUI Thresholding)",
        },
        {
          value: 13,
          color: "c4bd97",
          description: "Aspen",
        },
        {
          value: 21,
          color: "fbbeb9",
          description: "Jack or Lodgepole Pine Slash",
        },
        {
          value: 22,
          color: "f768a1",
          description: "White Spruce-Balsam Slash",
        },
        {
          value: 23,
          color: "ae017e",
          description: "Coastal Cedar-Hemlock-Douglas-Fir Slash",
        },
        {
          value: 31,
          color: "ffffbe",
          description: "Matted Grass",
        },
        {
          value: 32,
          color: "e6e600",
          description: "Standing Grass",
        },
        {
          value: 33,
          color: "ffffbe",
          description: "Grass",
        },
        {
          value: 40,
          color: "ffd37f",
          description: "Boreal Mixedwood-Leafless",
        },
        {
          value: 50,
          color: "ffaa00",
          description: "Boreal Mixedwood-Green",
        },
        {
          value: 60,
          color: "ffd37f",
          description: "Boreal Mixedwood",
        },
        {
          value: 70,
          color: "630000",
          description: "Dead Balsam Fir Mixedwood-Leafless",
        },
        {
          value: 80,
          color: "aa0000",
          description: "Dead Balsam Fir Mixedwood-Green",
        },
        {
          value: 90,
          color: "630000",
          description: "Dead Balsam Fir Mixedwood",
        },
        {
          value: 100,
          color: "ffffff",
          description: "Not Available",
        },
        {
          value: 101,
          color: "828282",
          description: "Non-fuel",
        },
        {
          value: 102,
          color: "73dfff",
          description: "Water",
        },
        {
          value: 103,
          color: "000000",
          description: "Unknown",
        },
        {
          value: 104,
          color: "a6a6a6",
          description: "Unclassified",
        },
        {
          value: 105,
          color: "cccccc",
          description: "Vegetated Non-Fuel",
        },
        {
          value: 405,
          color: "ffd37f",
          description: "Boreal Mixedwood-Leafless (05% Conifer)",
        },
        {
          value: 410,
          color: "ffd37f",
          description: "Boreal Mixedwood-Leafless (10% Conifer)",
        },
        {
          value: 415,
          color: "ffd37f",
          description: "Boreal Mixedwood-Leafless (15% Conifer)",
        },
        {
          value: 420,
          color: "ffd37f",
          description: "Boreal Mixedwood-Leafless (20% Conifer)",
        },
        {
          value: 425,
          color: "ffd37f",
          description: "Boreal Mixedwood-Leafless (25% Conifer)",
        },
        {
          value: 430,
          color: "ffd37f",
          description: "Boreal Mixedwood-Leafless (30% Conifer)",
        },
        {
          value: 435,
          color: "ffd37f",
          description: "Boreal Mixedwood-Leafless (35% Conifer)",
        },
        {
          value: 440,
          color: "ffd37f",
          description: "Boreal Mixedwood-Leafless (40% Conifer)",
        },
        {
          value: 445,
          color: "ffd37f",
          description: "Boreal Mixedwood-Leafless (45% Conifer)",
        },
        {
          value: 450,
          color: "ffd37f",
          description: "Boreal Mixedwood-Leafless (50% Conifer)",
        },
        {
          value: 455,
          color: "ffd37f",
          description: "Boreal Mixedwood-Leafless (55% Conifer)",
        },
        {
          value: 460,
          color: "ffd37f",
          description: "Boreal Mixedwood-Leafless (60% Conifer)",
        },
        {
          value: 465,
          color: "ffd37f",
          description: "Boreal Mixedwood-Leafless (65% Conifer)",
        },
        {
          value: 470,
          color: "ffd37f",
          description: "Boreal Mixedwood-Leafless (70% Conifer)",
        },
        {
          value: 475,
          color: "ffd37f",
          description: "Boreal Mixedwood-Leafless (75% Conifer)",
        },
        {
          value: 480,
          color: "ffd37f",
          description: "Boreal Mixedwood-Leafless (80% Conifer)",
        },
        {
          value: 485,
          color: "ffd37f",
          description: "Boreal Mixedwood-Leafless (85% Conifer)",
        },
        {
          value: 490,
          color: "ffd37f",
          description: "Boreal Mixedwood-Leafless (90% Conifer)",
        },
        {
          value: 495,
          color: "ffd37f",
          description: "Boreal Mixedwood-Leafless (95% Conifer)",
        },
        {
          value: 505,
          color: "ffaa00",
          description: "Boreal Mixedwood-Green (05% Conifer)",
        },
        {
          value: 510,
          color: "ffaa00",
          description: "Boreal Mixedwood-Green (10% Conifer)",
        },
        {
          value: 515,
          color: "ffaa00",
          description: "Boreal Mixedwood-Green (15% Conifer)",
        },
        {
          value: 520,
          color: "ffaa00",
          description: "Boreal Mixedwood-Green (20% Conifer)",
        },
        {
          value: 525,
          color: "ffaa00",
          description: "Boreal Mixedwood-Green (25% Conifer)",
        },
        {
          value: 530,
          color: "ffaa00",
          description: "Boreal Mixedwood-Green (30% Conifer)",
        },
        {
          value: 535,
          color: "ffaa00",
          description: "Boreal Mixedwood-Green (35% Conifer)",
        },
        {
          value: 540,
          color: "ffaa00",
          description: "Boreal Mixedwood-Green (40% Conifer)",
        },
        {
          value: 545,
          color: "ffaa00",
          description: "Boreal Mixedwood-Green (45% Conifer)",
        },
        {
          value: 550,
          color: "ffaa00",
          description: "Boreal Mixedwood-Green (50% Conifer)",
        },
        {
          value: 555,
          color: "ffaa00",
          description: "Boreal Mixedwood-Green (55% Conifer)",
        },
        {
          value: 560,
          color: "ffaa00",
          description: "Boreal Mixedwood-Green (60% Conifer)",
        },
        {
          value: 565,
          color: "ffaa00",
          description: "Boreal Mixedwood-Green (65% Conifer)",
        },
        {
          value: 570,
          color: "ffaa00",
          description: "Boreal Mixedwood-Green (70% Conifer)",
        },
        {
          value: 575,
          color: "ffaa00",
          description: "Boreal Mixedwood-Green (75% Conifer)",
        },
        {
          value: 580,
          color: "ffaa00",
          description: "Boreal Mixedwood-Green (80% Conifer)",
        },
        {
          value: 585,
          color: "ffaa00",
          description: "Boreal Mixedwood-Green (85% Conifer)",
        },
        {
          value: 590,
          color: "ffaa00",
          description: "Boreal Mixedwood-Green (90% Conifer)",
        },
        {
          value: 595,
          color: "ffaa00",
          description: "Boreal Mixedwood-Green (95% Conifer)",
        },
        {
          value: 605,
          color: "ffd37f",
          description: "Boreal Mixedwood (05% Conifer)",
        },
        {
          value: 610,
          color: "ffd37f",
          description: "Boreal Mixedwood (10% Conifer)",
        },
        {
          value: 615,
          color: "ffd37f",
          description: "Boreal Mixedwood (15% Conifer)",
        },
        {
          value: 620,
          color: "ffd37f",
          description: "Boreal Mixedwood (20% Conifer)",
        },
        {
          value: 625,
          color: "ffd37f",
          description: "Boreal Mixedwood (25% Conifer)",
        },
        {
          value: 630,
          color: "ffd37f",
          description: "Boreal Mixedwood (30% Conifer)",
        },
        {
          value: 635,
          color: "ffd37f",
          description: "Boreal Mixedwood (35% Conifer)",
        },
        {
          value: 640,
          color: "ffd37f",
          description: "Boreal Mixedwood (40% Conifer)",
        },
        {
          value: 645,
          color: "ffd37f",
          description: "Boreal Mixedwood (45% Conifer)",
        },
        {
          value: 650,
          color: "ffd37f",
          description: "Boreal Mixedwood (50% Conifer)",
        },
        {
          value: 655,
          color: "ffd37f",
          description: "Boreal Mixedwood (55% Conifer)",
        },
        {
          value: 660,
          color: "ffd37f",
          description: "Boreal Mixedwood (60% Conifer)",
        },
        {
          value: 665,
          color: "ffd37f",
          description: "Boreal Mixedwood (65% Conifer)",
        },
        {
          value: 670,
          color: "ffd37f",
          description: "Boreal Mixedwood (70% Conifer)",
        },
        {
          value: 675,
          color: "ffd37f",
          description: "Boreal Mixedwood (75% Conifer)",
        },
        {
          value: 680,
          color: "ffd37f",
          description: "Boreal Mixedwood (80% Conifer)",
        },
        {
          value: 685,
          color: "ffd37f",
          description: "Boreal Mixedwood (85% Conifer)",
        },
        {
          value: 690,
          color: "ffd37f",
          description: "Boreal Mixedwood (90% Conifer)",
        },
        {
          value: 695,
          color: "ffd37f",
          description: "Boreal Mixedwood (95% Conifer)",
        },
        {
          value: 705,
          color: "630000",
          description: "Dead Balsam Fir Mixedwood-Leafless (05% Dead Fir)",
        },
        {
          value: 710,
          color: "630000",
          description: "Dead Balsam Fir Mixedwood-Leafless (10% Dead Fir)",
        },
        {
          value: 715,
          color: "630000",
          description: "Dead Balsam Fir Mixedwood-Leafless (15% Dead Fir)",
        },
        {
          value: 720,
          color: "630000",
          description: "Dead Balsam Fir Mixedwood-Leafless (20% Dead Fir)",
        },
        {
          value: 725,
          color: "630000",
          description: "Dead Balsam Fir Mixedwood-Leafless (25% Dead Fir)",
        },
        {
          value: 730,
          color: "630000",
          description: "Dead Balsam Fir Mixedwood-Leafless (30% Dead Fir)",
        },
        {
          value: 735,
          color: "630000",
          description: "Dead Balsam Fir Mixedwood-Leafless (35% Dead Fir)",
        },
        {
          value: 740,
          color: "630000",
          description: "Dead Balsam Fir Mixedwood-Leafless (40% Dead Fir)",
        },
        {
          value: 745,
          color: "630000",
          description: "Dead Balsam Fir Mixedwood-Leafless (45% Dead Fir)",
        },
        {
          value: 750,
          color: "630000",
          description: "Dead Balsam Fir Mixedwood-Leafless (50% Dead Fir)",
        },
        {
          value: 755,
          color: "630000",
          description: "Dead Balsam Fir Mixedwood-Leafless (55% Dead Fir)",
        },
        {
          value: 760,
          color: "630000",
          description: "Dead Balsam Fir Mixedwood-Leafless (60% Dead Fir)",
        },
        {
          value: 765,
          color: "630000",
          description: "Dead Balsam Fir Mixedwood-Leafless (65% Dead Fir)",
        },
        {
          value: 770,
          color: "630000",
          description: "Dead Balsam Fir Mixedwood-Leafless (70% Dead Fir)",
        },
        {
          value: 775,
          color: "630000",
          description: "Dead Balsam Fir Mixedwood-Leafless (75% Dead Fir)",
        },
        {
          value: 780,
          color: "630000",
          description: "Dead Balsam Fir Mixedwood-Leafless (80% Dead Fir)",
        },
        {
          value: 785,
          color: "630000",
          description: "Dead Balsam Fir Mixedwood-Leafless (85% Dead Fir)",
        },
        {
          value: 790,
          color: "630000",
          description: "Dead Balsam Fir Mixedwood-Leafless (90% Dead Fir)",
        },
        {
          value: 795,
          color: "630000",
          description: "Dead Balsam Fir Mixedwood-Leafless (95% Dead Fir)",
        },
        {
          value: 805,
          color: "aa0000",
          description: "Dead Balsam Fir Mixedwood-Green (05% Dead Fir)",
        },
        {
          value: 810,
          color: "aa0000",
          description: "Dead Balsam Fir Mixedwood-Green (10% Dead Fir)",
        },
        {
          value: 815,
          color: "aa0000",
          description: "Dead Balsam Fir Mixedwood-Green (15% Dead Fir)",
        },
        {
          value: 820,
          color: "aa0000",
          description: "Dead Balsam Fir Mixedwood-Green (20% Dead Fir)",
        },
        {
          value: 825,
          color: "aa0000",
          description: "Dead Balsam Fir Mixedwood-Green (25% Dead Fir)",
        },
        {
          value: 830,
          color: "aa0000",
          description: "Dead Balsam Fir Mixedwood-Green (30% Dead Fir)",
        },
        {
          value: 835,
          color: "aa0000",
          description: "Dead Balsam Fir Mixedwood-Green (35% Dead Fir)",
        },
        {
          value: 840,
          color: "aa0000",
          description: "Dead Balsam Fir Mixedwood-Green (40% Dead Fir)",
        },
        {
          value: 845,
          color: "aa0000",
          description: "Dead Balsam Fir Mixedwood-Green (45% Dead Fir)",
        },
        {
          value: 850,
          color: "aa0000",
          description: "Dead Balsam Fir Mixedwood-Green (50% Dead Fir)",
        },
        {
          value: 855,
          color: "aa0000",
          description: "Dead Balsam Fir Mixedwood-Green (55% Dead Fir)",
        },
        {
          value: 860,
          color: "aa0000",
          description: "Dead Balsam Fir Mixedwood-Green (60% Dead Fir)",
        },
        {
          value: 865,
          color: "aa0000",
          description: "Dead Balsam Fir Mixedwood-Green (65% Dead Fir)",
        },
        {
          value: 870,
          color: "aa0000",
          description: "Dead Balsam Fir Mixedwood-Green (70% Dead Fir)",
        },
        {
          value: 875,
          color: "aa0000",
          description: "Dead Balsam Fir Mixedwood-Green (75% Dead Fir)",
        },
        {
          value: 880,
          color: "aa0000",
          description: "Dead Balsam Fir Mixedwood-Green (80% Dead Fir)",
        },
        {
          value: 885,
          color: "aa0000",
          description: "Dead Balsam Fir Mixedwood-Green (85% Dead Fir)",
        },
        {
          value: 890,
          color: "aa0000",
          description: "Dead Balsam Fir Mixedwood-Green (90% Dead Fir)",
        },
        {
          value: 895,
          color: "aa0000",
          description: "Dead Balsam Fir Mixedwood-Green (95% Dead Fir)",
        },
        {
          value: 905,
          color: "630000",
          description: "Dead Balsam Fir Mixedwood (05% Dead Fir)",
        },
        {
          value: 910,
          color: "630000",
          description: "Dead Balsam Fir Mixedwood (10% Dead Fir)",
        },
        {
          value: 915,
          color: "630000",
          description: "Dead Balsam Fir Mixedwood (15% Dead Fir)",
        },
        {
          value: 920,
          color: "630000",
          description: "Dead Balsam Fir Mixedwood (20% Dead Fir)",
        },
        {
          value: 925,
          color: "630000",
          description: "Dead Balsam Fir Mixedwood (25% Dead Fir)",
        },
        {
          value: 930,
          color: "630000",
          description: "Dead Balsam Fir Mixedwood (30% Dead Fir)",
        },
        {
          value: 935,
          color: "630000",
          description: "Dead Balsam Fir Mixedwood (35% Dead Fir)",
        },
        {
          value: 940,
          color: "630000",
          description: "Dead Balsam Fir Mixedwood (40% Dead Fir)",
        },
        {
          value: 945,
          color: "630000",
          description: "Dead Balsam Fir Mixedwood (45% Dead Fir)",
        },
        {
          value: 950,
          color: "630000",
          description: "Dead Balsam Fir Mixedwood (50% Dead Fir)",
        },
        {
          value: 955,
          color: "630000",
          description: "Dead Balsam Fir Mixedwood (55% Dead Fir)",
        },
        {
          value: 960,
          color: "630000",
          description: "Dead Balsam Fir Mixedwood (60% Dead Fir)",
        },
        {
          value: 965,
          color: "630000",
          description: "Dead Balsam Fir Mixedwood (65% Dead Fir)",
        },
        {
          value: 970,
          color: "630000",
          description: "Dead Balsam Fir Mixedwood (70% Dead Fir)",
        },
        {
          value: 975,
          color: "630000",
          description: "Dead Balsam Fir Mixedwood (75% Dead Fir)",
        },
        {
          value: 980,
          color: "630000",
          description: "Dead Balsam Fir Mixedwood (80% Dead Fir)",
        },
        {
          value: 985,
          color: "630000",
          description: "Dead Balsam Fir Mixedwood (85% Dead Fir)",
        },
        {
          value: 990,
          color: "630000",
          description: "Dead Balsam Fir Mixedwood (90% Dead Fir)",
        },
        {
          value: 995,
          color: "630000",
          description: "Dead Balsam Fir Mixedwood (95% Dead Fir)",
        },
      ],
    },
    {
      name: "CH",
      description: "Forest Canopy Height (CH) describes the average height of the top canopy for a stand.",
      "gee:units": units.meter,
      "gee:scale": 0.1,
    },
    {
      name: "Dist_raw",
      description: "Code that denotes general category of disturbance, type, and severity. Raw value from the original Landfire products, equivalent to \"Final Annual Disturbance 2024 (Dist24)\".",
      "gee:units": units.dimensionless,
      "gee:classes": [
        {
          value: 0,
          color: "000000",
          description: "Background",
        },
        {
          value: 2001,
          color: "0000ff",
          description: "Water body or other non-mappable land cover type",
        },
        {
          value: 2011,
          color: "ff0000",
          description: "MTBS Provisional Initial Assessment (PIA)-mapped wildfire; replaced by MTBS Extended Assessment data if available",
        },
        {
          value: 2012,
          color: "ff0000",
          description: "MTBS Provisional Initial Assessment (PIA)-mapped wildfire; replaced by MTBS Extended Assessment data if available",
        },
        {
          value: 2013,
          color: "ff0000",
          description: "MTBS Provisional Initial Assessment (PIA)-mapped wildfire; replaced by MTBS Extended Assessment data if available",
        },
        {
          value: 2014,
          color: "ff0000",
          description: "MTBS Provisional Initial Assessment (PIA)-mapped wildfire; replaced by MTBS Extended Assessment data if available",
        },
        {
          value: 2015,
          color: "ff0000",
          description: "MTBS Provisional Initial Assessment (PIA)-mapped wildfire; replaced by MTBS Extended Assessment data if available",
        },
        {
          value: 2021,
          color: "ff0000",
          description: "MTBS Provisional Initial Assessment (PIA)-mapped wildfire; replaced by MTBS Extended Assessment data if available",
        },
        {
          value: 2022,
          color: "ff0000",
          description: "MTBS Provisional Initial Assessment (PIA)-mapped wildfire; replaced by MTBS Extended Assessment data if available",
        },
        {
          value: 2023,
          color: "ff0000",
          description: "MTBS Provisional Initial Assessment (PIA)-mapped wildfire; replaced by MTBS Extended Assessment data if available",
        },
        {
          value: 2024,
          color: "ff0000",
          description: "MTBS Provisional Initial Assessment (PIA)-mapped wildfire; replaced by MTBS Extended Assessment data if available",
        },
        {
          value: 2025,
          color: "ff0000",
          description: "MTBS Provisional Initial Assessment (PIA)-mapped wildfire; replaced by MTBS Extended Assessment data if available",
        },
        {
          value: 2031,
          color: "ff0000",
          description: "MTBS Provisional Initial Assessment (PIA) no-data gaps filled with See5-modeled severity; replaced by Extended Assessment data if available",
        },
        {
          value: 2032,
          color: "ff0000",
          description: "MTBS Provisional Initial Assessment (PIA) no-data gaps filled with See5-modeled severity; replaced by Extended Assessment data if available",
        },
        {
          value: 2033,
          color: "ff0000",
          description: "MTBS Provisional Initial Assessment (PIA) no-data gaps filled with See5-modeled severity; replaced by Extended Assessment data if available",
        },
        {
          value: 2034,
          color: "ff0000",
          description: "MTBS Provisional Initial Assessment (PIA) no-data gaps filled with See5-modeled severity; replaced by Extended Assessment data if available",
        },
        {
          value: 2035,
          color: "ff0000",
          description: "MTBS Provisional Initial Assessment (PIA) no-data gaps filled with See5-modeled severity; replaced by Extended Assessment data if available",
        },
        {
          value: 2041,
          color: "ff0000",
          description: "MTBS Provisional Initial Assessment (PIA) no-data gaps filled with See5-modeled severity; replaced by Extended Assessment data if available",
        },
        {
          value: 2042,
          color: "ff0000",
          description: "MTBS Provisional Initial Assessment (PIA) no-data gaps filled with See5-modeled severity; replaced by Extended Assessment data if available",
        },
        {
          value: 2043,
          color: "ff0000",
          description: "MTBS Provisional Initial Assessment (PIA) no-data gaps filled with See5-modeled severity; replaced by Extended Assessment data if available",
        },
        {
          value: 2044,
          color: "ff0000",
          description: "MTBS Provisional Initial Assessment (PIA) no-data gaps filled with See5-modeled severity; replaced by Extended Assessment data if available",
        },
        {
          value: 2045,
          color: "ff0000",
          description: "MTBS Provisional Initial Assessment (PIA) no-data gaps filled with See5-modeled severity; replaced by Extended Assessment data if available",
        },
        {
          value: 2051,
          color: "ff0000",
          description: "MTBS Provisional Initial Assessment (PIA)-mapped prescribed fire; replaced by MTBS Extended Assessment data if available",
        },
        {
          value: 2052,
          color: "ff0000",
          description: "MTBS Provisional Initial Assessment (PIA)-mapped prescribed fire; replaced by MTBS Extended Assessment data if available",
        },
        {
          value: 2053,
          color: "ff0000",
          description: "MTBS Provisional Initial Assessment (PIA)-mapped prescribed fire; replaced by MTBS Extended Assessment data if available",
        },
        {
          value: 2054,
          color: "ff0000",
          description: "MTBS Provisional Initial Assessment (PIA)-mapped prescribed fire; replaced by MTBS Extended Assessment data if available",
        },
        {
          value: 2055,
          color: "ff0000",
          description: "MTBS Provisional Initial Assessment (PIA)-mapped prescribed fire; replaced by MTBS Extended Assessment data if available",
        },
        {
          value: 2061,
          color: "ff0000",
          description: "MTBS Provisional Initial Assessment (PIA)-mapped prescribed fire; replaced by MTBS Extended Assessment data if available",
        },
        {
          value: 2062,
          color: "ff0000",
          description: "MTBS Provisional Initial Assessment (PIA)-mapped prescribed fire; replaced by MTBS Extended Assessment data if available",
        },
        {
          value: 2063,
          color: "ff0000",
          description: "MTBS Provisional Initial Assessment (PIA)-mapped prescribed fire; replaced by MTBS Extended Assessment data if available",
        },
        {
          value: 2064,
          color: "ff0000",
          description: "MTBS Provisional Initial Assessment (PIA)-mapped prescribed fire; replaced by MTBS Extended Assessment data if available",
        },
        {
          value: 2065,
          color: "ff0000",
          description: "MTBS Provisional Initial Assessment (PIA)-mapped prescribed fire; replaced by MTBS Extended Assessment data if available",
        },
        {
          value: 2071,
          color: "ff0000",
          description: "MTBS Provisional Initial Assessment (PIA) no-data gaps filled with See5-modeled severity; replaced by Extended Assessment data if available",
        },
        {
          value: 2072,
          color: "ff0000",
          description: "MTBS Provisional Initial Assessment (PIA) no-data gaps filled with See5-modeled severity; replaced by Extended Assessment data if available",
        },
        {
          value: 2073,
          color: "ff0000",
          description: "MTBS Provisional Initial Assessment (PIA) no-data gaps filled with See5-modeled severity; replaced by Extended Assessment data if available",
        },
        {
          value: 2074,
          color: "ff0000",
          description: "MTBS Provisional Initial Assessment (PIA) no-data gaps filled with See5-modeled severity; replaced by Extended Assessment data if available",
        },
        {
          value: 2075,
          color: "ff0000",
          description: "MTBS Provisional Initial Assessment (PIA) no-data gaps filled with See5-modeled severity; replaced by Extended Assessment data if available",
        },
        {
          value: 2081,
          color: "ff0000",
          description: "MTBS Provisional Initial Assessment (PIA) no-data gaps filled with See5-modeled severity; replaced by Extended Assessment data if available",
        },
        {
          value: 2082,
          color: "ff0000",
          description: "MTBS Provisional Initial Assessment (PIA) no-data gaps filled with See5-modeled severity; replaced by Extended Assessment data if available",
        },
        {
          value: 2083,
          color: "ff0000",
          description: "MTBS Provisional Initial Assessment (PIA) no-data gaps filled with See5-modeled severity; replaced by Extended Assessment data if available",
        },
        {
          value: 2084,
          color: "ff0000",
          description: "MTBS Provisional Initial Assessment (PIA) no-data gaps filled with See5-modeled severity; replaced by Extended Assessment data if available",
        },
        {
          value: 2085,
          color: "ff0000",
          description: "MTBS Provisional Initial Assessment (PIA) no-data gaps filled with See5-modeled severity; replaced by Extended Assessment data if available",
        },
        {
          value: 2091,
          color: "ff0000",
          description: "National Park Service-mapped fire",
        },
        {
          value: 2092,
          color: "ff0000",
          description: "National Park Service-mapped fire",
        },
        {
          value: 2093,
          color: "ff0000",
          description: "National Park Service-mapped fire",
        },
        {
          value: 2094,
          color: "ff0000",
          description: "National Park Service-mapped fire",
        },
        {
          value: 2095,
          color: "ff0000",
          description: "National Park Service-mapped fire",
        },
        {
          value: 2101,
          color: "ff0000",
          description: "National Park Service-mapped fire",
        },
        {
          value: 2102,
          color: "ff0000",
          description: "National Park Service-mapped fire",
        },
        {
          value: 2103,
          color: "ff0000",
          description: "National Park Service-mapped fire",
        },
        {
          value: 2104,
          color: "ff0000",
          description: "National Park Service-mapped fire",
        },
        {
          value: 2105,
          color: "ff0000",
          description: "National Park Service-mapped fire",
        },
        {
          value: 2111,
          color: "ff0000",
          description: "NPS no-data gaps filled with See5-modeled severity",
        },
        {
          value: 2112,
          color: "ff0000",
          description: "NPS no-data gaps filled with See5-modeled severity",
        },
        {
          value: 2113,
          color: "ff0000",
          description: "NPS no-data gaps filled with See5-modeled severity",
        },
        {
          value: 2114,
          color: "ff0000",
          description: "NPS no-data gaps filled with See5-modeled severity",
        },
        {
          value: 2115,
          color: "ff0000",
          description: "NPS no-data gaps filled with See5-modeled severity",
        },
        {
          value: 2121,
          color: "ff0000",
          description: "NPS no-data gaps filled with See5-modeled severity",
        },
        {
          value: 2122,
          color: "ff0000",
          description: "NPS no-data gaps filled with See5-modeled severity",
        },
        {
          value: 2123,
          color: "ff0000",
          description: "NPS no-data gaps filled with See5-modeled severity",
        },
        {
          value: 2124,
          color: "ff0000",
          description: "NPS no-data gaps filled with See5-modeled severity",
        },
        {
          value: 2125,
          color: "ff0000",
          description: "NPS no-data gaps filled with See5-modeled severity",
        },
        {
          value: 2131,
          color: "ff0000",
          description: "RAVG-mapped fire",
        },
        {
          value: 2132,
          color: "ff0000",
          description: "RAVG-mapped fire",
        },
        {
          value: 2133,
          color: "ff0000",
          description: "RAVG-mapped fire",
        },
        {
          value: 2134,
          color: "ff0000",
          description: "RAVG-mapped fire",
        },
        {
          value: 2141,
          color: "ff0000",
          description: "RAVG-mapped fire",
        },
        {
          value: 2142,
          color: "ff0000",
          description: "RAVG-mapped fire",
        },
        {
          value: 2143,
          color: "ff0000",
          description: "RAVG-mapped fire",
        },
        {
          value: 2144,
          color: "ff0000",
          description: "RAVG-mapped fire",
        },
        {
          value: 2151,
          color: "ff0000",
          description: "RAVG no-data gaps filled with See5-modeled severity",
        },
        {
          value: 2152,
          color: "ff0000",
          description: "RAVG no-data gaps filled with See5-modeled severity",
        },
        {
          value: 2153,
          color: "ff0000",
          description: "RAVG no-data gaps filled with See5-modeled severity",
        },
        {
          value: 2154,
          color: "ff0000",
          description: "RAVG no-data gaps filled with See5-modeled severity",
        },
        {
          value: 2161,
          color: "ff0000",
          description: "RAVG no-data gaps filled with See5-modeled severity",
        },
        {
          value: 2162,
          color: "ff0000",
          description: "RAVG no-data gaps filled with See5-modeled severity",
        },
        {
          value: 2163,
          color: "ff0000",
          description: "RAVG no-data gaps filled with See5-modeled severity",
        },
        {
          value: 2164,
          color: "ff0000",
          description: "RAVG no-data gaps filled with See5-modeled severity",
        },
        {
          value: 2171,
          color: "ff0000",
          description: "BARC-mapped fire",
        },
        {
          value: 2172,
          color: "ff0000",
          description: "BARC-mapped fire",
        },
        {
          value: 2173,
          color: "ff0000",
          description: "BARC-mapped fire",
        },
        {
          value: 2174,
          color: "ff0000",
          description: "BARC-mapped fire",
        },
        {
          value: 2181,
          color: "ff0000",
          description: "BARC-mapped fire",
        },
        {
          value: 2182,
          color: "ff0000",
          description: "BARC-mapped fire",
        },
        {
          value: 2183,
          color: "ff0000",
          description: "BARC-mapped fire",
        },
        {
          value: 2184,
          color: "ff0000",
          description: "BARC-mapped fire",
        },
        {
          value: 2191,
          color: "ff0000",
          description: "BARC no-data gaps filled with See5-modeled severity",
        },
        {
          value: 2192,
          color: "ff0000",
          description: "BARC no-data gaps filled with See5-modeled severity",
        },
        {
          value: 2193,
          color: "ff0000",
          description: "BARC no-data gaps filled with See5-modeled severity",
        },
        {
          value: 2194,
          color: "ff0000",
          description: "BARC no-data gaps filled with See5-modeled severity",
        },
        {
          value: 2201,
          color: "ff0000",
          description: "BARC no-data gaps filled with See5-modeled severity",
        },
        {
          value: 2202,
          color: "ff0000",
          description: "BARC no-data gaps filled with See5-modeled severity",
        },
        {
          value: 2203,
          color: "ff0000",
          description: "BARC no-data gaps filled with See5-modeled severity",
        },
        {
          value: 2204,
          color: "ff0000",
          description: "BARC no-data gaps filled with See5-modeled severity",
        },
        {
          value: 2400,
          color: "bfbfbf",
          description: "No image-based change/severity detected within Development LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2401,
          color: "bfbfbf",
          description: "Image-based change detected within Development LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2402,
          color: "bfbfbf",
          description: "Image-based change detected within Development LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2403,
          color: "bfbfbf",
          description: "Image-based change detected within Development LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2404,
          color: "bfbfbf",
          description: "No image-based change/severity detected within Development LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2405,
          color: "bfbfbf",
          description: "Image-based change detected within Development LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2406,
          color: "bfbfbf",
          description: "Image-based change detected within Development LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2407,
          color: "bfbfbf",
          description: "Image-based change detected within Development LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2410,
          color: "806145",
          description: "No image-based change/severity detected within Clearcut LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2411,
          color: "806145",
          description: "Image-based change detected within Clearcut LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2412,
          color: "806145",
          description: "Image-based change detected within Clearcut LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2413,
          color: "806145",
          description: "Image-based change detected within Clearcut LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2414,
          color: "806145",
          description: "No image-based change/severity detected within Clearcut LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2415,
          color: "806145",
          description: "Image-based change detected within Clearcut LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2416,
          color: "806145",
          description: "Image-based change detected within Clearcut LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2417,
          color: "806145",
          description: "Image-based change detected within Clearcut LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2420,
          color: "ffff77",
          description: "No image-based change/severity detected within Harvest LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2421,
          color: "ffff77",
          description: "Image-based change detected within Harvest LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2422,
          color: "ffff77",
          description: "Image-based change detected within Harvest LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2423,
          color: "ffff77",
          description: "Image-based change detected within Harvest LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2424,
          color: "ffff77",
          description: "No image-based change/severity detected within Harvest LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2425,
          color: "ffff77",
          description: "Image-based change detected within Harvest LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2426,
          color: "ffff77",
          description: "Image-based change detected within Harvest LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2427,
          color: "ffff77",
          description: "Image-based change detected within Harvest LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2430,
          color: "b59c72",
          description: "No image-based change/severity detected within Thinning LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2431,
          color: "b59c72",
          description: "Image-based change detected within Thinning LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2432,
          color: "b59c72",
          description: "Image-based change detected within Thinning LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2433,
          color: "b59c72",
          description: "Image-based change detected within Thinning LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2434,
          color: "b59c72",
          description: "No image-based change/severity detected within Thinning LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2435,
          color: "b59c72",
          description: "Image-based change detected within Thinning LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2436,
          color: "b59c72",
          description: "Image-based change detected within Thinning LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2437,
          color: "b59c72",
          description: "Image-based change detected within Thinning LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2440,
          color: "ff6600",
          description: "No image-based change/severity detected within Mastication LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2441,
          color: "ff6600",
          description: "Image-based change detected within Mastication LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2442,
          color: "ff6600",
          description: "Image-based change detected within Mastication LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2443,
          color: "ff6600",
          description: "Image-based change detected within Mastication LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2444,
          color: "ff6600",
          description: "No image-based change/severity detected within Mastication LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2445,
          color: "ff6600",
          description: "Image-based change detected within Mastication LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2446,
          color: "ff6600",
          description: "Image-based change detected within Mastication LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2447,
          color: "ff6600",
          description: "Image-based change detected within Mastication LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2450,
          color: "60ff47",
          description: "No image-based change/severity detected within Mechanical Add LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2451,
          color: "60ff47",
          description: "Image-based change detected within Mechanical Add LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2452,
          color: "60ff47",
          description: "Image-based change detected within Mechanical Add LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2453,
          color: "60ff47",
          description: "Image-based change detected within Mechanical Add LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2454,
          color: "60ff47",
          description: "No image-based change/severity detected within Mechanical Add LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2455,
          color: "60ff47",
          description: "Image-based change detected within Mechanical Add LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2456,
          color: "60ff47",
          description: "Image-based change detected within Mechanical Add LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2457,
          color: "60ff47",
          description: "Image-based change detected within Mechanical Add LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2460,
          color: "60ff47",
          description: "No image-based change/severity detected within Mechanical Remove LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2461,
          color: "60ff47",
          description: "Image-based change detected within Mechanical Remove LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2462,
          color: "60ff47",
          description: "Image-based change detected within Mechanical Remove LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2463,
          color: "60ff47",
          description: "Image-based change detected within Mechanical Remove LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2464,
          color: "60ff47",
          description: "No image-based change/severity detected within Mechanical Remove LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2465,
          color: "60ff47",
          description: "Image-based change detected within Mechanical Remove LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2466,
          color: "60ff47",
          description: "Image-based change detected within Mechanical Remove LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2467,
          color: "60ff47",
          description: "Image-based change detected within Mechanical Remove LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2470,
          color: "60ff47",
          description: "No image-based change/severity detected within Mechanical Unknown LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2471,
          color: "60ff47",
          description: "Image-based change detected within Mechanical Unknown LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2472,
          color: "60ff47",
          description: "Image-based change detected within Mechanical Unknown LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2473,
          color: "60ff47",
          description: "Image-based change detected within Mechanical Unknown LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2474,
          color: "60ff47",
          description: "No image-based change/severity detected within Mechanical Unknown LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2475,
          color: "60ff47",
          description: "Image-based change detected within Mechanical Unknown LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2476,
          color: "60ff47",
          description: "Image-based change detected within Mechanical Unknown LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2477,
          color: "60ff47",
          description: "Image-based change detected within Mechanical Unknown LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2480,
          color: "ff0000",
          description: "No image-based change/severity detected within Wildfire LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2481,
          color: "ff0000",
          description: "Image-based change detected within Wildfire LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2482,
          color: "ff0000",
          description: "Image-based change detected within Wildfire LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2483,
          color: "ff0000",
          description: "Image-based change detected within Wildfire LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2484,
          color: "ff0000",
          description: "No image-based change/severity detected within Wildfire LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2485,
          color: "ff0000",
          description: "Image-based change detected within Wildfire LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2486,
          color: "ff0000",
          description: "Image-based change detected within Wildfire LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2487,
          color: "ff0000",
          description: "Image-based change detected within Wildfire LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2490,
          color: "ff0000",
          description: "No image-based change/severity detected within Wildland Fire Use LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2491,
          color: "ff0000",
          description: "Image-based change detected within Wildland Fire Use LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2492,
          color: "ff0000",
          description: "Image-based change detected within Wildland Fire Use LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2493,
          color: "ff0000",
          description: "Image-based change detected within Wildland Fire Use LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2494,
          color: "ff0000",
          description: "No image-based change/severity detected within Wildland Fire Use LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2495,
          color: "ff0000",
          description: "Image-based change detected within Wildland Fire Use LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2496,
          color: "ff0000",
          description: "Image-based change detected within Wildland Fire Use LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2497,
          color: "ff0000",
          description: "Image-based change detected within Wildland Fire Use LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2500,
          color: "ad001c",
          description: "No image-based change/severity detected within Prescribed Fire LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2501,
          color: "ad001c",
          description: "Image-based change detected within Prescribed Fire LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2502,
          color: "ad001c",
          description: "Image-based change detected within Prescribed Fire LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2503,
          color: "ad001c",
          description: "Image-based change detected within Prescribed Fire LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2504,
          color: "ad001c",
          description: "No image-based change/severity detected within Prescribed Fire LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2505,
          color: "ad001c",
          description: "Image-based change detected within Prescribed Fire LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2506,
          color: "ad001c",
          description: "Image-based change detected within Prescribed Fire LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2507,
          color: "ad001c",
          description: "Image-based change detected within Prescribed Fire LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2510,
          color: "bfbfbf",
          description: "No image-based change/severity detected within Weather LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2511,
          color: "bfbfbf",
          description: "Image-based change detected within Weather LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2512,
          color: "bfbfbf",
          description: "Image-based change detected within Weather LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2513,
          color: "bfbfbf",
          description: "Image-based change detected within Weather LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2514,
          color: "bfbfbf",
          description: "No image-based change/severity detected within Weather LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2515,
          color: "bfbfbf",
          description: "Image-based change detected within Weather LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2516,
          color: "bfbfbf",
          description: "Image-based change detected within Weather LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2517,
          color: "bfbfbf",
          description: "Image-based change detected within Weather LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2520,
          color: "43a2b5",
          description: "No image-based change/severity detected within Insecticide LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2521,
          color: "43a2b5",
          description: "Image-based change detected within Insecticide LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2522,
          color: "43a2b5",
          description: "Image-based change detected within Insecticide LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2523,
          color: "43a2b5",
          description: "Image-based change detected within Insecticide LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2524,
          color: "43a2b5",
          description: "No image-based change/severity detected within Insecticide LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2525,
          color: "43a2b5",
          description: "Image-based change detected within Insecticide LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2526,
          color: "43a2b5",
          description: "Image-based change detected within Insecticide LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2527,
          color: "43a2b5",
          description: "Image-based change detected within Insecticide LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2530,
          color: "ffff00",
          description: "No image-based change/severity detected within Chemical LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2531,
          color: "ffff00",
          description: "Image-based change detected within Chemical LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2532,
          color: "ffff00",
          description: "Image-based change detected within Chemical LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2533,
          color: "ffff00",
          description: "Image-based change detected within Chemical LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2534,
          color: "ffff00",
          description: "No image-based change/severity detected within Chemical LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2535,
          color: "ffff00",
          description: "Image-based change detected within Chemical LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2536,
          color: "ffff00",
          description: "Image-based change detected within Chemical LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2537,
          color: "ffff00",
          description: "Image-based change detected within Chemical LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2540,
          color: "92e8d7",
          description: "No image-based change/severity detected within Insects LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2541,
          color: "92e8d7",
          description: "Image-based change detected within Insects LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2542,
          color: "92e8d7",
          description: "Image-based change detected within Insects LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2543,
          color: "92e8d7",
          description: "Image-based change detected within Insects LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2544,
          color: "92e8d7",
          description: "No image-based change/severity detected within Insects LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2545,
          color: "92e8d7",
          description: "Image-based change detected within Insects LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2546,
          color: "92e8d7",
          description: "Image-based change detected within Insects LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2547,
          color: "92e8d7",
          description: "Image-based change detected within Insects LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2550,
          color: "042d75",
          description: "No image-based change/severity detected within Disease LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2551,
          color: "042d75",
          description: "Image-based change detected within Disease LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2552,
          color: "042d75",
          description: "Image-based change detected within Disease LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2553,
          color: "042d75",
          description: "Image-based change detected within Disease LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2554,
          color: "042d75",
          description: "No image-based change/severity detected within Disease LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2555,
          color: "042d75",
          description: "Image-based change detected within Disease LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2556,
          color: "042d75",
          description: "Image-based change detected within Disease LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2557,
          color: "042d75",
          description: "Image-based change detected within Disease LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2560,
          color: "0000ff",
          description: "No image-based change/severity detected within Insect/Disease LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2561,
          color: "0000ff",
          description: "Image-based change detected within Insect/Disease LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2562,
          color: "0000ff",
          description: "Image-based change detected within Insect/Disease LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2563,
          color: "0000ff",
          description: "Image-based change detected within Insect/Disease LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2564,
          color: "0000ff",
          description: "No image-based change/severity detected within Insect/Disease LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2565,
          color: "0000ff",
          description: "Image-based change detected within Insect/Disease LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2566,
          color: "0000ff",
          description: "Image-based change detected within Insect/Disease LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2567,
          color: "0000ff",
          description: "Image-based change detected within Insect/Disease LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2570,
          color: "c0ff8a",
          description: "No image-based change/severity detected within Herbicide LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2571,
          color: "c0ff8a",
          description: "Image-based change detected within Herbicide LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2572,
          color: "c0ff8a",
          description: "Image-based change detected within Herbicide LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2573,
          color: "c0ff8a",
          description: "Image-based change detected within Herbicide LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2574,
          color: "c0ff8a",
          description: "No image-based change/severity detected within Herbicide LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2575,
          color: "c0ff8a",
          description: "Image-based change detected within Herbicide LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2576,
          color: "c0ff8a",
          description: "Image-based change detected within Herbicide LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2577,
          color: "c0ff8a",
          description: "Image-based change detected within Herbicide LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2580,
          color: "003300",
          description: "No image-based change/severity detected within Biological LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2581,
          color: "003300",
          description: "Image-based change detected within Biological LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2582,
          color: "003300",
          description: "Image-based change detected within Biological LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2583,
          color: "003300",
          description: "Image-based change detected within Biological LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2584,
          color: "003300",
          description: "No image-based change/severity detected within Biological LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2585,
          color: "003300",
          description: "Image-based change detected within Biological LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2586,
          color: "003300",
          description: "Image-based change detected within Biological LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2587,
          color: "003300",
          description: "Image-based change detected within Biological LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2701,
          color: "7a7f75",
          description: "Image-based change detected overlapping USGS Burned Area data where the burn probability is 95% or greater",
        },
        {
          value: 2702,
          color: "7a7f75",
          description: "Image-based change detected overlapping USGS Burned Area data where the burn probability is 95% or greater",
        },
        {
          value: 2703,
          color: "7a7f75",
          description: "Image-based change detected overlapping USGS Burned Area data where the burn probability is 95% or greater",
        },
        {
          value: 2711,
          color: "7a7f75",
          description: "Image-based change detected overlapping USGS Burned Area data where the burn probability is 95% or greater",
        },
        {
          value: 2712,
          color: "7a7f75",
          description: "Image-based change detected overlapping USGS Burned Area data where the burn probability is 95% or greater",
        },
        {
          value: 2713,
          color: "7a7f75",
          description: "Image-based change detected overlapping USGS Burned Area data where the burn probability is 95% or greater",
        },
        {
          value: 2721,
          color: "7a7f75",
          description: "Image-based change detected without an overlapping LANDFIRE Event or Burned Area data",
        },
        {
          value: 2722,
          color: "7a7f75",
          description: "Image-based change detected without an overlapping LANDFIRE Event or Burned Area data",
        },
        {
          value: 2723,
          color: "7a7f75",
          description: "Image-based change detected without an overlapping LANDFIRE Event or Burned Area data",
        },
        {
          value: 2731,
          color: "7a7f75",
          description: "Image-based change detected without an overlapping LANDFIRE Event or Burned Area data",
        },
        {
          value: 2732,
          color: "7a7f75",
          description: "Image-based change detected without an overlapping LANDFIRE Event or Burned Area data",
        },
        {
          value: 2733,
          color: "7a7f75",
          description: "Image-based change detected without an overlapping LANDFIRE Event or Burned Area data",
        },
      ],
    },
    {
      name: "Dist_status",
      description: "Code representing disturbance occurrence and presence/absence of mapped disturbance data. Derived from Dist_raw.",
      "gee:units": units.dimensionless,
      "gee:classes": [
        {
          value: 0,
          color: "e8e8e8",
          description: "No Disturbance",
        },
        {
          value: 1,
          color: "ff7c80",
          description: "Disturbance",
        },
        {
          value: 2,
          color: "0070c0",
          description: "Water",
        },
        {
          value: 3,
          color: "d86dcd",
          description: "Not Mapped",
        },
      ],
    },
    {
      name: "Dist_type_L1",
      description: "Disturbance type represented as a first-order class. Derived categorical view from Dist_raw.",
      "gee:units": units.dimensionless,
      "gee:classes": [
        {
          value: 0,
          color: "e8e8e8",
          description: "No Disturbance",
        },
        {
          value: 1,
          color: "d6604d",
          description: "Fire",
        },
        {
          value: 2,
          color: "f4a582",
          description: "Mechanical Add",
        },
        {
          value: 3,
          color: "b88712",
          description: "Mechanical Remove",
        },
        {
          value: 4,
          color: "d1e5f0",
          description: "Windthrow",
        },
        {
          value: 5,
          color: "6eaac8",
          description: "Insects-Disease",
        },
        {
          value: 6,
          color: "6a3d9a",
          description: "Mechanical Unknown",
        },
        {
          value: 7,
          color: "9c27b0",
          description: "Mastication",
        },
        {
          value: 8,
          color: "003300",
          description: "Biological",
        },
        {
          value: 9,
          color: "ffff00",
          description: "Chemical",
        },
        {
          value: 10,
          color: "6f6f6f",
          description: "Development",
        },
      ],
    },
    {
      name: "Dist_type_L2",
      description: "Disturbance type represented as a second-order class. Derived categorical view from Dist_raw.",
      "gee:units": units.dimensionless,
      "gee:classes": [
        {
          value: 0,
          color: "e8e8e8",
          description: "No Disturbance",
        },
        {
          value: 11,
          color: "d6604d",
          description: "Fire",
        },
        {
          value: 12,
          color: "ff0000",
          description: "Wildfire",
        },
        {
          value: 13,
          color: "d6604d",
          description: "Wildland Fire Use",
        },
        {
          value: 14,
          color: "ad001c",
          description: "Prescribed Fire",
        },
        {
          value: 15,
          color: "c73f00",
          description: "Unknown Fire",
        },
        {
          value: 21,
          color: "f4a582",
          description: "Mechanical Add",
        },
        {
          value: 22,
          color: "e7a77a",
          description: "Mechanical Other",
        },
        {
          value: 31,
          color: "b88712",
          description: "Mechanical Remove",
        },
        {
          value: 32,
          color: "806145",
          description: "Clearcut",
        },
        {
          value: 33,
          color: "ffff77",
          description: "Harvest",
        },
        {
          value: 34,
          color: "b59c72",
          description: "Thinning",
        },
        {
          value: 41,
          color: "d1e5f0",
          description: "Windthrow",
        },
        {
          value: 51,
          color: "0000ff",
          description: "Insects-Disease",
        },
        {
          value: 52,
          color: "92e8d7",
          description: "Insects",
        },
        {
          value: 53,
          color: "042d75",
          description: "Disease",
        },
        {
          value: 61,
          color: "6a3d9a",
          description: "Mechanical Unknown",
        },
        {
          value: 62,
          color: "8e63bf",
          description: "Unknown",
        },
        {
          value: 71,
          color: "9c27b0",
          description: "Mastication",
        },
        {
          value: 81,
          color: "003300",
          description: "Biological",
        },
        {
          value: 91,
          color: "ffff00",
          description: "Chemical",
        },
        {
          value: 92,
          color: "fff176",
          description: "Insecticide",
        },
        {
          value: 93,
          color: "ffee58",
          description: "Herbicide",
        },
        {
          value: 101,
          color: "6f6f6f",
          description: "Development",
        },
      ],
    },
    {
      name: "Dist_severity",
      description: "Disturbance severity. Derived categorical view from Dist_raw.",
      "gee:units": units.dimensionless,
      "gee:classes": [
        {
          value: 0,
          color: "f0f0f0",
          description: "Not Applicable",
        },
        {
          value: 1,
          color: "009e73",
          description: "Increased Green",
        },
        {
          value: 2,
          color: "56b4e9",
          description: "Unburned/Low",
        },
        {
          value: 3,
          color: "f0e442",
          description: "Low",
        },
        {
          value: 4,
          color: "e69f00",
          description: "Moderate",
        },
        {
          value: 5,
          color: "d55e00",
          description: "High",
        },
        {
          value: 6,
          color: "999999",
          description: "No Severity",
        },
      ],
    },
    {
      name: "EVC",
      description: "The code that identifies the percent canopy cover.",
      "gee:units": units.percent,
      "gee:classes": [
        {
          value: 11,
          color: "0000ff",
          description: "Open Water",
        },
        {
          value: 12,
          color: "9fa1f0",
          description: "Snow/Ice",
        },
        {
          value: 13,
          color: "403da8",
          description: "Developed-Upland Deciduous Forest",
        },
        {
          value: 14,
          color: "444f89",
          description: "Developed-Upland Evergreen Forest",
        },
        {
          value: 15,
          color: "6677cd",
          description: "Developed-Upland Mixed Forest",
        },
        {
          value: 16,
          color: "7a8ef5",
          description: "Developed-Upland Herbaceous",
        },
        {
          value: 17,
          color: "9eaad7",
          description: "Developed-Upland Shrubland",
        },
        {
          value: 21,
          color: "fdccd3",
          description: "Developed - Open Space",
        },
        {
          value: 22,
          color: "ff7a8f",
          description: "Developed-Low Intensity",
        },
        {
          value: 23,
          color: "fd2c4f",
          description: "Developed-Medium Intensity",
        },
        {
          value: 24,
          color: "ad001c",
          description: "Developed-High Intensity",
        },
        {
          value: 25,
          color: "010101",
          description: "Developed-Roads",
        },
        {
          value: 31,
          color: "bfbfbf",
          description: "Barren",
        },
        {
          value: 32,
          color: "e6e8fa",
          description: "Quarries-Strip Mines-Gravel Pits-Well and Wind Pads",
        },
        {
          value: 61,
          color: "a80084",
          description: "NASS-Vineyard",
        },
        {
          value: 63,
          color: "fff58c",
          description: "NASS-Row Crop-Close Grown Crop",
        },
        {
          value: 64,
          color: "faff77",
          description: "NASS-Row Crop",
        },
        {
          value: 65,
          color: "ffed77",
          description: "NASS-Close Grown Crop",
        },
        {
          value: 68,
          color: "fae3a3",
          description: "NASS-Wheat",
        },
        {
          value: 69,
          color: "d2ffed",
          description: "NASS-Aquaculture",
        },
        {
          value: 82,
          color: "ffff78",
          description: "Cultivated Crops",
        },
        {
          value: 100,
          color: "7a7f75",
          description: "Sparse Vegetation Canopy",
        },
        {
          value: 110,
          color: "ccff99",
          description: "Tree Cover = 10%",
        },
        {
          value: 111,
          color: "cafc97",
          description: "Tree Cover = 11%",
        },
        {
          value: 112,
          color: "c7fa93",
          description: "Tree Cover = 12%",
        },
        {
          value: 113,
          color: "c2f78f",
          description: "Tree Cover = 13%",
        },
        {
          value: 114,
          color: "c0f58e",
          description: "Tree Cover = 14%",
        },
        {
          value: 115,
          color: "bcf28a",
          description: "Tree Cover = 15%",
        },
        {
          value: 116,
          color: "b7f086",
          description: "Tree Cover = 16%",
        },
        {
          value: 117,
          color: "b5ed85",
          description: "Tree Cover = 17%",
        },
        {
          value: 118,
          color: "b2eb81",
          description: "Tree Cover = 18%",
        },
        {
          value: 119,
          color: "ade87d",
          description: "Tree Cover = 19%",
        },
        {
          value: 120,
          color: "ade87d",
          description: "Tree Cover = 20%",
        },
        {
          value: 121,
          color: "aae67a",
          description: "Tree Cover = 21%",
        },
        {
          value: 122,
          color: "a5e376",
          description: "Tree Cover = 22%",
        },
        {
          value: 123,
          color: "a3e075",
          description: "Tree Cover = 23%",
        },
        {
          value: 124,
          color: "a0de71",
          description: "Tree Cover = 24%",
        },
        {
          value: 125,
          color: "9bdb6e",
          description: "Tree Cover = 25%",
        },
        {
          value: 126,
          color: "9ad96c",
          description: "Tree Cover = 26%",
        },
        {
          value: 127,
          color: "96d669",
          description: "Tree Cover = 27%",
        },
        {
          value: 128,
          color: "92d466",
          description: "Tree Cover = 28%",
        },
        {
          value: 129,
          color: "90d164",
          description: "Tree Cover = 29%",
        },
        {
          value: 130,
          color: "8fd162",
          description: "Tree Cover = 30%",
        },
        {
          value: 131,
          color: "8acf5f",
          description: "Tree Cover = 31%",
        },
        {
          value: 132,
          color: "88cc5e",
          description: "Tree Cover = 32%",
        },
        {
          value: 133,
          color: "85c95b",
          description: "Tree Cover = 33%",
        },
        {
          value: 134,
          color: "80c758",
          description: "Tree Cover = 34%",
        },
        {
          value: 135,
          color: "7fc456",
          description: "Tree Cover = 35%",
        },
        {
          value: 136,
          color: "7cc253",
          description: "Tree Cover = 36%",
        },
        {
          value: 137,
          color: "77bf50",
          description: "Tree Cover = 37%",
        },
        {
          value: 138,
          color: "76bd4f",
          description: "Tree Cover = 38%",
        },
        {
          value: 139,
          color: "73ba4c",
          description: "Tree Cover = 39%",
        },
        {
          value: 140,
          color: "70ba4a",
          description: "Tree Cover = 40%",
        },
        {
          value: 141,
          color: "6eb849",
          description: "Tree Cover = 41%",
        },
        {
          value: 142,
          color: "6bb547",
          description: "Tree Cover = 42%",
        },
        {
          value: 143,
          color: "67b344",
          description: "Tree Cover = 43%",
        },
        {
          value: 144,
          color: "65b043",
          description: "Tree Cover = 44%",
        },
        {
          value: 145,
          color: "63ad40",
          description: "Tree Cover = 45%",
        },
        {
          value: 146,
          color: "5eab3e",
          description: "Tree Cover = 46%",
        },
        {
          value: 147,
          color: "5da83d",
          description: "Tree Cover = 47%",
        },
        {
          value: 148,
          color: "5aa63a",
          description: "Tree Cover = 48%",
        },
        {
          value: 149,
          color: "56a337",
          description: "Tree Cover = 49%",
        },
        {
          value: 150,
          color: "56a337",
          description: "Tree Cover = 50%",
        },
        {
          value: 151,
          color: "54a135",
          description: "Tree Cover = 51%",
        },
        {
          value: 152,
          color: "4f9e33",
          description: "Tree Cover = 52%",
        },
        {
          value: 153,
          color: "4e9c32",
          description: "Tree Cover = 53%",
        },
        {
          value: 154,
          color: "4c992f",
          description: "Tree Cover = 54%",
        },
        {
          value: 155,
          color: "47962d",
          description: "Tree Cover = 55%",
        },
        {
          value: 156,
          color: "45942b",
          description: "Tree Cover = 56%",
        },
        {
          value: 157,
          color: "44912a",
          description: "Tree Cover = 57%",
        },
        {
          value: 158,
          color: "408f28",
          description: "Tree Cover = 58%",
        },
        {
          value: 159,
          color: "3e8c26",
          description: "Tree Cover = 59%",
        },
        {
          value: 160,
          color: "3e8c26",
          description: "Tree Cover = 60%",
        },
        {
          value: 161,
          color: "3a8a24",
          description: "Tree Cover = 61%",
        },
        {
          value: 162,
          color: "388722",
          description: "Tree Cover = 62%",
        },
        {
          value: 163,
          color: "378521",
          description: "Tree Cover = 63%",
        },
        {
          value: 164,
          color: "33821f",
          description: "Tree Cover = 64%",
        },
        {
          value: 165,
          color: "31801d",
          description: "Tree Cover = 65%",
        },
        {
          value: 166,
          color: "307d1d",
          description: "Tree Cover = 66%",
        },
        {
          value: 167,
          color: "2c7a1b",
          description: "Tree Cover = 67%",
        },
        {
          value: 168,
          color: "2b7819",
          description: "Tree Cover = 68%",
        },
        {
          value: 169,
          color: "2a7519",
          description: "Tree Cover = 69%",
        },
        {
          value: 170,
          color: "277517",
          description: "Tree Cover = 70%",
        },
        {
          value: 171,
          color: "257316",
          description: "Tree Cover = 71%",
        },
        {
          value: 172,
          color: "247015",
          description: "Tree Cover = 72%",
        },
        {
          value: 173,
          color: "216e14",
          description: "Tree Cover = 73%",
        },
        {
          value: 174,
          color: "206b12",
          description: "Tree Cover = 74%",
        },
        {
          value: 175,
          color: "1f6912",
          description: "Tree Cover = 75%",
        },
        {
          value: 176,
          color: "1c6610",
          description: "Tree Cover = 76%",
        },
        {
          value: 177,
          color: "1a630f",
          description: "Tree Cover = 77%",
        },
        {
          value: 178,
          color: "1a610f",
          description: "Tree Cover = 78%",
        },
        {
          value: 179,
          color: "175e0d",
          description: "Tree Cover = 79%",
        },
        {
          value: 180,
          color: "165e0c",
          description: "Tree Cover = 80%",
        },
        {
          value: 181,
          color: "155c0c",
          description: "Tree Cover = 81%",
        },
        {
          value: 182,
          color: "13590b",
          description: "Tree Cover = 82%",
        },
        {
          value: 183,
          color: "11570a",
          description: "Tree Cover = 83%",
        },
        {
          value: 184,
          color: "115409",
          description: "Tree Cover = 84%",
        },
        {
          value: 185,
          color: "0e5208",
          description: "Tree Cover = 85%",
        },
        {
          value: 186,
          color: "0d4f07",
          description: "Tree Cover = 86%",
        },
        {
          value: 187,
          color: "0d4d07",
          description: "Tree Cover = 87%",
        },
        {
          value: 188,
          color: "0a4a06",
          description: "Tree Cover = 88%",
        },
        {
          value: 189,
          color: "094705",
          description: "Tree Cover = 89%",
        },
        {
          value: 190,
          color: "094705",
          description: "Tree Cover = 90%",
        },
        {
          value: 191,
          color: "074504",
          description: "Tree Cover = 91%",
        },
        {
          value: 192,
          color: "064203",
          description: "Tree Cover = 92%",
        },
        {
          value: 193,
          color: "064003",
          description: "Tree Cover = 93%",
        },
        {
          value: 194,
          color: "043d02",
          description: "Tree Cover = 94%",
        },
        {
          value: 195,
          color: "043b02",
          description: "Tree Cover = 95%",
        },
        {
          value: 196,
          color: "033802",
          description: "Tree Cover = 96%",
        },
        {
          value: 197,
          color: "023601",
          description: "Tree Cover = 97%",
        },
        {
          value: 198,
          color: "013301",
          description: "Tree Cover = 98%",
        },
        {
          value: 199,
          color: "003300",
          description: "Tree Cover >= 99%",
        },
        {
          value: 210,
          color: "d4b27d",
          description: "Shrub Cover = 10%",
        },
        {
          value: 211,
          color: "d4b07b",
          description: "Shrub Cover = 11%",
        },
        {
          value: 212,
          color: "d4af7b",
          description: "Shrub Cover = 12%",
        },
        {
          value: 213,
          color: "d4ae79",
          description: "Shrub Cover = 13%",
        },
        {
          value: 214,
          color: "d1aa77",
          description: "Shrub Cover = 14%",
        },
        {
          value: 215,
          color: "d1a875",
          description: "Shrub Cover = 15%",
        },
        {
          value: 216,
          color: "d1a675",
          description: "Shrub Cover = 16%",
        },
        {
          value: 217,
          color: "d1a573",
          description: "Shrub Cover = 17%",
        },
        {
          value: 218,
          color: "d1a473",
          description: "Shrub Cover = 18%",
        },
        {
          value: 219,
          color: "d1a171",
          description: "Shrub Cover = 19%",
        },
        {
          value: 220,
          color: "cf9f70",
          description: "Shrub Cover = 20%",
        },
        {
          value: 221,
          color: "cf9c6d",
          description: "Shrub Cover = 21%",
        },
        {
          value: 222,
          color: "cf9b6d",
          description: "Shrub Cover = 22%",
        },
        {
          value: 223,
          color: "cf9a6b",
          description: "Shrub Cover = 23%",
        },
        {
          value: 224,
          color: "cf986b",
          description: "Shrub Cover = 24%",
        },
        {
          value: 225,
          color: "cf9769",
          description: "Shrub Cover = 25%",
        },
        {
          value: 226,
          color: "cc9368",
          description: "Shrub Cover = 26%",
        },
        {
          value: 227,
          color: "cc9266",
          description: "Shrub Cover = 27%",
        },
        {
          value: 228,
          color: "cc9166",
          description: "Shrub Cover = 28%",
        },
        {
          value: 229,
          color: "cc8e64",
          description: "Shrub Cover = 29%",
        },
        {
          value: 230,
          color: "cc8e64",
          description: "Shrub Cover = 30%",
        },
        {
          value: 231,
          color: "c98961",
          description: "Shrub Cover = 31%",
        },
        {
          value: 232,
          color: "c98961",
          description: "Shrub Cover = 32%",
        },
        {
          value: 233,
          color: "c9865f",
          description: "Shrub Cover = 33%",
        },
        {
          value: 234,
          color: "c9865f",
          description: "Shrub Cover = 34%",
        },
        {
          value: 235,
          color: "c9845f",
          description: "Shrub Cover = 35%",
        },
        {
          value: 236,
          color: "c7815b",
          description: "Shrub Cover = 36%",
        },
        {
          value: 237,
          color: "c77f5b",
          description: "Shrub Cover = 37%",
        },
        {
          value: 238,
          color: "c77e5a",
          description: "Shrub Cover = 38%",
        },
        {
          value: 239,
          color: "c77e5a",
          description: "Shrub Cover = 39%",
        },
        {
          value: 240,
          color: "c77b58",
          description: "Shrub Cover = 40%",
        },
        {
          value: 241,
          color: "c47956",
          description: "Shrub Cover = 41%",
        },
        {
          value: 242,
          color: "c47654",
          description: "Shrub Cover = 42%",
        },
        {
          value: 243,
          color: "c47654",
          description: "Shrub Cover = 43%",
        },
        {
          value: 244,
          color: "c47352",
          description: "Shrub Cover = 44%",
        },
        {
          value: 245,
          color: "c47352",
          description: "Shrub Cover = 45%",
        },
        {
          value: 246,
          color: "c26e4f",
          description: "Shrub Cover = 46%",
        },
        {
          value: 247,
          color: "c26e4f",
          description: "Shrub Cover = 47%",
        },
        {
          value: 248,
          color: "c26e4f",
          description: "Shrub Cover = 48%",
        },
        {
          value: 249,
          color: "c26b4e",
          description: "Shrub Cover = 49%",
        },
        {
          value: 250,
          color: "bf694d",
          description: "Shrub Cover = 50%",
        },
        {
          value: 251,
          color: "bf664b",
          description: "Shrub Cover = 51%",
        },
        {
          value: 252,
          color: "bf664b",
          description: "Shrub Cover = 52%",
        },
        {
          value: 253,
          color: "bf6449",
          description: "Shrub Cover = 53%",
        },
        {
          value: 254,
          color: "bd6148",
          description: "Shrub Cover = 54%",
        },
        {
          value: 255,
          color: "bd6046",
          description: "Shrub Cover = 55%",
        },
        {
          value: 256,
          color: "bd5e46",
          description: "Shrub Cover = 56%",
        },
        {
          value: 257,
          color: "bd5e46",
          description: "Shrub Cover = 57%",
        },
        {
          value: 258,
          color: "bd5c44",
          description: "Shrub Cover = 58%",
        },
        {
          value: 259,
          color: "ba5943",
          description: "Shrub Cover = 59%",
        },
        {
          value: 260,
          color: "ba5741",
          description: "Shrub Cover = 60%",
        },
        {
          value: 261,
          color: "ba5541",
          description: "Shrub Cover = 61%",
        },
        {
          value: 262,
          color: "ba543f",
          description: "Shrub Cover = 62%",
        },
        {
          value: 263,
          color: "b8533e",
          description: "Shrub Cover = 63%",
        },
        {
          value: 264,
          color: "b8513e",
          description: "Shrub Cover = 64%",
        },
        {
          value: 265,
          color: "b84f3d",
          description: "Shrub Cover = 65%",
        },
        {
          value: 266,
          color: "b54c3c",
          description: "Shrub Cover = 66%",
        },
        {
          value: 267,
          color: "b54a3a",
          description: "Shrub Cover = 67%",
        },
        {
          value: 268,
          color: "b54a3a",
          description: "Shrub Cover = 68%",
        },
        {
          value: 269,
          color: "b5483a",
          description: "Shrub Cover = 69%",
        },
        {
          value: 270,
          color: "b34637",
          description: "Shrub Cover = 70%",
        },
        {
          value: 271,
          color: "b34437",
          description: "Shrub Cover = 71%",
        },
        {
          value: 272,
          color: "b34236",
          description: "Shrub Cover = 72%",
        },
        {
          value: 273,
          color: "b34036",
          description: "Shrub Cover = 73%",
        },
        {
          value: 274,
          color: "b03f35",
          description: "Shrub Cover = 74%",
        },
        {
          value: 275,
          color: "b03d33",
          description: "Shrub Cover = 75%",
        },
        {
          value: 276,
          color: "b03b33",
          description: "Shrub Cover = 76%",
        },
        {
          value: 277,
          color: "b03a31",
          description: "Shrub Cover = 77%",
        },
        {
          value: 278,
          color: "ad3731",
          description: "Shrub Cover = 78%",
        },
        {
          value: 279,
          color: "ad3731",
          description: "Shrub Cover = 79%",
        },
        {
          value: 280,
          color: "ad332f",
          description: "Shrub Cover = 80%",
        },
        {
          value: 281,
          color: "ab322e",
          description: "Shrub Cover = 81%",
        },
        {
          value: 282,
          color: "ab2f2c",
          description: "Shrub Cover = 82%",
        },
        {
          value: 283,
          color: "ab2f2c",
          description: "Shrub Cover = 83%",
        },
        {
          value: 284,
          color: "ab2c2c",
          description: "Shrub Cover = 84%",
        },
        {
          value: 285,
          color: "a82a2a",
          description: "Shrub Cover = 85%",
        },
        {
          value: 286,
          color: "a8282b",
          description: "Shrub Cover = 86%",
        },
        {
          value: 287,
          color: "a82729",
          description: "Shrub Cover = 87%",
        },
        {
          value: 288,
          color: "a62429",
          description: "Shrub Cover = 88%",
        },
        {
          value: 289,
          color: "a62327",
          description: "Shrub Cover = 89%",
        },
        {
          value: 290,
          color: "a61f26",
          description: "Shrub Cover = 90%",
        },
        {
          value: 291,
          color: "a31d24",
          description: "Shrub Cover = 91%",
        },
        {
          value: 292,
          color: "a31c25",
          description: "Shrub Cover = 92%",
        },
        {
          value: 293,
          color: "a31824",
          description: "Shrub Cover = 93%",
        },
        {
          value: 294,
          color: "a31725",
          description: "Shrub Cover = 94%",
        },
        {
          value: 295,
          color: "a11321",
          description: "Shrub Cover = 95%",
        },
        {
          value: 296,
          color: "a11021",
          description: "Shrub Cover = 96%",
        },
        {
          value: 297,
          color: "a10d21",
          description: "Shrub Cover = 97%",
        },
        {
          value: 298,
          color: "9e0920",
          description: "Shrub Cover = 98%",
        },
        {
          value: 299,
          color: "9e0020",
          description: "Shrub Cover >= 99%",
        },
        {
          value: 310,
          color: "ffcc66",
          description: "Herb Cover = 10%",
        },
        {
          value: 311,
          color: "ffcc66",
          description: "Herb Cover = 11%",
        },
        {
          value: 312,
          color: "ffc966",
          description: "Herb Cover = 12%",
        },
        {
          value: 313,
          color: "ffc966",
          description: "Herb Cover = 13%",
        },
        {
          value: 314,
          color: "ffc963",
          description: "Herb Cover = 14%",
        },
        {
          value: 315,
          color: "ffc663",
          description: "Herb Cover = 15%",
        },
        {
          value: 316,
          color: "ffc561",
          description: "Herb Cover = 16%",
        },
        {
          value: 317,
          color: "ffc561",
          description: "Herb Cover = 17%",
        },
        {
          value: 318,
          color: "ffc15e",
          description: "Herb Cover = 18%",
        },
        {
          value: 319,
          color: "ffc15e",
          description: "Herb Cover = 19%",
        },
        {
          value: 320,
          color: "ffc05c",
          description: "Herb Cover = 20%",
        },
        {
          value: 321,
          color: "ffbe5c",
          description: "Herb Cover = 21%",
        },
        {
          value: 322,
          color: "ffbe5c",
          description: "Herb Cover = 22%",
        },
        {
          value: 323,
          color: "ffbd59",
          description: "Herb Cover = 23%",
        },
        {
          value: 324,
          color: "ffba59",
          description: "Herb Cover = 24%",
        },
        {
          value: 325,
          color: "ffb957",
          description: "Herb Cover = 25%",
        },
        {
          value: 326,
          color: "ffb957",
          description: "Herb Cover = 26%",
        },
        {
          value: 327,
          color: "ffb554",
          description: "Herb Cover = 27%",
        },
        {
          value: 328,
          color: "ffb554",
          description: "Herb Cover = 28%",
        },
        {
          value: 329,
          color: "ffb452",
          description: "Herb Cover = 29%",
        },
        {
          value: 330,
          color: "ffb152",
          description: "Herb Cover = 30%",
        },
        {
          value: 331,
          color: "ffb04f",
          description: "Herb Cover = 31%",
        },
        {
          value: 332,
          color: "ffb04f",
          description: "Herb Cover = 32%",
        },
        {
          value: 333,
          color: "ffad4f",
          description: "Herb Cover = 33%",
        },
        {
          value: 334,
          color: "ffac4d",
          description: "Herb Cover = 34%",
        },
        {
          value: 335,
          color: "ffac4d",
          description: "Herb Cover = 35%",
        },
        {
          value: 336,
          color: "ffab4a",
          description: "Herb Cover = 36%",
        },
        {
          value: 337,
          color: "ffa74a",
          description: "Herb Cover = 37%",
        },
        {
          value: 338,
          color: "ffa647",
          description: "Herb Cover = 38%",
        },
        {
          value: 339,
          color: "ffa647",
          description: "Herb Cover = 39%",
        },
        {
          value: 340,
          color: "ffa245",
          description: "Herb Cover = 40%",
        },
        {
          value: 341,
          color: "ffa245",
          description: "Herb Cover = 41%",
        },
        {
          value: 342,
          color: "ffa142",
          description: "Herb Cover = 42%",
        },
        {
          value: 343,
          color: "ff9e42",
          description: "Herb Cover = 43%",
        },
        {
          value: 344,
          color: "ff9e42",
          description: "Herb Cover = 44%",
        },
        {
          value: 345,
          color: "ff9c40",
          description: "Herb Cover = 45%",
        },
        {
          value: 346,
          color: "ff9940",
          description: "Herb Cover = 46%",
        },
        {
          value: 347,
          color: "ff983d",
          description: "Herb Cover = 47%",
        },
        {
          value: 348,
          color: "ff983d",
          description: "Herb Cover = 48%",
        },
        {
          value: 349,
          color: "ff933b",
          description: "Herb Cover = 49%",
        },
        {
          value: 350,
          color: "ff933b",
          description: "Herb Cover = 50%",
        },
        {
          value: 351,
          color: "ff9238",
          description: "Herb Cover = 51%",
        },
        {
          value: 352,
          color: "ff8e38",
          description: "Herb Cover = 52%",
        },
        {
          value: 353,
          color: "ff8d36",
          description: "Herb Cover = 53%",
        },
        {
          value: 354,
          color: "ff8d36",
          description: "Herb Cover = 54%",
        },
        {
          value: 355,
          color: "ff8936",
          description: "Herb Cover = 55%",
        },
        {
          value: 356,
          color: "ff8833",
          description: "Herb Cover = 56%",
        },
        {
          value: 357,
          color: "ff8833",
          description: "Herb Cover = 57%",
        },
        {
          value: 358,
          color: "ff8730",
          description: "Herb Cover = 58%",
        },
        {
          value: 359,
          color: "ff8330",
          description: "Herb Cover = 59%",
        },
        {
          value: 360,
          color: "ff822e",
          description: "Herb Cover = 60%",
        },
        {
          value: 361,
          color: "ff822e",
          description: "Herb Cover = 61%",
        },
        {
          value: 362,
          color: "ff7c2b",
          description: "Herb Cover = 62%",
        },
        {
          value: 363,
          color: "ff7c2b",
          description: "Herb Cover = 63%",
        },
        {
          value: 364,
          color: "ff7b29",
          description: "Herb Cover = 64%",
        },
        {
          value: 365,
          color: "ff7729",
          description: "Herb Cover = 65%",
        },
        {
          value: 366,
          color: "ff7729",
          description: "Herb Cover = 66%",
        },
        {
          value: 367,
          color: "ff7626",
          description: "Herb Cover = 67%",
        },
        {
          value: 368,
          color: "ff7226",
          description: "Herb Cover = 68%",
        },
        {
          value: 369,
          color: "ff7024",
          description: "Herb Cover = 69%",
        },
        {
          value: 370,
          color: "ff7024",
          description: "Herb Cover = 70%",
        },
        {
          value: 371,
          color: "ff6b21",
          description: "Herb Cover = 71%",
        },
        {
          value: 372,
          color: "ff6b21",
          description: "Herb Cover = 72%",
        },
        {
          value: 373,
          color: "ff691f",
          description: "Herb Cover = 73%",
        },
        {
          value: 374,
          color: "ff661f",
          description: "Herb Cover = 74%",
        },
        {
          value: 375,
          color: "ff641c",
          description: "Herb Cover = 75%",
        },
        {
          value: 376,
          color: "ff641c",
          description: "Herb Cover = 76%",
        },
        {
          value: 377,
          color: "ff641c",
          description: "Herb Cover = 77%",
        },
        {
          value: 378,
          color: "ff5e19",
          description: "Herb Cover = 78%",
        },
        {
          value: 379,
          color: "ff5e19",
          description: "Herb Cover = 79%",
        },
        {
          value: 380,
          color: "ff5d17",
          description: "Herb Cover = 80%",
        },
        {
          value: 381,
          color: "ff5917",
          description: "Herb Cover = 81%",
        },
        {
          value: 382,
          color: "ff5714",
          description: "Herb Cover = 82%",
        },
        {
          value: 383,
          color: "ff5714",
          description: "Herb Cover = 83%",
        },
        {
          value: 384,
          color: "ff5112",
          description: "Herb Cover = 84%",
        },
        {
          value: 385,
          color: "ff5112",
          description: "Herb Cover = 85%",
        },
        {
          value: 386,
          color: "ff4f0f",
          description: "Herb Cover = 86%",
        },
        {
          value: 387,
          color: "ff4b0f",
          description: "Herb Cover = 87%",
        },
        {
          value: 388,
          color: "ff4b0f",
          description: "Herb Cover = 88%",
        },
        {
          value: 389,
          color: "ff490d",
          description: "Herb Cover = 89%",
        },
        {
          value: 390,
          color: "ff450d",
          description: "Herb Cover = 90%",
        },
        {
          value: 391,
          color: "ff430a",
          description: "Herb Cover = 91%",
        },
        {
          value: 392,
          color: "ff430a",
          description: "Herb Cover = 92%",
        },
        {
          value: 393,
          color: "ff3d08",
          description: "Herb Cover = 93%",
        },
        {
          value: 394,
          color: "ff3d08",
          description: "Herb Cover = 94%",
        },
        {
          value: 395,
          color: "ff3b05",
          description: "Herb Cover = 95%",
        },
        {
          value: 396,
          color: "ff3705",
          description: "Herb Cover = 96%",
        },
        {
          value: 397,
          color: "ff3503",
          description: "Herb Cover = 97%",
        },
        {
          value: 398,
          color: "ff3503",
          description: "Herb Cover = 98%",
        },
        {
          value: 399,
          color: "ff3300",
          description: "Herb Cover >= 99%",
        },
      ],
    },
    {
      name: "EVH",
      description: "Value representing height (m).",
      "gee:units": units.meter,
      "gee:classes": [
        {
          value: 11,
          color: "0000ff",
          description: "Open Water",
        },
        {
          value: 12,
          color: "9fa1f0",
          description: "Snow/Ice",
        },
        {
          value: 13,
          color: "403da8",
          description: "Developed-Upland Deciduous Forest",
        },
        {
          value: 14,
          color: "444f89",
          description: "Developed-Upland Evergreen Forest",
        },
        {
          value: 15,
          color: "6677cd",
          description: "Developed-Upland Mixed Forest",
        },
        {
          value: 16,
          color: "7a8ef5",
          description: "Developed-Upland Herbaceous",
        },
        {
          value: 17,
          color: "9eaad7",
          description: "Developed-Upland Shrubland",
        },
        {
          value: 21,
          color: "fdccd3",
          description: "Developed - Open Space",
        },
        {
          value: 22,
          color: "ff7a8f",
          description: "Developed - Low Intensity",
        },
        {
          value: 23,
          color: "fd2c4f",
          description: "Developed - Medium Intensity",
        },
        {
          value: 24,
          color: "ad001c",
          description: "Developed - High Intensity",
        },
        {
          value: 25,
          color: "010101",
          description: "Developed-Roads",
        },
        {
          value: 31,
          color: "bfbfbf",
          description: "Barren",
        },
        {
          value: 32,
          color: "e6e8fa",
          description: "Quarries-Strip Mines-Gravel Pits-Well and Wind Pads",
        },
        {
          value: 61,
          color: "a80084",
          description: "NASS-Vineyard",
        },
        {
          value: 63,
          color: "fff58c",
          description: "NASS-Row Crop-Close Grown Crop",
        },
        {
          value: 64,
          color: "faff77",
          description: "NASS-Row Crop",
        },
        {
          value: 65,
          color: "ffed77",
          description: "NASS-Close Grown Crop",
        },
        {
          value: 68,
          color: "fae3a3",
          description: "NASS-Wheat",
        },
        {
          value: 69,
          color: "d2ffed",
          description: "NASS-Aquaculture",
        },
        {
          value: 82,
          color: "ffff78",
          description: "Cultivated Crops",
        },
        {
          value: 100,
          color: "7a7f75",
          description: "Sparse Vegetation Canopy",
        },
        {
          value: 101,
          color: "ccff99",
          description: "Tree Height = 1 meter",
        },
        {
          value: 102,
          color: "c7fa93",
          description: "Tree Height = 2 meters",
        },
        {
          value: 103,
          color: "c0f58e",
          description: "Tree Height = 3 meters",
        },
        {
          value: 104,
          color: "bcf28a",
          description: "Tree Height = 4 meters",
        },
        {
          value: 105,
          color: "b5ed85",
          description: "Tree Height = 5 meters",
        },
        {
          value: 106,
          color: "b2eb81",
          description: "Tree Height = 6 meters",
        },
        {
          value: 107,
          color: "abe67c",
          description: "Tree Height = 7 meters",
        },
        {
          value: 108,
          color: "a8e378",
          description: "Tree Height = 8 meters",
        },
        {
          value: 109,
          color: "a0de71",
          description: "Tree Height = 9 meters",
        },
        {
          value: 110,
          color: "9bdb6e",
          description: "Tree Height = 10 meters",
        },
        {
          value: 111,
          color: "96d669",
          description: "Tree Height = 11 meters",
        },
        {
          value: 112,
          color: "92d466",
          description: "Tree Height = 12 meters",
        },
        {
          value: 113,
          color: "8dcf61",
          description: "Tree Height = 13 meters",
        },
        {
          value: 114,
          color: "88cc5e",
          description: "Tree Height = 14 meters",
        },
        {
          value: 115,
          color: "83c75a",
          description: "Tree Height = 15 meters",
        },
        {
          value: 116,
          color: "7fc456",
          description: "Tree Height = 16 meters",
        },
        {
          value: 117,
          color: "77bf50",
          description: "Tree Height = 17 meters",
        },
        {
          value: 118,
          color: "74bd4d",
          description: "Tree Height = 18 meters",
        },
        {
          value: 119,
          color: "6eb849",
          description: "Tree Height = 19 meters",
        },
        {
          value: 120,
          color: "6bb547",
          description: "Tree Height = 20 meters",
        },
        {
          value: 121,
          color: "65b043",
          description: "Tree Height = 21 meters",
        },
        {
          value: 122,
          color: "63ad40",
          description: "Tree Height = 22 meters",
        },
        {
          value: 123,
          color: "5da83d",
          description: "Tree Height = 23 meters",
        },
        {
          value: 124,
          color: "57a638",
          description: "Tree Height = 24 meters",
        },
        {
          value: 125,
          color: "54a135",
          description: "Tree Height = 25 meters",
        },
        {
          value: 126,
          color: "4f9e33",
          description: "Tree Height = 26 meters",
        },
        {
          value: 127,
          color: "4c992f",
          description: "Tree Height = 27 meters",
        },
        {
          value: 128,
          color: "47962d",
          description: "Tree Height = 28 meters",
        },
        {
          value: 129,
          color: "44912a",
          description: "Tree Height = 29 meters",
        },
        {
          value: 130,
          color: "408f28",
          description: "Tree Height = 30 meters",
        },
        {
          value: 131,
          color: "3d8a25",
          description: "Tree Height = 31 meters",
        },
        {
          value: 132,
          color: "388722",
          description: "Tree Height = 32 meters",
        },
        {
          value: 133,
          color: "33821f",
          description: "Tree Height = 33 meters",
        },
        {
          value: 134,
          color: "31801d",
          description: "Tree Height = 34 meters",
        },
        {
          value: 135,
          color: "2c7a1b",
          description: "Tree Height = 35 meters",
        },
        {
          value: 136,
          color: "2b7819",
          description: "Tree Height = 36 meters",
        },
        {
          value: 137,
          color: "267317",
          description: "Tree Height = 37 meters",
        },
        {
          value: 138,
          color: "247015",
          description: "Tree Height = 38 meters",
        },
        {
          value: 139,
          color: "206b12",
          description: "Tree Height = 39 meters",
        },
        {
          value: 140,
          color: "1c6911",
          description: "Tree Height = 40 meters",
        },
        {
          value: 141,
          color: "1a630f",
          description: "Tree Height = 41 meters",
        },
        {
          value: 142,
          color: "17610e",
          description: "Tree Height = 42 meters",
        },
        {
          value: 143,
          color: "155c0c",
          description: "Tree Height = 43 meters",
        },
        {
          value: 144,
          color: "13590b",
          description: "Tree Height = 44 meters",
        },
        {
          value: 145,
          color: "115409",
          description: "Tree Height = 45 meters",
        },
        {
          value: 146,
          color: "0e5208",
          description: "Tree Height = 46 meters",
        },
        {
          value: 147,
          color: "0b4d06",
          description: "Tree Height = 47 meters",
        },
        {
          value: 148,
          color: "0a4a05",
          description: "Tree Height = 48 meters",
        },
        {
          value: 149,
          color: "074504",
          description: "Tree Height = 49 meters",
        },
        {
          value: 150,
          color: "064203",
          description: "Tree Height = 50 meters",
        },
        {
          value: 151,
          color: "043d02",
          description: "Tree Height = 51 meters",
        },
        {
          value: 152,
          color: "043b02",
          description: "Tree Height = 52 meters",
        },
        {
          value: 153,
          color: "023601",
          description: "Tree Height = 53 meters",
        },
        {
          value: 154,
          color: "003300",
          description: "Tree Height = 54 meters",
        },
        {
          value: 155,
          color: "003300",
          description: "Tree Height = 55 meters",
        },
        {
          value: 156,
          color: "003300",
          description: "Tree Height = 56 meters",
        },
        {
          value: 157,
          color: "003300",
          description: "Tree Height = 57 meters",
        },
        {
          value: 158,
          color: "003300",
          description: "Tree Height = 58 meters",
        },
        {
          value: 159,
          color: "003300",
          description: "Tree Height = 59 meters",
        },
        {
          value: 160,
          color: "003300",
          description: "Tree Height = 60 meters",
        },
        {
          value: 161,
          color: "003300",
          description: "Tree Height = 61 meters",
        },
        {
          value: 162,
          color: "003300",
          description: "Tree Height = 62 meters",
        },
        {
          value: 163,
          color: "003300",
          description: "Tree Height = 63 meters",
        },
        {
          value: 164,
          color: "003300",
          description: "Tree Height = 64 meters",
        },
        {
          value: 165,
          color: "003300",
          description: "Tree Height = 65 meters",
        },
        {
          value: 166,
          color: "003300",
          description: "Tree Height = 66 meters",
        },
        {
          value: 167,
          color: "003300",
          description: "Tree Height = 67 meters",
        },
        {
          value: 168,
          color: "003300",
          description: "Tree Height = 68 meters",
        },
        {
          value: 169,
          color: "003300",
          description: "Tree Height = 69 meters",
        },
        {
          value: 170,
          color: "003300",
          description: "Tree Height = 70 meters",
        },
        {
          value: 171,
          color: "003300",
          description: "Tree Height = 71 meters",
        },
        {
          value: 172,
          color: "003300",
          description: "Tree Height = 72 meters",
        },
        {
          value: 173,
          color: "003300",
          description: "Tree Height = 73 meters",
        },
        {
          value: 174,
          color: "003300",
          description: "Tree Height = 74 meters",
        },
        {
          value: 175,
          color: "003300",
          description: "Tree Height = 75 meters",
        },
        {
          value: 176,
          color: "003300",
          description: "Tree Height = 76 meters",
        },
        {
          value: 177,
          color: "003300",
          description: "Tree Height = 77 meters",
        },
        {
          value: 178,
          color: "003300",
          description: "Tree Height = 78 meters",
        },
        {
          value: 179,
          color: "003300",
          description: "Tree Height = 79 meters",
        },
        {
          value: 180,
          color: "003300",
          description: "Tree Height = 80 meters",
        },
        {
          value: 181,
          color: "003300",
          description: "Tree Height = 81 meters",
        },
        {
          value: 182,
          color: "003300",
          description: "Tree Height = 82 meters",
        },
        {
          value: 183,
          color: "003300",
          description: "Tree Height = 83 meters",
        },
        {
          value: 184,
          color: "003300",
          description: "Tree Height = 84 meters",
        },
        {
          value: 185,
          color: "003300",
          description: "Tree Height = 85 meters",
        },
        {
          value: 186,
          color: "003300",
          description: "Tree Height = 86 meters",
        },
        {
          value: 187,
          color: "003300",
          description: "Tree Height = 87 meters",
        },
        {
          value: 188,
          color: "003300",
          description: "Tree Height = 88 meters",
        },
        {
          value: 189,
          color: "003300",
          description: "Tree Height = 89 meters",
        },
        {
          value: 190,
          color: "003300",
          description: "Tree Height = 90 meters",
        },
        {
          value: 191,
          color: "003300",
          description: "Tree Height = 91 meters",
        },
        {
          value: 192,
          color: "003300",
          description: "Tree Height = 92 meters",
        },
        {
          value: 193,
          color: "003300",
          description: "Tree Height = 93 meters",
        },
        {
          value: 194,
          color: "003300",
          description: "Tree Height = 94 meters",
        },
        {
          value: 195,
          color: "003300",
          description: "Tree Height = 95 meters",
        },
        {
          value: 196,
          color: "003300",
          description: "Tree Height = 96 meters",
        },
        {
          value: 197,
          color: "003300",
          description: "Tree Height = 97 meters",
        },
        {
          value: 198,
          color: "003300",
          description: "Tree Height = 98 meters",
        },
        {
          value: 199,
          color: "003300",
          description: "Tree Height >= 99 meters",
        },
        {
          value: 201,
          color: "d4b27d",
          description: "Shrub Height = 0.1 meter",
        },
        {
          value: 202,
          color: "d4ae79",
          description: "Shrub Height = 0.2 meter",
        },
        {
          value: 203,
          color: "d1a675",
          description: "Shrub Height = 0.3 meter",
        },
        {
          value: 204,
          color: "d1a171",
          description: "Shrub Height = 0.4 meter",
        },
        {
          value: 205,
          color: "cf9b6d",
          description: "Shrub Height = 0.5 meter",
        },
        {
          value: 206,
          color: "cf9569",
          description: "Shrub Height = 0.6 meter",
        },
        {
          value: 207,
          color: "cc9166",
          description: "Shrub Height = 0.7 meter",
        },
        {
          value: 208,
          color: "c98961",
          description: "Shrub Height = 0.8 meter",
        },
        {
          value: 209,
          color: "c9865f",
          description: "Shrub Height = 0.9 meter",
        },
        {
          value: 210,
          color: "c77e5a",
          description: "Shrub Height = 1 meter",
        },
        {
          value: 211,
          color: "c47956",
          description: "Shrub Height = 1.1 meters",
        },
        {
          value: 212,
          color: "c47352",
          description: "Shrub Height = 1.2 meters",
        },
        {
          value: 213,
          color: "c26e4f",
          description: "Shrub Height = 1.3 meters",
        },
        {
          value: 214,
          color: "bf694d",
          description: "Shrub Height = 1.4 meters",
        },
        {
          value: 215,
          color: "bf6449",
          description: "Shrub Height = 1.5 meters",
        },
        {
          value: 216,
          color: "bd5e46",
          description: "Shrub Height = 1.6 meters",
        },
        {
          value: 217,
          color: "ba5943",
          description: "Shrub Height = 1.7 meters",
        },
        {
          value: 218,
          color: "b8533e",
          description: "Shrub Height = 1.8 meters",
        },
        {
          value: 219,
          color: "b84f3d",
          description: "Shrub Height = 1.9 meters",
        },
        {
          value: 220,
          color: "b5483a",
          description: "Shrub Height = 2.0 meters",
        },
        {
          value: 221,
          color: "b34437",
          description: "Shrub Height = 2.1 meters",
        },
        {
          value: 222,
          color: "b03d33",
          description: "Shrub Height = 2.2 meters",
        },
        {
          value: 223,
          color: "ad3931",
          description: "Shrub Height = 2.3 meters",
        },
        {
          value: 224,
          color: "ad332f",
          description: "Shrub Height = 2.4 meters",
        },
        {
          value: 225,
          color: "ab2f2c",
          description: "Shrub Height = 2.5 meters",
        },
        {
          value: 226,
          color: "a82729",
          description: "Shrub Height = 2.6 meters",
        },
        {
          value: 227,
          color: "a62128",
          description: "Shrub Height = 2.7 meters",
        },
        {
          value: 228,
          color: "a31a26",
          description: "Shrub Height = 2.8 meters",
        },
        {
          value: 229,
          color: "a11222",
          description: "Shrub Height = 2.9 meters",
        },
        {
          value: 230,
          color: "9e0020",
          description: "Shrub Height >= 3.0 meters",
        },
        {
          value: 301,
          color: "ffcc66",
          description: "Herb Height = 0.1 meter",
        },
        {
          value: 302,
          color: "ffba59",
          description: "Herb Height = 0.2 meter",
        },
        {
          value: 303,
          color: "ffa94d",
          description: "Herb Height = 0.3 meter",
        },
        {
          value: 304,
          color: "ff9640",
          description: "Herb Height = 0.4 meter",
        },
        {
          value: 305,
          color: "ff8533",
          description: "Herb Height = 0.5 meter",
        },
        {
          value: 306,
          color: "ff7029",
          description: "Herb Height = 0.6 meter",
        },
        {
          value: 307,
          color: "ff5c1c",
          description: "Herb Height = 0.7 meter",
        },
        {
          value: 308,
          color: "ff4912",
          description: "Herb Height = 0.8 meter",
        },
        {
          value: 309,
          color: "ff3300",
          description: "Herb Height = 0.9 meter",
        },
        {
          value: 310,
          color: "ff3300",
          description: "Herb Height >= 1 meter",
        },
      ],
    },
    {
      name: "EVT",
      description: "Code that identifies the vegetation and land cover types.",
      "gee:units": units.dimensionless,
      "gee:classes": [
        {
          value: 4401,
          color: "ffcd70",
          description: "Alaska Arctic Coastal Sedge-Dwarf-Shrubland",
        },
        {
          value: 4402,
          color: "124c87",
          description: "Alaska Arctic Floodplain Forest",
        },
        {
          value: 4403,
          color: "124c87",
          description: "Alaska Arctic Large River Floodplain Forest",
        },
        {
          value: 4404,
          color: "92ede0",
          description: "Alaska Arctic Mesic Alder Shrubland",
        },
        {
          value: 4405,
          color: "ff250d",
          description: "Alaska Arctic Permafrost Plateau Dwarf-Shrub Lichen Tundra",
        },
        {
          value: 4406,
          color: "ff990a",
          description: "Alaska Arctic Tidal Flat",
        },
        {
          value: 4407,
          color: "ffd377",
          description: "Alaska Sub-boreal and Maritime Alpine Mesic Herbaceous Meadow",
        },
        {
          value: 4408,
          color: "92ede0",
          description: "Alaska Sub-boreal Mesic Subalpine Alder Shrubland",
        },
        {
          value: 4409,
          color: "b6fae3",
          description: "Alaska Sub-boreal Mountain Hemlock-White Spruce Forest",
        },
        {
          value: 4410,
          color: "b6fae3",
          description: "Alaska Sub-boreal White-Lutz Spruce Forest and Woodland",
        },
        {
          value: 4411,
          color: "852708",
          description: "Alaskan Pacific Acidic Shrub Peatland",
        },
        {
          value: 4412,
          color: "d48122",
          description: "Alaskan Pacific Alpine-Subalpine Dwarf-shrubland & Heath",
        },
        {
          value: 4413,
          color: "124c87",
          description: "Alaskan Pacific Floodplain Conifer Forest",
        },
        {
          value: 4414,
          color: "124c87",
          description: "Alaskan Pacific Maritime Alpine Floodplain Shrubland",
        },
        {
          value: 4415,
          color: "92ede0",
          description: "Alaskan Pacific Maritime Avalanche Slope Shrubland",
        },
        {
          value: 4416,
          color: "ff0000",
          description: "Alaskan Pacific Maritime Coastal Meadow and Slough-Levee",
        },
        {
          value: 4417,
          color: "ff5521",
          description: "Alaskan Pacific Maritime Mesic Herbaceous Meadow",
        },
        {
          value: 4418,
          color: "852708",
          description: "Alaskan Pacific Maritime Mountain Hemlock-Shore Pine Peatland",
        },
        {
          value: 4419,
          color: "042d75",
          description: "Alaskan Pacific Maritime Western Hemlock Forest",
        },
        {
          value: 4420,
          color: "005200",
          description: "Alaskan Pacific Mesic Western Hemlock-Yellow-cedar Forest",
        },
        {
          value: 4421,
          color: "005c00",
          description: "Alaskan Pacific Mountain Hemlock Forest and Subalpine Woodland",
        },
        {
          value: 4422,
          color: "4f241a",
          description: "Alaskan Pacific Poorly Drained Conifer Woodland",
        },
        {
          value: 4423,
          color: "007500",
          description: "Alaskan Pacific Sitka Spruce Forest and Beach Ridge",
        },
        {
          value: 4424,
          color: "ff9900",
          description: "Alaskan Pacific Wet Low Shrubland & Floodplain Wetland",
        },
        {
          value: 4425,
          color: "92ede0",
          description: "Alaskan Pacific-Aleutian Alder-Salmonberry-Copperbush Shrubland",
        },
        {
          value: 4426,
          color: "ff0000",
          description: "Alaskan Pacific-Aleutian Coastal Dune Beach and Beach Meadow",
        },
        {
          value: 4427,
          color: "ffcd70",
          description: "Alaskan Pacific-Aleutian Fen and Wet Meadow",
        },
        {
          value: 4428,
          color: "646464",
          description: "Alaskan Pacific-Aleutian Rocky Coastline and Sea Cliff",
        },
        {
          value: 4429,
          color: "4f241a",
          description: "Aleutian Ericaceous Dwarf-shrubland Heath and Fell-field",
        },
        {
          value: 4430,
          color: "ff5521",
          description: "Aleutian Mesic Herbaceous Meadow",
        },
        {
          value: 4431,
          color: "49afbc",
          description: "Aleutian Mesic-Wet Willow Shrubland",
        },
        {
          value: 4432,
          color: "646464",
          description: "Aleutian Volcanic Rock and Talus",
        },
        {
          value: 4434,
          color: "646464",
          description: "North American Arctic Bedrock and Talus",
        },
        {
          value: 4435,
          color: "c24415",
          description: "North American Arctic Dryas Tundra",
        },
        {
          value: 4436,
          color: "ff6600",
          description: "North American Arctic Dwarf-Shrub Lichen Tundra",
        },
        {
          value: 4437,
          color: "852708",
          description: "North American Arctic Dwarf-shrub-Sphagnum Peatland",
        },
        {
          value: 4438,
          color: "ff9900",
          description: "North American Arctic Freshwater Marsh",
        },
        {
          value: 4439,
          color: "ff250d",
          description: "North American Arctic Lichen Tundra",
        },
        {
          value: 4440,
          color: "ff5521",
          description: "North American Arctic Mesic Herbaceous Meadow",
        },
        {
          value: 4441,
          color: "c24415",
          description: "North American Arctic Mesic Sedge-Willow Tundra",
        },
        {
          value: 4442,
          color: "49afbc",
          description: "North American Arctic Mesic-Wet Low Willow Shrubland",
        },
        {
          value: 4443,
          color: "c24415",
          description: "North American Arctic Polygonal Ground Shrub-Tussock Tundra",
        },
        {
          value: 4444,
          color: "d48122",
          description: "North American Arctic Scrub Birch-Ericaceous Shrubland",
        },
        {
          value: 4445,
          color: "ff6600",
          description: "North American Arctic Sparse Tundra",
        },
        {
          value: 4446,
          color: "ffcd70",
          description: "North American Arctic Wet Sedge Tundra and Polygonal Ground",
        },
        {
          value: 4447,
          color: "ff0000",
          description: "North American Arctic-Subarctic Coastal Dune & Beach Meadow",
        },
        {
          value: 4448,
          color: "ff491c",
          description: "North American Arctic-Subarctic Shrub-Tussock Tundra",
        },
        {
          value: 4449,
          color: "ff990a",
          description: "North American Arctic-Subarctic Tidal Salt and Brackish Marsh",
        },
        {
          value: 4450,
          color: "ff491c",
          description: "North American Arctic-Subarctic Tussock Tundra",
        },
        {
          value: 4453,
          color: "d48122",
          description: "Western North American Boreal Alpine Dwarf-shrubland",
        },
        {
          value: 4454,
          color: "ffd377",
          description: "Western North American Boreal Alpine Mesic Herbaceous Meadow",
        },
        {
          value: 4455,
          color: "646464",
          description: "Western North American Boreal Montane-Alpine Talus and Bedrock",
        },
        {
          value: 4456,
          color: "4f241a",
          description: "Western North American Boreal Black Spruce Bog and Dwarf-Tree Peatland",
        },
        {
          value: 4457,
          color: "b6faff",
          description: "Western North American Boreal Black Spruce-Tamarack Fen",
        },
        {
          value: 4458,
          color: "646464",
          description: "Western North American Boreal Cliff Scree and Rock",
        },
        {
          value: 4459,
          color: "c0ff8a",
          description: "Western North American Boreal Dry Aspen-Steppe Bluff",
        },
        {
          value: 4460,
          color: "ff7230",
          description: "Western North American Boreal Dry Grassland",
        },
        {
          value: 4461,
          color: "ff9900",
          description: "Western North American Boreal Freshwater Emergent Marsh",
        },
        {
          value: 4462,
          color: "124c87",
          description: "Western North American Boreal Lowland Large River Floodplain Conifer Forest",
        },
        {
          value: 4463,
          color: "005c00",
          description: "Western North American Boreal Mesic Birch-Aspen Forest",
        },
        {
          value: 4464,
          color: "ff1908",
          description: "Western North American Boreal Mesic Bluejoint-Forb Meadow",
        },
        {
          value: 4465,
          color: "49afbc",
          description: "Western North American Boreal Mesic Scrub Birch-Willow Shrubland",
        },
        {
          value: 4466,
          color: "b6fae3",
          description: "Western North American Boreal Mesic White Spruce Forest",
        },
        {
          value: 4467,
          color: "b6fae3",
          description: "Western North American Boreal Mesic-Wet Black Spruce Forest and Woodland",
        },
        {
          value: 4468,
          color: "124c87",
          description: "Western North American Boreal Montane Floodplain Conifer Forest",
        },
        {
          value: 4469,
          color: "124c87",
          description: "Western North American Boreal Riparian Stringer Conifer Forest",
        },
        {
          value: 4470,
          color: "ff9900",
          description: "Western North American Boreal Shrub Floodplain",
        },
        {
          value: 4471,
          color: "a64c11",
          description: "Western North American Boreal Shrub Swamp",
        },
        {
          value: 4472,
          color: "963a0c",
          description: "Western North American Boreal Shrub-Sedge Bog & Acidic Fen",
        },
        {
          value: 4473,
          color: "ffcd70",
          description: "Western North American Boreal Shrub-Sedge Rich and Alkaline Fen",
        },
        {
          value: 4474,
          color: "b6fae3",
          description: "Western North American Boreal Spruce-Lichen Woodland",
        },
        {
          value: 4475,
          color: "b6fae3",
          description: "Western North American Boreal Treeline White Spruce Woodland",
        },
        {
          value: 4476,
          color: "b6faff",
          description: "Western North American Boreal Wet Black Spruce-Tussock Woodland",
        },
        {
          value: 4477,
          color: "ffcd70",
          description: "Western North American Boreal Wet Meadow",
        },
        {
          value: 4478,
          color: "124c87",
          description: "Western North American Boreal Treeline Hardwood-White Spruce Woodland",
        },
        {
          value: 4479,
          color: "9fff80",
          description: "Western North American Boreal Treeline White Spruce-Hardwood Woodland",
        },
        {
          value: 4480,
          color: "9fff80",
          description: "Western North American Boreal Mesic Hardwood-White Spruce Forest",
        },
        {
          value: 4481,
          color: "9fff80",
          description: "Western North American Boreal Mesic White Spruce-Hardwood Forest",
        },
        {
          value: 4482,
          color: "9fff80",
          description: "Alaska Sub-boreal Hardwood-White-Lutz Spruce Forest and Woodland",
        },
        {
          value: 4483,
          color: "9fff80",
          description: "Alaska Sub-boreal White-Lutz Spruce-Hardwood Forest and Woodland",
        },
        {
          value: 4484,
          color: "b6fae3",
          description: "Western North American Boreal Mesic-Wet Black Spruce-Hardwood Forest and Woodland",
        },
        {
          value: 4485,
          color: "124c87",
          description: "Alaskan Pacific Floodplain Deciduous Forest",
        },
        {
          value: 4486,
          color: "124c87",
          description: "Alaskan Pacific Floodplain Mixed Forest",
        },
        {
          value: 4487,
          color: "124c87",
          description: "Western North American Boreal Lowland Large River Floodplain Deciduous Forest",
        },
        {
          value: 4488,
          color: "124c87",
          description: "Western North American Boreal Lowland Large River Floodplain Mixed Forest",
        },
        {
          value: 4489,
          color: "124c87",
          description: "Western North American Boreal Montane Floodplain Deciduous Forest",
        },
        {
          value: 4490,
          color: "124c87",
          description: "Western North American Boreal Montane Floodplain Mixed Forest",
        },
        {
          value: 4491,
          color: "124c87",
          description: "Western North American Boreal Riparian Stringer Deciduous Forest",
        },
        {
          value: 4492,
          color: "124c87",
          description: "Western North American Boreal Riparian Stringer Mixed Forest",
        },
        {
          value: 4601,
          color: "646464",
          description: "Micronesian Dry Cliff",
        },
        {
          value: 4602,
          color: "646464",
          description: "Micronesian Dry-Site Lava Flow",
        },
        {
          value: 4603,
          color: "646464",
          description: "Micronesian Dry Coastal Strand",
        },
        {
          value: 4604,
          color: "00bd00",
          description: "Micronesian Lowland Rain Forest",
        },
        {
          value: 4605,
          color: "3fff2e",
          description: "Micronesian Lowland Limestone Forest",
        },
        {
          value: 4606,
          color: "00bd00",
          description: "Central and Southern Polynesian Montane Rainforest",
        },
        {
          value: 4609,
          color: "00ed00",
          description: "Micronesian Ravine and Riparian Forest",
        },
        {
          value: 4610,
          color: "ff9900",
          description: "Polynesian Freshwater Marsh",
        },
        {
          value: 4611,
          color: "43a2b5",
          description: "Micronesian Swamp Forest",
        },
        {
          value: 4612,
          color: "00ed00",
          description: "Western Pacific Mangrove",
        },
        {
          value: 4614,
          color: "00bd00",
          description: "Central and Southern Polynesian Coastal Wooded Strand",
        },
        {
          value: 4615,
          color: "646464",
          description: "Central and Southern Polynesian Cliff",
        },
        {
          value: 4616,
          color: "646464",
          description: "Central and Southern Polynesian Lava Flow",
        },
        {
          value: 4617,
          color: "646464",
          description: "Central and Southern Polynesian Dry Coastal Strand",
        },
        {
          value: 4618,
          color: "e0fcc0",
          description: "Central and Southern Polynesian Lowland Rain Forest",
        },
        {
          value: 4620,
          color: "00cc00",
          description: "Central and Southern Polynesian Cloud Forest",
        },
        {
          value: 4621,
          color: "2aff1f",
          description: "Central and Southern Polynesian Littoral Forest",
        },
        {
          value: 4622,
          color: "00ed00",
          description: "Central and Southern Polynesian Ravine and Riparian Forest",
        },
        {
          value: 4623,
          color: "43a2b5",
          description: "Central and Southern Polynesian Swamp Forest",
        },
        {
          value: 4624,
          color: "00ed00",
          description: "Micronesian Ravine and Riparian Shrubland",
        },
        {
          value: 4627,
          color: "2aff1f",
          description: "Central and Southern Polynesian Dry Coastal Strand Shrubland",
        },
        {
          value: 4628,
          color: "2aff1f",
          description: "Central and Southern Polynesian Dry Coastal Strand Herbaceous",
        },
        {
          value: 4629,
          color: "2aff1f",
          description: "Micronesian Dry Coastal Strand Shrubland",
        },
        {
          value: 4630,
          color: "2aff1f",
          description: "Micronesian Dry Coastal Strand Herbaceous",
        },
        {
          value: 4902,
          color: "124c87",
          description: "Alaska Arctic Floodplain Shrubland",
        },
        {
          value: 4903,
          color: "124c87",
          description: "Alaska Arctic Large River Floodplain Shrubland",
        },
        {
          value: 4904,
          color: "124c87",
          description: "Alaska Arctic Floodplain Herbaceous",
        },
        {
          value: 4905,
          color: "124c87",
          description: "Alaska Arctic Large River Floodplain Herbaceous",
        },
        {
          value: 4911,
          color: "852708",
          description: "Alaskan Pacific Acidic Sedge Peatland",
        },
        {
          value: 4913,
          color: "124c87",
          description: "Alaskan Pacific Floodplain Shrubland (Conifer Forest)",
        },
        {
          value: 4914,
          color: "ff9900",
          description: "Alaskan Pacific Maritime Alpine Floodplain Herbaceous",
        },
        {
          value: 4937,
          color: "852708",
          description: "North American Arctic Wet Sedge-Sphagnum Peatland",
        },
        {
          value: 4943,
          color: "ff491c",
          description: "North American Arctic Polygonal Ground Tussock Tundra",
        },
        {
          value: 4947,
          color: "646464",
          description: "North American Arctic-Subarctic Coastal Dune & Beach",
        },
        {
          value: 4962,
          color: "124c87",
          description: "Western North American Boreal Lowland Large River Floodplain Shrubland (Conifer Forest)",
        },
        {
          value: 4963,
          color: "646464",
          description: "Western North American Boreal Lowland Large River Floodplain Sparse Vegetation",
        },
        {
          value: 4964,
          color: "646464",
          description: "Western North American Boreal Montane Floodplain Sparse Vegetation",
        },
        {
          value: 4965,
          color: "646464",
          description: "Alaskan Pacific Floodplain Sparse Vegetation",
        },
        {
          value: 4966,
          color: "646464",
          description: "Alaska Arctic Large River Floodplain Sparse Vegetation",
        },
        {
          value: 4968,
          color: "124c87",
          description: "Western North American Boreal Montane Floodplain Shrubland (Conifer Forest)",
        },
        {
          value: 4969,
          color: "124c87",
          description: "Western North American Boreal Riparian Stringer Shrubland (Conifer Forest)",
        },
        {
          value: 4970,
          color: "ff9900",
          description: "Western North American Boreal Herbaceous Floodplain",
        },
        {
          value: 4973,
          color: "ffcd70",
          description: "Western North American Boreal Herbaceous Rich and Alkaline Fen",
        },
        {
          value: 4985,
          color: "124c87",
          description: "Alaskan Pacific Floodplain Shrubland (Deciduous Forest)",
        },
        {
          value: 4986,
          color: "124c87",
          description: "Alaskan Pacific Floodplain Shrubland (Mixed Forest)",
        },
        {
          value: 4987,
          color: "124c87",
          description: "Western North American Boreal Lowland Large River Floodplain Shrubland (Deciduous Forest)",
        },
        {
          value: 4988,
          color: "124c87",
          description: "Western North American Boreal Lowland Large River Floodplain Shrubland (Mixed Forest)",
        },
        {
          value: 4989,
          color: "124c87",
          description: "Western North American Boreal Montane Floodplain Shrubland (Deciduous Forest)",
        },
        {
          value: 4990,
          color: "124c87",
          description: "Western North American Boreal Montane Floodplain Shrubland (Mixed Forest)",
        },
        {
          value: 4991,
          color: "124c87",
          description: "Western North American Boreal Riparian Stringer Shrubland (Deciduous Forest)",
        },
        {
          value: 4992,
          color: "124c87",
          description: "Western North American Boreal Riparian Stringer Shrubland (Mixed Forest)",
        },
        {
          value: 7008,
          color: "cbffab",
          description: "North Pacific Oak Woodland",
        },
        {
          value: 7009,
          color: "c0ff8a",
          description: "Northwestern Great Plains Aspen Forest and Parkland",
        },
        {
          value: 7010,
          color: "b4ff94",
          description: "Northern Rocky Mountain Western Larch Savanna",
        },
        {
          value: 7011,
          color: "c0ff8a",
          description: "Rocky Mountain Aspen Forest and Woodland",
        },
        {
          value: 7012,
          color: "abff8a",
          description: "Rocky Mountain Bigtooth Maple Ravine Woodland",
        },
        {
          value: 7013,
          color: "06357a",
          description: "Western Great Plains Dry Bur Oak Forest and Woodland",
        },
        {
          value: 7014,
          color: "91ff73",
          description: "Central and Southern California Mixed Evergreen Woodland",
        },
        {
          value: 7015,
          color: "87ff69",
          description: "California Coastal Redwood Forest",
        },
        {
          value: 7016,
          color: "79ff5e",
          description: "Colorado Plateau Pinyon-Juniper Woodland",
        },
        {
          value: 7017,
          color: "6cff52",
          description: "Columbia Plateau Western Juniper Woodland and Savanna",
        },
        {
          value: 7018,
          color: "60ff47",
          description: "East Cascades Mesic Montane Mixed-Conifer Forest and Woodland",
        },
        {
          value: 7019,
          color: "4eff3b",
          description: "Great Basin Pinyon-Juniper Woodland",
        },
        {
          value: 7020,
          color: "3fff2e",
          description: "Inter-Mountain Basins Subalpine Limber-Bristlecone Pine Woodland",
        },
        {
          value: 7021,
          color: "2aff1f",
          description: "Klamath-Siskiyou Lower Montane Serpentine Mixed Conifer Woodland",
        },
        {
          value: 7022,
          color: "e0fcc0",
          description: "Klamath-Siskiyou Upper Montane Serpentine Mixed Conifer Woodland",
        },
        {
          value: 7023,
          color: "00ed00",
          description: "Madrean Encinal",
        },
        {
          value: 7024,
          color: "00ed00",
          description: "Madrean Lower Montane Pine-Oak Forest and Woodland",
        },
        {
          value: 7025,
          color: "79ff5e",
          description: "Madrean Pinyon-Juniper Woodland",
        },
        {
          value: 7026,
          color: "00ed00",
          description: "Madrean Upper Montane Conifer-Oak Forest and Woodland",
        },
        {
          value: 7027,
          color: "00de00",
          description: "Mediterranean California Dry-Mesic Mixed Conifer Forest and Woodland",
        },
        {
          value: 7028,
          color: "00cc00",
          description: "Mediterranean California Mesic Mixed Conifer Forest and Woodland",
        },
        {
          value: 7029,
          color: "00bd00",
          description: "Mediterranean California Mixed Oak Woodland",
        },
        {
          value: 7030,
          color: "00bd00",
          description: "Mediterranean California Lower Montane Conifer Forest and Woodland",
        },
        {
          value: 7031,
          color: "00ad00",
          description: "California Montane Jeffrey Pine-(Ponderosa Pine) Woodland",
        },
        {
          value: 7032,
          color: "009e00",
          description: "Mediterranean California Red Fir Forest",
        },
        {
          value: 7033,
          color: "009100",
          description: "Mediterranean California Subalpine Woodland",
        },
        {
          value: 7034,
          color: "e0fcc0",
          description: "Mediterranean California Mesic Serpentine Woodland",
        },
        {
          value: 7035,
          color: "008200",
          description: "North Pacific Dry Douglas-fir-(Madrone) Forest and Woodland",
        },
        {
          value: 7036,
          color: "007500",
          description: "North Pacific Seasonal Sitka Spruce Forest",
        },
        {
          value: 7037,
          color: "006900",
          description: "North Pacific Maritime Dry-Mesic Douglas-fir-Western Hemlock Forest",
        },
        {
          value: 7038,
          color: "005c00",
          description: "North Pacific Maritime Mesic Subalpine Parkland",
        },
        {
          value: 7039,
          color: "006900",
          description: "North Pacific Maritime Mesic-Wet Douglas-fir-Western Hemlock Forest",
        },
        {
          value: 7041,
          color: "005c00",
          description: "North Pacific Mountain Hemlock Forest",
        },
        {
          value: 7042,
          color: "004700",
          description: "North Pacific Mesic Western Hemlock-Silver Fir Forest",
        },
        {
          value: 7043,
          color: "003d00",
          description: "Mediterranean California Mixed Evergreen Forest",
        },
        {
          value: 7044,
          color: "005c00",
          description: "Northern California Mesic Subalpine Woodland",
        },
        {
          value: 7045,
          color: "003300",
          description: "Northern Rocky Mountain Dry-Mesic Montane Mixed Conifer Forest",
        },
        {
          value: 7046,
          color: "bfffe9",
          description: "Northern Rocky Mountain Subalpine Woodland and Parkland",
        },
        {
          value: 7047,
          color: "60ff47",
          description: "Northern Rocky Mountain Mesic Montane Mixed Conifer Forest",
        },
        {
          value: 7048,
          color: "b6fae3",
          description: "Northwestern Great Plains Highland White Spruce Woodland",
        },
        {
          value: 7049,
          color: "aef5e0",
          description: "Rocky Mountain Foothill Limber Pine-Juniper Woodland",
        },
        {
          value: 7050,
          color: "a3f0db",
          description: "Rocky Mountain Lodgepole Pine Forest",
        },
        {
          value: 7051,
          color: "003300",
          description: "Southern Rocky Mountain Dry-Mesic Montane Mixed Conifer Forest and Woodland",
        },
        {
          value: 7052,
          color: "00cc00",
          description: "Southern Rocky Mountain Mesic Montane Mixed Conifer Forest and Woodland",
        },
        {
          value: 7053,
          color: "d6ffb5",
          description: "Northern Rocky Mountain Ponderosa Pine Woodland and Savanna",
        },
        {
          value: 7054,
          color: "d6ffb5",
          description: "Southern Rocky Mountain Ponderosa Pine Woodland",
        },
        {
          value: 7055,
          color: "ecfccc",
          description: "Rocky Mountain Subalpine Dry-Mesic Spruce-Fir Forest and Woodland",
        },
        {
          value: 7056,
          color: "ecfccc",
          description: "Rocky Mountain Subalpine Mesic-Wet Spruce-Fir Forest and Woodland",
        },
        {
          value: 7057,
          color: "3fff2e",
          description: "Rocky Mountain Subalpine-Montane Limber-Bristlecone Pine Woodland",
        },
        {
          value: 7058,
          color: "a3f0db",
          description: "Sierra Nevada Subalpine Lodgepole Pine Forest and Woodland",
        },
        {
          value: 7059,
          color: "79ff5e",
          description: "Southern Rocky Mountain Pinyon-Juniper Woodland",
        },
        {
          value: 7060,
          color: "d6ffb5",
          description: "East Cascades Ponderosa Pine Forest and Woodland",
        },
        {
          value: 7061,
          color: "c0ff8a",
          description: "Inter-Mountain Basins Aspen-Mixed Conifer Forest and Woodland",
        },
        {
          value: 7062,
          color: "9bebd8",
          description: "Inter-Mountain Basins Curl-leaf Mountain Mahogany Woodland",
        },
        {
          value: 7063,
          color: "92e8d7",
          description: "North Pacific Broadleaf Landslide Forest",
        },
        {
          value: 7064,
          color: "ccb687",
          description: "Colorado Plateau Mixed Low Sagebrush Shrubland",
        },
        {
          value: 7065,
          color: "c7b081",
          description: "Columbia Plateau Scabland Shrubland",
        },
        {
          value: 7066,
          color: "c2aa7e",
          description: "Inter-Mountain Basins Mat Saltbush Shrubland",
        },
        {
          value: 7067,
          color: "ffd377",
          description: "Mediterranean California Alpine Fell-Field",
        },
        {
          value: 7068,
          color: "b59c72",
          description: "North Pacific Dry and Mesic Alpine Dwarf-Shrubland",
        },
        {
          value: 7069,
          color: "b59c72",
          description: "North Pacific Dry and Mesic Alpine Fell-field or Meadow",
        },
        {
          value: 7070,
          color: "ab916a",
          description: "Rocky Mountain Alpine Dwarf-Shrubland",
        },
        {
          value: 7071,
          color: "ffd377",
          description: "Sierra Nevada Alpine Dwarf-Shrubland",
        },
        {
          value: 7072,
          color: "ccb687",
          description: "Wyoming Basins Dwarf Sagebrush Shrubland and Steppe",
        },
        {
          value: 7073,
          color: "a68b6b",
          description: "Baja Semi-Desert Coastal Succulent Scrub",
        },
        {
          value: 7074,
          color: "a18660",
          description: "Chihuahuan Creosotebush Desert Scrub",
        },
        {
          value: 7075,
          color: "9c805c",
          description: "Chihuahuan Mixed Salt Desert Scrub",
        },
        {
          value: 7076,
          color: "967b59",
          description: "Chihuahuan Stabilized Coppice Dune and Sand Flat Scrub",
        },
        {
          value: 7077,
          color: "917554",
          description: "Chihuahuan Succulent Desert Scrub",
        },
        {
          value: 7078,
          color: "8c7050",
          description: "Colorado Plateau Blackbrush-Mormon-tea Shrubland",
        },
        {
          value: 7079,
          color: "876a4c",
          description: "Great Basin Xeric Mixed Sagebrush Shrubland",
        },
        {
          value: 7080,
          color: "826548",
          description: "Inter-Mountain Basins Big Sagebrush Shrubland",
        },
        {
          value: 7081,
          color: "9c805c",
          description: "Inter-Mountain Basins Mixed Salt Desert Scrub",
        },
        {
          value: 7082,
          color: "8c7050",
          description: "Mojave Mid-Elevation Mixed Desert Scrub",
        },
        {
          value: 7083,
          color: "806145",
          description: "North Pacific Avalanche Chute Shrubland",
        },
        {
          value: 7084,
          color: "806145",
          description: "North Pacific Montane Shrubland",
        },
        {
          value: 7085,
          color: "7a5d41",
          description: "Northwestern Great Plains Shrubland",
        },
        {
          value: 7086,
          color: "75573d",
          description: "Rocky Mountain Lower Montane-Foothill Shrubland",
        },
        {
          value: 7087,
          color: "a18660",
          description: "Sonora-Mojave Creosotebush-White Bursage Desert Scrub",
        },
        {
          value: 7088,
          color: "9c805c",
          description: "Sonora-Mojave Mixed Salt Desert Scrub",
        },
        {
          value: 7090,
          color: "a18660",
          description: "Sonoran Granite Outcrop Desert Scrub",
        },
        {
          value: 7091,
          color: "a18660",
          description: "Sonoran Mid-Elevation Desert Scrub",
        },
        {
          value: 7092,
          color: "a68b6b",
          description: "Southern California Coastal Scrub",
        },
        {
          value: 7093,
          color: "705239",
          description: "Southern Colorado Plateau Sand Shrubland",
        },
        {
          value: 7094,
          color: "705239",
          description: "Western Great Plains Sandhill Steppe",
        },
        {
          value: 7096,
          color: "6b4d36",
          description: "California Maritime Chaparral",
        },
        {
          value: 7097,
          color: "3b1e13",
          description: "California Mesic Chaparral",
        },
        {
          value: 7098,
          color: "422518",
          description: "California Montane Woodland and Chaparral",
        },
        {
          value: 7099,
          color: "422518",
          description: "California Xeric Serpentine Chaparral",
        },
        {
          value: 7100,
          color: "4a2c1d",
          description: "Chihuahuan Mixed Desert and Thornscrub",
        },
        {
          value: 7101,
          color: "917554",
          description: "Madrean Oriental Chaparral",
        },
        {
          value: 7102,
          color: "79ff5e",
          description: "Colorado Plateau Pinyon-Juniper Shrubland",
        },
        {
          value: 7103,
          color: "593b28",
          description: "Great Basin Semi-Desert Chaparral",
        },
        {
          value: 7104,
          color: "593b28",
          description: "Mogollon Chaparral",
        },
        {
          value: 7105,
          color: "63452f",
          description: "Northern and Central California Dry-Mesic Chaparral",
        },
        {
          value: 7106,
          color: "75573d",
          description: "Northern Rocky Mountain Montane-Foothill Deciduous Shrubland",
        },
        {
          value: 7107,
          color: "f5af36",
          description: "Rocky Mountain Gambel Oak-Mixed Montane Shrubland",
        },
        {
          value: 7108,
          color: "593b28",
          description: "Sonora-Mojave Semi-Desert Chaparral",
        },
        {
          value: 7109,
          color: "f2a830",
          description: "Sonoran Paloverde-Mixed Cacti Desert Scrub",
        },
        {
          value: 7110,
          color: "63452f",
          description: "Southern California Dry-Mesic Chaparral",
        },
        {
          value: 7111,
          color: "967b59",
          description: "Western Great Plains Mesquite Shrubland",
        },
        {
          value: 7112,
          color: "8ae3d4",
          description: "California Central Valley Mixed Oak Savanna",
        },
        {
          value: 7113,
          color: "83de6e",
          description: "California Coastal Live Oak Woodland and Savanna",
        },
        {
          value: 7114,
          color: "79d9cf",
          description: "California Lower Montane Foothill Pine Woodland and Savanna",
        },
        {
          value: 7115,
          color: "4eff3b",
          description: "Inter-Mountain Basins Juniper Savanna",
        },
        {
          value: 7116,
          color: "917554",
          description: "Madrean Juniper Savanna",
        },
        {
          value: 7117,
          color: "d6ffb5",
          description: "Southern Rocky Mountain Ponderosa Pine Savanna",
        },
        {
          value: 7118,
          color: "83de6e",
          description: "Southern California Oak Woodland and Savanna",
        },
        {
          value: 7119,
          color: "79ff5e",
          description: "Southern Rocky Mountain Juniper Woodland and Savanna",
        },
        {
          value: 7120,
          color: "cbffab",
          description: "Willamette Valley Upland Prairie",
        },
        {
          value: 7121,
          color: "ffcc33",
          description: "Apacherian-Chihuahuan Semi-Desert Shrub-Steppe",
        },
        {
          value: 7122,
          color: "ffcc33",
          description: "Chihuahuan Gypsophilous Grassland and Steppe",
        },
        {
          value: 7123,
          color: "c7b081",
          description: "Columbia Plateau Steppe and Grassland",
        },
        {
          value: 7124,
          color: "876a4c",
          description: "Columbia Plateau Low Sagebrush Steppe",
        },
        {
          value: 7125,
          color: "e69729",
          description: "Inter-Mountain Basins Big Sagebrush Steppe",
        },
        {
          value: 7126,
          color: "db8c25",
          description: "Inter-Mountain Basins Montane Sagebrush Steppe",
        },
        {
          value: 7127,
          color: "826548",
          description: "Inter-Mountain Basins Semi-Desert Shrub-Steppe",
        },
        {
          value: 7128,
          color: "c9741e",
          description: "Northern California Coastal Scrub",
        },
        {
          value: 7129,
          color: "ffeb99",
          description: "California Central Valley and Southern Coastal Grassland",
        },
        {
          value: 7130,
          color: "ffeb99",
          description: "California Mesic Serpentine Grassland",
        },
        {
          value: 7131,
          color: "fff894",
          description: "California Northern Coastal Grassland",
        },
        {
          value: 7132,
          color: "fff18c",
          description: "Central Mixedgrass Prairie Grassland",
        },
        {
          value: 7133,
          color: "ffe987",
          description: "Chihuahuan Sandy Plains Semi-Desert Grassland",
        },
        {
          value: 7134,
          color: "ffe282",
          description: "Columbia Basin Foothill and Canyon Dry Grassland",
        },
        {
          value: 7135,
          color: "ffc87d",
          description: "Inter-Mountain Basins Semi-Desert Grassland",
        },
        {
          value: 7136,
          color: "ffd377",
          description: "Mediterranean California Alpine Dry Tundra",
        },
        {
          value: 7137,
          color: "ffcd70",
          description: "Mediterranean California Subalpine Meadow",
        },
        {
          value: 7138,
          color: "ffc66b",
          description: "North Pacific Montane Grassland",
        },
        {
          value: 7139,
          color: "ffbf66",
          description: "Northern Rocky Mountain Lower Montane-Foothill-Valley Grassland",
        },
        {
          value: 7140,
          color: "ffb861",
          description: "Northern Rocky Mountain Subalpine-Upper Montane Grassland",
        },
        {
          value: 7141,
          color: "ffb05c",
          description: "Northwestern Great Plains Mixedgrass Prairie",
        },
        {
          value: 7142,
          color: "ffc66b",
          description: "Columbia Basin Palouse Prairie",
        },
        {
          value: 7143,
          color: "ab916a",
          description: "Rocky Mountain Alpine Fell-Field",
        },
        {
          value: 7144,
          color: "ab916a",
          description: "Rocky Mountain Alpine Turf",
        },
        {
          value: 7145,
          color: "ffa352",
          description: "Rocky Mountain Subalpine-Montane Mesic Meadow",
        },
        {
          value: 7146,
          color: "ab916a",
          description: "Southern Rocky Mountain Montane-Subalpine Grassland",
        },
        {
          value: 7147,
          color: "ff9d4d",
          description: "Western Great Plains Foothill and Piedmont Grassland",
        },
        {
          value: 7148,
          color: "ff9447",
          description: "Western Great Plains Sand Prairie",
        },
        {
          value: 7149,
          color: "ff8e42",
          description: "Western Great Plains Shortgrass Prairie",
        },
        {
          value: 7150,
          color: "ff8940",
          description: "Western Great Plains Tallgrass Prairie",
        },
        {
          value: 7151,
          color: "51b48d",
          description: "California Central Valley Riparian Woodland",
        },
        {
          value: 7152,
          color: "51b48d",
          description: "California Central Valley Riparian Shrubland",
        },
        {
          value: 7153,
          color: "c2aa7e",
          description: "Inter-Mountain Basins Greasewood Flat",
        },
        {
          value: 7156,
          color: "43a2b5",
          description: "North Pacific Lowland Riparian Forest",
        },
        {
          value: 7157,
          color: "43a2b5",
          description: "North Pacific Lowland Riparian Shrubland",
        },
        {
          value: 7158,
          color: "43a2b5",
          description: "North Pacific Montane Riparian Woodland",
        },
        {
          value: 7159,
          color: "43a2b5",
          description: "North Pacific Montane Riparian Shrubland",
        },
        {
          value: 7161,
          color: "042d75",
          description: "Northern Rocky Mountain Conifer Swamp",
        },
        {
          value: 7165,
          color: "3792ad",
          description: "Northern Rocky Mountain Foothill Conifer Wooded Steppe",
        },
        {
          value: 7166,
          color: "003300",
          description: "Middle Rocky Mountain Montane Douglas-fir Forest and Woodland",
        },
        {
          value: 7167,
          color: "a3f0db",
          description: "Rocky Mountain Poor-Site Lodgepole Pine Forest",
        },
        {
          value: 7168,
          color: "806145",
          description: "Northern Rocky Mountain Avalanche Chute Shrubland",
        },
        {
          value: 7169,
          color: "806145",
          description: "Northern Rocky Mountain Subalpine Deciduous Shrubland",
        },
        {
          value: 7170,
          color: "e0fcc0",
          description: "Klamath-Siskiyou Xeromorphic Serpentine Savanna",
        },
        {
          value: 7171,
          color: "ff7230",
          description: "North Pacific Alpine and Subalpine Dry Grassland",
        },
        {
          value: 7172,
          color: "00cc00",
          description: "Sierran-Intermontane Desert Western White Pine-White Fir Woodland",
        },
        {
          value: 7173,
          color: "a3f0db",
          description: "North Pacific Wooded Volcanic Flowage",
        },
        {
          value: 7174,
          color: "004700",
          description: "North Pacific Dry-Mesic Silver Fir-Western Hemlock-Douglas-fir Forest",
        },
        {
          value: 7177,
          color: "e0fcc0",
          description: "California Coastal Closed-Cone Conifer Forest and Woodland",
        },
        {
          value: 7178,
          color: "042d75",
          description: "North Pacific Hypermaritime Western Red-cedar-Western Hemlock Forest",
        },
        {
          value: 7179,
          color: "d6ffb5",
          description: "Northwestern Great Plains-Black Hills Ponderosa Pine Woodland and Savanna",
        },
        {
          value: 7191,
          color: "ff4419",
          description: "Recently Logged-Herb and Grass Cover",
        },
        {
          value: 7192,
          color: "ff4419",
          description: "Recently Logged-Shrub Cover",
        },
        {
          value: 7193,
          color: "ff4419",
          description: "Recently Logged-Tree Cover",
        },
        {
          value: 7195,
          color: "ff3b14",
          description: "Recently Burned-Herb and Grass Cover",
        },
        {
          value: 7196,
          color: "ff3b14",
          description: "Recently Burned-Shrub Cover",
        },
        {
          value: 7197,
          color: "ff3b14",
          description: "Recently Burned-Tree Cover",
        },
        {
          value: 7198,
          color: "ff4419",
          description: "Recently Disturbed Other-Herb and Grass Cover",
        },
        {
          value: 7199,
          color: "ff4419",
          description: "Recently Disturbed Other-Shrub Cover",
        },
        {
          value: 7200,
          color: "ff4419",
          description: "Recently Disturbed Other-Tree Cover",
        },
        {
          value: 7207,
          color: "fff18c",
          description: "Central Mixedgrass Prairie Shrubland",
        },
        {
          value: 7234,
          color: "e0fcc0",
          description: "Mediterranean California Mesic Serpentine Chaparral",
        },
        {
          value: 7238,
          color: "aef5e0",
          description: "Laurentian-Acadian Northern Oak Forest",
        },
        {
          value: 7239,
          color: "aef5e0",
          description: "Laurentian-Acadian Northern Pine-(Oak) Forest",
        },
        {
          value: 7240,
          color: "005c00",
          description: "Laurentian-Acadian Hardwood Forest",
        },
        {
          value: 7241,
          color: "005c00",
          description: "Laurentian-Acadian Pine-Hemlock-Hardwood Forest",
        },
        {
          value: 7242,
          color: "aef5e0",
          description: "Laurentian Oak Barrens",
        },
        {
          value: 7243,
          color: "aef5e0",
          description: "Laurentian Pine-Oak Barrens",
        },
        {
          value: 7247,
          color: "523422",
          description: "Southern Appalachian Grass Bald",
        },
        {
          value: 7248,
          color: "ff6229",
          description: "Northern Atlantic Coastal Plain Dune and Swale Grassland",
        },
        {
          value: 7249,
          color: "5bc3c7",
          description: "Atlantic Coastal Plain Peatland Pocosin and Canebrake Shrubland",
        },
        {
          value: 7250,
          color: "9bebd8",
          description: "Inter-Mountain Basins Curl-leaf Mountain Mahogany Shrubland",
        },
        {
          value: 7256,
          color: "ffcc33",
          description: "Apacherian-Chihuahuan Semi-Desert Grassland",
        },
        {
          value: 7260,
          color: "00bd00",
          description: "Mediterranean California Lower Montane Black Oak Forest and Woodland",
        },
        {
          value: 7261,
          color: "00bd00",
          description: "Mediterranean California Lower Montane Black Oak-Conifer Forest and Woodland",
        },
        {
          value: 7262,
          color: "d6ffb5",
          description: "East Cascades Oak Forest and Woodland",
        },
        {
          value: 7263,
          color: "d6ffb5",
          description: "East Cascades Oak-Ponderosa Pine Forest and Woodland",
        },
        {
          value: 7264,
          color: "79d9cf",
          description: "California Lower Montane Blue Oak Woodland and Savanna",
        },
        {
          value: 7265,
          color: "79d9cf",
          description: "California Lower Montane Blue Oak-Foothill Pine Woodland and Savanna",
        },
        {
          value: 7268,
          color: "c0ff8a",
          description: "Eastern Great Plains Tallgrass Aspen Shrubland",
        },
        {
          value: 7270,
          color: "e0fcc0",
          description: "Klamath-Siskiyou Xeromorphic Serpentine Chaparral",
        },
        {
          value: 7272,
          color: "3289a8",
          description: "Eastern Boreal Floodplain Shrubland",
        },
        {
          value: 7286,
          color: "55bbc2",
          description: "Paleozoic Plateau Bluff and Talus Herbaceous",
        },
        {
          value: 7288,
          color: "523422",
          description: "Acadian-Appalachian Alpine Tundra Meadow",
        },
        {
          value: 7289,
          color: "523422",
          description: "Acadian-Appalachian Subalpine Heath-Krummholz",
        },
        {
          value: 7290,
          color: "2c7fa3",
          description: "North-Central Oak Barrens Herbaceous",
        },
        {
          value: 7291,
          color: "ff9900",
          description: "Central Interior Highlands Calcareous Glade and Barrens Herbaceous",
        },
        {
          value: 7292,
          color: "0000ff",
          description: "Open Water",
        },
        {
          value: 7295,
          color: "e6e8fa",
          description: "Quarries-Strip Mines-Gravel Pits-Well and Wind Pads",
        },
        {
          value: 7296,
          color: "ff7a8f",
          description: "Developed-Low Intensity",
        },
        {
          value: 7297,
          color: "fd2c4f",
          description: "Developed-Medium Intensity",
        },
        {
          value: 7298,
          color: "ad001c",
          description: "Developed-High Intensity",
        },
        {
          value: 7299,
          color: "010101",
          description: "Developed-Roads",
        },
        {
          value: 7300,
          color: "343434",
          description: "Developed-Open Space",
        },
        {
          value: 7301,
          color: "c0ff8a",
          description: "Laurentian-Acadian Sub-boreal Aspen-Birch Forest",
        },
        {
          value: 7302,
          color: "abff8a",
          description: "Laurentian-Acadian Northern Hardwoods Forest",
        },
        {
          value: 7303,
          color: "55bbc2",
          description: "Northeastern Interior Dry-Mesic Oak Forest",
        },
        {
          value: 7304,
          color: "55bbc2",
          description: "Ozark-Ouachita Dry-Mesic Oak Forest",
        },
        {
          value: 7305,
          color: "0d4585",
          description: "Southern Interior Low Plateau Dry-Mesic Oak Forest",
        },
        {
          value: 7306,
          color: "55bbc2",
          description: "East Gulf Coastal Plain Northern Loess Plain Oak-Hickory Upland",
        },
        {
          value: 7307,
          color: "55bbc2",
          description: "East Gulf Coastal Plain Northern Dry Upland Hardwood Forest",
        },
        {
          value: 7308,
          color: "55bbc2",
          description: "Crosstimbers Oak Forest and Woodland",
        },
        {
          value: 7309,
          color: "d8d8bf",
          description: "Southern Appalachian Northern Hardwood Forest",
        },
        {
          value: 7310,
          color: "55bbc2",
          description: "North-Central Interior Dry-Mesic Oak Forest and Woodland",
        },
        {
          value: 7311,
          color: "55bbc2",
          description: "North-Central Interior Dry Oak Forest and Woodland",
        },
        {
          value: 7312,
          color: "55bbc2",
          description: "Ouachita Montane Oak Forest",
        },
        {
          value: 7313,
          color: "005c00",
          description: "North-Central Interior Beech-Maple Forest",
        },
        {
          value: 7314,
          color: "abff8a",
          description: "North-Central Interior Maple-Basswood Forest",
        },
        {
          value: 7315,
          color: "0d4585",
          description: "Southern Appalachian Oak Forest",
        },
        {
          value: 7316,
          color: "55bbc2",
          description: "Southern Piedmont Mesic Forest",
        },
        {
          value: 7317,
          color: "0d4585",
          description: "Allegheny-Cumberland Dry Oak Forest and Woodland",
        },
        {
          value: 7318,
          color: "124c87",
          description: "Southern and Central Appalachian Cove Forest",
        },
        {
          value: 7320,
          color: "55bbc2",
          description: "Central and Southern Appalachian Montane Oak Forest",
        },
        {
          value: 7321,
          color: "002673",
          description: "South-Central Interior Mesophytic Forest",
        },
        {
          value: 7322,
          color: "55bbc2",
          description: "Crowley's Ridge Mesic Loess Slope Forest",
        },
        {
          value: 7323,
          color: "91ff73",
          description: "West Gulf Coastal Plain Mesic Hardwood Forest",
        },
        {
          value: 7324,
          color: "55bbc2",
          description: "Northern Atlantic Coastal Plain Hardwood Forest",
        },
        {
          value: 7325,
          color: "9fff80",
          description: "East Gulf Coastal Plain Northern Mesic Hardwood Slope Forest",
        },
        {
          value: 7326,
          color: "55bbc2",
          description: "South-Central Interior / Upper Coastal Plain Flatwoods",
        },
        {
          value: 7327,
          color: "55bbc2",
          description: "East Gulf Coastal Plain Northern Loess Bluff Forest",
        },
        {
          value: 7328,
          color: "64ccce",
          description: "Southern Coastal Plain Limestone Forest",
        },
        {
          value: 7329,
          color: "64ccce",
          description: "East Gulf Coastal Plain Southern Loess Bluff Forest",
        },
        {
          value: 7330,
          color: "91ff73",
          description: "Southern Coastal Plain Dry Upland Hardwood Forest",
        },
        {
          value: 7331,
          color: "c0ff8a",
          description: "Eastern Great Plains Tallgrass Aspen Forest and Woodland",
        },
        {
          value: 7333,
          color: "3c717e",
          description: "South Florida Hardwood Hammock",
        },
        {
          value: 7334,
          color: "55bbc2",
          description: "Ozark-Ouachita Mesic Hardwood Forest",
        },
        {
          value: 7335,
          color: "91ff73",
          description: "Southern Atlantic Coastal Plain Dry and Dry-Mesic Oak Forest",
        },
        {
          value: 7336,
          color: "3c717e",
          description: "Southwest Florida Maritime Hammock",
        },
        {
          value: 7337,
          color: "3c717e",
          description: "Southeast Florida Maritime Hammock",
        },
        {
          value: 7338,
          color: "91ff73",
          description: "Central and South Texas Coastal Fringe Forest and Woodland",
        },
        {
          value: 7339,
          color: "91ff73",
          description: "West Gulf Coastal Plain Chenier and Upper Texas Coastal Fringe Forest and Woodland",
        },
        {
          value: 7340,
          color: "523422",
          description: "Appalachian Shale Barrens",
        },
        {
          value: 7342,
          color: "55bbc2",
          description: "Piedmont Hardpan Woodland and Forest",
        },
        {
          value: 7343,
          color: "91ff73",
          description: "Southern Atlantic Coastal Plain Mesic Hardwood Forest",
        },
        {
          value: 7346,
          color: "74d6cc",
          description: "Atlantic Coastal Plain Fall-line Sandhills Longleaf Pine Woodland",
        },
        {
          value: 7347,
          color: "74d6cc",
          description: "Atlantic Coastal Plain Upland Longleaf Pine Woodland",
        },
        {
          value: 7348,
          color: "74d6cc",
          description: "West Gulf Coastal Plain Upland Longleaf Pine Forest and Woodland",
        },
        {
          value: 7349,
          color: "74d6cc",
          description: "East Gulf Coastal Plain Interior Upland Longleaf Pine Woodland",
        },
        {
          value: 7350,
          color: "9fff80",
          description: "Central and Southern Appalachian Spruce-Fir Forest",
        },
        {
          value: 7351,
          color: "74d6cc",
          description: "Southeastern Interior Longleaf Pine Woodland",
        },
        {
          value: 7352,
          color: "0d4585",
          description: "Southern Appalachian Montane Pine Forest and Woodland",
        },
        {
          value: 7353,
          color: "0a3d80",
          description: "Southern Appalachian Low-Elevation Pine Forest",
        },
        {
          value: 7354,
          color: "74d6cc",
          description: "Northeastern Interior Pine Barrens",
        },
        {
          value: 7355,
          color: "74d6cc",
          description: "Northern Atlantic Coastal Plain Pitch Pine Barrens",
        },
        {
          value: 7356,
          color: "74d6cc",
          description: "Florida Longleaf Pine Sandhill",
        },
        {
          value: 7357,
          color: "91ff73",
          description: "Southern Coastal Plain Mesic Slope Forest",
        },
        {
          value: 7358,
          color: "55bbc2",
          description: "Bastrop Lost Pines Forest and Woodland",
        },
        {
          value: 7360,
          color: "0d4585",
          description: "South Florida Pine Rockland",
        },
        {
          value: 7361,
          color: "6bd1ce",
          description: "Central Atlantic Coastal Plain Maritime Forest",
        },
        {
          value: 7362,
          color: "aef5e0",
          description: "Laurentian-Acadian Northern Pine Forest",
        },
        {
          value: 7363,
          color: "ff9900",
          description: "Central Interior Highlands Dry Acidic Glade and Barrens",
        },
        {
          value: 7364,
          color: "55bbc2",
          description: "Ozark-Ouachita Dry Oak Woodland",
        },
        {
          value: 7366,
          color: "005c00",
          description: "Laurentian-Acadian Pine-Hemlock Forest",
        },
        {
          value: 7367,
          color: "74d6be",
          description: "Ozark-Ouachita Shortleaf Pine Forest and Woodland",
        },
        {
          value: 7368,
          color: "9fff80",
          description: "Southern Piedmont Dry Pine Forest",
        },
        {
          value: 7369,
          color: "0d4585",
          description: "Central Appalachian Dry Pine Forest",
        },
        {
          value: 7370,
          color: "002673",
          description: "Appalachian Hemlock Forest",
        },
        {
          value: 7371,
          color: "91ff73",
          description: "West Gulf Coastal Plain Pine Forest",
        },
        {
          value: 7372,
          color: "74d6be",
          description: "East Gulf Coastal Plain Interior Shortleaf Pine Forest",
        },
        {
          value: 7373,
          color: "ba360e",
          description: "Acadian Low-Elevation Spruce-Fir Forest",
        },
        {
          value: 7374,
          color: "ba360e",
          description: "Acadian-Appalachian Montane Spruce-Fir Forest",
        },
        {
          value: 7375,
          color: "002673",
          description: "Eastern Serpentine Woodland",
        },
        {
          value: 7376,
          color: "55bbc2",
          description: "Southern Ridge and Valley / Cumberland Dry Calcareous Forest",
        },
        {
          value: 7377,
          color: "0d4585",
          description: "Central Appalachian Pine Rocky Woodland",
        },
        {
          value: 7378,
          color: "74d6be",
          description: "West Gulf Coastal Plain Sandhill Shortleaf Pine Forest and Woodland",
        },
        {
          value: 7379,
          color: "91ff73",
          description: "Northern Atlantic Coastal Plain Maritime Forest",
        },
        {
          value: 7380,
          color: "6bd1ce",
          description: "East Gulf Coastal Plain Maritime Forest",
        },
        {
          value: 7381,
          color: "55bbc2",
          description: "Lower Mississippi River Dune Woodland and Forest",
        },
        {
          value: 7382,
          color: "6bd1ce",
          description: "Southern Atlantic Coastal Plain Maritime Forest",
        },
        {
          value: 7383,
          color: "226d99",
          description: "Edwards Plateau Limestone Savanna and Woodland",
        },
        {
          value: 7384,
          color: "91ff73",
          description: "Mississippi Delta Maritime Forest",
        },
        {
          value: 7385,
          color: "806145",
          description: "Great Plains Wooded Draw and Ravine Woodland",
        },
        {
          value: 7386,
          color: "523422",
          description: "Acadian-Appalachian Alpine Tundra Shrubland",
        },
        {
          value: 7387,
          color: "91ff73",
          description: "Florida Peninsula Inland Scrub Shrubland",
        },
        {
          value: 7389,
          color: "523422",
          description: "Acadian-Appalachian Subalpine Woodland",
        },
        {
          value: 7390,
          color: "523422",
          description: "Tamaulipan Mixed Deciduous Thornscrub",
        },
        {
          value: 7391,
          color: "523422",
          description: "Tamaulipan Mesquite Upland Woodland",
        },
        {
          value: 7392,
          color: "523422",
          description: "Tamaulipan Calcareous Thornscrub",
        },
        {
          value: 7393,
          color: "226d99",
          description: "Edwards Plateau Limestone Shrubland",
        },
        {
          value: 7394,
          color: "06357a",
          description: "North-Central Interior Oak Savanna",
        },
        {
          value: 7395,
          color: "2c7fa3",
          description: "North-Central Oak Barrens Woodland",
        },
        {
          value: 7396,
          color: "806145",
          description: "Great Plains Wooded Draw and Ravine Shrubland",
        },
        {
          value: 7397,
          color: "523422",
          description: "Nashville Basin Limestone Glade and Woodland",
        },
        {
          value: 7398,
          color: "523422",
          description: "Cumberland Sandstone Glade and Barrens",
        },
        {
          value: 7399,
          color: "f0a52e",
          description: "Northern Atlantic Coastal Plain Grassland",
        },
        {
          value: 7400,
          color: "523422",
          description: "Central Appalachian Alkaline Glade and Woodland",
        },
        {
          value: 7401,
          color: "ff9900",
          description: "Central Interior Highlands Calcareous Glade and Barrens Woodland",
        },
        {
          value: 7403,
          color: "74d6cc",
          description: "West Gulf Coastal Plain Catahoula Barrens",
        },
        {
          value: 7405,
          color: "ff9900",
          description: "West Gulf Coastal Plain Nepheline Syenite Glade",
        },
        {
          value: 7406,
          color: "9fff80",
          description: "Southern Piedmont Dry Oak Forest",
        },
        {
          value: 7407,
          color: "aef5e0",
          description: "Laurentian Pine Barrens",
        },
        {
          value: 7408,
          color: "523422",
          description: "Alabama Ketona Glade and Woodland",
        },
        {
          value: 7409,
          color: "d8d8bf",
          description: "Great Lakes Alvar",
        },
        {
          value: 7410,
          color: "226d99",
          description: "Llano Uplift Acidic Forest and Woodland",
        },
        {
          value: 7411,
          color: "ff5c26",
          description: "Great Lakes Wet-Mesic Lakeplain Prairie",
        },
        {
          value: 7412,
          color: "ff8940",
          description: "North-Central Interior Sand and Gravel Tallgrass Prairie",
        },
        {
          value: 7413,
          color: "523422",
          description: "Bluegrass Savanna and Woodland Prairie",
        },
        {
          value: 7414,
          color: "523422",
          description: "Southern Appalachian Shrub Bald",
        },
        {
          value: 7415,
          color: "ff9900",
          description: "Arkansas Valley Prairie",
        },
        {
          value: 7416,
          color: "523422",
          description: "Western Highland Rim Prairie and Barrens",
        },
        {
          value: 7417,
          color: "523422",
          description: "Eastern Highland Rim Prairie and Barrens",
        },
        {
          value: 7418,
          color: "523422",
          description: "Pennyroyal Karst Plain Prairie and Barrens",
        },
        {
          value: 7419,
          color: "523422",
          description: "Southern Ridge and Valley Patch Prairie",
        },
        {
          value: 7420,
          color: "ff8940",
          description: "Northern Tallgrass Prairie",
        },
        {
          value: 7421,
          color: "ff8940",
          description: "Central Tallgrass Prairie",
        },
        {
          value: 7422,
          color: "ff9447",
          description: "Texas Blackland Tallgrass Prairie",
        },
        {
          value: 7423,
          color: "ff8940",
          description: "Southeastern Great Plains Tallgrass Prairie",
        },
        {
          value: 7424,
          color: "ff9900",
          description: "East-Central Texas Plains Xeric Sandyland",
        },
        {
          value: 7425,
          color: "74d6cc",
          description: "Florida Dry Prairie Grassland",
        },
        {
          value: 7426,
          color: "ff9900",
          description: "Southern Atlantic Coastal Plain Dune and Maritime Grassland",
        },
        {
          value: 7428,
          color: "ff9447",
          description: "West Gulf Coastal Plain Northern Calcareous Prairie",
        },
        {
          value: 7429,
          color: "ff9447",
          description: "West Gulf Coastal Plain Southern Calcareous Prairie",
        },
        {
          value: 7430,
          color: "002673",
          description: "Southern Coastal Plain Blackland Prairie",
        },
        {
          value: 7431,
          color: "ff9900",
          description: "Southwest Florida Dune and Coastal Grassland",
        },
        {
          value: 7434,
          color: "ff8940",
          description: "Texas-Louisiana Coastal Prairie",
        },
        {
          value: 7435,
          color: "ff9900",
          description: "East Gulf Coastal Plain Dune and Coastal Grassland",
        },
        {
          value: 7436,
          color: "ff6229",
          description: "Northern Atlantic Coastal Plain Dune and Swale Shrubland",
        },
        {
          value: 7437,
          color: "ff9900",
          description: "Texas Coast Dune and Coastal Grassland",
        },
        {
          value: 7438,
          color: "523422",
          description: "Tamaulipan Savanna Grassland",
        },
        {
          value: 7439,
          color: "ffab57",
          description: "Tamaulipan Lomas",
        },
        {
          value: 7441,
          color: "523422",
          description: "Bluegrass Savanna and Woodland",
        },
        {
          value: 7442,
          color: "ff9900",
          description: "Arkansas Valley Prairie and Woodland",
        },
        {
          value: 7444,
          color: "3289a8",
          description: "Eastern Boreal Floodplain Woodland",
        },
        {
          value: 7445,
          color: "5bc3c7",
          description: "South Florida Dwarf Cypress Savanna",
        },
        {
          value: 7446,
          color: "74d6cc",
          description: "South Florida Pine Flatwoods",
        },
        {
          value: 7447,
          color: "5bc3c7",
          description: "South Florida Cypress Dome",
        },
        {
          value: 7448,
          color: "9fff80",
          description: "Southern Piedmont Dry Oak-(Pine) Forest",
        },
        {
          value: 7449,
          color: "74d6cc",
          description: "Central Atlantic Coastal Plain Wet Longleaf Pine Savanna and Flatwoods",
        },
        {
          value: 7450,
          color: "74d6cc",
          description: "Southern Atlantic Coastal Plain Wet Pine Savanna and Flatwoods",
        },
        {
          value: 7451,
          color: "74d6cc",
          description: "West Gulf Coastal Plain Wet Longleaf Pine Savanna and Flatwoods",
        },
        {
          value: 7452,
          color: "5bc3c7",
          description: "Atlantic Coastal Plain Peatland Pocosin and Canebrake Woodland",
        },
        {
          value: 7453,
          color: "74d6cc",
          description: "Central Florida Pine Flatwoods",
        },
        {
          value: 7454,
          color: "74d6cc",
          description: "East Gulf Coastal Plain Near-Coast Pine Flatwoods",
        },
        {
          value: 7455,
          color: "64ccce",
          description: "East Gulf Coastal Plain Southern Loblolly Flatwoods",
        },
        {
          value: 7456,
          color: "74d6cc",
          description: "Northern Atlantic Coastal Plain Pitch Pine Lowland",
        },
        {
          value: 7457,
          color: "91ff73",
          description: "South-Central Interior / Upper Coastal Plain Wet Flatwoods",
        },
        {
          value: 7458,
          color: "91ff73",
          description: "West Gulf Coastal Plain Pine Flatwoods",
        },
        {
          value: 7459,
          color: "5bc3c7",
          description: "Atlantic Coastal Plain Clay-Based Carolina Bay Wetland",
        },
        {
          value: 7460,
          color: "5bc3c7",
          description: "Southern Coastal Plain Nonriverine Cypress Dome",
        },
        {
          value: 7461,
          color: "d8d8bf",
          description: "Southern Coastal Plain Seepage Swamp and Baygall Woodland",
        },
        {
          value: 7462,
          color: "d8d8bf",
          description: "West Gulf Coastal Plain Seepage Swamp and Baygall",
        },
        {
          value: 7463,
          color: "0d4585",
          description: "Central Appalachian Dry Oak Forest",
        },
        {
          value: 7464,
          color: "baa377",
          description: "Acadian Sub-Boreal Spruce Barrens",
        },
        {
          value: 7465,
          color: "ba360e",
          description: "Acadian Sub-Boreal Spruce Flat",
        },
        {
          value: 7466,
          color: "aef5e0",
          description: "Great Lakes Wooded Dune and Swale",
        },
        {
          value: 7467,
          color: "06357a",
          description: "Tamaulipan Floodplain Woodland",
        },
        {
          value: 7468,
          color: "d8d8bf",
          description: "Atlantic Coastal Plain Streamhead Seepage Swamp-Pocosin-Baygall Woodland",
        },
        {
          value: 7469,
          color: "d8d8bf",
          description: "Atlantic Coastal Plain Streamhead Seepage Swamp-Pocosin-Baygall Shrubland",
        },
        {
          value: 7471,
          color: "3c717e",
          description: "Southwest Florida Coastal Strand Shrubland",
        },
        {
          value: 7472,
          color: "3c717e",
          description: "Southeast Florida Coastal Strand Shrubland",
        },
        {
          value: 7474,
          color: "06357a",
          description: "Tamaulipan Floodplain Shrubland",
        },
        {
          value: 7475,
          color: "06357a",
          description: "Tamaulipan Floodplain Herbaceous",
        },
        {
          value: 7476,
          color: "06357a",
          description: "Tamaulipan Riparian Woodland",
        },
        {
          value: 7481,
          color: "3289a8",
          description: "Laurentian-Acadian Alkaline Conifer-Hardwood Swamp",
        },
        {
          value: 7482,
          color: "5bc3c7",
          description: "Great Plains Prairie Pothole",
        },
        {
          value: 7483,
          color: "ff9900",
          description: "South Florida Everglades Sawgrass Marsh",
        },
        {
          value: 7484,
          color: "ff9900",
          description: "South Florida Wet Marl Prairie",
        },
        {
          value: 7485,
          color: "ff9900",
          description: "East Gulf Coastal Plain Wet Prairie",
        },
        {
          value: 7486,
          color: "ff9900",
          description: "Texas Saline Coastal Prairie",
        },
        {
          value: 7487,
          color: "ff8940",
          description: "Texas-Louisiana Coastal Prairie Pondshore",
        },
        {
          value: 7488,
          color: "5bc3c7",
          description: "Eastern Great Plains Wet Meadow-Prairie-Marsh",
        },
        {
          value: 7489,
          color: "ff9900",
          description: "Floridian Highlands Freshwater Marsh",
        },
        {
          value: 7500,
          color: "646464",
          description: "South Texas Salt and Brackish Tidal Flat",
        },
        {
          value: 7501,
          color: "d8d8bf",
          description: "Southern Atlantic Coastal Plain Nonriverine Swamp and Wet Hardwood Forest",
        },
        {
          value: 7502,
          color: "0d4585",
          description: "Central Appalachian Dry Oak-Pine Forest",
        },
        {
          value: 7503,
          color: "ffcc33",
          description: "Chihuahuan Loamy Plains Desert Grassland",
        },
        {
          value: 7504,
          color: "ffcc33",
          description: "Chihuahuan-Sonoran Desert Bottomland and Swale Grassland",
        },
        {
          value: 7505,
          color: "55bbc2",
          description: "Ouachita Novaculite Glade and Woodland",
        },
        {
          value: 7506,
          color: "91ff73",
          description: "West Gulf Coastal Plain Nonriverine Wet Hardwood Flatwoods",
        },
        {
          value: 7507,
          color: "74d6be",
          description: "Ozark-Ouachita Shortleaf Pine-Bluestem Woodland",
        },
        {
          value: 7509,
          color: "55bbc2",
          description: "Mississippi River Alluvial Plain Dry-Mesic Loess Slope Forest",
        },
        {
          value: 7510,
          color: "74d6be",
          description: "Crowley's Ridge Sand Forest",
        },
        {
          value: 7511,
          color: "002673",
          description: "Appalachian Northern Hardwood Forest",
        },
        {
          value: 7512,
          color: "002673",
          description: "Appalachian (Hemlock)-Northern Hardwood Forest",
        },
        {
          value: 7513,
          color: "91ff73",
          description: "Lower Mississippi River Flatwoods",
        },
        {
          value: 7514,
          color: "ff9900",
          description: "Central Florida Herbaceous Pondshore",
        },
        {
          value: 7515,
          color: "ff9900",
          description: "Southern Coastal Plain Herbaceous Seep and Bog",
        },
        {
          value: 7516,
          color: "ff9900",
          description: "Atlantic Coastal Plain Sandhill Seep",
        },
        {
          value: 7517,
          color: "55bbc2",
          description: "Paleozoic Plateau Bluff and Talus Woodland",
        },
        {
          value: 7518,
          color: "91ff73",
          description: "North-Central Interior Wet Flatwoods",
        },
        {
          value: 7519,
          color: "55bbc2",
          description: "East-Central Texas Plains Post Oak Savanna and Woodland",
        },
        {
          value: 7522,
          color: "f0a52e",
          description: "Northern Atlantic Coastal Plain Heathland",
        },
        {
          value: 7523,
          color: "226d99",
          description: "Edwards Plateau Dry-Mesic Slope Forest and Woodland",
        },
        {
          value: 7524,
          color: "226d99",
          description: "Edwards Plateau Mesic Canyon",
        },
        {
          value: 7525,
          color: "06357a",
          description: "Edwards Plateau Riparian Forest and Woodland",
        },
        {
          value: 7527,
          color: "74d6be",
          description: "East Gulf Coastal Plain Interior Oak Forest",
        },
        {
          value: 7545,
          color: "74d6cc",
          description: "East Gulf Coastal Plain Near-Coast Pine Wet Flatwoods",
        },
        {
          value: 7546,
          color: "74d6be",
          description: "East Gulf Coastal Plain Interior Shortleaf Pine-Oak Forest",
        },
        {
          value: 7547,
          color: "74d6cc",
          description: "Central Florida Pine Wet Flatwoods",
        },
        {
          value: 7548,
          color: "74d6cc",
          description: "South Florida Pine Wet Flatwoods",
        },
        {
          value: 7554,
          color: "ba360e",
          description: "Acadian Low-Elevation Hardwood Forest",
        },
        {
          value: 7555,
          color: "ba360e",
          description: "Acadian Low-Elevation Spruce-Fir-Hardwood Forest",
        },
        {
          value: 7556,
          color: "0d4585",
          description: "Central Appalachian Oak Rocky Woodland",
        },
        {
          value: 7557,
          color: "0d4585",
          description: "Central Appalachian Pine-Oak Rocky Woodland",
        },
        {
          value: 7560,
          color: "523422",
          description: "Tamaulipan Mesquite Upland Scrub",
        },
        {
          value: 7561,
          color: "226d99",
          description: "Llano Uplift Acidic Herbaceous Glade",
        },
        {
          value: 7562,
          color: "06357a",
          description: "Tamaulipan Riparian Shrubland",
        },
        {
          value: 7563,
          color: "06357a",
          description: "Edwards Plateau Riparian Shrubland",
        },
        {
          value: 7564,
          color: "06357a",
          description: "Edwards Plateau Riparian Herbaceous",
        },
        {
          value: 7565,
          color: "91ff73",
          description: "Florida Peninsula Inland Scrub Woodland",
        },
        {
          value: 7566,
          color: "74d6cc",
          description: "Florida Dry Prairie Shruband",
        },
        {
          value: 7567,
          color: "002673",
          description: "Southern Coastal Plain Blackland Prairie Woodland",
        },
        {
          value: 7571,
          color: "d8d8bf",
          description: "Southern Coastal Plain Seepage Swamp and Baygall Shrubland",
        },
        {
          value: 7573,
          color: "06357a",
          description: "Tamaulipan Riparian Herbaceous",
        },
        {
          value: 7578,
          color: "ff9900",
          description: "East Gulf Coastal Plain Wet Savanna",
        },
        {
          value: 7582,
          color: "74d6be",
          description: "Ozark-Ouachita Oak Forest and Woodland",
        },
        {
          value: 7583,
          color: "74d6be",
          description: "Ozark-Ouachita Shortleaf Pine-Oak Forest and Woodland",
        },
        {
          value: 7584,
          color: "91ff73",
          description: "West Gulf Coastal Plain Hardwood Forest",
        },
        {
          value: 7585,
          color: "91ff73",
          description: "West Gulf Coastal Plain Pine-Hardwood Forest",
        },
        {
          value: 7586,
          color: "74d6be",
          description: "West Gulf Coastal Plain Sandhill Oak Forest and Woodland",
        },
        {
          value: 7587,
          color: "74d6be",
          description: "West Gulf Coastal Plain Sandhill Oak and Shortleaf Pine Forest and Woodland",
        },
        {
          value: 7588,
          color: "64ccce",
          description: "East Gulf Coastal Plain Southern Hardwood Flatwoods",
        },
        {
          value: 7589,
          color: "64ccce",
          description: "East Gulf Coastal Plain Southern Loblolly-Hardwood Flatwoods",
        },
        {
          value: 7590,
          color: "91ff73",
          description: "West Gulf Coastal Plain Hardwood Flatwoods",
        },
        {
          value: 7591,
          color: "91ff73",
          description: "West Gulf Coastal Plain Pine-Hardwood Flatwoods",
        },
        {
          value: 7662,
          color: "ff9900",
          description: "Temperate Pacific Freshwater Emergent Marsh",
        },
        {
          value: 7663,
          color: "a64c11",
          description: "North Pacific Shrub Swamp",
        },
        {
          value: 7668,
          color: "ff990a",
          description: "Temperate Pacific Tidal Salt and Brackish Marsh",
        },
        {
          value: 7669,
          color: "646464",
          description: "Temperate Pacific Intertidal Flat",
        },
        {
          value: 7733,
          color: "646464",
          description: "North Pacific Montane Massive Bedrock-Cliff and Talus",
        },
        {
          value: 7734,
          color: "646464",
          description: "North Pacific Alpine and Subalpine Bedrock and Scree",
        },
        {
          value: 7735,
          color: "9fa1f0",
          description: "North American Glacier and Ice Field",
        },
        {
          value: 7736,
          color: "646464",
          description: "Unconsolidated Shore",
        },
        {
          value: 7737,
          color: "646464",
          description: "North American Glacial Outwash",
        },
        {
          value: 7754,
          color: "e3d41c",
          description: "Agriculture-Pasture and Hay",
        },
        {
          value: 7755,
          color: "faff77",
          description: "Agriculture-Cultivated Crops and Irrigated Agriculture",
        },
        {
          value: 7800,
          color: "ff692e",
          description: "Hawai'i Floodplain Forest",
        },
        {
          value: 7802,
          color: "ff692e",
          description: "Hawai'i Riparian Forest",
        },
        {
          value: 7804,
          color: "ff9900",
          description: "Hawai'i Freshwater Marsh",
        },
        {
          value: 7806,
          color: "ff7230",
          description: "Hawai'i Bog",
        },
        {
          value: 7807,
          color: "ff990a",
          description: "Northern Polynesia Tidal Salt Marsh",
        },
        {
          value: 7808,
          color: "c0ff8a",
          description: "Hawai'i Lowland Rainforest",
        },
        {
          value: 7809,
          color: "c0ff8a",
          description: "Hawai'i Montane Cloud Forest",
        },
        {
          value: 7810,
          color: "c0ff8a",
          description: "Hawai'i Montane Rainforest",
        },
        {
          value: 7811,
          color: "963a0c",
          description: "Hawai'i Wet Cliff and Ridge Crest Shrubland",
        },
        {
          value: 7812,
          color: "005c00",
          description: "Hawai'i Mesic Coastal Forest",
        },
        {
          value: 7813,
          color: "baa377",
          description: "Hawai'i Lowland Dry Forest",
        },
        {
          value: 7814,
          color: "005c00",
          description: "Hawai'i Lowland Mesic Forest",
        },
        {
          value: 7815,
          color: "baa377",
          description: "Hawai'i Montane-Subalpine Dry Forest and Woodland",
        },
        {
          value: 7816,
          color: "005c00",
          description: "Hawai'i Montane-Subalpine Mesic Forest",
        },
        {
          value: 7817,
          color: "9c805c",
          description: "Hawai'i Lowland Dry Shrubland",
        },
        {
          value: 7818,
          color: "963a0c",
          description: "Hawai'i Lowland Mesic Shrubland",
        },
        {
          value: 7819,
          color: "fb7936",
          description: "Hawai'i Lowland Dry Grassland",
        },
        {
          value: 7820,
          color: "ff7230",
          description: "Hawai'i Lowland Mesic Grassland",
        },
        {
          value: 7821,
          color: "9c805c",
          description: "Hawai'i Montane-Subalpine Dry Shrubland",
        },
        {
          value: 7822,
          color: "fb7936",
          description: "Hawai'i Montane-Subalpine Dry Grassland",
        },
        {
          value: 7823,
          color: "ff7230",
          description: "Hawai'i Montane-Subalpine Mesic Grassland",
        },
        {
          value: 7824,
          color: "963a0c",
          description: "Hawai'i Alpine Dwarf-Shrubland",
        },
        {
          value: 7826,
          color: "963a0c",
          description: "Hawai'i Dry Coastal Strand Shrubland",
        },
        {
          value: 7827,
          color: "963a0c",
          description: "Hawai'i Wet-Mesic Coastal Strand",
        },
        {
          value: 7828,
          color: "ff7230",
          description: "Hawai'i Subalpine Mesic Shrubland",
        },
        {
          value: 7829,
          color: "646464",
          description: "Hawai'i Alpine Bedrock and Scree",
        },
        {
          value: 7830,
          color: "646464",
          description: "Hawai'i Dry Coastal Strand Sparse Vegetation",
        },
        {
          value: 7831,
          color: "646464",
          description: "Hawai'i Dry-Site Lava Flow",
        },
        {
          value: 7832,
          color: "ff692e",
          description: "Hawai'I Floodplain Shrubland",
        },
        {
          value: 7833,
          color: "ff692e",
          description: "Hawai'i Riparian Shrubland",
        },
        {
          value: 7834,
          color: "d21c5e",
          description: "Tropical Pacific Orchard",
        },
        {
          value: 7835,
          color: "d21c77",
          description: "Tropical Pacific Bush fruit and Berries",
        },
        {
          value: 7836,
          color: "d2ffed",
          description: "Tropical Pacific Aquaculture",
        },
        {
          value: 7837,
          color: "faff77",
          description: "Sugar Cane",
        },
        {
          value: 7838,
          color: "d21c77",
          description: "Caribbean Bush fruit and berries",
        },
        {
          value: 7860,
          color: "005c00",
          description: "Caribbean Coastal Dry Evergreen Forest",
        },
        {
          value: 7861,
          color: "5bc3c7",
          description: "Caribbean Coastal Mangrove",
        },
        {
          value: 7862,
          color: "646464",
          description: "Caribbean Coastal Rocky Shore",
        },
        {
          value: 7863,
          color: "91ff73",
          description: "Caribbean Coastal Thornscrub",
        },
        {
          value: 7864,
          color: "91ff73",
          description: "Caribbean Dry Karst Shrubland",
        },
        {
          value: 7865,
          color: "60ff47",
          description: "Caribbean Edapho-Xerophilous \"Mogote\" Complex",
        },
        {
          value: 7866,
          color: "705239",
          description: "Caribbean Emergent Herbaceous Estuary",
        },
        {
          value: 7867,
          color: "5bc3c7",
          description: "Caribbean Estuary Mangrove",
        },
        {
          value: 7868,
          color: "9c805c",
          description: "Caribbean Floodplain Forest",
        },
        {
          value: 7869,
          color: "705239",
          description: "Caribbean Freshwater Marsh",
        },
        {
          value: 7870,
          color: "00de00",
          description: "Caribbean Lowland Moist Serpentine Woodland",
        },
        {
          value: 7871,
          color: "74d6cc",
          description: "Caribbean Montane Meadow",
        },
        {
          value: 7872,
          color: "aef5e0",
          description: "Caribbean Montane Wet Elfin Forest",
        },
        {
          value: 7873,
          color: "00de00",
          description: "Caribbean Montane Wet Serpentine Woodland",
        },
        {
          value: 7874,
          color: "705239",
          description: "Caribbean Montane Wet Short Shrubland",
        },
        {
          value: 7875,
          color: "9c805c",
          description: "Caribbean Riparian Forest",
        },
        {
          value: 7876,
          color: "646464",
          description: "Caribbean Salt Flat and Pond",
        },
        {
          value: 7877,
          color: "646464",
          description: "Caribbean Sand Beach Vegetation",
        },
        {
          value: 7878,
          color: "83de6e",
          description: "Caribbean Sand Savanna",
        },
        {
          value: 7879,
          color: "00de00",
          description: "Caribbean Seasonal Evergreen Lowland Forest",
        },
        {
          value: 7880,
          color: "00de00",
          description: "Caribbean Seasonal Evergreen Submontane/Lowland Forest",
        },
        {
          value: 7881,
          color: "b4ff94",
          description: "Caribbean Semi-deciduous Lowland Forest",
        },
        {
          value: 7882,
          color: "91ff73",
          description: "Caribbean Serpentine Dry Scrub",
        },
        {
          value: 7883,
          color: "aef5e0",
          description: "Caribbean Submontane/Montane Karstic Forest",
        },
        {
          value: 7884,
          color: "9c805c",
          description: "Caribbean Wet Montane Forest",
        },
        {
          value: 7885,
          color: "9c805c",
          description: "Caribbean Wet Submontane/Lowland Forest",
        },
        {
          value: 7886,
          color: "646464",
          description: "Stabilized Caribbean Dunes",
        },
        {
          value: 7887,
          color: "9c805c",
          description: "Caribbean Floodplain Shrubland",
        },
        {
          value: 7888,
          color: "9c805c",
          description: "Caribbean Riparian Shrubland",
        },
        {
          value: 7900,
          color: "704489",
          description: "Western Cool Temperate Urban Deciduous Forest",
        },
        {
          value: 7901,
          color: "aa66cd",
          description: "Western Cool Temperate Urban Evergreen Forest",
        },
        {
          value: 7902,
          color: "c29ed7",
          description: "Western Cool Temperate Urban Mixed Forest",
        },
        {
          value: 7903,
          color: "ca7af5",
          description: "Western Cool Temperate Urban Herbaceous",
        },
        {
          value: 7904,
          color: "cfabd7",
          description: "Western Cool Temperate Urban Shrubland",
        },
        {
          value: 7905,
          color: "704489",
          description: "Eastern Cool Temperate Urban Deciduous Forest",
        },
        {
          value: 7906,
          color: "aa66cd",
          description: "Eastern Cool Temperate Urban Evergreen Forest",
        },
        {
          value: 7907,
          color: "c29ed7",
          description: "Eastern Cool Temperate Urban Mixed Forest",
        },
        {
          value: 7908,
          color: "ca7af5",
          description: "Eastern Cool Temperate Urban Herbaceous",
        },
        {
          value: 7909,
          color: "cfabd7",
          description: "Eastern Cool Temperate Urban Shrubland",
        },
        {
          value: 7910,
          color: "704489",
          description: "Western Warm Temperate Urban Deciduous Forest",
        },
        {
          value: 7911,
          color: "aa66cd",
          description: "Western Warm Temperate Urban Evergreen Forest",
        },
        {
          value: 7912,
          color: "c29ed7",
          description: "Western Warm Temperate Urban Mixed Forest",
        },
        {
          value: 7913,
          color: "ca7af5",
          description: "Western Warm Temperate Urban Herbaceous",
        },
        {
          value: 7914,
          color: "cfabd7",
          description: "Western Warm Temperate Urban Shrubland",
        },
        {
          value: 7915,
          color: "704489",
          description: "Eastern Warm Temperate Urban Deciduous Forest",
        },
        {
          value: 7916,
          color: "aa66cd",
          description: "Eastern Warm Temperate Urban Evergreen Forest",
        },
        {
          value: 7917,
          color: "c29ed7",
          description: "Eastern Warm Temperate Urban Mixed Forest",
        },
        {
          value: 7918,
          color: "ca7af5",
          description: "Eastern Warm Temperate Urban Herbaceous",
        },
        {
          value: 7919,
          color: "cfabd7",
          description: "Eastern Warm Temperate Urban Shrubland",
        },
        {
          value: 7920,
          color: "403da8",
          description: "Western Cool Temperate Developed Deciduous Forest",
        },
        {
          value: 7921,
          color: "6677cd",
          description: "Western Cool Temperate Developed Evergreen Forest",
        },
        {
          value: 7922,
          color: "444f89",
          description: "Western Cool Temperate Developed Mixed Forest",
        },
        {
          value: 7923,
          color: "7a8ef5",
          description: "Western Cool Temperate Developed Shrubland",
        },
        {
          value: 7924,
          color: "9eaad7",
          description: "Western Cool Temperate Developed Herbaceous",
        },
        {
          value: 7925,
          color: "403da8",
          description: "Eastern Cool Temperate Developed Deciduous Forest",
        },
        {
          value: 7926,
          color: "6677cd",
          description: "Eastern Cool Temperate Developed Evergreen Forest",
        },
        {
          value: 7927,
          color: "444f89",
          description: "Eastern Cool Temperate Developed Mixed Forest",
        },
        {
          value: 7928,
          color: "7a8ef5",
          description: "Eastern Cool Temperate Developed Shrubland",
        },
        {
          value: 7929,
          color: "9eaad7",
          description: "Eastern Cool Temperate Developed Herbaceous",
        },
        {
          value: 7930,
          color: "403da8",
          description: "Western Warm Temperate Developed Deciduous Forest",
        },
        {
          value: 7931,
          color: "6677cd",
          description: "Western Warm Temperate Developed Evergreen Forest",
        },
        {
          value: 7932,
          color: "444f89",
          description: "Western Warm Temperate Developed Mixed Forest",
        },
        {
          value: 7933,
          color: "7a8ef5",
          description: "Western Warm Temperate Developed Shrubland",
        },
        {
          value: 7934,
          color: "9eaad7",
          description: "Western Warm Temperate Developed Herbaceous",
        },
        {
          value: 7935,
          color: "403da8",
          description: "Eastern Warm Temperate Developed Deciduous Forest",
        },
        {
          value: 7936,
          color: "6677cd",
          description: "Eastern Warm Temperate Developed Evergreen Forest",
        },
        {
          value: 7937,
          color: "444f89",
          description: "Eastern Warm Temperate Developed Mixed Forest",
        },
        {
          value: 7938,
          color: "7a8ef5",
          description: "Eastern Warm Temperate Developed Shrubland",
        },
        {
          value: 7939,
          color: "9eaad7",
          description: "Eastern Warm Temperate Developed Herbaceous",
        },
        {
          value: 7960,
          color: "d21c5e",
          description: "Western Cool Temperate Orchard",
        },
        {
          value: 7961,
          color: "a80084",
          description: "Western Cool Temperate Vineyard",
        },
        {
          value: 7962,
          color: "d21c77",
          description: "Western Cool Temperate Bush fruit and berries",
        },
        {
          value: 7963,
          color: "fff58c",
          description: "Western Cool Temperate Row Crop - Close Grown Crop",
        },
        {
          value: 7964,
          color: "faff77",
          description: "Western Cool Temperate Row Crop",
        },
        {
          value: 7965,
          color: "ffed77",
          description: "Western Cool Temperate Close Grown Crop",
        },
        {
          value: 7966,
          color: "ffff77",
          description: "Western Cool Temperate Fallow/Idle Cropland",
        },
        {
          value: 7967,
          color: "e3d41c",
          description: "Western Cool Temperate Pasture and Hayland",
        },
        {
          value: 7968,
          color: "fae3a3",
          description: "Western Cool Temperate Wheat",
        },
        {
          value: 7969,
          color: "d2ffed",
          description: "Western Cool Temperate Aquaculture",
        },
        {
          value: 7970,
          color: "d21c5e",
          description: "Eastern Cool Temperate Orchard",
        },
        {
          value: 7971,
          color: "a80084",
          description: "Eastern Cool Temperate Vineyard",
        },
        {
          value: 7972,
          color: "d21c77",
          description: "Eastern Cool Temperate Bush fruit and berries",
        },
        {
          value: 7973,
          color: "fff58c",
          description: "Eastern Cool Temperate Row Crop - Close Grown Crop",
        },
        {
          value: 7974,
          color: "faff77",
          description: "Eastern Cool Temperate Row Crop",
        },
        {
          value: 7975,
          color: "ffed77",
          description: "Eastern Cool Temperate Close Grown Crop",
        },
        {
          value: 7976,
          color: "ffff77",
          description: "Eastern Cool Temperate Fallow/Idle Cropland",
        },
        {
          value: 7977,
          color: "e3d41c",
          description: "Eastern Cool Temperate Pasture and Hayland",
        },
        {
          value: 7978,
          color: "fae3a3",
          description: "Eastern Cool Temperate Wheat",
        },
        {
          value: 7979,
          color: "d2ffed",
          description: "Eastern Cool Temperate Aquaculture",
        },
        {
          value: 7980,
          color: "d21c5e",
          description: "Western Warm Temperate Orchard",
        },
        {
          value: 7981,
          color: "a80084",
          description: "Western Warm Temperate Vineyard",
        },
        {
          value: 7982,
          color: "d21c77",
          description: "Western Warm Temperate Bush fruit and berries",
        },
        {
          value: 7983,
          color: "fff58c",
          description: "Western Warm Temperate Row Crop - Close Grown Crop",
        },
        {
          value: 7984,
          color: "faff77",
          description: "Western Warm Temperate Row Crop",
        },
        {
          value: 7985,
          color: "ffed77",
          description: "Western Warm Temperate Close Grown Crop",
        },
        {
          value: 7986,
          color: "ffff77",
          description: "Western Warm Temperate Fallow/Idle Cropland",
        },
        {
          value: 7987,
          color: "e3d41c",
          description: "Western Warm Temperate Pasture and Hayland",
        },
        {
          value: 7988,
          color: "fae3a3",
          description: "Western Warm Temperate Wheat",
        },
        {
          value: 7989,
          color: "d2ffed",
          description: "Western Warm Temperate Aquaculture",
        },
        {
          value: 7990,
          color: "d21c5e",
          description: "Eastern Warm Temperate Orchard",
        },
        {
          value: 7991,
          color: "a80084",
          description: "Eastern Warm Temperate Vineyard",
        },
        {
          value: 7992,
          color: "d21c77",
          description: "Eastern Warm Temperate Bush fruit and berries",
        },
        {
          value: 7993,
          color: "fff58c",
          description: "Eastern Warm Temperate Row Crop - Close Grown Crop",
        },
        {
          value: 7994,
          color: "faff77",
          description: "Eastern Warm Temperate Row Crop",
        },
        {
          value: 7995,
          color: "ffed77",
          description: "Eastern Warm Temperate Close Grown Crop",
        },
        {
          value: 7996,
          color: "ffff77",
          description: "Eastern Warm Temperate Fallow/Idle Cropland",
        },
        {
          value: 7997,
          color: "e3d41c",
          description: "Eastern Warm Temperate Pasture and Hayland",
        },
        {
          value: 7998,
          color: "fae3a3",
          description: "Eastern Warm Temperate Wheat",
        },
        {
          value: 7999,
          color: "d2ffed",
          description: "Eastern Warm Temperate Aquaculture",
        },
        {
          value: 9001,
          color: "646464",
          description: "Colorado Plateau Mixed Bedrock Canyon and Tableland",
        },
        {
          value: 9002,
          color: "49abba",
          description: "Columbia Basin Foothill Riparian Woodland",
        },
        {
          value: 9003,
          color: "49abba",
          description: "Great Basin Foothill and Lower Montane Riparian Woodland",
        },
        {
          value: 9004,
          color: "646464",
          description: "Inter-Mountain Basins Active and Stabilized Dune",
        },
        {
          value: 9005,
          color: "fa6438",
          description: "Inter-Mountain Basins Alkaline Closed Depression",
        },
        {
          value: 9006,
          color: "646464",
          description: "Inter-Mountain Basins Cliff and Canyon",
        },
        {
          value: 9008,
          color: "646464",
          description: "Inter-Mountain Basins Playa",
        },
        {
          value: 9009,
          color: "646464",
          description: "Inter-Mountain Basins Shale Badland",
        },
        {
          value: 9010,
          color: "646464",
          description: "Inter-Mountain Basins Wash",
        },
        {
          value: 9011,
          color: "fa6438",
          description: "North American Arid West Emergent Marsh",
        },
        {
          value: 9012,
          color: "49abba",
          description: "Northern Rocky Mountain Lower Montane Riparian Woodland",
        },
        {
          value: 9014,
          color: "06357a",
          description: "Northwestern Great Plains Floodplain Forest and Woodland",
        },
        {
          value: 9015,
          color: "06357a",
          description: "Northwestern Great Plains Riparian Forest",
        },
        {
          value: 9016,
          color: "646464",
          description: "Rocky Mountain Alpine Bedrock and Scree",
        },
        {
          value: 9017,
          color: "b86018",
          description: "Rocky Mountain Alpine-Montane Wet Meadow",
        },
        {
          value: 9018,
          color: "646464",
          description: "Rocky Mountain Cliff Canyon and Massive Bedrock",
        },
        {
          value: 9019,
          color: "49abba",
          description: "Rocky Mountain Lower Montane-Foothill Riparian Woodland",
        },
        {
          value: 9021,
          color: "b86018",
          description: "Rocky Mountain Subalpine-Montane Riparian Shrubland",
        },
        {
          value: 9022,
          color: "b86018",
          description: "Rocky Mountain Subalpine-Montane Riparian Woodland",
        },
        {
          value: 9023,
          color: "646464",
          description: "Western Great Plains Badlands",
        },
        {
          value: 9024,
          color: "646464",
          description: "Western Great Plains Cliff and Outcrop",
        },
        {
          value: 9025,
          color: "ff8940",
          description: "Western Great Plains Closed Depression Wetland",
        },
        {
          value: 9026,
          color: "06357a",
          description: "Western Great Plains Floodplain Forest and Woodland",
        },
        {
          value: 9027,
          color: "ff8940",
          description: "Western Great Plains Open Freshwater Depression Wetland",
        },
        {
          value: 9028,
          color: "06357a",
          description: "Western Great Plains Riparian Woodland",
        },
        {
          value: 9029,
          color: "ff8940",
          description: "Western Great Plains Saline Depression Wetland",
        },
        {
          value: 9030,
          color: "b86018",
          description: "Columbia Plateau Silver Sagebrush Seasonally Flooded Shrub-Steppe",
        },
        {
          value: 9032,
          color: "646464",
          description: "Columbia Plateau Ash and Tuff Badland",
        },
        {
          value: 9033,
          color: "646464",
          description: "Inter-Mountain Basins Volcanic Rock and Cinder Land",
        },
        {
          value: 9034,
          color: "51b48d",
          description: "North American Warm Desert Riparian Woodland",
        },
        {
          value: 9035,
          color: "51b48d",
          description: "North American Warm Desert Lower Montane Riparian Woodland",
        },
        {
          value: 9036,
          color: "ff5c26",
          description: "Acadian Coastal Salt Marsh",
        },
        {
          value: 9037,
          color: "ff5c26",
          description: "Acadian Estuary Marsh",
        },
        {
          value: 9038,
          color: "baa377",
          description: "Acadian Maritime Bog",
        },
        {
          value: 9039,
          color: "ba360e",
          description: "Acadian-Appalachian Conifer Seepage Forest",
        },
        {
          value: 9040,
          color: "646464",
          description: "Acadian-North Atlantic Rocky Coast",
        },
        {
          value: 9041,
          color: "91ff73",
          description: "Atlantic Coastal Plain Blackwater Stream Floodplain Forest",
        },
        {
          value: 9042,
          color: "91ff73",
          description: "Atlantic Coastal Plain Brownwater Stream Floodplain Forest",
        },
        {
          value: 9044,
          color: "ff9900",
          description: "Atlantic Coastal Plain Embayed Region Tidal Freshwater Marsh",
        },
        {
          value: 9045,
          color: "ff9900",
          description: "Atlantic Coastal Plain Embayed Region Tidal Salt and Brackish Marsh",
        },
        {
          value: 9047,
          color: "ff9900",
          description: "Atlantic Coastal Plain Indian River Lagoon Tidal Marsh",
        },
        {
          value: 9048,
          color: "852708",
          description: "Atlantic Coastal Plain Northern Bog",
        },
        {
          value: 9050,
          color: "91ff73",
          description: "Atlantic Coastal Plain Small Blackwater River Floodplain Forest",
        },
        {
          value: 9051,
          color: "91ff73",
          description: "Atlantic Coastal Plain Small Brownwater River Floodplain Forest",
        },
        {
          value: 9055,
          color: "baa377",
          description: "Boreal-Laurentian Bog",
        },
        {
          value: 9056,
          color: "baa377",
          description: "Boreal-Laurentian Conifer Acidic Swamp and Treed Poor Fen",
        },
        {
          value: 9057,
          color: "ff5c26",
          description: "Boreal-Laurentian-Acadian Acidic Basin Fen",
        },
        {
          value: 9059,
          color: "005c00",
          description: "Central Appalachian River Floodplain Forest",
        },
        {
          value: 9060,
          color: "005c00",
          description: "Central Appalachian Stream and Riparian Woodland",
        },
        {
          value: 9061,
          color: "646464",
          description: "Central Atlantic Coastal Plain Sandy Beach",
        },
        {
          value: 9062,
          color: "646464",
          description: "Central California Coast Ranges Cliff and Canyon",
        },
        {
          value: 9063,
          color: "ff9900",
          description: "Central Florida Wet Prairie and Herbaceous Seep",
        },
        {
          value: 9064,
          color: "646464",
          description: "Central Interior Acidic Cliff and Talus",
        },
        {
          value: 9065,
          color: "646464",
          description: "Central Interior Calcareous Cliff and Talus",
        },
        {
          value: 9066,
          color: "005c00",
          description: "Central Interior Highlands and Appalachian Sinkhole and Depression Pond",
        },
        {
          value: 9068,
          color: "91ff73",
          description: "Central Texas Coastal Prairie Riparian Forest",
        },
        {
          value: 9069,
          color: "91ff73",
          description: "Central Texas Coastal Prairie River Floodplain Forest",
        },
        {
          value: 9071,
          color: "91ff73",
          description: "Columbia Bottomlands Forest and Woodland",
        },
        {
          value: 9073,
          color: "646464",
          description: "Cumberland Acidic Cliff and Rockhouse",
        },
        {
          value: 9075,
          color: "005c00",
          description: "Cumberland Seepage Forest",
        },
        {
          value: 9077,
          color: "ff9900",
          description: "East Gulf Coastal Plain Depression Pondshore",
        },
        {
          value: 9080,
          color: "d8d8bf",
          description: "East Gulf Coastal Plain Freshwater Tidal Wooded Swamp",
        },
        {
          value: 9082,
          color: "91ff73",
          description: "East Gulf Coastal Plain Large River Floodplain Forest",
        },
        {
          value: 9083,
          color: "d8d8bf",
          description: "East Gulf Coastal Plain Northern Seepage Swamp",
        },
        {
          value: 9085,
          color: "91ff73",
          description: "East Gulf Coastal Plain Small Stream and River Floodplain Forest",
        },
        {
          value: 9088,
          color: "aef5e0",
          description: "Laurentian-Acadian Sub-boreal Dry-Mesic Pine-Black Spruce Forest",
        },
        {
          value: 9089,
          color: "b6fae3",
          description: "Laurentian-Acadian Sub-boreal Mesic Balsam Fir-Spruce Forest",
        },
        {
          value: 9091,
          color: "646464",
          description: "Edwards Plateau Cliff",
        },
        {
          value: 9092,
          color: "06357a",
          description: "Edwards Plateau Floodplain Terrace Forest and Woodland",
        },
        {
          value: 9094,
          color: "ff9900",
          description: "Florida Big Bend Fresh and Oligohaline Tidal Marsh",
        },
        {
          value: 9095,
          color: "ff9900",
          description: "Florida Big Bend Salt and Brackish Tidal Marsh",
        },
        {
          value: 9097,
          color: "646464",
          description: "Florida Panhandle Beach Vegetation",
        },
        {
          value: 9098,
          color: "ff9900",
          description: "Florida River Floodplain Marsh",
        },
        {
          value: 9099,
          color: "646464",
          description: "Great Lakes Acidic Rocky Shore and Cliff",
        },
        {
          value: 9100,
          color: "646464",
          description: "Great Lakes Alkaline Rocky Shore and Cliff",
        },
        {
          value: 9101,
          color: "646464",
          description: "Great Lakes Dune",
        },
        {
          value: 9102,
          color: "ff5c26",
          description: "Great Lakes Freshwater Estuary and Delta",
        },
        {
          value: 9103,
          color: "646464",
          description: "Gulf Coast Chenier Plain Beach",
        },
        {
          value: 9104,
          color: "ff9900",
          description: "Gulf Coast Chenier Plain Fresh and Oligohaline Tidal Marsh",
        },
        {
          value: 9105,
          color: "ff9900",
          description: "Gulf Coast Chenier Plain Salt and Brackish Tidal Marsh",
        },
        {
          value: 9106,
          color: "005c00",
          description: "High Allegheny Wetland",
        },
        {
          value: 9110,
          color: "646464",
          description: "Klamath-Siskiyou Cliff and Outcrop",
        },
        {
          value: 9111,
          color: "aef5e0",
          description: "Laurentian Acidic Rocky Outcrop Woodland",
        },
        {
          value: 9112,
          color: "aef5e0",
          description: "Laurentian Jack Pine-Red Pine Forest",
        },
        {
          value: 9113,
          color: "646464",
          description: "Laurentian-Acadian Acidic Cliff and Talus",
        },
        {
          value: 9114,
          color: "ff5c26",
          description: "Laurentian-Acadian Alkaline Fen",
        },
        {
          value: 9115,
          color: "646464",
          description: "Laurentian-Acadian Calcareous Cliff and Talus",
        },
        {
          value: 9116,
          color: "d8d8bf",
          description: "Laurentian-Acadian Calcareous Rocky Outcrop Woodland",
        },
        {
          value: 9117,
          color: "3289a8",
          description: "Laurentian-Acadian Floodplain Forest",
        },
        {
          value: 9118,
          color: "ff5c26",
          description: "Laurentian-Acadian Freshwater Marsh",
        },
        {
          value: 9119,
          color: "646464",
          description: "Laurentian-Acadian Lakeshore Beach",
        },
        {
          value: 9120,
          color: "ff5c26",
          description: "Laurentian-Acadian Wet Meadow",
        },
        {
          value: 9121,
          color: "917554",
          description: "Llano Estacado Caprock Escarpment and Breaks Shrubland and Steppe",
        },
        {
          value: 9122,
          color: "646464",
          description: "Louisiana Beach",
        },
        {
          value: 9125,
          color: "646464",
          description: "Mediterranean California Alpine Bedrock and Scree",
        },
        {
          value: 9129,
          color: "51b48d",
          description: "Mediterranean California Foothill and Lower Montane Riparian Woodland",
        },
        {
          value: 9130,
          color: "646464",
          description: "Mediterranean California Northern Coastal Dune",
        },
        {
          value: 9133,
          color: "51b48d",
          description: "Mediterranean California Serpentine Foothill and Lower Montane Riparian Woodland and Seep",
        },
        {
          value: 9134,
          color: "646464",
          description: "Mediterranean California Southern Coastal Dune",
        },
        {
          value: 9136,
          color: "ff9900",
          description: "Mississippi Delta Fresh and Oligohaline Tidal Marsh",
        },
        {
          value: 9137,
          color: "ff9900",
          description: "Mississippi Delta Salt and Brackish Tidal Marsh",
        },
        {
          value: 9138,
          color: "d8d8bf",
          description: "Mississippi River Bottomland Depression",
        },
        {
          value: 9139,
          color: "64ccce",
          description: "Mississippi River High Floodplain (Bottomland) Forest",
        },
        {
          value: 9140,
          color: "78c878",
          description: "Mississippi River Low Floodplain (Bottomland) Forest",
        },
        {
          value: 9141,
          color: "19a0b4",
          description: "Mississippi River Riparian Forest",
        },
        {
          value: 9142,
          color: "ff9900",
          description: "Mississippi Sound Fresh and Oligohaline Tidal Marsh",
        },
        {
          value: 9143,
          color: "ff9900",
          description: "Mississippi Sound Salt and Brackish Tidal Marsh",
        },
        {
          value: 9145,
          color: "646464",
          description: "North American Warm Desert Active and Stabilized Dune",
        },
        {
          value: 9146,
          color: "646464",
          description: "North American Warm Desert Badland",
        },
        {
          value: 9147,
          color: "646464",
          description: "North American Warm Desert Bedrock Cliff and Outcrop",
        },
        {
          value: 9148,
          color: "51b48d",
          description: "North American Warm Desert Cienega",
        },
        {
          value: 9150,
          color: "646464",
          description: "North American Warm Desert Pavement",
        },
        {
          value: 9151,
          color: "646464",
          description: "North American Warm Desert Playa",
        },
        {
          value: 9152,
          color: "51b48d",
          description: "North American Warm Desert Riparian Mesquite Bosque Woodland",
        },
        {
          value: 9153,
          color: "646464",
          description: "North American Warm Desert Volcanic Rockland",
        },
        {
          value: 9154,
          color: "51b48d",
          description: "North American Warm Desert Wash Woodland",
        },
        {
          value: 9160,
          color: "646464",
          description: "North Pacific Active Volcanic Rock and Cinder Land",
        },
        {
          value: 9165,
          color: "43a2b5",
          description: "North Pacific Hardwood-Conifer Swamp",
        },
        {
          value: 9166,
          color: "523422",
          description: "North Pacific Herbaceous Bald and Bluff",
        },
        {
          value: 9167,
          color: "c9741e",
          description: "North Pacific Hypermaritime Herbaceous Headland",
        },
        {
          value: 9170,
          color: "008200",
          description: "North Pacific Lowland Mixed Hardwood-Conifer Forest",
        },
        {
          value: 9171,
          color: "646464",
          description: "North Pacific Maritime Coastal Sand Dune and Strand",
        },
        {
          value: 9173,
          color: "646464",
          description: "North-Central Appalachian Acidic Cliff and Talus",
        },
        {
          value: 9174,
          color: "005c00",
          description: "North-Central Appalachian Acidic Swamp",
        },
        {
          value: 9175,
          color: "646464",
          description: "North-Central Appalachian Circumneutral Cliff and Talus",
        },
        {
          value: 9176,
          color: "5bc3c7",
          description: "North-Central Appalachian Seepage Fen",
        },
        {
          value: 9177,
          color: "005c00",
          description: "North-Central Interior and Appalachian Acidic Peatland Woodland",
        },
        {
          value: 9178,
          color: "3289a8",
          description: "North-Central Interior and Appalachian Rich Swamp",
        },
        {
          value: 9179,
          color: "005c00",
          description: "North-Central Interior Floodplain Forest",
        },
        {
          value: 9180,
          color: "5bc3c7",
          description: "North-Central Interior Freshwater Marsh",
        },
        {
          value: 9181,
          color: "55bbc2",
          description: "North-Central Interior Quartzite Glade",
        },
        {
          value: 9182,
          color: "5bc3c7",
          description: "North-Central Interior Shrub Alkaline Fen",
        },
        {
          value: 9183,
          color: "5bc3c7",
          description: "North-Central Interior Shrub Swamp",
        },
        {
          value: 9184,
          color: "646464",
          description: "Northeastern Erosional Bluff",
        },
        {
          value: 9185,
          color: "ba360e",
          description: "Northern Appalachian-Acadian Conifer-Hardwood Acidic Swamp",
        },
        {
          value: 9186,
          color: "523422",
          description: "Northern Appalachian-Acadian Rocky Heath Outcrop Woodland",
        },
        {
          value: 9187,
          color: "d8d8bf",
          description: "Northern Atlantic Coastal Plain Basin Peat Swamp",
        },
        {
          value: 9188,
          color: "d8d8bf",
          description: "Northern Atlantic Coastal Plain Basin Swamp and Wet Hardwood Forest",
        },
        {
          value: 9189,
          color: "ff9900",
          description: "Northern Atlantic Coastal Plain Brackish Tidal Marsh",
        },
        {
          value: 9190,
          color: "55bbc2",
          description: "Northern Atlantic Coastal Plain Calcareous Ravine",
        },
        {
          value: 9191,
          color: "ff9900",
          description: "Northern Atlantic Coastal Plain Fresh and Oligohaline Tidal Marsh",
        },
        {
          value: 9192,
          color: "91ff73",
          description: "Northern Atlantic Coastal Plain Pond",
        },
        {
          value: 9193,
          color: "646464",
          description: "Northern Atlantic Coastal Plain Sandy Beach",
        },
        {
          value: 9195,
          color: "005c00",
          description: "Northern Atlantic Coastal Plain Riparian and Floodplain Forest",
        },
        {
          value: 9197,
          color: "ff9900",
          description: "Northern Atlantic Coastal Plain Tidal Salt Marsh",
        },
        {
          value: 9198,
          color: "d8d8bf",
          description: "Northern Atlantic Coastal Plain Tidal Swamp",
        },
        {
          value: 9202,
          color: "ff5c26",
          description: "Northern Great Lakes Coastal Marsh",
        },
        {
          value: 9203,
          color: "ff5c26",
          description: "Northern Great Lakes Interdunal Wetland",
        },
        {
          value: 9207,
          color: "005c00",
          description: "Ozark-Ouachita Riparian Forest",
        },
        {
          value: 9208,
          color: "74d6cc",
          description: "Panhandle Florida Limestone Glade",
        },
        {
          value: 9209,
          color: "005c00",
          description: "Piedmont Seepage Wetland",
        },
        {
          value: 9210,
          color: "91ff73",
          description: "Piedmont Upland Depression Swamp",
        },
        {
          value: 9211,
          color: "91ff73",
          description: "Red River Large Floodplain Forest",
        },
        {
          value: 9213,
          color: "646464",
          description: "Sierra Nevada Cliff and Canyon",
        },
        {
          value: 9216,
          color: "5bc3c7",
          description: "South Florida Bayhead Swamp",
        },
        {
          value: 9218,
          color: "5bc3c7",
          description: "South Florida Hydric Hammock",
        },
        {
          value: 9220,
          color: "91ff73",
          description: "South Florida Pond-apple/Popash Slough",
        },
        {
          value: 9221,
          color: "646464",
          description: "South Florida Shell Hash Beach",
        },
        {
          value: 9222,
          color: "91ff73",
          description: "South Florida Slough Gator Hole and Willow Head Herbaceous",
        },
        {
          value: 9223,
          color: "005c00",
          description: "South-Central Interior Large Floodplain Forest",
        },
        {
          value: 9224,
          color: "005c00",
          description: "South-Central Interior Small Stream and Riparian Forest",
        },
        {
          value: 9226,
          color: "646464",
          description: "Southeast Florida Beach",
        },
        {
          value: 9227,
          color: "646464",
          description: "Southeastern Coastal Plain Cliff",
        },
        {
          value: 9228,
          color: "ff9900",
          description: "Southeastern Coastal Plain Interdunal Wetland",
        },
        {
          value: 9229,
          color: "5bc3c7",
          description: "Southeastern Coastal Plain Natural Lakeshore",
        },
        {
          value: 9230,
          color: "005c00",
          description: "Southeastern Great Plains Floodplain Forest and Woodland",
        },
        {
          value: 9231,
          color: "005c00",
          description: "Southeastern Great Plains Riparian Forest and Woodland",
        },
        {
          value: 9232,
          color: "005c00",
          description: "Southern and Central Appalachian Bog and Fen",
        },
        {
          value: 9233,
          color: "002673",
          description: "Southern and Central Appalachian Mafic Glade and Barrens",
        },
        {
          value: 9234,
          color: "646464",
          description: "Southern Appalachian Granitic Dome",
        },
        {
          value: 9237,
          color: "5bc3c7",
          description: "Southern Appalachian Seepage Wetland",
        },
        {
          value: 9239,
          color: "ff9900",
          description: "Southern Atlantic Coastal Plain Depression Pondshore",
        },
        {
          value: 9240,
          color: "646464",
          description: "Southern Atlantic Coastal Plain Florida Beach",
        },
        {
          value: 9241,
          color: "ff9900",
          description: "Southern Atlantic Coastal Plain Fresh and Oligohaline Tidal Marsh",
        },
        {
          value: 9242,
          color: "91ff73",
          description: "Southern Atlantic Coastal Plain Large River Floodplain Forest",
        },
        {
          value: 9243,
          color: "ff9900",
          description: "Southern Atlantic Coastal Plain Salt and Brackish Tidal Marsh",
        },
        {
          value: 9244,
          color: "646464",
          description: "Southern Atlantic Coastal Plain Sea Island Beach",
        },
        {
          value: 9245,
          color: "d8d8bf",
          description: "Southern Atlantic Coastal Plain Tidal Wooded Swamp",
        },
        {
          value: 9246,
          color: "646464",
          description: "Southern California Coast Ranges Cliff and Canyon",
        },
        {
          value: 9247,
          color: "91ff73",
          description: "Southern Coastal Plain Blackwater River Floodplain Forest",
        },
        {
          value: 9248,
          color: "d8d8bf",
          description: "Southern Coastal Plain Hydric Hammock",
        },
        {
          value: 9249,
          color: "d8d8bf",
          description: "Southern Coastal Plain Nonriverine Basin Swamp",
        },
        {
          value: 9250,
          color: "91ff73",
          description: "Southern Coastal Plain Oak Dome and Hammock",
        },
        {
          value: 9251,
          color: "646464",
          description: "Southern Coastal Plain Sinkhole",
        },
        {
          value: 9256,
          color: "002673",
          description: "Southern Piedmont Glade and Barrens",
        },
        {
          value: 9257,
          color: "646464",
          description: "Southern Piedmont Granite Flatrock and Outcrop",
        },
        {
          value: 9258,
          color: "005c00",
          description: "Southern Piedmont Large Floodplain Forest",
        },
        {
          value: 9259,
          color: "005c00",
          description: "Southern Piedmont Small Floodplain and Riparian Forest",
        },
        {
          value: 9260,
          color: "002673",
          description: "Southern Ridge and Valley Calcareous Glade and Woodland",
        },
        {
          value: 9261,
          color: "5bc3c7",
          description: "Southern Ridge and Valley Seepage Fen",
        },
        {
          value: 9262,
          color: "646464",
          description: "Southwest Florida Beach",
        },
        {
          value: 9265,
          color: "646464",
          description: "Southwestern Great Plains Canyon",
        },
        {
          value: 9266,
          color: "5bc3c7",
          description: "Tamaulipan Closed Depression Wetland Woodland",
        },
        {
          value: 9268,
          color: "06357a",
          description: "Tamaulipan Ramadero",
        },
        {
          value: 9270,
          color: "523422",
          description: "Tamaulipan Saline Thornscrub",
        },
        {
          value: 9272,
          color: "ff7f3b",
          description: "Temperate Pacific Subalpine-Montane Wet Meadow",
        },
        {
          value: 9273,
          color: "646464",
          description: "Texas Coast Beach",
        },
        {
          value: 9274,
          color: "ff9900",
          description: "Texas Coast Fresh and Oligohaline Tidal Marsh",
        },
        {
          value: 9275,
          color: "ff9900",
          description: "Texas Coast Salt and Brackish Tidal Marsh",
        },
        {
          value: 9282,
          color: "91ff73",
          description: "West Gulf Coastal Plain Large River Floodplain Forest",
        },
        {
          value: 9283,
          color: "d8d8bf",
          description: "West Gulf Coastal Plain Near-Coast Large River Swamp",
        },
        {
          value: 9284,
          color: "91ff73",
          description: "West Gulf Coastal Plain Small Stream and River Forest",
        },
        {
          value: 9288,
          color: "55bbc2",
          description: "Northeastern Interior Calcareous Oak Forest",
        },
        {
          value: 9289,
          color: "00ed00",
          description: "Madrean Mesic Canyon Forest and Woodland",
        },
        {
          value: 9290,
          color: "646464",
          description: "Southeastern Great Plains Cliff",
        },
        {
          value: 9295,
          color: "aef5e0",
          description: "Laurentian-Acadian Sub-boreal Dry-Mesic Pine-Black Spruce-Hardwood Forest",
        },
        {
          value: 9301,
          color: "ff692e",
          description: "California Ruderal Grassland and Meadow",
        },
        {
          value: 9302,
          color: "ff3b14",
          description: "Californian Ruderal Forest",
        },
        {
          value: 9303,
          color: "91ff73",
          description: "Caribbean & Mesoamerican Lowland Ruderal Shrubland",
        },
        {
          value: 9304,
          color: "00de00",
          description: "Caribbean Forest Plantation",
        },
        {
          value: 9305,
          color: "00de00",
          description: "Caribbean Ruderal Dry Forest",
        },
        {
          value: 9307,
          color: "ff692e",
          description: "Great Basin & Intermountain Introduced Annual and Biennial Forbland",
        },
        {
          value: 9308,
          color: "ff692e",
          description: "Great Basin & Intermountain Introduced Annual Grassland",
        },
        {
          value: 9309,
          color: "ff692e",
          description: "Great Basin & Intermountain Introduced Perennial Grassland and Forbland",
        },
        {
          value: 9310,
          color: "ff692e",
          description: "North American Warm Desert Ruderal & Planted Scrub",
        },
        {
          value: 9311,
          color: "ff692e",
          description: "North Pacific Maritime Coastal Sand Dune Ruderal Scrub",
        },
        {
          value: 9312,
          color: "9e430e",
          description: "Northeastern North American Temperate Forest Plantation",
        },
        {
          value: 9314,
          color: "ff692e",
          description: "Northern & Central Native Ruderal Flooded & Swamp Forest",
        },
        {
          value: 9315,
          color: "ff692e",
          description: "Northern & Central Native Ruderal Forest",
        },
        {
          value: 9316,
          color: "ff692e",
          description: "Northern & Central Plains Ruderal & Planted Shrubland",
        },
        {
          value: 9317,
          color: "ff692e",
          description: "Northern & Central Ruderal Shrubland",
        },
        {
          value: 9318,
          color: "ff692e",
          description: "Northern & Central Ruderal Wet Meadow & Marsh",
        },
        {
          value: 9319,
          color: "ff692e",
          description: "Southeastern Exotic Ruderal Forest",
        },
        {
          value: 9320,
          color: "0084a8",
          description: "Southeastern Native Ruderal Flooded & Swamp Forest",
        },
        {
          value: 9321,
          color: "ff692e",
          description: "Southeastern Native Ruderal Forest",
        },
        {
          value: 9322,
          color: "9e430e",
          description: "Southeastern North American Temperate Forest Plantation",
        },
        {
          value: 9323,
          color: "ff692e",
          description: "Southeastern Ruderal Shrubland",
        },
        {
          value: 9324,
          color: "ff692e",
          description: "Southeastern Ruderal Wet Meadow & Marsh",
        },
        {
          value: 9325,
          color: "ff692e",
          description: "Great Plains Comanchian Ruderal Shrubland",
        },
        {
          value: 9326,
          color: "ff692e",
          description: "Southern Vancouverian Lowland Ruderal Shrubland",
        },
        {
          value: 9327,
          color: "ff692e",
          description: "Interior West Ruderal Riparian Forest",
        },
        {
          value: 9328,
          color: "ff692e",
          description: "Interior Western North American Temperate Ruderal Shrubland",
        },
        {
          value: 9329,
          color: "ff692e",
          description: "Western North American Ruderal Wet Shrubland",
        },
        {
          value: 9332,
          color: "0084a8",
          description: "Southeastern Exotic Ruderal Flooded & Swamp Forest",
        },
        {
          value: 9336,
          color: "ff692e",
          description: "Great Basin & Intermountain Ruderal Shrubland",
        },
        {
          value: 9337,
          color: "ff692e",
          description: "California Ruderal Scrub",
        },
        {
          value: 9340,
          color: "00de00",
          description: "Caribbean Lowland Ruderal Rainforest",
        },
        {
          value: 9341,
          color: "00de00",
          description: "Caribbean Montane Ruderal Forest",
        },
        {
          value: 9343,
          color: "ff692e",
          description: "Hawaiian Montane Ruderal Forest & Woodland",
        },
        {
          value: 9344,
          color: "ff692e",
          description: "Hawaiian Ruderal Coastal Salt Marsh",
        },
        {
          value: 9345,
          color: "ff692e",
          description: "Hawaiian Ruderal Flooded & Swamp Forest",
        },
        {
          value: 9346,
          color: "ff692e",
          description: "Hawaiian Ruderal Freshwater Wet Meadow & Marsh",
        },
        {
          value: 9347,
          color: "00ed00",
          description: "Hawaiian Ruderal Mangrove",
        },
        {
          value: 9348,
          color: "ff692e",
          description: "Polynesian Ruderal Dry Woodland",
        },
        {
          value: 9349,
          color: "ff692e",
          description: "Polynesian Ruderal Lowland Rainforest",
        },
        {
          value: 9350,
          color: "ff692e",
          description: "Polynesian Ruderal Lowland Shrubland",
        },
        {
          value: 9351,
          color: "ff692e",
          description: "Polynesian Ruderal Scrub Coastal Strand",
        },
        {
          value: 9352,
          color: "ff692e",
          description: "Polynesian Ruderal Subalpine-Montane Shrubland",
        },
        {
          value: 9353,
          color: "9e430e",
          description: "Tropical Pacific Forest Plantation",
        },
        {
          value: 9354,
          color: "705239",
          description: "Caribbean Ruderal Freshwater Wet Meadow & Marsh",
        },
        {
          value: 9355,
          color: "00de00",
          description: "Tropical Agroforestry Plantation",
        },
        {
          value: 9502,
          color: "49abba",
          description: "Columbia Basin Foothill Riparian Shrubland",
        },
        {
          value: 9503,
          color: "49abba",
          description: "Great Basin Foothill and Lower Montane Riparian Shrubland",
        },
        {
          value: 9504,
          color: "49abba",
          description: "Columbia Basin Foothill Riparian Herbaceous",
        },
        {
          value: 9505,
          color: "49abba",
          description: "Great Basin Foothill and Lower Montane Riparian Herbaceous",
        },
        {
          value: 9512,
          color: "49abba",
          description: "Northern Rocky Mountain Lower Montane Riparian Shrubland",
        },
        {
          value: 9513,
          color: "06357a",
          description: "Northwestern Great Plains Floodplain Shrubland",
        },
        {
          value: 9514,
          color: "06357a",
          description: "Northwestern Great Plains Floodplain Herbaceous",
        },
        {
          value: 9515,
          color: "06357a",
          description: "Northwestern Great Plains Riparian Shrubland",
        },
        {
          value: 9516,
          color: "06357a",
          description: "Northwestern Great Plains Riparian Herbaceous",
        },
        {
          value: 9519,
          color: "49abba",
          description: "Rocky Mountain Lower Montane-Foothill Riparian Shrubland",
        },
        {
          value: 9526,
          color: "06357a",
          description: "Western Great Plains Floodplain Shrubland",
        },
        {
          value: 9527,
          color: "06357a",
          description: "Western Great Plains Floodplain Herbaceous",
        },
        {
          value: 9528,
          color: "06357a",
          description: "Western Great Plains Riparian Shrubland",
        },
        {
          value: 9529,
          color: "06357a",
          description: "Western Great Plains Riparian Herbaceous",
        },
        {
          value: 9533,
          color: "51b48d",
          description: "North American Warm Desert Riparian Herbaceous",
        },
        {
          value: 9534,
          color: "51b48d",
          description: "North American Warm Desert Riparian Shrubland",
        },
        {
          value: 9535,
          color: "51b48d",
          description: "North American Warm Desert Lower Montane Riparian Shrubland",
        },
        {
          value: 9541,
          color: "91ff73",
          description: "Atlantic Coastal Plain Blackwater Stream Floodplain Shrubland",
        },
        {
          value: 9542,
          color: "91ff73",
          description: "Atlantic Coastal Plain Blackwater Stream Floodplain Herbaceous",
        },
        {
          value: 9559,
          color: "005c00",
          description: "Central Appalachian River Floodplain Shrubland",
        },
        {
          value: 9560,
          color: "005c00",
          description: "Central Appalachian Stream and Riparian Shrubland",
        },
        {
          value: 9561,
          color: "005c00",
          description: "Central Appalachian River Floodplain Herbaceous",
        },
        {
          value: 9562,
          color: "005c00",
          description: "Central Appalachian Stream and Riparian Herbaceous",
        },
        {
          value: 9568,
          color: "91ff73",
          description: "Central Texas Coastal Prairie Riparian Shrubland",
        },
        {
          value: 9569,
          color: "91ff73",
          description: "Central Texas Coastal Prairie River Floodplain Shrubland",
        },
        {
          value: 9570,
          color: "91ff73",
          description: "Central Texas Coastal Prairie Riparian Herbaceous",
        },
        {
          value: 9571,
          color: "91ff73",
          description: "Central Texas Coastal Prairie River Floodplain Herbaceous",
        },
        {
          value: 9582,
          color: "91ff73",
          description: "East Gulf Coastal Plain Large River Floodplain Shrubland",
        },
        {
          value: 9583,
          color: "91ff73",
          description: "East Gulf Coastal Plain Large River Floodplain Herbaceous",
        },
        {
          value: 9585,
          color: "91ff73",
          description: "East Gulf Coastal Plain Small Stream and River Floodplain Shrubland",
        },
        {
          value: 9586,
          color: "91ff73",
          description: "East Gulf Coastal Plain Small Stream and River Floodplain Herbaceous",
        },
        {
          value: 9592,
          color: "06357a",
          description: "Edwards Plateau Floodplain Terrace Shrubland",
        },
        {
          value: 9593,
          color: "06357a",
          description: "Edwards Plateau Floodplain Terrace Herbaceous",
        },
        {
          value: 9601,
          color: "ff6229",
          description: "Great Lakes Dune Grassland",
        },
        {
          value: 9604,
          color: "ff9900",
          description: "Gulf Coast Chenier Plain Fresh and Oligohaline Tidal Marsh Shrubland",
        },
        {
          value: 9605,
          color: "ff9900",
          description: "Gulf Coast Chenier Plain Salt and Brackish Tidal Marsh Shrubland",
        },
        {
          value: 9611,
          color: "aef5e0",
          description: "Laurentian Acidic Rocky Outcrop Shrubland",
        },
        {
          value: 9616,
          color: "d8d8bf",
          description: "Laurentian-Acadian Calcareous Rocky Outcrop Shrubland",
        },
        {
          value: 9617,
          color: "3289a8",
          description: "Laurentian-Acadian Floodplain Shrubland",
        },
        {
          value: 9620,
          color: "ff5c26",
          description: "Laurentian-Acadian Shrub Swamp",
        },
        {
          value: 9629,
          color: "51b48d",
          description: "Mediterranean California Foothill and Lower Montane Riparian Shrubland",
        },
        {
          value: 9633,
          color: "51b48d",
          description: "Mediterranean California Serpentine Foothill and Lower Montane Riparian Shrubland and Seep",
        },
        {
          value: 9639,
          color: "64ccce",
          description: "Mississippi River High Floodplain (Bottomland) Shrubland",
        },
        {
          value: 9640,
          color: "78c878",
          description: "Mississippi River Low Floodplain (Bottomland) Shrubland",
        },
        {
          value: 9641,
          color: "64ccce",
          description: "Mississippi River High Floodplain (Bottomland) Herbaceous",
        },
        {
          value: 9642,
          color: "78c878",
          description: "Mississippi River Low Floodplain (Bottomland) Herbaceous",
        },
        {
          value: 9652,
          color: "51b48d",
          description: "North American Warm Desert Riparian Mesquite Bosque Shrubland",
        },
        {
          value: 9654,
          color: "51b48d",
          description: "North American Warm Desert Wash Shrubland",
        },
        {
          value: 9667,
          color: "c9741e",
          description: "North Pacific Hypermaritime Shrub Headland",
        },
        {
          value: 9677,
          color: "005c00",
          description: "North-Central Interior and Appalachian Acidic Peatland Shrubland",
        },
        {
          value: 9679,
          color: "005c00",
          description: "North-Central Interior Floodplain Shrubland",
        },
        {
          value: 9682,
          color: "5bc3c7",
          description: "North-Central Interior Graminoid Alkaline Fen",
        },
        {
          value: 9683,
          color: "5bc3c7",
          description: "North-Central Interior Wet Meadow",
        },
        {
          value: 9686,
          color: "523422",
          description: "Northern Appalachian-Acadian Rocky Heath Outcrop Shrubland",
        },
        {
          value: 9695,
          color: "005c00",
          description: "Northern Atlantic Coastal Plain Riparian and Floodplain Shrubland",
        },
        {
          value: 9696,
          color: "005c00",
          description: "Northern Atlantic Coastal Plain Riparian and Floodplain Herbaceous",
        },
        {
          value: 9707,
          color: "005c00",
          description: "Ozark-Ouachita Riparian Shrubland",
        },
        {
          value: 9708,
          color: "005c00",
          description: "Ozark-Ouachita Riparian Herbaceous",
        },
        {
          value: 9722,
          color: "91ff73",
          description: "South Florida Slough Gator Hole and Willow Head Woodland",
        },
        {
          value: 9723,
          color: "005c00",
          description: "South-Central Interior Large Floodplain Shrubland",
        },
        {
          value: 9724,
          color: "005c00",
          description: "South-Central Interior Small Stream and Riparian Shrubland",
        },
        {
          value: 9725,
          color: "005c00",
          description: "South-Central Interior Large Floodplain Herbaceous",
        },
        {
          value: 9726,
          color: "005c00",
          description: "South-Central Interior Small Stream and Riparian Herbaceous",
        },
        {
          value: 9730,
          color: "005c00",
          description: "Southeastern Great Plains Floodplain Shrubland",
        },
        {
          value: 9731,
          color: "005c00",
          description: "Southeastern Great Plains Riparian Shrubland",
        },
        {
          value: 9732,
          color: "005c00",
          description: "Southeastern Great Plains Floodplain Herbaceous",
        },
        {
          value: 9733,
          color: "005c00",
          description: "Southeastern Great Plains Riparian Herbaceous",
        },
        {
          value: 9742,
          color: "91ff73",
          description: "Southern Atlantic Coastal Plain Large River Floodplain Shrubland",
        },
        {
          value: 9743,
          color: "91ff73",
          description: "Southern Atlantic Coastal Plain Large River Floodplain Herbaceous",
        },
        {
          value: 9758,
          color: "005c00",
          description: "Southern Piedmont Large Floodplain Shrubland",
        },
        {
          value: 9759,
          color: "005c00",
          description: "Southern Piedmont Small Floodplain and Riparian Shrubland",
        },
        {
          value: 9760,
          color: "005c00",
          description: "Southern Piedmont Large Floodplain Herbaceous",
        },
        {
          value: 9761,
          color: "005c00",
          description: "Southern Piedmont Small Floodplain and Riparian Herbaceous",
        },
        {
          value: 9766,
          color: "5bc3c7",
          description: "Tamaulipan Closed Depression Wetland Shrubland",
        },
        {
          value: 9774,
          color: "ff9900",
          description: "Texas Coast Fresh and Oligohaline Tidal Marsh Shrubland",
        },
        {
          value: 9775,
          color: "ff9900",
          description: "Texas Coast Salt and Brackish Tidal Marsh Shrubland",
        },
        {
          value: 9782,
          color: "91ff73",
          description: "West Gulf Coastal Plain Large River Floodplain Shrubland",
        },
        {
          value: 9783,
          color: "91ff73",
          description: "West Gulf Coastal Plain Large River Floodplain Herbaceous",
        },
        {
          value: 9784,
          color: "91ff73",
          description: "West Gulf Coastal Plain Small Stream and River Shrubland",
        },
        {
          value: 9785,
          color: "91ff73",
          description: "West Gulf Coastal Plain Small Stream and River Herbaceous",
        },
        {
          value: 9803,
          color: "74d6cc",
          description: "Caribbean & Mesoamerican Lowland Ruderal Grassland",
        },
        {
          value: 9810,
          color: "ff692e",
          description: "North American Warm Desert Ruderal & Planted Grassland",
        },
        {
          value: 9811,
          color: "ff692e",
          description: "North Pacific Maritime Coastal Sand Dune Ruderal Herb Vegetation",
        },
        {
          value: 9816,
          color: "ff692e",
          description: "Northern & Central Plains Ruderal & Planted Grassland",
        },
        {
          value: 9817,
          color: "ff692e",
          description: "Northern & Central Ruderal Meadow",
        },
        {
          value: 9823,
          color: "ff692e",
          description: "Southeastern Ruderal Grassland",
        },
        {
          value: 9825,
          color: "ff692e",
          description: "Great Plains Comanchian Ruderal Grassland",
        },
        {
          value: 9826,
          color: "ff692e",
          description: "Southern Vancouverian Lowland Ruderal Grassland",
        },
        {
          value: 9827,
          color: "ff692e",
          description: "Interior West Ruderal Riparian Scrub",
        },
        {
          value: 9828,
          color: "ff692e",
          description: "Interior Western North American Temperate Ruderal Grassland",
        },
        {
          value: 9829,
          color: "ff692e",
          description: "Western North American Ruderal Wet Meadow & Marsh",
        },
        {
          value: 9848,
          color: "ff692e",
          description: "Polynesian Ruderal Dry Scrub",
        },
        {
          value: 9850,
          color: "ff692e",
          description: "Polynesian Ruderal Lowland Grassland",
        },
        {
          value: 9851,
          color: "ff692e",
          description: "Polynesian Ruderal Herb Coastal Strand",
        },
        {
          value: 9852,
          color: "ff692e",
          description: "Polynesian Ruderal Subalpine-Montane Grassland",
        },
        {
          value: 9993,
          color: "ff9900",
          description: "West Gulf Coastal Plain Flatwoods Pond",
        },
        {
          value: 9994,
          color: "ff9900",
          description: "West Gulf Coastal Plain Herbaceous Seep and Bog",
        },
      ],
    },
    {
      name: "EVT_GP",
      description: "Code that represents the vegetation type group, a more general category than EVT. A categorical view derived from EVT.",
      "gee:units": units.dimensionless,
      "gee:classes": [
        {
          value: 11,
          color: "0000ff",
          description: "Open Water",
        },
        {
          value: 12,
          color: "9fa1f0",
          description: "Snow-Ice",
        },
        {
          value: 13,
          color: "704489",
          description: "Developed-Upland Deciduous Forest",
        },
        {
          value: 14,
          color: "aa66cd",
          description: "Developed-Upland Evergreen Forest",
        },
        {
          value: 15,
          color: "c29ed7",
          description: "Developed-Upland Mixed Forest",
        },
        {
          value: 16,
          color: "ca7af5",
          description: "Developed-Upland Herbaceous",
        },
        {
          value: 17,
          color: "cfabd7",
          description: "Developed-Upland Shrubland",
        },
        {
          value: 21,
          color: "343434",
          description: "Developed-Open Space",
        },
        {
          value: 22,
          color: "ff7a8f",
          description: "Developed-Low Intensity",
        },
        {
          value: 23,
          color: "fd2c4f",
          description: "Developed-Medium Intensity",
        },
        {
          value: 24,
          color: "ad001c",
          description: "Developed-High Intensity",
        },
        {
          value: 25,
          color: "010101",
          description: "Developed-Roads",
        },
        {
          value: 32,
          color: "e6e8fa",
          description: "Quarries-Strip Mines-Gravel Pits-Well and Wind Pads",
        },
        {
          value: 60,
          color: "d21c5e",
          description: "Agricultural-Orchard",
        },
        {
          value: 61,
          color: "a80084",
          description: "Agricultural-Vineyard",
        },
        {
          value: 62,
          color: "d21c77",
          description: "Agricultural-Bush fruit and berries",
        },
        {
          value: 63,
          color: "fff58c",
          description: "Agricultural-Row Crop-Close Grown Crop",
        },
        {
          value: 64,
          color: "faff77",
          description: "Agricultural-Row Crop",
        },
        {
          value: 65,
          color: "ffed77",
          description: "Agricultural-Close Grown Crop",
        },
        {
          value: 66,
          color: "ffff77",
          description: "Agricultural-Fallow/Idle Cropland",
        },
        {
          value: 67,
          color: "e3d41c",
          description: "Agricultural-Pasture and Hayland",
        },
        {
          value: 68,
          color: "fae3a3",
          description: "Agricultural-Wheat",
        },
        {
          value: 69,
          color: "d2ffed",
          description: "Agricultural-Aquaculture",
        },
        {
          value: 70,
          color: "faff77",
          description: "Agricultural-Sugar cane",
        },
        {
          value: 81,
          color: "e3d41c",
          description: "Agriculture-Pasture and Hay",
        },
        {
          value: 82,
          color: "faff77",
          description: "Agriculture-Cultivated Crops and Irrigated Agriculture",
        },
        {
          value: 601,
          color: "ffd377",
          description: "Alpine Dwarf-Shrubland, Fell-field and Meadow",
        },
        {
          value: 602,
          color: "c0ff8a",
          description: "Aspen Forest, Woodland, and Parkland",
        },
        {
          value: 603,
          color: "c0ff8a",
          description: "Aspen-Mixed Conifer Forest and Woodland",
        },
        {
          value: 604,
          color: "826548",
          description: "Big Sagebrush Shrubland and Steppe",
        },
        {
          value: 605,
          color: "abff8a",
          description: "Bigtooth Maple Woodland",
        },
        {
          value: 606,
          color: "8c7050",
          description: "Blackbrush Shrubland",
        },
        {
          value: 607,
          color: "e0fcc0",
          description: "Chaparral",
        },
        {
          value: 609,
          color: "a68b6b",
          description: "Pacific Coastal Scrub",
        },
        {
          value: 610,
          color: "00ed00",
          description: "Conifer-Oak Forest and Woodland",
        },
        {
          value: 611,
          color: "a18660",
          description: "Creosotebush Desert Scrub",
        },
        {
          value: 612,
          color: "806145",
          description: "Deciduous Shrubland",
        },
        {
          value: 613,
          color: "c7b081",
          description: "Desert Scrub",
        },
        {
          value: 614,
          color: "008200",
          description: "Douglas-fir Forest and Woodland",
        },
        {
          value: 615,
          color: "006900",
          description: "Douglas-fir-Western Hemlock Forest and Woodland",
        },
        {
          value: 616,
          color: "ffd377",
          description: "Dry Tundra",
        },
        {
          value: 617,
          color: "ffeb99",
          description: "Grassland",
        },
        {
          value: 618,
          color: "ffcc33",
          description: "Grassland and Steppe",
        },
        {
          value: 619,
          color: "c2aa7e",
          description: "Greasewood Shrubland",
        },
        {
          value: 620,
          color: "6cff52",
          description: "Juniper Woodland and Savanna",
        },
        {
          value: 621,
          color: "3fff2e",
          description: "Limber Pine Woodland",
        },
        {
          value: 622,
          color: "a3f0db",
          description: "Lodgepole Pine Forest and Woodland",
        },
        {
          value: 623,
          color: "ccb687",
          description: "Low Sagebrush Shrubland and Steppe",
        },
        {
          value: 624,
          color: "967b59",
          description: "Mesquite Woodland and Scrub",
        },
        {
          value: 625,
          color: "00de00",
          description: "Douglas-fir-Ponderosa Pine-Lodgepole Pine Forest and Woodland",
        },
        {
          value: 626,
          color: "91ff73",
          description: "California Mixed Evergreen Forest and Woodland",
        },
        {
          value: 627,
          color: "005c00",
          description: "Mountain Hemlock Forest and Woodland",
        },
        {
          value: 628,
          color: "9bebd8",
          description: "Mountain Mahogany Woodland and Shrubland",
        },
        {
          value: 629,
          color: "cbffab",
          description: "Western Oak Woodland and Savanna",
        },
        {
          value: 630,
          color: "79ff5e",
          description: "Pinyon-Juniper Woodland",
        },
        {
          value: 631,
          color: "00ad00",
          description: "Ponderosa Pine Forest, Woodland and Savanna",
        },
        {
          value: 632,
          color: "92e8d7",
          description: "Red Alder Forest and Woodland",
        },
        {
          value: 633,
          color: "009e00",
          description: "Red Fir Forest and Woodland",
        },
        {
          value: 634,
          color: "87ff69",
          description: "Redwood Forest and Woodland",
        },
        {
          value: 635,
          color: "51b48d",
          description: "Western Riparian Woodland and Shrubland",
        },
        {
          value: 636,
          color: "c2aa7e",
          description: "Salt Desert Scrub",
        },
        {
          value: 637,
          color: "705239",
          description: "Sand Shrubland",
        },
        {
          value: 638,
          color: "007500",
          description: "Sitka Spruce Forest",
        },
        {
          value: 639,
          color: "b6fae3",
          description: "Spruce-Fir Forest and Woodland",
        },
        {
          value: 640,
          color: "009100",
          description: "Subalpine Woodland and Parkland",
        },
        {
          value: 641,
          color: "917554",
          description: "Succulent Desert Scrub",
        },
        {
          value: 642,
          color: "004700",
          description: "Western Hemlock-Silver Fir Forest",
        },
        {
          value: 643,
          color: "60ff47",
          description: "Douglas-fir-Grand Fir-White Fir Forest and Woodland",
        },
        {
          value: 644,
          color: "b4ff94",
          description: "Western Larch Forest and Woodland",
        },
        {
          value: 645,
          color: "2aff1f",
          description: "Western Red-cedar-Western Hemlock Forest",
        },
        {
          value: 646,
          color: "fff18c",
          description: "Mixedgrass Prairie",
        },
        {
          value: 647,
          color: "ff9447",
          description: "Sand Prairie",
        },
        {
          value: 648,
          color: "ff8e42",
          description: "Shortgrass Prairie",
        },
        {
          value: 649,
          color: "ff8940",
          description: "Tallgrass Prairie",
        },
        {
          value: 650,
          color: "5bc3c7",
          description: "Depressional Wetland",
        },
        {
          value: 651,
          color: "523422",
          description: "Alpine-Subalpine Barrens",
        },
        {
          value: 652,
          color: "c0ff8a",
          description: "Aspen-Birch Forest",
        },
        {
          value: 653,
          color: "ff9900",
          description: "Atlantic Coastal Marsh",
        },
        {
          value: 654,
          color: "ff6229",
          description: "Atlantic Dunes and Grasslands",
        },
        {
          value: 655,
          color: "005c00",
          description: "Beech-Maple-Basswood Forest",
        },
        {
          value: 656,
          color: "91ff73",
          description: "Texas Live Oak",
        },
        {
          value: 657,
          color: "5bc3c7",
          description: "Cypress",
        },
        {
          value: 658,
          color: "55bbc2",
          description: "Coastal Plain Oak Forest",
        },
        {
          value: 659,
          color: "06357a",
          description: "Bur Oak Woodland and Savanna",
        },
        {
          value: 660,
          color: "55bbc2",
          description: "White Oak-Red Oak-Hickory Forest and Woodland",
        },
        {
          value: 661,
          color: "0d4585",
          description: "Chestnut Oak Forest and Woodland",
        },
        {
          value: 662,
          color: "55bbc2",
          description: "Post Oak Woodland and Savanna",
        },
        {
          value: 663,
          color: "55bbc2",
          description: "Black Oak Woodland and Savanna",
        },
        {
          value: 664,
          color: "523422",
          description: "Chestnut Oak-Virginia Pine Forest and Woodland",
        },
        {
          value: 665,
          color: "aef5e0",
          description: "Red Pine-White Pine Forest and Woodland",
        },
        {
          value: 666,
          color: "3289a8",
          description: "Eastern Floodplain Forests",
        },
        {
          value: 667,
          color: "55bbc2",
          description: "White Oak-Beech Forest and Woodland",
        },
        {
          value: 668,
          color: "06357a",
          description: "Eastern Small Stream Riparian Forests",
        },
        {
          value: 669,
          color: "b86018",
          description: "Western Herbaceous Wetland",
        },
        {
          value: 670,
          color: "523422",
          description: "Glades and Barrens",
        },
        {
          value: 671,
          color: "d8d8bf",
          description: "Great Lakes Alvar",
        },
        {
          value: 672,
          color: "3c717e",
          description: "Hammocks",
        },
        {
          value: 673,
          color: "55bbc2",
          description: "Hardwood Flatwoods",
        },
        {
          value: 674,
          color: "f0a52e",
          description: "Heathland and Grassland",
        },
        {
          value: 675,
          color: "ff5c26",
          description: "Inland Marshes and Prairies",
        },
        {
          value: 676,
          color: "aef5e0",
          description: "Jack Pine Forest",
        },
        {
          value: 677,
          color: "74d6cc",
          description: "Longleaf Pine Woodland",
        },
        {
          value: 678,
          color: "5bc3c7",
          description: "Mangrove",
        },
        {
          value: 679,
          color: "6bd1ce",
          description: "Maritime Forest",
        },
        {
          value: 680,
          color: "91ff73",
          description: "Sweetgum-Water Oak Forest",
        },
        {
          value: 681,
          color: "55bbc2",
          description: "Montane Oak Forest",
        },
        {
          value: 682,
          color: "abff8a",
          description: "Yellow Birch-Sugar Maple Forest",
        },
        {
          value: 683,
          color: "852708",
          description: "Peatland Forests",
        },
        {
          value: 684,
          color: "0d4585",
          description: "Pine Flatwoods",
        },
        {
          value: 685,
          color: "005c00",
          description: "Pine-Hemlock-Hardwood Forest",
        },
        {
          value: 686,
          color: "0d4585",
          description: "Pitch Pine Woodlands",
        },
        {
          value: 687,
          color: "5bc3c7",
          description: "Pocosin",
        },
        {
          value: 688,
          color: "523422",
          description: "Prairies and Barrens",
        },
        {
          value: 689,
          color: "55bbc2",
          description: "Shortleaf Pine Woodland",
        },
        {
          value: 690,
          color: "74d6be",
          description: "Shortleaf Pine-Oak Forest and Woodland",
        },
        {
          value: 691,
          color: "91ff73",
          description: "Southern Scrub Oak",
        },
        {
          value: 692,
          color: "baa377",
          description: "Spruce Flats and Barrens",
        },
        {
          value: 693,
          color: "9fff80",
          description: "Spruce-Fir-Hardwood Forest",
        },
        {
          value: 694,
          color: "d8d8bf",
          description: "Atlantic Swamp Forests",
        },
        {
          value: 695,
          color: "0a3d80",
          description: "Virginia Pine Forest",
        },
        {
          value: 696,
          color: "00ed00",
          description: "Juniper-Oak",
        },
        {
          value: 699,
          color: "79ff5e",
          description: "Pinyon-Juniper Shrubland",
        },
        {
          value: 700,
          color: "646464",
          description: "Sparse Vegetation",
        },
        {
          value: 701,
          color: "ff692e",
          description: "Introduced Riparian Vegetation",
        },
        {
          value: 702,
          color: "ff692e",
          description: "Introduced Annual Grassland",
        },
        {
          value: 703,
          color: "ff692e",
          description: "Introduced Perennial Grassland and Forbland",
        },
        {
          value: 704,
          color: "ff692e",
          description: "Introduced Annual and Biennial Forbland",
        },
        {
          value: 706,
          color: "ff692e",
          description: "Introduced Upland Vegetation-Shrub",
        },
        {
          value: 707,
          color: "ff3b14",
          description: "Introduced Upland Vegetation-Treed",
        },
        {
          value: 708,
          color: "0084a8",
          description: "Introduced Woody Wetland Vegetation",
        },
        {
          value: 709,
          color: "ff692e",
          description: "Introduced Herbaceous Wetland Vegetation",
        },
        {
          value: 710,
          color: "ff4419",
          description: "Transitional Herbaceous Vegetation",
        },
        {
          value: 720,
          color: "ff4419",
          description: "Transitional Shrub Vegetation",
        },
        {
          value: 730,
          color: "ff4419",
          description: "Transitional Forest Vegetation",
        },
        {
          value: 731,
          color: "9e430e",
          description: "Managed Tree Plantation",
        },
        {
          value: 740,
          color: "ff692e",
          description: "Ruderal Forest",
        },
        {
          value: 750,
          color: "92ede0",
          description: "Alder Shrubland",
        },
        {
          value: 751,
          color: "124c87",
          description: "Alpine Floodplain",
        },
        {
          value: 752,
          color: "92ede0",
          description: "Avalanche Slope Shrubland",
        },
        {
          value: 753,
          color: "124c87",
          description: "Balsam Poplar-Aspen Woodland",
        },
        {
          value: 754,
          color: "ff0000",
          description: "Beach Meadow",
        },
        {
          value: 756,
          color: "005c00",
          description: "Birch-Aspen Forest",
        },
        {
          value: 758,
          color: "b6faff",
          description: "Black Spruce Forest and Woodland",
        },
        {
          value: 759,
          color: "ff7230",
          description: "Boreal Grassland",
        },
        {
          value: 760,
          color: "c0ff8a",
          description: "Dry Aspen-Steppe Bluff",
        },
        {
          value: 762,
          color: "ffcd70",
          description: "Dwarf Shrubland",
        },
        {
          value: 763,
          color: "124c87",
          description: "Floodplain Forest and Shrubland",
        },
        {
          value: 765,
          color: "ff9900",
          description: "Freshwater Marsh",
        },
        {
          value: 767,
          color: "ffd377",
          description: "Herbaceous Meadow",
        },
        {
          value: 770,
          color: "124c87",
          description: "Riparian Stringer Forest and Shrubland",
        },
        {
          value: 772,
          color: "ff9900",
          description: "Shrub and Herbaceous Floodplain Wetland",
        },
        {
          value: 773,
          color: "852708",
          description: "Shrub and Herbaceous Peatlands",
        },
        {
          value: 774,
          color: "a64c11",
          description: "Shrub Swamp",
        },
        {
          value: 775,
          color: "ff250d",
          description: "Shrub Tundra",
        },
        {
          value: 777,
          color: "ff6600",
          description: "Sparse Tundra",
        },
        {
          value: 778,
          color: "b6fae3",
          description: "Spruce-Lichen Woodland",
        },
        {
          value: 779,
          color: "ff990a",
          description: "Tidal Flat",
        },
        {
          value: 780,
          color: "ff990a",
          description: "Tidal Marsh",
        },
        {
          value: 781,
          color: "ff491c",
          description: "Tussock Tundra",
        },
        {
          value: 782,
          color: "042d75",
          description: "Western Hemlock-Yellow-cedar Forest",
        },
        {
          value: 783,
          color: "ffcd70",
          description: "Wet Meadow",
        },
        {
          value: 784,
          color: "b6fae3",
          description: "White Spruce Forest and Woodland",
        },
        {
          value: 785,
          color: "b6fae3",
          description: "White Spruce Forest and Woodland",
        },
        {
          value: 786,
          color: "49afbc",
          description: "Willow Shrubland",
        },
        {
          value: 790,
          color: "c0ff8a",
          description: "Hawai'i Rainforest",
        },
        {
          value: 791,
          color: "baa377",
          description: "Hawai'i Dry Forest",
        },
        {
          value: 792,
          color: "005c00",
          description: "Hawai'i Mesic Forest",
        },
        {
          value: 793,
          color: "9c805c",
          description: "Hawai'i Dry Shrubland",
        },
        {
          value: 794,
          color: "963a0c",
          description: "Hawai'i Mesic Shrubland",
        },
        {
          value: 795,
          color: "fb7936",
          description: "Hawai'i Dry Grassland",
        },
        {
          value: 796,
          color: "ff7230",
          description: "Hawai'i Mesic Grassland",
        },
        {
          value: 797,
          color: "ff692e",
          description: "Hawai'i Riparian Forest",
        },
        {
          value: 798,
          color: "ff692e",
          description: "Hawai'i Riparian Shrubland",
        },
        {
          value: 801,
          color: "3fff2e",
          description: "Pacific Islands Limestone Forest",
        },
        {
          value: 802,
          color: "2aff1f",
          description: "Pacific Islands Littoral/Strand Vegetation",
        },
        {
          value: 803,
          color: "e0fcc0",
          description: "Pacific Islands Lowland Forest",
        },
        {
          value: 804,
          color: "00ed00",
          description: "Pacific Islands Mangrove Forest",
        },
        {
          value: 806,
          color: "00ed00",
          description: "Pacific Islands Ravine Forest",
        },
        {
          value: 808,
          color: "00cc00",
          description: "Pacific Islands Scrub Forest/Shrub",
        },
        {
          value: 809,
          color: "ff9900",
          description: "Pacific Islands Swamp/Marsh",
        },
        {
          value: 810,
          color: "00bd00",
          description: "Pacific Islands Upland Forest",
        },
        {
          value: 811,
          color: "ff692e",
          description: "Polynesian Ruderal Forest",
        },
        {
          value: 812,
          color: "ff692e",
          description: "Polynesian Ruderal Shrubland",
        },
        {
          value: 813,
          color: "ff692e",
          description: "Polynesian Ruderal Grassland",
        },
        {
          value: 820,
          color: "83de6e",
          description: "Caribbean Deciduous Forest",
        },
        {
          value: 821,
          color: "00de00",
          description: "Caribbean Mixed Evergreen Deciduous Forest",
        },
        {
          value: 822,
          color: "60ff47",
          description: "Caribbean Mixed Evergreen Deciduous Forest",
        },
        {
          value: 824,
          color: "705239",
          description: "Caribbean Shrub/Herbaceous Wetland",
        },
        {
          value: 825,
          color: "aef5e0",
          description: "Caribbean Evergreen Forest",
        },
        {
          value: 826,
          color: "005c00",
          description: "Caribbean Evergreen Forest",
        },
        {
          value: 828,
          color: "91ff73",
          description: "Caribbean Shrubland",
        },
        {
          value: 829,
          color: "74d6cc",
          description: "Caribbean Herbaceous",
        },
      ],
    },
    {
      name: "FBFM13",
      description: "Anderson's 13 classes for Fire Behavior and Fuel Models (FBFM13; Anderson 1982). Typical surface fuel arrangements or collections of fuel properties, based on distinct distributions of fuel loadings found among surface fuel components (live and dead), size classes, and fuel types",
      "gee:units": units.dimensionless,
      "gee:classes": [
        {
          value: 1,
          color: "ffffbe",
          description: "FBFM1",
        },
        {
          value: 2,
          color: "ffff00",
          description: "FBFM2",
        },
        {
          value: 3,
          color: "e6c50b",
          description: "FBFM3",
        },
        {
          value: 4,
          color: "ffd37f",
          description: "FBFM4",
        },
        {
          value: 5,
          color: "ffaa66",
          description: "FBFM5",
        },
        {
          value: 6,
          color: "cdaa66",
          description: "FBFM6",
        },
        {
          value: 7,
          color: "897044",
          description: "FBFM7",
        },
        {
          value: 8,
          color: "d3ffbe",
          description: "FBFM8",
        },
        {
          value: 9,
          color: "70a800",
          description: "FBFM9",
        },
        {
          value: 10,
          color: "267300",
          description: "FBFM10",
        },
        {
          value: 11,
          color: "e8beff",
          description: "FBFM11",
        },
        {
          value: 12,
          color: "7a8ef5",
          description: "FBFM12",
        },
        {
          value: 13,
          color: "c500ff",
          description: "FBFM13",
        },
        {
          value: 91,
          color: "84008a",
          description: "Urban",
        },
        {
          value: 92,
          color: "9fa1f0",
          description: "Snow/Ice",
        },
        {
          value: 93,
          color: "e973ff",
          description: "Agriculture",
        },
        {
          value: 98,
          color: "0000ff",
          description: "Water",
        },
        {
          value: 99,
          color: "bfbfbf",
          description: "Barren",
        },
      ],
    },
    {
      name: "FBFM40",
      description: "Scott and Burgan's 40-class Fire Behavior Fuel Model (FMFB40; Scott and Burgan 2004). The fuel models are described by the most common fire carrying fuel type (grass, grass/shrub, brush, timber, or slash), loading and surface area-to-volume ratio by size class and component, fuel bed depth, and moisture of extinction.",
      "gee:units": units.dimensionless,
      "gee:classes": [
        {
          value: 91,
          color: "686868",
          description: "NB1",
        },
        {
          value: 92,
          color: "e1e1e1",
          description: "NB2",
        },
        {
          value: 93,
          color: "ffeded",
          description: "NB3",
        },
        {
          value: 98,
          color: "000ed6",
          description: "NB8",
        },
        {
          value: 99,
          color: "4d6e70",
          description: "NB9",
        },
        {
          value: 101,
          color: "ffebbe",
          description: "GR1",
        },
        {
          value: 102,
          color: "ffd373",
          description: "GR2",
        },
        {
          value: 103,
          color: "ffec8b",
          description: "GR3",
        },
        {
          value: 104,
          color: "ffff73",
          description: "GR4",
        },
        {
          value: 105,
          color: "f5de29",
          description: "GR5",
        },
        {
          value: 106,
          color: "e6e640",
          description: "GR6",
        },
        {
          value: 107,
          color: "cdc673",
          description: "GR7",
        },
        {
          value: 108,
          color: "8b864e",
          description: "GR8",
        },
        {
          value: 109,
          color: "a87000",
          description: "GR9",
        },
        {
          value: 121,
          color: "ffaa00",
          description: "GS1",
        },
        {
          value: 122,
          color: "ffa77f",
          description: "GS2",
        },
        {
          value: 123,
          color: "ff6300",
          description: "GS3",
        },
        {
          value: 124,
          color: "cd6600",
          description: "GS4",
        },
        {
          value: 141,
          color: "d7c29e",
          description: "SH1",
        },
        {
          value: 142,
          color: "d7b09e",
          description: "SH2",
        },
        {
          value: 143,
          color: "cd8966",
          description: "SH3",
        },
        {
          value: 144,
          color: "895a44",
          description: "SH4",
        },
        {
          value: 145,
          color: "cdaa66",
          description: "SH5",
        },
        {
          value: 146,
          color: "ed7044",
          description: "SH6",
        },
        {
          value: 147,
          color: "cd7d39",
          description: "SH7",
        },
        {
          value: 148,
          color: "a83800",
          description: "SH8",
        },
        {
          value: 149,
          color: "731a00",
          description: "SH9",
        },
        {
          value: 161,
          color: "e9ffbe",
          description: "TU1",
        },
        {
          value: 162,
          color: "aaff00",
          description: "TU2",
        },
        {
          value: 163,
          color: "b4d79e",
          description: "TU3",
        },
        {
          value: 164,
          color: "70a800",
          description: "TU4",
        },
        {
          value: 165,
          color: "267300",
          description: "TU5",
        },
        {
          value: 181,
          color: "beffe8",
          description: "TL1",
        },
        {
          value: 182,
          color: "00ffc5",
          description: "TL2",
        },
        {
          value: 183,
          color: "bed2ff",
          description: "TL3",
        },
        {
          value: 184,
          color: "7b68ee",
          description: "TL4",
        },
        {
          value: 185,
          color: "bee8ff",
          description: "TL5",
        },
        {
          value: 186,
          color: "00c5ff",
          description: "TL6",
        },
        {
          value: 187,
          color: "0084a8",
          description: "TL7",
        },
        {
          value: 188,
          color: "005ce6",
          description: "TL8",
        },
        {
          value: 189,
          color: "4d6e91",
          description: "TL9",
        },
        {
          value: 201,
          color: "e8beff",
          description: "SB1",
        },
        {
          value: 202,
          color: "c500ff",
          description: "SB2",
        },
        {
          value: 203,
          color: "ffbee8",
          description: "SB3",
        },
        {
          value: 204,
          color: "ff7f7f",
          description: "SB4",
        },
      ],
    },
    {
      name: "FDist_raw",
      description: "Code that denotes fuel disturbance type, severity, and time since disturbance. Raw value from original Landire products, equivalent to FDist24.",
      "gee:units": units.dimensionless,
      "gee:classes": [
        {
          value: -1111,
          color: "6f6f6f",
          description: "-1111",
        },
        {
          value: 0,
          color: "000000",
          description: "0",
        },
        {
          value: 111,
          color: "d6604d",
          description: "111",
        },
        {
          value: 112,
          color: "d6604d",
          description: "112",
        },
        {
          value: 113,
          color: "d6604d",
          description: "113",
        },
        {
          value: 121,
          color: "d6604d",
          description: "121",
        },
        {
          value: 122,
          color: "d6604d",
          description: "122",
        },
        {
          value: 123,
          color: "d6604d",
          description: "123",
        },
        {
          value: 131,
          color: "d6604d",
          description: "131",
        },
        {
          value: 132,
          color: "d6604d",
          description: "132",
        },
        {
          value: 133,
          color: "d6604d",
          description: "133",
        },
        {
          value: 211,
          color: "f4a582",
          description: "211",
        },
        {
          value: 212,
          color: "f4a582",
          description: "212",
        },
        {
          value: 213,
          color: "f4a582",
          description: "213",
        },
        {
          value: 221,
          color: "f4a582",
          description: "221",
        },
        {
          value: 222,
          color: "f4a582",
          description: "222",
        },
        {
          value: 223,
          color: "f4a582",
          description: "223",
        },
        {
          value: 231,
          color: "f4a582",
          description: "231",
        },
        {
          value: 232,
          color: "f4a582",
          description: "232",
        },
        {
          value: 233,
          color: "f4a582",
          description: "233",
        },
        {
          value: 311,
          color: "fddbc7",
          description: "311",
        },
        {
          value: 312,
          color: "fddbc7",
          description: "312",
        },
        {
          value: 313,
          color: "fddbc7",
          description: "313",
        },
        {
          value: 321,
          color: "fddbc7",
          description: "321",
        },
        {
          value: 322,
          color: "fddbc7",
          description: "322",
        },
        {
          value: 323,
          color: "fddbc7",
          description: "323",
        },
        {
          value: 331,
          color: "fddbc7",
          description: "331",
        },
        {
          value: 332,
          color: "fddbc7",
          description: "332",
        },
        {
          value: 333,
          color: "fddbc7",
          description: "333",
        },
        {
          value: 411,
          color: "d1e5f0",
          description: "411",
        },
        {
          value: 412,
          color: "d1e5f0",
          description: "412",
        },
        {
          value: 413,
          color: "d1e5f0",
          description: "413",
        },
        {
          value: 421,
          color: "d1e5f0",
          description: "421",
        },
        {
          value: 422,
          color: "d1e5f0",
          description: "422",
        },
        {
          value: 423,
          color: "d1e5f0",
          description: "423",
        },
        {
          value: 431,
          color: "d1e5f0",
          description: "431",
        },
        {
          value: 432,
          color: "d1e5f0",
          description: "432",
        },
        {
          value: 433,
          color: "d1e5f0",
          description: "433",
        },
        {
          value: 511,
          color: "92c5de",
          description: "511",
        },
        {
          value: 512,
          color: "92c5de",
          description: "512",
        },
        {
          value: 513,
          color: "92c5de",
          description: "513",
        },
        {
          value: 521,
          color: "92c5de",
          description: "521",
        },
        {
          value: 522,
          color: "92c5de",
          description: "522",
        },
        {
          value: 523,
          color: "92c5de",
          description: "523",
        },
        {
          value: 531,
          color: "92c5de",
          description: "531",
        },
        {
          value: 532,
          color: "92c5de",
          description: "532",
        },
        {
          value: 533,
          color: "92c5de",
          description: "533",
        },
        {
          value: 611,
          color: "4393c5",
          description: "611",
        },
        {
          value: 612,
          color: "4393c5",
          description: "612",
        },
        {
          value: 613,
          color: "4393c5",
          description: "613",
        },
        {
          value: 621,
          color: "4393c5",
          description: "621",
        },
        {
          value: 622,
          color: "4393c5",
          description: "622",
        },
        {
          value: 623,
          color: "4393c5",
          description: "623",
        },
        {
          value: 631,
          color: "4393c5",
          description: "631",
        },
        {
          value: 632,
          color: "4393c5",
          description: "632",
        },
        {
          value: 633,
          color: "4393c5",
          description: "633",
        },
        {
          value: 711,
          color: "2166ac",
          description: "711",
        },
        {
          value: 712,
          color: "2166ac",
          description: "712",
        },
        {
          value: 713,
          color: "2166ac",
          description: "713",
        },
        {
          value: 721,
          color: "2166ac",
          description: "721",
        },
        {
          value: 722,
          color: "2166ac",
          description: "722",
        },
        {
          value: 723,
          color: "2166ac",
          description: "723",
        },
        {
          value: 731,
          color: "2166ac",
          description: "731",
        },
        {
          value: 732,
          color: "2166ac",
          description: "732",
        },
        {
          value: 733,
          color: "2166ac",
          description: "733",
        },
      ],
    },
    {
      name: "FDist_status",
      description: "Code representing disturbance occurrence and presence/absence of mapped disturbance data. Derived from FDist_raw.",
      "gee:units": units.dimensionless,
      "gee:classes": [
        {
          value: 0,
          color: "e8e8e8",
          description: "No Disturbance",
        },
        {
          value: 1,
          color: "ff7c80",
          description: "Disturbance",
        },
        {
          value: 2,
          color: "0070c0",
          description: "Water",
        },
        {
          value: 3,
          color: "d86dcd",
          description: "Not Mapped",
        },
      ],
    },
    {
      name: "FDist_type_L1",
      description: "Disturbance type represented as a first-order class. Derived categorical view from FDist_raw.",
      "gee:units": units.dimensionless,
      "gee:classes": [
        {
          value: 0,
          color: "e8e8e8",
          description: "No Disturbance",
        },
        {
          value: 1,
          color: "d6604d",
          description: "Fire",
        },
        {
          value: 2,
          color: "f4a582",
          description: "Mechanical Add",
        },
        {
          value: 3,
          color: "b88712",
          description: "Mechanical Remove",
        },
        {
          value: 4,
          color: "d1e5f0",
          description: "Windthrow",
        },
        {
          value: 5,
          color: "6eaac8",
          description: "Insects-Disease",
        },
        {
          value: 6,
          color: "6a3d9a",
          description: "Mechanical Unknown",
        },
        {
          value: 7,
          color: "9c27b0",
          description: "Mastication",
        },
        {
          value: 8,
          color: "003300",
          description: "Biological",
        },
        {
          value: 9,
          color: "ffff00",
          description: "Chemical",
        },
        {
          value: 10,
          color: "6f6f6f",
          description: "Development",
        },
      ],
    },
    {
      name: "FDist_type_L2",
      description: "Disturbance type represented as a second-order class. Derived categorical view from FDist_raw.",
      "gee:units": units.dimensionless,
      "gee:classes": [
        {
          value: 0,
          color: "e8e8e8",
          description: "No Disturbance",
        },
        {
          value: 11,
          color: "d6604d",
          description: "Fire",
        },
        {
          value: 12,
          color: "ff0000",
          description: "Wildfire",
        },
        {
          value: 13,
          color: "d6604d",
          description: "Wildland Fire Use",
        },
        {
          value: 14,
          color: "ad001c",
          description: "Prescribed Fire",
        },
        {
          value: 15,
          color: "c73f00",
          description: "Unknown Fire",
        },
        {
          value: 21,
          color: "f4a582",
          description: "Mechanical Add",
        },
        {
          value: 22,
          color: "e7a77a",
          description: "Mechanical Other",
        },
        {
          value: 31,
          color: "b88712",
          description: "Mechanical Remove",
        },
        {
          value: 32,
          color: "806145",
          description: "Clearcut",
        },
        {
          value: 33,
          color: "ffff77",
          description: "Harvest",
        },
        {
          value: 34,
          color: "b59c72",
          description: "Thinning",
        },
        {
          value: 41,
          color: "d1e5f0",
          description: "Windthrow",
        },
        {
          value: 51,
          color: "0000ff",
          description: "Insects-Disease",
        },
        {
          value: 52,
          color: "92e8d7",
          description: "Insects",
        },
        {
          value: 53,
          color: "042d75",
          description: "Disease",
        },
        {
          value: 61,
          color: "6a3d9a",
          description: "Mechanical Unknown",
        },
        {
          value: 62,
          color: "8e63bf",
          description: "Unknown",
        },
        {
          value: 71,
          color: "9c27b0",
          description: "Mastication",
        },
        {
          value: 81,
          color: "003300",
          description: "Biological",
        },
        {
          value: 91,
          color: "ffff00",
          description: "Chemical",
        },
        {
          value: 92,
          color: "fff176",
          description: "Insecticide",
        },
        {
          value: 93,
          color: "ffee58",
          description: "Herbicide",
        },
        {
          value: 101,
          color: "6f6f6f",
          description: "Development",
        },
      ],
    },
    {
      name: "FDist_severity",
      description: "Disturbance severity. Derived categorical view from FDist_raw.",
      "gee:units": units.dimensionless,
      "gee:classes": [
        {
          value: 0,
          color: "f0f0f0",
          description: "Not Applicable",
        },
        {
          value: 1,
          color: "009e73",
          description: "Increased Green",
        },
        {
          value: 2,
          color: "56b4e9",
          description: "Unburned/Low",
        },
        {
          value: 3,
          color: "f0e442",
          description: "Low",
        },
        {
          value: 4,
          color: "e69f00",
          description: "Moderate",
        },
        {
          value: 5,
          color: "d55e00",
          description: "High",
        },
        {
          value: 6,
          color: "999999",
          description: "No Severity",
        },
      ],
    },
    {
      name: "FDist_time",
      description: "Time since disturbance. Derived categorial view from FDist_raw.",
      "gee:units": units.dimensionless,
      "gee:classes": [
        {
          value: 0,
          color: "f0f0f0",
          description: "Not Applicable",
        },
        {
          value: 1,
          color: "0d609f",
          description: "One Year",
        },
        {
          value: 2,
          color: "58a6d4",
          description: "Two to Five Years",
        },
        {
          value: 3,
          color: "9ed3ea",
          description: "Six to Ten Years",
        },
      ],
    },
    {
      name: "FVC",
      description: "Code representing the land cover type and percent cover by life form.",
      "gee:units": units.percent,
      "gee:classes": [
        {
          value: 11,
          color: "0000ff",
          description: "Open Water",
        },
        {
          value: 12,
          color: "9fa1f0",
          description: "Snow/Ice",
        },
        {
          value: 13,
          color: "403da8",
          description: "Developed-Upland Deciduous Forest",
        },
        {
          value: 14,
          color: "444f89",
          description: "Developed-Upland Evergreen Forest",
        },
        {
          value: 15,
          color: "6677cd",
          description: "Developed-Upland Mixed Forest",
        },
        {
          value: 16,
          color: "7a8ef5",
          description: "Developed-Upland Herbaceous",
        },
        {
          value: 17,
          color: "9eaad7",
          description: "Developed-Upland Shrubland",
        },
        {
          value: 18,
          color: "343434",
          description: "Developed-Herbaceous Wetland Vegetation",
        },
        {
          value: 19,
          color: "343434",
          description: "Developed-Woody Wetland Vegetation",
        },
        {
          value: 20,
          color: "ffebe0",
          description: "Developed-General",
        },
        {
          value: 21,
          color: "fdccd3",
          description: "Developed-Open Space",
        },
        {
          value: 22,
          color: "ff7a8f",
          description: "Developed-Low Intensity",
        },
        {
          value: 23,
          color: "fd2c4f",
          description: "Developed-Medium Intensity",
        },
        {
          value: 24,
          color: "ad001c",
          description: "Developed-High Intensity",
        },
        {
          value: 25,
          color: "010101",
          description: "Developed-Roads",
        },
        {
          value: 31,
          color: "bfbfbf",
          description: "Barren",
        },
        {
          value: 32,
          color: "e6e8fa",
          description: "Quarries-Strip Mines-Gravel Pits",
        },
        {
          value: 60,
          color: "d21c5e",
          description: "NASS-Orchard",
        },
        {
          value: 61,
          color: "a80084",
          description: "NASS-Vineyard",
        },
        {
          value: 62,
          color: "d21c77",
          description: "NASS-Bush fruit and berries",
        },
        {
          value: 63,
          color: "fff58c",
          description: "NASS-Row Crop-Close Grown Crop",
        },
        {
          value: 64,
          color: "faff77",
          description: "NASS-Row Crop",
        },
        {
          value: 65,
          color: "ffed77",
          description: "NASS-Close Grown Crop",
        },
        {
          value: 66,
          color: "ffff77",
          description: "NASS-Fallow/Idle Cropland",
        },
        {
          value: 67,
          color: "e3d41c",
          description: "NASS-Pasture and Hayland",
        },
        {
          value: 68,
          color: "fae3a3",
          description: "NASS-Wheat",
        },
        {
          value: 69,
          color: "d2ffed",
          description: "NASS-Aquaculture",
        },
        {
          value: 75,
          color: "7f38ff",
          description: "Herbaceous Semi-dry",
        },
        {
          value: 76,
          color: "7f38ff",
          description: "Herbaceous Semi-wet",
        },
        {
          value: 78,
          color: "7f382b",
          description: "Recently Disturbed Forest",
        },
        {
          value: 80,
          color: "e973ff",
          description: "Agriculture",
        },
        {
          value: 81,
          color: "ffff9c",
          description: "Pasture/Hay",
        },
        {
          value: 82,
          color: "ffff78",
          description: "Cultivated Crops",
        },
        {
          value: 83,
          color: "ffff54",
          description: "Small Grains",
        },
        {
          value: 84,
          color: "ffff2b",
          description: "Fallow",
        },
        {
          value: 85,
          color: "ffff00",
          description: "Urban-Recreational Grasses",
        },
        {
          value: 95,
          color: "7f8fff",
          description: "Herbaceous Wetlands",
        },
        {
          value: 100,
          color: "7a7f75",
          description: "Sparse Vegetation Canopy",
        },
        {
          value: 101,
          color: "ccff99",
          description: "Tree Cover >= 10 and < 20%",
        },
        {
          value: 102,
          color: "aee082",
          description: "Tree Cover >= 20 and < 30%",
        },
        {
          value: 103,
          color: "91c46c",
          description: "Tree Cover >= 30 and < 40%",
        },
        {
          value: 104,
          color: "77ab57",
          description: "Tree Cover >= 40 and < 50%",
        },
        {
          value: 105,
          color: "5e9144",
          description: "Tree Cover >= 50 and < 60%",
        },
        {
          value: 106,
          color: "467832",
          description: "Tree Cover >= 60 and < 70%",
        },
        {
          value: 107,
          color: "336324",
          description: "Tree Cover >= 70 and < 80%",
        },
        {
          value: 108,
          color: "204f16",
          description: "Tree Cover >= 80 and < 90%",
        },
        {
          value: 109,
          color: "003300",
          description: "Tree Cover >= 90 and <= 100%",
        },
        {
          value: 111,
          color: "d4b27d",
          description: "Shrub Cover >= 10 and < 20%",
        },
        {
          value: 112,
          color: "d1a171",
          description: "Shrub Cover >= 20 and < 30%",
        },
        {
          value: 113,
          color: "cc9166",
          description: "Shrub Cover >= 30 and < 40%",
        },
        {
          value: 114,
          color: "c77e5a",
          description: "Shrub Cover >= 40 and < 50%",
        },
        {
          value: 115,
          color: "c26e4f",
          description: "Shrub Cover >= 50 and < 60%",
        },
        {
          value: 116,
          color: "bd5e46",
          description: "Shrub Cover >= 60 and < 70%",
        },
        {
          value: 117,
          color: "b54c3c",
          description: "Shrub Cover >= 70 and < 80%",
        },
        {
          value: 118,
          color: "b03b33",
          description: "Shrub Cover >= 80 and < 90%",
        },
        {
          value: 119,
          color: "9e0020",
          description: "Shrub Cover >= 90 and <= 100%",
        },
        {
          value: 121,
          color: "ffcc66",
          description: "Herb Cover >= 10 and < 20%",
        },
        {
          value: 122,
          color: "ffba59",
          description: "Herb Cover >= 20 and < 30%",
        },
        {
          value: 123,
          color: "ffa94d",
          description: "Herb Cover >= 30 and < 40%",
        },
        {
          value: 124,
          color: "ff9a42",
          description: "Herb Cover >= 40 and < 50%",
        },
        {
          value: 125,
          color: "ff8636",
          description: "Herb Cover >= 50 and < 60%",
        },
        {
          value: 126,
          color: "ff752b",
          description: "Herb Cover >= 60 and < 70%",
        },
        {
          value: 127,
          color: "ff6421",
          description: "Herb Cover >= 70 and < 80%",
        },
        {
          value: 128,
          color: "ff5517",
          description: "Herb Cover >= 80 and < 90%",
        },
        {
          value: 129,
          color: "ff3300",
          description: "Herb Cover >= 90 and <= 100%",
        },
        {
          value: 150,
          color: "7a7f75",
          description: "Sparse Vegetation Canopy",
        },
        {
          value: 151,
          color: "ccff99",
          description: "Tree Canopy >= 10 and < 25%",
        },
        {
          value: 152,
          color: "467832",
          description: "Tree Canopy >= 25 and < 60%",
        },
        {
          value: 153,
          color: "003300",
          description: "Tree Canopy >= 60 and <= 100%",
        },
        {
          value: 161,
          color: "d4b27d",
          description: "Shrub Canopy >= 10 and < 25%",
        },
        {
          value: 162,
          color: "c26e4f",
          description: "Shrub Canopy >= 25 and < 60%",
        },
        {
          value: 163,
          color: "9e0020",
          description: "Shrub Canopy >= 60 and <= 100%",
        },
        {
          value: 171,
          color: "ffa94d",
          description: "Herb Canopy >= 10 and < 60%",
        },
        {
          value: 172,
          color: "ff752b",
          description: "Herb Canopy >= 60 and <= 100%",
        },
      ],
    },
    {
      name: "FVH",
      description: "FVH represents the average height of the dominant vegetation for a 30m grid cell and is binned separately for each life form.",
      "gee:units": units.meter,
      "gee:classes": [
        {
          value: 11,
          color: "0000ff",
          description: "Open Water",
        },
        {
          value: 12,
          color: "9fa1f0",
          description: "Snow/Ice",
        },
        {
          value: 13,
          color: "403da8",
          description: "Developed-Upland Deciduous Forest",
        },
        {
          value: 14,
          color: "444f89",
          description: "Developed-Upland Evergreen Forest",
        },
        {
          value: 15,
          color: "6677cd",
          description: "Developed-Upland Mixed Forest",
        },
        {
          value: 16,
          color: "7a8ef5",
          description: "Developed-Upland Herbaceous",
        },
        {
          value: 17,
          color: "9eaad7",
          description: "Developed-Upland Shrubland",
        },
        {
          value: 18,
          color: "343434",
          description: "Developed-Herbaceous Wetland Vegetation",
        },
        {
          value: 19,
          color: "343434",
          description: "Developed-Woody Wetland Vegetation",
        },
        {
          value: 20,
          color: "ffebe0",
          description: "Developed-General",
        },
        {
          value: 21,
          color: "fdccd3",
          description: "Developed-Open",
        },
        {
          value: 22,
          color: "ff7a8f",
          description: "Developed-Low Intensity",
        },
        {
          value: 23,
          color: "fd2c4f",
          description: "Developed-Medium Intensity",
        },
        {
          value: 24,
          color: "ad001c",
          description: "Developed-High Intensity",
        },
        {
          value: 25,
          color: "010101",
          description: "Developed-Roads",
        },
        {
          value: 31,
          color: "bfbfbf",
          description: "Barren",
        },
        {
          value: 32,
          color: "e6e8fa",
          description: "Quarries-Strip Mines-Gravel Pits",
        },
        {
          value: 60,
          color: "d21c5e",
          description: "Orchard",
        },
        {
          value: 61,
          color: "a80084",
          description: "NASS-Vineyard",
        },
        {
          value: 62,
          color: "d21c77",
          description: "Bush fruit",
        },
        {
          value: 63,
          color: "fff58c",
          description: "NASS-Row Crop-Close Grown Crop",
        },
        {
          value: 64,
          color: "faff77",
          description: "NASS-Row Crop",
        },
        {
          value: 65,
          color: "ffed77",
          description: "NASS-Close Grown Crop",
        },
        {
          value: 66,
          color: "ffff77",
          description: "Fallow/Idle",
        },
        {
          value: 68,
          color: "fae3a3",
          description: "NASS-Wheat",
        },
        {
          value: 69,
          color: "d2ffed",
          description: "NASS-Aquaculture",
        },
        {
          value: 75,
          color: "7f38ff",
          description: "Herbaceous Semi-dry",
        },
        {
          value: 76,
          color: "7f38ff",
          description: "Herbaceous Semi-wet",
        },
        {
          value: 80,
          color: "e973ff",
          description: "Agriculture",
        },
        {
          value: 81,
          color: "ffff9c",
          description: "Pasture/Hay",
        },
        {
          value: 82,
          color: "ffff78",
          description: "Cultivated Crops",
        },
        {
          value: 83,
          color: "ffff54",
          description: "Small Grains",
        },
        {
          value: 84,
          color: "ffff2b",
          description: "Fallow Idle Crop",
        },
        {
          value: 95,
          color: "7f8fff",
          description: "Herbaceous Wetlands",
        },
        {
          value: 100,
          color: "7a7f75",
          description: "Sparse Vegetation Height",
        },
        {
          value: 425,
          color: "ffcc66",
          description: "Herb Height 0 - <0.5 meters",
        },
        {
          value: 475,
          color: "ff9933",
          description: "Herb Height 0.5 - <1.0 meters",
        },
        {
          value: 499,
          color: "ff6600",
          description: "Herb Height - <1.0 meter",
        },
        {
          value: 502,
          color: "c2a353",
          description: "Shrub Height 0 - <0.5 meters",
        },
        {
          value: 507,
          color: "b0803c",
          description: "Shrub Height 0.5 - <1.0 meter",
        },
        {
          value: 520,
          color: "9e5f28",
          description: "Shrub Height 1.0 - <3.0 meters",
        },
        {
          value: 530,
          color: "752300",
          description: "Shrub Height - <3.0 meters",
        },
        {
          value: 603,
          color: "ccffcc",
          description: "Forest Height 1.8 - <5 meters",
        },
        {
          value: 607,
          color: "c0fcbd",
          description: "Forest Height 5 - <9 meters",
        },
        {
          value: 611,
          color: "b0f7ab",
          description: "Forest Height 9 - <13 meters",
        },
        {
          value: 615,
          color: "a4f59d",
          description: "Forest Height 13 - <17 meters",
        },
        {
          value: 619,
          color: "96f08d",
          description: "Forest Height 17 - <21 meters",
        },
        {
          value: 623,
          color: "87eb7c",
          description: "Forest Height 21 - <25 meters",
        },
        {
          value: 627,
          color: "7be86f",
          description: "Forest Height 25 - <29 meters",
        },
        {
          value: 631,
          color: "6ae35f",
          description: "Forest Height 29 - <33 meters",
        },
        {
          value: 635,
          color: "5ede52",
          description: "Forest Height 33 - <37 meters",
        },
        {
          value: 639,
          color: "4dd943",
          description: "Forest Height 37 - <41 meters",
        },
        {
          value: 643,
          color: "3ed633",
          description: "Forest Height 41 - <45 meters",
        },
        {
          value: 647,
          color: "29d124",
          description: "Forest Height 45 - <=49 meters",
        },
        {
          value: 651,
          color: "0ecc0e",
          description: "Forest Height >=50 meters",
        },
      ],
    },
    {
      name: "FVT",
      description: "Fuel-oriented vegetation type coding based on translated EVT labels and disturbance context.",
      "gee:units": units.dimensionless,
      "gee:classes": [
        {
          value: 11,
          color: "0000ff",
          description: "Ba Open Water",
        },
        {
          value: 12,
          color: "9fa1f0",
          description: "Ba Snow-Ice",
        },
        {
          value: 20,
          color: "343434",
          description: "Bau Urban",
        },
        {
          value: 21,
          color: "343434",
          description: "Bau Developed-Open Space",
        },
        {
          value: 22,
          color: "ff7a8f",
          description: "Bau Developed-Low Intensity",
        },
        {
          value: 23,
          color: "fd2c4f",
          description: "Bau Developed-Medium Intensity",
        },
        {
          value: 24,
          color: "ad001c",
          description: "Bau Developed-High Intensity",
        },
        {
          value: 31,
          color: "bfbfbf",
          description: "Bab Barren",
        },
        {
          value: 32,
          color: "e6e8fa",
          description: "Bab Quarries-Strip Mines-Gravel Pits-Well and Wind Pads",
        },
        {
          value: 80,
          color: "ffd277",
          description: "Da Agriculture",
        },
        {
          value: 81,
          color: "e3d41c",
          description: "Dab Agriculture-Pasture and Hay",
        },
        {
          value: 82,
          color: "faff77",
          description: "Da Agriculture-Cultivated Crops and Irrigated Agriculture",
        },
        {
          value: 2001,
          color: "646464",
          description: "Sps Inter-Mountain Basins Sparsely Vegetated Systems",
        },
        {
          value: 2002,
          color: "646464",
          description: "Sps Mediterranean California Sparsely Vegetated Systems",
        },
        {
          value: 2003,
          color: "646464",
          description: "Sps North Pacific Sparsely Vegetated Systems",
        },
        {
          value: 2004,
          color: "646464",
          description: "Sps North American Warm Desert Sparsely Vegetated Systems",
        },
        {
          value: 2005,
          color: "646464",
          description: "Sps Pacific Coastal Dunes and Other Sparsely Vegetated Systems",
        },
        {
          value: 2006,
          color: "646464",
          description: "Sps Rocky Mountain Alpine/Montane Sparsely Vegetated Systems",
        },
        {
          value: 2007,
          color: "646464",
          description: "Sps Western Great Plains Sparsely Vegetated Systems",
        },
        {
          value: 2008,
          color: "cbffab",
          description: "Tr North Pacific Oak Woodland",
        },
        {
          value: 2009,
          color: "c0ff8a",
          description: "Tr Northwestern Great Plains Aspen Forest and Parkland",
        },
        {
          value: 2010,
          color: "b4ff94",
          description: "Tr Northern Rocky Mountain Western Larch Savanna",
        },
        {
          value: 2011,
          color: "c0ff8a",
          description: "Tr Rocky Mountain Aspen Forest and Woodland",
        },
        {
          value: 2012,
          color: "abff8a",
          description: "Tr Rocky Mountain Bigtooth Maple Ravine Woodland",
        },
        {
          value: 2013,
          color: "06357a",
          description: "Tr Western Great Plains Dry Bur Oak Forest and Woodland",
        },
        {
          value: 2014,
          color: "91ff73",
          description: "Tr Central and Southern California Mixed Evergreen Woodland",
        },
        {
          value: 2015,
          color: "87ff69",
          description: "Tr California Coastal Redwood Forest",
        },
        {
          value: 2016,
          color: "79ff5e",
          description: "Tr Colorado Plateau Pinyon-Juniper Woodland",
        },
        {
          value: 2017,
          color: "6cff52",
          description: "Tr Columbia Plateau Western Juniper Woodland and Savanna",
        },
        {
          value: 2018,
          color: "60ff47",
          description: "Tr East Cascades Mesic Montane Mixed-Conifer Forest and Woodland",
        },
        {
          value: 2019,
          color: "4eff3b",
          description: "Tr Great Basin Pinyon-Juniper Woodland",
        },
        {
          value: 2020,
          color: "3fff2e",
          description: "Tr Inter-Mountain Basins Subalpine Limber-Bristlecone Pine Woodland",
        },
        {
          value: 2021,
          color: "2aff1f",
          description: "Tr Klamath-Siskiyou Lower Montane Serpentine Mixed Conifer Woodland",
        },
        {
          value: 2022,
          color: "e0fcc0",
          description: "Tr Klamath-Siskiyou Upper Montane Serpentine Mixed Conifer Woodland",
        },
        {
          value: 2023,
          color: "00ed00",
          description: "Tr Madrean Encinal",
        },
        {
          value: 2024,
          color: "00ed00",
          description: "Tr Madrean Lower Montane Pine-Oak Forest and Woodland",
        },
        {
          value: 2025,
          color: "79ff5e",
          description: "Tr Madrean Pinyon-Juniper Woodland",
        },
        {
          value: 2026,
          color: "00ed00",
          description: "Tr Madrean Upper Montane Conifer-Oak Forest and Woodland",
        },
        {
          value: 2027,
          color: "00de00",
          description: "Tr Mediterranean California Dry-Mesic Mixed Conifer Forest and Woodland",
        },
        {
          value: 2028,
          color: "00cc00",
          description: "Tr Mediterranean California Mesic Mixed Conifer Forest and Woodland",
        },
        {
          value: 2029,
          color: "00bd00",
          description: "Tr Mediterranean California Mixed Oak Woodland",
        },
        {
          value: 2030,
          color: "00bd00",
          description: "Tr Mediterranean California Lower Montane Conifer Forest and Woodland",
        },
        {
          value: 2031,
          color: "00ad00",
          description: "Tr California Montane Jeffrey Pine(-Ponderosa Pine) Woodland",
        },
        {
          value: 2032,
          color: "009e00",
          description: "Tr Mediterranean California Red Fir Forest",
        },
        {
          value: 2033,
          color: "009100",
          description: "Tr Mediterranean California Subalpine Woodland",
        },
        {
          value: 2034,
          color: "e0fcc0",
          description: "Tr Mediterranean California Mesic Serpentine Woodland and Chaparral",
        },
        {
          value: 2035,
          color: "008200",
          description: "Tr North Pacific Dry Douglas-fir(-Madrone) Forest and Woodland",
        },
        {
          value: 2036,
          color: "007500",
          description: "Tr North Pacific Hypermaritime Seasonal Sitka Spruce Forest",
        },
        {
          value: 2037,
          color: "006900",
          description: "Tr North Pacific Maritime Dry-Mesic Douglas-fir-Western Hemlock Forest",
        },
        {
          value: 2038,
          color: "005c00",
          description: "Tr North Pacific Maritime Mesic Subalpine Parkland",
        },
        {
          value: 2039,
          color: "006900",
          description: "Tr North Pacific Maritime Mesic-Wet Douglas-fir-Western Hemlock Forest",
        },
        {
          value: 2040,
          color: "005200",
          description: "Tr Alaskan Pacific Mesic Western Hemlock-Yellow-cedar Forest",
        },
        {
          value: 2041,
          color: "005c00",
          description: "Tr North Pacific Mountain Hemlock Forest",
        },
        {
          value: 2042,
          color: "004700",
          description: "Tr North Pacific Mesic Western Hemlock-Silver Fir Forest",
        },
        {
          value: 2043,
          color: "003d00",
          description: "Tr Mediterranean California Mixed Evergreen Forest",
        },
        {
          value: 2044,
          color: "005c00",
          description: "Tr Northern California Mesic Subalpine Woodland",
        },
        {
          value: 2045,
          color: "003300",
          description: "Tr Northern Rocky Mountain Dry-Mesic Montane Mixed Conifer Forest",
        },
        {
          value: 2046,
          color: "bfffe9",
          description: "Tr Northern Rocky Mountain Subalpine Woodland and Parkland",
        },
        {
          value: 2047,
          color: "60ff47",
          description: "Tr Northern Rocky Mountain Mesic Montane Mixed Conifer Forest",
        },
        {
          value: 2048,
          color: "b6fae3",
          description: "Tr Northwestern Great Plains Highland White Spruce Woodland",
        },
        {
          value: 2049,
          color: "aef5e0",
          description: "Tr Rocky Mountain Foothill Limber Pine-Juniper Woodland",
        },
        {
          value: 2050,
          color: "a3f0db",
          description: "Tr Rocky Mountain Lodgepole Pine Forest",
        },
        {
          value: 2051,
          color: "003300",
          description: "Tr Southern Rocky Mountain Dry-Mesic Montane Mixed Conifer Forest and Woodland",
        },
        {
          value: 2052,
          color: "00cc00",
          description: "Tr Southern Rocky Mountain Mesic Montane Mixed Conifer Forest and Woodland",
        },
        {
          value: 2053,
          color: "d6ffb5",
          description: "Tr Northern Rocky Mountain Ponderosa Pine Woodland and Savanna",
        },
        {
          value: 2054,
          color: "d6ffb5",
          description: "Tr Southern Rocky Mountain Ponderosa Pine Woodland",
        },
        {
          value: 2055,
          color: "ecfccc",
          description: "Tr Rocky Mountain Subalpine Dry-Mesic Spruce-Fir Forest and Woodland",
        },
        {
          value: 2056,
          color: "ecfccc",
          description: "Tr Rocky Mountain Subalpine Mesic-Wet Spruce-Fir Forest and Woodland",
        },
        {
          value: 2057,
          color: "3fff2e",
          description: "Tr Rocky Mountain Subalpine-Montane Limber-Bristlecone Pine Woodland",
        },
        {
          value: 2058,
          color: "a3f0db",
          description: "Tr Sierra Nevada Subalpine Lodgepole Pine Forest and Woodland",
        },
        {
          value: 2059,
          color: "79ff5e",
          description: "Tr Southern Rocky Mountain Pinyon-Juniper Woodland",
        },
        {
          value: 2060,
          color: "d6ffb5",
          description: "Tr East Cascades Ponderosa Pine Forest and Woodland",
        },
        {
          value: 2061,
          color: "c0ff8a",
          description: "Tr Inter-Mountain Basins Aspen-Mixed Conifer Forest and Woodland",
        },
        {
          value: 2062,
          color: "9bebd8",
          description: "Tr Inter-Mountain Basins Curl-leaf Mountain Mahogany Woodland and Shrubland",
        },
        {
          value: 2063,
          color: "92e8d7",
          description: "Tr North Pacific Broadleaf Landslide Forest and Shrubland",
        },
        {
          value: 2064,
          color: "ccb687",
          description: "Sh Colorado Plateau Mixed Low Sagebrush Shrubland",
        },
        {
          value: 2065,
          color: "c7b081",
          description: "Sh Columbia Plateau Scabland Shrubland",
        },
        {
          value: 2066,
          color: "c2aa7e",
          description: "Sh Inter-Mountain Basins Mat Saltbush Shrubland",
        },
        {
          value: 2067,
          color: "ffd377",
          description: "Sh Mediterranean California Alpine Fell-Field",
        },
        {
          value: 2068,
          color: "b59c72",
          description: "Sh North Pacific Dry and Mesic Alpine Dwarf-Shrubland or Fell-field or Meadow",
        },
        {
          value: 2070,
          color: "ab916a",
          description: "Sh Rocky Mountain Alpine Dwarf-Shrubland",
        },
        {
          value: 2071,
          color: "ffd377",
          description: "Sh Sierra Nevada Alpine Dwarf-Shrubland",
        },
        {
          value: 2072,
          color: "ccb687",
          description: "Sh Wyoming Basins Dwarf Sagebrush Shrubland and Steppe",
        },
        {
          value: 2073,
          color: "a68b6b",
          description: "Sh Baja Semi-Desert Coastal Succulent Scrub",
        },
        {
          value: 2074,
          color: "a18660",
          description: "Sh Chihuahuan Creosotebush Desert Scrub",
        },
        {
          value: 2075,
          color: "9c805c",
          description: "Sh Chihuahuan Mixed Salt Desert Scrub",
        },
        {
          value: 2076,
          color: "967b59",
          description: "Sh Chihuahuan Stabilized Coppice Dune and Sand Flat Scrub",
        },
        {
          value: 2077,
          color: "917554",
          description: "Sh Chihuahuan Succulent Desert Scrub",
        },
        {
          value: 2078,
          color: "8c7050",
          description: "Sh Colorado Plateau Blackbrush-Mormon-tea Shrubland",
        },
        {
          value: 2079,
          color: "876a4c",
          description: "Sh Great Basin Xeric Mixed Sagebrush Shrubland",
        },
        {
          value: 2080,
          color: "826548",
          description: "Sh Inter-Mountain Basins Big Sagebrush Shrubland",
        },
        {
          value: 2081,
          color: "9c805c",
          description: "Sh Inter-Mountain Basins Mixed Salt Desert Scrub",
        },
        {
          value: 2082,
          color: "8c7050",
          description: "Sh Mojave Mid-Elevation Mixed Desert Scrub",
        },
        {
          value: 2083,
          color: "806145",
          description: "Sh North Pacific Avalanche Chute Shrubland",
        },
        {
          value: 2084,
          color: "806145",
          description: "Sh North Pacific Montane Shrubland",
        },
        {
          value: 2085,
          color: "7a5d41",
          description: "Sh Northwestern Great Plains Shrubland",
        },
        {
          value: 2086,
          color: "75573d",
          description: "Sh Rocky Mountain Lower Montane-Foothill Shrubland",
        },
        {
          value: 2087,
          color: "a18660",
          description: "Sh Sonora-Mojave Creosotebush-White Bursage Desert Scrub",
        },
        {
          value: 2088,
          color: "9c805c",
          description: "Sh Sonora-Mojave Mixed Salt Desert Scrub",
        },
        {
          value: 2090,
          color: "a18660",
          description: "Sh Sonoran Granite Outcrop Desert Scrub",
        },
        {
          value: 2091,
          color: "a18660",
          description: "Sh Sonoran Mid-Elevation Desert Scrub",
        },
        {
          value: 2092,
          color: "a68b6b",
          description: "Sh Southern California Coastal Scrub",
        },
        {
          value: 2093,
          color: "705239",
          description: "Sh Southern Colorado Plateau Sand Shrubland",
        },
        {
          value: 2094,
          color: "705239",
          description: "Sh Western Great Plains Sandhill Steppe",
        },
        {
          value: 2095,
          color: "967b59",
          description: "Sh Apacherian-Chihuahuan Mesquite Upland Scrub",
        },
        {
          value: 2096,
          color: "6b4d36",
          description: "Sh California Maritime Chaparral",
        },
        {
          value: 2097,
          color: "3b1e13",
          description: "Sh California Mesic Chaparral",
        },
        {
          value: 2098,
          color: "422518",
          description: "Sh Northern California Montane Woodland and Chaparral",
        },
        {
          value: 2099,
          color: "422518",
          description: "Sh California Xeric Serpentine Chaparral",
        },
        {
          value: 2100,
          color: "4a2c1d",
          description: "Sh Chihuahuan Mixed Desert and Thornscrub",
        },
        {
          value: 2101,
          color: "917554",
          description: "Sh Madrean Oriental Chaparral",
        },
        {
          value: 2102,
          color: "79ff5e",
          description: "Sh Colorado Plateau Pinyon-Juniper Shrubland",
        },
        {
          value: 2103,
          color: "593b28",
          description: "Sh Great Basin Semi-Desert Chaparral",
        },
        {
          value: 2104,
          color: "593b28",
          description: "Sh Mogollon Chaparral",
        },
        {
          value: 2105,
          color: "63452f",
          description: "Sh Northern and Central California Dry-Mesic Chaparral",
        },
        {
          value: 2106,
          color: "75573d",
          description: "Sh Northern Rocky Mountain Montane-Foothill Deciduous Shrubland",
        },
        {
          value: 2107,
          color: "f5af36",
          description: "Sh Rocky Mountain Gambel Oak-Mixed Montane Shrubland",
        },
        {
          value: 2108,
          color: "593b28",
          description: "Sh Sonora-Mojave Semi-Desert Chaparral",
        },
        {
          value: 2109,
          color: "f2a830",
          description: "Sh Sonoran Paloverde-Mixed Cacti Desert Scrub",
        },
        {
          value: 2110,
          color: "63452f",
          description: "Sh Southern California Dry-Mesic Chaparral",
        },
        {
          value: 2111,
          color: "967b59",
          description: "Sh Western Great Plains Mesquite Woodland and Shrubland",
        },
        {
          value: 2112,
          color: "8ae3d4",
          description: "Tr California Central Valley Mixed Oak Savanna",
        },
        {
          value: 2113,
          color: "83de6e",
          description: "Tr California Coastal Live Oak Woodland and Savanna",
        },
        {
          value: 2114,
          color: "79d9cf",
          description: "Tr California Lower Montane Foothill Pine Woodland and Savanna",
        },
        {
          value: 2115,
          color: "4eff3b",
          description: "Tr Inter-Mountain Basins Juniper Savanna",
        },
        {
          value: 2116,
          color: "917554",
          description: "Tr Madrean Juniper Savanna",
        },
        {
          value: 2117,
          color: "d6ffb5",
          description: "Tr Southern Rocky Mountain Ponderosa Pine Savanna",
        },
        {
          value: 2118,
          color: "83de6e",
          description: "Tr Southern California Oak Woodland and Savanna",
        },
        {
          value: 2119,
          color: "79ff5e",
          description: "Tr Southern Rocky Mountain Juniper Woodland and Savanna",
        },
        {
          value: 2120,
          color: "cbffab",
          description: "Tr Willamette Valley Upland Prairie and Savanna",
        },
        {
          value: 2121,
          color: "ffcc33",
          description: "Sh Apacherian-Chihuahuan Semi-Desert Grassland and Steppe",
        },
        {
          value: 2122,
          color: "ffcc33",
          description: "He Chihuahuan Gypsophilous Grassland and Steppe",
        },
        {
          value: 2123,
          color: "c7b081",
          description: "He Columbia Plateau Steppe and Grassland",
        },
        {
          value: 2124,
          color: "876a4c",
          description: "Sh Columbia Plateau Low Sagebrush Steppe",
        },
        {
          value: 2125,
          color: "e69729",
          description: "Sh Inter-Mountain Basins Big Sagebrush Steppe",
        },
        {
          value: 2126,
          color: "db8c25",
          description: "Sh Inter-Mountain Basins Montane Sagebrush Steppe",
        },
        {
          value: 2127,
          color: "826548",
          description: "Sh Inter-Mountain Basins Semi-Desert Shrub-Steppe",
        },
        {
          value: 2128,
          color: "c9741e",
          description: "Sh Northern California Coastal Scrub",
        },
        {
          value: 2129,
          color: "ffeb99",
          description: "He California Central Valley and Southern Coastal Grassland",
        },
        {
          value: 2130,
          color: "ffeb99",
          description: "He California Mesic Serpentine Grassland",
        },
        {
          value: 2131,
          color: "fff894",
          description: "He California Northern Coastal Grassland",
        },
        {
          value: 2132,
          color: "fff18c",
          description: "Sh Central Mixedgrass Prairie",
        },
        {
          value: 2133,
          color: "ffe987",
          description: "He Chihuahuan Sandy Plains Semi-Desert Grassland",
        },
        {
          value: 2134,
          color: "ffe282",
          description: "He Columbia Basin Foothill and Canyon Dry Grassland",
        },
        {
          value: 2135,
          color: "ffc87d",
          description: "He Inter-Mountain Basins Semi-Desert Grassland",
        },
        {
          value: 2136,
          color: "ffd377",
          description: "He Mediterranean California Alpine Dry Tundra",
        },
        {
          value: 2137,
          color: "ffcd70",
          description: "He Mediterranean California Subalpine Meadow",
        },
        {
          value: 2138,
          color: "ffc66b",
          description: "He North Pacific Montane Grassland",
        },
        {
          value: 2139,
          color: "ffbf66",
          description: "He Northern Rocky Mountain Lower Montane-Foothill-Valley Grassland",
        },
        {
          value: 2140,
          color: "ffb861",
          description: "He Northern Rocky Mountain Subalpine-Upper Montane Grassland",
        },
        {
          value: 2141,
          color: "ffb05c",
          description: "He Northwestern Great Plains Mixedgrass Prairie",
        },
        {
          value: 2142,
          color: "ffc66b",
          description: "He Columbia Basin Palouse Prairie",
        },
        {
          value: 2143,
          color: "ab916a",
          description: "He Rocky Mountain Alpine Fell-Field",
        },
        {
          value: 2144,
          color: "ab916a",
          description: "He Rocky Mountain Alpine Turf",
        },
        {
          value: 2145,
          color: "ffa352",
          description: "He Rocky Mountain Subalpine-Montane Mesic Meadow",
        },
        {
          value: 2146,
          color: "ab916a",
          description: "He Southern Rocky Mountain Montane-Subalpine Grassland",
        },
        {
          value: 2147,
          color: "ff9d4d",
          description: "He Western Great Plains Foothill and Piedmont Grassland",
        },
        {
          value: 2148,
          color: "ff9447",
          description: "He Western Great Plains Sand Prairie",
        },
        {
          value: 2149,
          color: "ff8e42",
          description: "He Western Great Plains Shortgrass Prairie",
        },
        {
          value: 2150,
          color: "ff8940",
          description: "He Western Great Plains Tallgrass Prairie",
        },
        {
          value: 2151,
          color: "51b48d",
          description: "Tr California Central Valley Riparian Woodland and Shrubland",
        },
        {
          value: 2152,
          color: "51b48d",
          description: "Tr California Montane Riparian Systems",
        },
        {
          value: 2153,
          color: "c2aa7e",
          description: "Sh Inter-Mountain Basins Greasewood Flat",
        },
        {
          value: 2154,
          color: "49abba",
          description: "Tr Inter-Mountain Basins Montane Riparian Systems",
        },
        {
          value: 2155,
          color: "51b48d",
          description: "Tr North American Warm Desert Riparian Systems",
        },
        {
          value: 2156,
          color: "43a2b5",
          description: "Tr North Pacific Lowland Riparian Forest and Shrubland",
        },
        {
          value: 2157,
          color: "43a2b5",
          description: "Tr North Pacific Swamp Systems",
        },
        {
          value: 2158,
          color: "43a2b5",
          description: "Tr North Pacific Montane Riparian Woodland and Shrubland",
        },
        {
          value: 2159,
          color: "49abba",
          description: "Tr Rocky Mountain Montane Riparian Systems",
        },
        {
          value: 2160,
          color: "b86018",
          description: "Tr Rocky Mountain Subalpine/Upper Montane Riparian Systems",
        },
        {
          value: 2161,
          color: "49abba",
          description: "Tr Northern Rocky Mountain Conifer Swamp",
        },
        {
          value: 2162,
          color: "06357a",
          description: "Tr Western Great Plains Floodplain Systems",
        },
        {
          value: 2163,
          color: "ff7f3b",
          description: "He Pacific Coastal Marsh Systems",
        },
        {
          value: 2164,
          color: "b86018",
          description: "He Rocky Mountain Wetland-Herbaceous",
        },
        {
          value: 2165,
          color: "3792ad",
          description: "Tr Northern Rocky Mountain Foothill Conifer Wooded Steppe",
        },
        {
          value: 2166,
          color: "003300",
          description: "Tr Middle Rocky Mountain Montane Douglas-fir Forest and Woodland",
        },
        {
          value: 2167,
          color: "a3f0db",
          description: "Tr Rocky Mountain Poor-Site Lodgepole Pine Forest",
        },
        {
          value: 2168,
          color: "806145",
          description: "Sh Northern Rocky Mountain Avalanche Chute Shrubland",
        },
        {
          value: 2169,
          color: "806145",
          description: "Sh Northern Rocky Mountain Subalpine Deciduous Shrubland",
        },
        {
          value: 2170,
          color: "e0fcc0",
          description: "Tr Klamath-Siskiyou Xeromorphic Serpentine Savanna and Chaparral",
        },
        {
          value: 2171,
          color: "ff7230",
          description: "He North Pacific Alpine and Subalpine Dry Grassland",
        },
        {
          value: 2172,
          color: "00cc00",
          description: "Tr Sierran-Intermontane Desert Western White Pine-White Fir Woodland",
        },
        {
          value: 2173,
          color: "a3f0db",
          description: "Tr North Pacific Wooded Volcanic Flowage",
        },
        {
          value: 2174,
          color: "004700",
          description: "Tr North Pacific Dry-Mesic Silver Fir-Western Hemlock-Douglas-fir Forest",
        },
        {
          value: 2176,
          color: "b86018",
          description: "He Rocky Mountain Alpine-Montane Wet Meadow",
        },
        {
          value: 2177,
          color: "e0fcc0",
          description: "Tr California Coastal Closed-Cone Conifer Forest and Woodland",
        },
        {
          value: 2178,
          color: "042d75",
          description: "Tr North Pacific Hypermaritime Western Red-cedar-Western Hemlock Forest",
        },
        {
          value: 2179,
          color: "d6ffb5",
          description: "Tr Northwestern Great Plains-Black Hills Ponderosa Pine Woodland and Savanna",
        },
        {
          value: 2180,
          color: "ff692e",
          description: "Tr Introduced Riparian Vegetation",
        },
        {
          value: 2181,
          color: "ff692e",
          description: "He Introduced Upland Vegetation-Annual Grassland",
        },
        {
          value: 2182,
          color: "ff692e",
          description: "He Introduced Upland Vegetation-Perennial Grassland and Forbland",
        },
        {
          value: 2183,
          color: "ff692e",
          description: "He Introduced Upland Vegetation-Annual and Biennial Forbland",
        },
        {
          value: 2184,
          color: "ff692e",
          description: "He California Annual Grassland",
        },
        {
          value: 2185,
          color: "0084a8",
          description: "Tr Introduced Wetland Vegetation",
        },
        {
          value: 2186,
          color: "ff692e",
          description: "Sh Introduced Upland Vegetation-Shrub",
        },
        {
          value: 2187,
          color: "ff692e",
          description: "Tr Introduced Upland Vegetation-Treed",
        },
        {
          value: 2190,
          color: "ff3b14",
          description: "Sh Recently Burned-Shrub Cover",
        },
        {
          value: 2191,
          color: "ff4419",
          description: "He Recently Logged-Herb and Grass Cover",
        },
        {
          value: 2192,
          color: "ff4419",
          description: "Sh Recently Logged-Shrub Cover",
        },
        {
          value: 2193,
          color: "ff4419",
          description: "Tr Recently Logged-Tree Cover",
        },
        {
          value: 2194,
          color: "ff3b14",
          description: "Tr Ruderal Upland-Treed",
        },
        {
          value: 2195,
          color: "ff3b14",
          description: "He Recently Burned-Herb and Grass Cover",
        },
        {
          value: 2197,
          color: "ff3b14",
          description: "Tr Recently Burned-Tree Cover",
        },
        {
          value: 2198,
          color: "ff4419",
          description: "He Recently Disturbed-Herb and Grass Cover",
        },
        {
          value: 2199,
          color: "ff4419",
          description: "Sh Recently Disturbed-Shrub Cover",
        },
        {
          value: 2200,
          color: "008200",
          description: "Tr Coastal Douglas-fir Woodland",
        },
        {
          value: 2201,
          color: "cbffab",
          description: "Tr Quercus garryana Woodland Alliance",
        },
        {
          value: 2202,
          color: "6cff52",
          description: "Tr Juniperus occidentalis Wooded Herbaceous Alliance",
        },
        {
          value: 2203,
          color: "195d91",
          description: "Tr Juniperus occidentalis Woodland Alliance",
        },
        {
          value: 2204,
          color: "ff4419",
          description: "Tr Recently Disturbed-Tree Cover",
        },
        {
          value: 2205,
          color: "004700",
          description: "Tr Tsuga mertensiana-Abies amabilis Woodland Alliance",
        },
        {
          value: 2206,
          color: "008200",
          description: "Tr Pseudotsuga menziesii Giant Forest Alliance",
        },
        {
          value: 2208,
          color: "00cc00",
          description: "Tr Abies concolor Forest Alliance",
        },
        {
          value: 2209,
          color: "422518",
          description: "Sh Southern California Montane Woodland and Chaparral",
        },
        {
          value: 2210,
          color: "8c7050",
          description: "Sh Coleogyne ramosissima Shrubland Alliance",
        },
        {
          value: 2211,
          color: "9c805c",
          description: "Sh Grayia spinosa Shrubland Alliance",
        },
        {
          value: 2213,
          color: "8c2f0a",
          description: "Sh Quercus havardii Shrubland Alliance",
        },
        {
          value: 2214,
          color: "593b28",
          description: "Sh Arctostaphylos patula Shrubland Alliance",
        },
        {
          value: 2215,
          color: "593b28",
          description: "Sh Quercus turbinella Shrubland Alliance",
        },
        {
          value: 2216,
          color: "593b28",
          description: "Sh Cercocarpus montanus Shrubland Alliance",
        },
        {
          value: 2217,
          color: "f5af36",
          description: "Sh Quercus gambelii Shrubland Alliance",
        },
        {
          value: 2218,
          color: "646464",
          description: "Sps North American Warm Desert Sparsely Vegetated Systems II",
        },
        {
          value: 2219,
          color: "646464",
          description: "Sps Inter-Mountain Basins Sparsely Vegetated Systems II",
        },
        {
          value: 2220,
          color: "db8c25",
          description: "Sh Artemisia tridentata ssp. vaseyana Shrubland Alliance",
        },
        {
          value: 2221,
          color: "646464",
          description: "Sps Mediterranean California Sparsely Vegetated Systems II",
        },
        {
          value: 2222,
          color: "646464",
          description: "Sps Rocky Mountain Alpine/Montane Sparsely Vegetated Systems II",
        },
        {
          value: 2223,
          color: "646464",
          description: "Sps Sonoran Desert Sparsely Vegetated",
        },
        {
          value: 2224,
          color: "fa6438",
          description: "He Inter-Mountain Basins Alkaline Closed Depression",
        },
        {
          value: 2225,
          color: "fa6438",
          description: "He North American Arid West Emergent Marsh",
        },
        {
          value: 2226,
          color: "00ed00",
          description: "Tr Madrean Mesic Canyon Forest and Woodland",
        },
        {
          value: 2227,
          color: "003300",
          description: "Tr Pseudotsuga menziesii Forest Alliance",
        },
        {
          value: 2228,
          color: "b4ff94",
          description: "Tr Larix occidentalis Forest Alliance",
        },
        {
          value: 2229,
          color: "bfffe9",
          description: "Tr Pinus albicaulis Woodland Alliance",
        },
        {
          value: 2230,
          color: "79d9cf",
          description: "Tr Pinus sabiniana Woodland Alliance",
        },
        {
          value: 2231,
          color: "00de00",
          description: "Tr Sequoiadendron giganteum Forest Alliance",
        },
        {
          value: 2232,
          color: "60ff47",
          description: "Tr Abies grandis Forest Forest",
        },
        {
          value: 2233,
          color: "523422",
          description: "He North Pacific Herbaceous Bald and Bluff",
        },
        {
          value: 2234,
          color: "c9741e",
          description: "Sh North Pacific Hypermaritime Shrub and Herbaceous Headland",
        },
        {
          value: 2235,
          color: "008200",
          description: "Tr North Pacific Lowland Mixed Hardwood-Conifer Forest",
        },
        {
          value: 2236,
          color: "ff7f3b",
          description: "He Temperate Pacific Subalpine-Montane Wet Meadow",
        },
        {
          value: 2238,
          color: "aef5e0",
          description: "Tr Laurentian-Acadian Northern Oak Forest",
        },
        {
          value: 2239,
          color: "aef5e0",
          description: "Tr Laurentian-Acadian Northern Pine-Oak Forest",
        },
        {
          value: 2240,
          color: "005c00",
          description: "Tr Laurentian-Acadian Hardwood Forest",
        },
        {
          value: 2241,
          color: "005c00",
          description: "Tr Laurentian-Acadian Pine-Hemlock-Hardwood Forest",
        },
        {
          value: 2242,
          color: "aef5e0",
          description: "Tr Laurentian Oak Barrens",
        },
        {
          value: 2243,
          color: "aef5e0",
          description: "Tr Laurentian Pine-Oak Barrens",
        },
        {
          value: 2244,
          color: "b6fae3",
          description: "Tr Boreal Hardwood Forest",
        },
        {
          value: 2245,
          color: "b6fae3",
          description: "Tr Boreal White Spruce-Fir-Hardwood Forest",
        },
        {
          value: 2246,
          color: "aef5e0",
          description: "Tr Laurentian Jack Pine-Red Pine Forest",
        },
        {
          value: 2251,
          color: "ff6229",
          description: "He Great Lakes Dune Grassland",
        },
        {
          value: 2260,
          color: "00bd00",
          description: "Tr Mediterranean California Lower Montane Black Oak Forest and Woodland",
        },
        {
          value: 2261,
          color: "00bd00",
          description: "Tr Mediterranean California Lower Montane Black Oak - Conifer Forest and Woodland",
        },
        {
          value: 2262,
          color: "d6ffb5",
          description: "Tr East Cascades Oak Forest and Woodland",
        },
        {
          value: 2263,
          color: "d6ffb5",
          description: "Tr East Cascades Oak - Ponderosa Pine Forest and Woodland",
        },
        {
          value: 2264,
          color: "79d9cf",
          description: "Tr California Lower Montane Blue Oak Forest and Woodland",
        },
        {
          value: 2265,
          color: "79d9cf",
          description: "Tr California Lower Montane Blue Oak-Foothill Pine Forest and Woodland",
        },
        {
          value: 2266,
          color: "008200",
          description: "Tr Oregon White Oak Woodland",
        },
        {
          value: 2267,
          color: "008200",
          description: "Tr Douglas-fir - Oregon White Oak Woodland",
        },
        {
          value: 2270,
          color: "ff692e",
          description: "Sh California Ruderal Grassland Meadow & Scrub",
        },
        {
          value: 2271,
          color: "ff3b14",
          description: "Tr Californian Ruderal Forest",
        },
        {
          value: 2272,
          color: "ff692e",
          description: "He Great Basin & Intermountain Introduced Annual and Biennial Forbland",
        },
        {
          value: 2273,
          color: "ff692e",
          description: "He Great Basin & Intermountain Introduced Annual Grassland",
        },
        {
          value: 2274,
          color: "ff692e",
          description: "He Great Basin & Intermountain Introduced Perennial Grassland and Forbland",
        },
        {
          value: 2275,
          color: "ff692e",
          description: "Sh North American Warm Desert Ruderal & Planted Scrub & Grassland",
        },
        {
          value: 2276,
          color: "ff692e",
          description: "Sh North Pacific Maritime Coastal Sand Dune Ruderal Scrub & Herb Vegetation",
        },
        {
          value: 2277,
          color: "ff692e",
          description: "Sh Southern Vancouverian Lowland Ruderal Grassland & Shrubland",
        },
        {
          value: 2278,
          color: "ff692e",
          description: "Tr Interior West Ruderal Riparian Forest & Scrub",
        },
        {
          value: 2279,
          color: "ff692e",
          description: "Sh Interior Western North American Temperate Ruderal Grassland & Shrubland",
        },
        {
          value: 2280,
          color: "ff692e",
          description: "Sh Western North American Ruderal Wet Shrubland Meadow & Marsh",
        },
        {
          value: 2282,
          color: "ff692e",
          description: "Sh Great Basin & Intermountain Ruderal Shrubland",
        },
        {
          value: 2301,
          color: "c0ff8a",
          description: "Tr Boreal Aspen-Birch Forest",
        },
        {
          value: 2302,
          color: "abff8a",
          description: "Tr Laurentian-Acadian Northern Hardwoods Forest",
        },
        {
          value: 2303,
          color: "55bbc2",
          description: "Tr Northeastern Interior Dry-Mesic Oak Forest",
        },
        {
          value: 2304,
          color: "55bbc2",
          description: "Tr Ozark-Ouachita Dry-Mesic Oak Forest",
        },
        {
          value: 2305,
          color: "0d4585",
          description: "Tr Southern Interior Low Plateau Dry-Mesic Oak Forest",
        },
        {
          value: 2306,
          color: "55bbc2",
          description: "Tr East Gulf Coastal Plain Northern Loess Plain Oak-Hickory Upland",
        },
        {
          value: 2307,
          color: "55bbc2",
          description: "Tr East Gulf Coastal Plain Northern Dry Upland Hardwood Forest",
        },
        {
          value: 2308,
          color: "55bbc2",
          description: "Tr Crosstimbers Oak Forest and Woodland",
        },
        {
          value: 2309,
          color: "d8d8bf",
          description: "Tr Southern Appalachian Northern Hardwood Forest",
        },
        {
          value: 2310,
          color: "55bbc2",
          description: "Tr North-Central Interior Dry-Mesic Oak Forest and Woodland",
        },
        {
          value: 2311,
          color: "55bbc2",
          description: "Tr North-Central Interior Dry Oak Forest and Woodland",
        },
        {
          value: 2312,
          color: "55bbc2",
          description: "Tr Ouachita Montane Oak Forest",
        },
        {
          value: 2313,
          color: "005c00",
          description: "Tr North-Central Interior Beech-Maple Forest",
        },
        {
          value: 2314,
          color: "abff8a",
          description: "Tr North-Central Interior Maple-Basswood Forest",
        },
        {
          value: 2315,
          color: "0d4585",
          description: "Tr Southern Appalachian Oak Forest",
        },
        {
          value: 2316,
          color: "55bbc2",
          description: "Tr Southern Piedmont Mesic Forest",
        },
        {
          value: 2317,
          color: "0d4585",
          description: "Tr Allegheny-Cumberland Dry Oak Forest and Woodland",
        },
        {
          value: 2318,
          color: "124c87",
          description: "Tr Southern and Central Appalachian Cove Forest",
        },
        {
          value: 2319,
          color: "852708",
          description: "Tr Atlantic Coastal Plain Northern Bog",
        },
        {
          value: 2320,
          color: "55bbc2",
          description: "Tr Central and Southern Appalachian Montane Oak Forest",
        },
        {
          value: 2321,
          color: "002673",
          description: "Tr South-Central Interior Mesophytic Forest",
        },
        {
          value: 2322,
          color: "55bbc2",
          description: "Tr Crowley's Ridge Mesic Loess Slope Forest",
        },
        {
          value: 2323,
          color: "91ff73",
          description: "Tr West Gulf Coastal Plain Mesic Hardwood Forest",
        },
        {
          value: 2324,
          color: "55bbc2",
          description: "Tr Northern Atlantic Coastal Plain Hardwood Forest",
        },
        {
          value: 2325,
          color: "9fff80",
          description: "Tr East Gulf Coastal Plain Northern Mesic Hardwood Slope Forest",
        },
        {
          value: 2326,
          color: "55bbc2",
          description: "Tr South-Central Interior/Upper Coastal Plain Flatwoods",
        },
        {
          value: 2327,
          color: "55bbc2",
          description: "Tr East Gulf Coastal Plain Northern Loess Bluff Forest",
        },
        {
          value: 2328,
          color: "64ccce",
          description: "Tr Southern Coastal Plain Limestone Forest",
        },
        {
          value: 2329,
          color: "64ccce",
          description: "Tr East Gulf Coastal Plain Southern Loess Bluff Forest",
        },
        {
          value: 2330,
          color: "91ff73",
          description: "Tr Southern Coastal Plain Dry Upland Hardwood Forest",
        },
        {
          value: 2331,
          color: "c0ff8a",
          description: "Tr Eastern Great Plains Tallgrass Aspen Parkland",
        },
        {
          value: 2333,
          color: "3c717e",
          description: "Tr South Florida Hardwood Hammock",
        },
        {
          value: 2334,
          color: "55bbc2",
          description: "Tr Ozark-Ouachita Mesic Hardwood Forest",
        },
        {
          value: 2335,
          color: "91ff73",
          description: "Tr Southern Atlantic Coastal Plain Dry and Dry-Mesic Oak Forest",
        },
        {
          value: 2336,
          color: "3c717e",
          description: "Tr Southwest Florida Coastal Strand and Maritime Hammock",
        },
        {
          value: 2337,
          color: "3c717e",
          description: "Tr Southeast Florida Coastal Strand and Maritime Hammock",
        },
        {
          value: 2338,
          color: "91ff73",
          description: "Tr Central and South Texas Coastal Fringe Forest and Woodland",
        },
        {
          value: 2339,
          color: "91ff73",
          description: "Tr West Gulf Coastal Plain Chenier and Upper Texas Coastal Fringe Forest and Woodland",
        },
        {
          value: 2340,
          color: "523422",
          description: "Tr Appalachian Shale Barrens",
        },
        {
          value: 2341,
          color: "000000",
          description: "Tr Northwestern Great Plains Canyon",
        },
        {
          value: 2342,
          color: "55bbc2",
          description: "Tr Piedmont Hardpan Woodland and Forest",
        },
        {
          value: 2343,
          color: "91ff73",
          description: "Tr Southern Atlantic Coastal Plain Mesic Hardwood Forest",
        },
        {
          value: 2344,
          color: "aef5e0",
          description: "Tr Boreal Jack Pine-Black Spruce Forest",
        },
        {
          value: 2346,
          color: "74d6cc",
          description: "Tr Atlantic Coastal Plain Fall-line Sandhills Longleaf Pine Woodland",
        },
        {
          value: 2347,
          color: "74d6cc",
          description: "Tr Atlantic Coastal Plain Upland Longleaf Pine Woodland",
        },
        {
          value: 2348,
          color: "74d6cc",
          description: "Tr West Gulf Coastal Plain Upland Longleaf Pine Forest and Woodland",
        },
        {
          value: 2349,
          color: "74d6cc",
          description: "Tr East Gulf Coastal Plain Interior Upland Longleaf Pine Woodland",
        },
        {
          value: 2350,
          color: "9fff80",
          description: "Tr Central and Southern Appalachian Spruce-Fir Forest",
        },
        {
          value: 2351,
          color: "74d6cc",
          description: "Tr Southeastern Interior Longleaf Pine Woodland",
        },
        {
          value: 2352,
          color: "0d4585",
          description: "Tr Southern Appalachian Montane Pine Forest and Woodland",
        },
        {
          value: 2353,
          color: "0a3d80",
          description: "Tr Southern Appalachian Low-Elevation Pine Forest",
        },
        {
          value: 2354,
          color: "74d6cc",
          description: "Tr Northeastern Interior Pine Barrens",
        },
        {
          value: 2355,
          color: "74d6cc",
          description: "Tr Northern Atlantic Coastal Plain Pitch Pine Barrens",
        },
        {
          value: 2356,
          color: "74d6cc",
          description: "Tr Florida Longleaf Pine Sandhill",
        },
        {
          value: 2357,
          color: "91ff73",
          description: "Tr Southern Coastal Plain Mesic Slope Forest",
        },
        {
          value: 2358,
          color: "55bbc2",
          description: "Tr East-Central Texas Plains Pine Forest and Woodland",
        },
        {
          value: 2359,
          color: "55bbc2",
          description: "Tr Northeastern Interior Calcareous Oak Forest",
        },
        {
          value: 2360,
          color: "0d4585",
          description: "Tr South Florida Pine Rockland",
        },
        {
          value: 2361,
          color: "6bd1ce",
          description: "Tr Central Atlantic Coastal Plain Maritime Forest",
        },
        {
          value: 2362,
          color: "aef5e0",
          description: "Tr Laurentian-Acadian Northern Pine Forest",
        },
        {
          value: 2363,
          color: "ff9900",
          description: "Tr Central Interior Highlands Dry Acidic Glade and Barrens",
        },
        {
          value: 2364,
          color: "55bbc2",
          description: "Tr Ozark-Ouachita Dry Oak Woodland",
        },
        {
          value: 2365,
          color: "b6fae3",
          description: "Tr Boreal White Spruce-Fir Forest",
        },
        {
          value: 2366,
          color: "005c00",
          description: "Tr Laurentian-Acadian Pine-Hemlock Forest",
        },
        {
          value: 2367,
          color: "74d6be",
          description: "Tr Ozark-Ouachita Shortleaf Pine Forest and Woodland",
        },
        {
          value: 2368,
          color: "9fff80",
          description: "Tr Southern Piedmont Dry Pine Forest",
        },
        {
          value: 2369,
          color: "0d4585",
          description: "Tr Central Appalachian Dry Pine Forest",
        },
        {
          value: 2370,
          color: "002673",
          description: "Tr Appalachian Hemlock Forest",
        },
        {
          value: 2371,
          color: "91ff73",
          description: "Tr West Gulf Coastal Plain Pine Forest",
        },
        {
          value: 2372,
          color: "74d6be",
          description: "Tr East Gulf Coastal Plain Interior Shortleaf Pine Forest",
        },
        {
          value: 2373,
          color: "ba360e",
          description: "Tr Acadian Low-Elevation Spruce-Fir Forest",
        },
        {
          value: 2374,
          color: "ba360e",
          description: "Tr Acadian-Appalachian Montane Spruce-Fir Forest",
        },
        {
          value: 2375,
          color: "002673",
          description: "Tr Eastern Serpentine Woodland",
        },
        {
          value: 2376,
          color: "55bbc2",
          description: "Tr Southern Ridge and Valley/Cumberland Dry Calcareous Forest",
        },
        {
          value: 2377,
          color: "0d4585",
          description: "Tr Central Appalachian Rocky Pine Woodland",
        },
        {
          value: 2378,
          color: "74d6be",
          description: "Tr West Gulf Coastal Plain Sandhill Shortleaf Pine Forest and Woodland",
        },
        {
          value: 2379,
          color: "91ff73",
          description: "Tr Northern Atlantic Coastal Plain Maritime Forest",
        },
        {
          value: 2380,
          color: "6bd1ce",
          description: "Tr East Gulf Coastal Plain Maritime Forest",
        },
        {
          value: 2381,
          color: "55bbc2",
          description: "Tr Lower Mississippi River Dune Woodland and Forest",
        },
        {
          value: 2382,
          color: "6bd1ce",
          description: "Tr Southern Atlantic Coastal Plain Maritime Forest",
        },
        {
          value: 2383,
          color: "226d99",
          description: "Tr Edwards Plateau Limestone Savanna and Woodland",
        },
        {
          value: 2384,
          color: "91ff73",
          description: "Tr Mississippi Delta Maritime Forest",
        },
        {
          value: 2385,
          color: "806145",
          description: "Tr Western Great Plains Wooded Draw and Ravine",
        },
        {
          value: 2386,
          color: "523422",
          description: "Sh Acadian-Appalachian Alpine Tundra",
        },
        {
          value: 2387,
          color: "91ff73",
          description: "Tr Florida Peninsula Inland Scrub",
        },
        {
          value: 2389,
          color: "523422",
          description: "Tr Acadian-Appalachian Subalpine Woodland and Heath-Krummholz",
        },
        {
          value: 2390,
          color: "523422",
          description: "Sh Tamaulipan Mixed Deciduous Thornscrub",
        },
        {
          value: 2391,
          color: "523422",
          description: "Tr Tamaulipan Mesquite Upland Scrub",
        },
        {
          value: 2392,
          color: "523422",
          description: "Sh Tamaulipan Calcareous Thornscrub",
        },
        {
          value: 2393,
          color: "226d99",
          description: "Sh Edwards Plateau Limestone Shrubland",
        },
        {
          value: 2394,
          color: "06357a",
          description: "Tr North-Central Interior Oak Savanna",
        },
        {
          value: 2395,
          color: "2c7fa3",
          description: "Tr North-Central Oak Barrens",
        },
        {
          value: 2396,
          color: "5bc3c7",
          description: "Tr Tamaulipan Closed Depression Wetland",
        },
        {
          value: 2397,
          color: "523422",
          description: "Tr Nashville Basin Limestone Glade and Woodland",
        },
        {
          value: 2398,
          color: "523422",
          description: "Tr Cumberland Sandstone Glade and Barrens",
        },
        {
          value: 2399,
          color: "002673",
          description: "Tr Southern Piedmont Glade and Barrens",
        },
        {
          value: 2400,
          color: "523422",
          description: "Tr Central Appalachian Alkaline Glade and Woodland",
        },
        {
          value: 2401,
          color: "ff9900",
          description: "Tr Central Interior Highlands Calcareous Glade and Barrens",
        },
        {
          value: 2402,
          color: "000000",
          description: "Sh Llano Estacado Caprock Escarpment and Breaks Shrubland and Steppe",
        },
        {
          value: 2403,
          color: "74d6cc",
          description: "Tr West Gulf Coastal Plain Catahoula Barrens",
        },
        {
          value: 2405,
          color: "ff9900",
          description: "Tr West Gulf Coastal Plain Nepheline Syenite Glade",
        },
        {
          value: 2406,
          color: "9fff80",
          description: "Tr Southern Piedmont Dry Oak Forest",
        },
        {
          value: 2407,
          color: "aef5e0",
          description: "Tr Laurentian Pine Barrens",
        },
        {
          value: 2408,
          color: "523422",
          description: "Tr Alabama Ketona Glade and Woodland",
        },
        {
          value: 2409,
          color: "d8d8bf",
          description: "He Great Lakes Alvar",
        },
        {
          value: 2410,
          color: "226d99",
          description: "Tr Llano Uplift Acidic Forest Woodland and Glade",
        },
        {
          value: 2411,
          color: "ff5c26",
          description: "He Great Lakes Wet-Mesic Lakeplain Prairie",
        },
        {
          value: 2412,
          color: "ff8940",
          description: "He North-Central Interior Sand and Gravel Tallgrass Prairie",
        },
        {
          value: 2413,
          color: "523422",
          description: "Tr Bluegrass Savanna and Woodland",
        },
        {
          value: 2414,
          color: "523422",
          description: "Sh Southern Appalachian Grass and Shrub Bald",
        },
        {
          value: 2415,
          color: "ff9900",
          description: "Tr Arkansas Valley Prairie and Woodland",
        },
        {
          value: 2416,
          color: "523422",
          description: "He Western Highland Rim Prairie and Barrens",
        },
        {
          value: 2417,
          color: "523422",
          description: "He Eastern Highland Rim Prairie and Barrens",
        },
        {
          value: 2418,
          color: "523422",
          description: "He Pennyroyal Karst Plain Prairie and Barrens",
        },
        {
          value: 2419,
          color: "523422",
          description: "He Southern Ridge and Valley Patch Prairie",
        },
        {
          value: 2420,
          color: "ff8940",
          description: "He Northern Tallgrass Prairie",
        },
        {
          value: 2421,
          color: "ff8940",
          description: "He Central Tallgrass Prairie",
        },
        {
          value: 2422,
          color: "ff9447",
          description: "He Texas Blackland Tallgrass Prairie",
        },
        {
          value: 2423,
          color: "ff8940",
          description: "He Southeastern Great Plains Tallgrass Prairie",
        },
        {
          value: 2424,
          color: "ff9900",
          description: "He East-Central Texas Plains Xeric Sandyland",
        },
        {
          value: 2425,
          color: "74d6cc",
          description: "Sh Florida Dry Prairie",
        },
        {
          value: 2426,
          color: "ff9900",
          description: "He Southern Atlantic Coastal Plain Dune and Maritime Grassland",
        },
        {
          value: 2428,
          color: "ff9447",
          description: "He West Gulf Coastal Plain Northern Calcareous Prairie",
        },
        {
          value: 2429,
          color: "ff9447",
          description: "He West Gulf Coastal Plain Southern Calcareous Prairie",
        },
        {
          value: 2430,
          color: "002673",
          description: "Tr Southern Coastal Plain Blackland Prairie and Woodland",
        },
        {
          value: 2431,
          color: "ff9900",
          description: "He Southwest Florida Dune and Coastal Grassland",
        },
        {
          value: 2433,
          color: "ff9447",
          description: "Tr East Gulf Coastal Plain Jackson Prairie and Woodland",
        },
        {
          value: 2434,
          color: "ff8940",
          description: "He Texas-Louisiana Coastal Prairie",
        },
        {
          value: 2435,
          color: "ff9900",
          description: "He East Gulf Coastal Plain Dune and Coastal Grassland",
        },
        {
          value: 2436,
          color: "ff6229",
          description: "Sh Northern Atlantic Coastal Plain Dune and Swale",
        },
        {
          value: 2437,
          color: "ff9900",
          description: "He Central and Upper Texas Coast Dune and Coastal Grassland",
        },
        {
          value: 2438,
          color: "523422",
          description: "He Tamaulipan Savanna Grassland",
        },
        {
          value: 2439,
          color: "ffab57",
          description: "Sh Tamaulipan Lomas",
        },
        {
          value: 2440,
          color: "ff9900",
          description: "He Tamaulipan Clay Grassland",
        },
        {
          value: 2441,
          color: "523422",
          description: "Sh Tamaulipan Saline Thornscrub",
        },
        {
          value: 2442,
          color: "ff7936",
          description: "He South Texas Sand Sheet Grassland",
        },
        {
          value: 2443,
          color: "ff9900",
          description: "He South Texas Dune and Coastal Grassland",
        },
        {
          value: 2444,
          color: "aef5e0",
          description: "Tr Eastern Boreal Floodplain",
        },
        {
          value: 2445,
          color: "5bc3c7",
          description: "Tr South Florida Dwarf Cypress Savanna",
        },
        {
          value: 2446,
          color: "74d6cc",
          description: "Tr South Florida Pine Flatwoods",
        },
        {
          value: 2447,
          color: "5bc3c7",
          description: "Tr South Florida Cypress Dome",
        },
        {
          value: 2448,
          color: "9fff80",
          description: "Tr Southern Piedmont Dry Oak-Pine Forest",
        },
        {
          value: 2449,
          color: "74d6cc",
          description: "Tr Central Atlantic Coastal Plain Wet Longleaf Pine Savanna and Flatwoods",
        },
        {
          value: 2450,
          color: "74d6cc",
          description: "Tr Southern Atlantic Coastal Plain Wet Pine Savanna and Flatwoods",
        },
        {
          value: 2451,
          color: "74d6cc",
          description: "Tr West Gulf Coastal Plain Wet Longleaf Pine Savanna and Flatwoods",
        },
        {
          value: 2452,
          color: "5bc3c7",
          description: "Tr Atlantic Coastal Plain Peatland Pocosin and Canebrake",
        },
        {
          value: 2453,
          color: "74d6cc",
          description: "Tr Central Florida Pine Flatwoods",
        },
        {
          value: 2454,
          color: "74d6cc",
          description: "Tr East Gulf Coastal Plain Near-Coast Pine Flatwoods",
        },
        {
          value: 2455,
          color: "64ccce",
          description: "Tr East Gulf Coastal Plain Southern Loblolly Flatwoods",
        },
        {
          value: 2456,
          color: "74d6cc",
          description: "Tr Northern Atlantic Coastal Plain Pitch Pine Lowland",
        },
        {
          value: 2457,
          color: "91ff73",
          description: "Tr South-Central Interior/Upper Coastal Plain Wet Flatwoods",
        },
        {
          value: 2458,
          color: "91ff73",
          description: "Tr West Gulf Coastal Plain Pine Flatwoods",
        },
        {
          value: 2459,
          color: "5bc3c7",
          description: "Tr Atlantic Coastal Plain Clay-Based Carolina Bay Wetland",
        },
        {
          value: 2460,
          color: "5bc3c7",
          description: "Tr Southern Coastal Plain Nonriverine Cypress Dome",
        },
        {
          value: 2461,
          color: "d8d8bf",
          description: "Tr Southern Coastal Plain Seepage Swamp and Baygall",
        },
        {
          value: 2462,
          color: "d8d8bf",
          description: "Tr West Gulf Coastal Plain Seepage Swamp and Baygall",
        },
        {
          value: 2463,
          color: "0d4585",
          description: "Tr Central Appalachian Dry Oak Forest",
        },
        {
          value: 2464,
          color: "baa377",
          description: "Tr Acadian Near-Boreal Spruce Barrens",
        },
        {
          value: 2465,
          color: "ba360e",
          description: "Tr Acadian Sub-Boreal Spruce Flat",
        },
        {
          value: 2466,
          color: "aef5e0",
          description: "Tr Great Lakes Wooded Dune and Swale",
        },
        {
          value: 2467,
          color: "06357a",
          description: "Tr Tamaulipan Floodplain Forest",
        },
        {
          value: 2468,
          color: "d8d8bf",
          description: "Tr Atlantic Coastal Plain Streamhead Seepage Swamp-Pocosin-Baygall",
        },
        {
          value: 2469,
          color: "06357a",
          description: "Tr Eastern Great Plains Floodplain Systems",
        },
        {
          value: 2470,
          color: "5bc3c7",
          description: "Tr Caribbean Coastal Wetland Systems",
        },
        {
          value: 2471,
          color: "005c00",
          description: "Tr Central Interior and Appalachian Floodplain Systems",
        },
        {
          value: 2472,
          color: "005c00",
          description: "Tr Central Interior and Appalachian Riparian Systems",
        },
        {
          value: 2473,
          color: "91ff73",
          description: "Tr Gulf and Atlantic Coastal Plain Floodplain Systems",
        },
        {
          value: 2474,
          color: "91ff73",
          description: "Tr Gulf and Atlantic Coastal Plain Small Stream Riparian Systems",
        },
        {
          value: 2475,
          color: "3289a8",
          description: "Tr Laurentian-Acadian Floodplain Systems",
        },
        {
          value: 2476,
          color: "06357a",
          description: "Tr Tamaulipan Riparian Systems",
        },
        {
          value: 2477,
          color: "baa377",
          description: "Tr Boreal Acidic Peatland Systems",
        },
        {
          value: 2478,
          color: "5bc3c7",
          description: "Tr Caribbean Swamp System",
        },
        {
          value: 2479,
          color: "005c00",
          description: "Tr Central Interior and Appalachian Swamp Systems",
        },
        {
          value: 2480,
          color: "d8d8bf",
          description: "Tr Gulf and Atlantic Coastal Plain Swamp Systems",
        },
        {
          value: 2481,
          color: "3289a8",
          description: "Tr Laurentian-Acadian Alkaline Conifer-Hardwood Swamp",
        },
        {
          value: 2482,
          color: "5bc3c7",
          description: "He Great Plains Prairie Pothole",
        },
        {
          value: 2483,
          color: "ff9900",
          description: "Tr South Florida Everglades Sawgrass Marsh",
        },
        {
          value: 2484,
          color: "ff9900",
          description: "He South Florida Wet Marl Prairie",
        },
        {
          value: 2485,
          color: "ff9900",
          description: "Tr East Gulf Coastal Plain Savanna and Wet Prairie",
        },
        {
          value: 2486,
          color: "ff9900",
          description: "He Texas Saline Coastal Prairie",
        },
        {
          value: 2487,
          color: "ff8940",
          description: "He Texas-Louisiana Coastal Prairie Pondshore",
        },
        {
          value: 2488,
          color: "5bc3c7",
          description: "He Eastern Great Plains Wet Meadow-Prairie-Marsh",
        },
        {
          value: 2489,
          color: "ff9900",
          description: "Tr Floridian Highlands Freshwater Marsh",
        },
        {
          value: 2490,
          color: "ff9900",
          description: "Sh Gulf and Atlantic Coastal Plain Tidal Marsh Systems",
        },
        {
          value: 2491,
          color: "ff5c26",
          description: "He Acadian Salt Marsh and Estuary Systems",
        },
        {
          value: 2492,
          color: "ff5c26",
          description: "He Great Lakes Coastal Marsh Systems",
        },
        {
          value: 2493,
          color: "5bc3c7",
          description: "Sh Central Interior and Appalachian Shrub-Herbaceous Wetland Systems",
        },
        {
          value: 2494,
          color: "ff5c26",
          description: "Sh Laurentian-Acadian Shrub-Herbaceous Wetland Systems",
        },
        {
          value: 2495,
          color: "ff8940",
          description: "He Western Great Plains Depressional Wetland Systems",
        },
        {
          value: 2496,
          color: "646464",
          description: "Sps Caribbean Coastal Beach Systems",
        },
        {
          value: 2497,
          color: "646464",
          description: "Sps Central Interior and Appalachian Sparsely Vegetated Systems",
        },
        {
          value: 2498,
          color: "646464",
          description: "Sps Gulf and Atlantic Coastal Plain Sparsely Vegetated Systems",
        },
        {
          value: 2499,
          color: "646464",
          description: "Sps Laurentian-Acadian Sparsely Vegetated Systems",
        },
        {
          value: 2501,
          color: "d8d8bf",
          description: "Tr Southern Atlantic Coastal Plain Nonriverine Swamp and Wet Hardwood Forest",
        },
        {
          value: 2502,
          color: "0d4585",
          description: "Tr Central Appalachian Dry Oak-Pine Forest",
        },
        {
          value: 2503,
          color: "ffcc33",
          description: "He Chihuahuan Loamy Plains Desert Grassland",
        },
        {
          value: 2504,
          color: "ffcc33",
          description: "He Chihuahuan-Sonoran Desert Bottomland and Swale Grassland",
        },
        {
          value: 2505,
          color: "55bbc2",
          description: "Tr Ouachita Novaculite Glade and Woodland",
        },
        {
          value: 2506,
          color: "91ff73",
          description: "Tr West Gulf Coastal Plain Nonriverine Wet Hardwood Flatwoods",
        },
        {
          value: 2507,
          color: "74d6be",
          description: "Tr Ozark-Ouachita Shortleaf Pine-Bluestem Woodland",
        },
        {
          value: 2509,
          color: "55bbc2",
          description: "Tr Mississippi River Alluvial Plain Dry-Mesic Loess Slope Forest",
        },
        {
          value: 2510,
          color: "74d6be",
          description: "Tr Crowley's Ridge Sand Forest",
        },
        {
          value: 2511,
          color: "002673",
          description: "Tr Appalachian Northern Hardwood Forest",
        },
        {
          value: 2512,
          color: "002673",
          description: "Tr Appalachian Hemlock-Northern Hardwood Forest",
        },
        {
          value: 2513,
          color: "91ff73",
          description: "Tr Lower Mississippi River Flatwoods",
        },
        {
          value: 2514,
          color: "ff9900",
          description: "He Central Florida Herbaceous Pondshore",
        },
        {
          value: 2515,
          color: "ff9900",
          description: "He Southern Coastal Plain Herbaceous Seep and Bog",
        },
        {
          value: 2516,
          color: "ff9900",
          description: "He Atlantic Coastal Plain Sandhill Seep",
        },
        {
          value: 2517,
          color: "55bbc2",
          description: "Tr Paleozoic Plateau Bluff and Talus",
        },
        {
          value: 2518,
          color: "91ff73",
          description: "Tr North-Central Interior Wet Flatwoods",
        },
        {
          value: 2519,
          color: "55bbc2",
          description: "Tr East-Central Texas Plains Post Oak Savanna and Woodland",
        },
        {
          value: 2522,
          color: "f0a52e",
          description: "Sh Northern Atlantic Coastal Plain Heathland",
        },
        {
          value: 2523,
          color: "226d99",
          description: "Tr Edwards Plateau Dry-Mesic Slope Forest and Woodland",
        },
        {
          value: 2524,
          color: "226d99",
          description: "Tr Edwards Plateau Mesic Canyon",
        },
        {
          value: 2525,
          color: "06357a",
          description: "Tr Edwards Plateau Riparian",
        },
        {
          value: 2526,
          color: "ba360e",
          description: "Tr Laurentian-Acadian Swamp Systems",
        },
        {
          value: 2527,
          color: "74d6be",
          description: "Tr East Gulf Coastal Plain Interior Oak Forest",
        },
        {
          value: 2529,
          color: "000635",
          description: "Tr Edwards Plateau Floodplain Terrace",
        },
        {
          value: 2531,
          color: "ff3b14",
          description: "Tr Ruderal Upland Vegetation",
        },
        {
          value: 2532,
          color: "ff3b14",
          description: "Tr Ruderal Forest-Northern and Central Hardwood and Conifer",
        },
        {
          value: 2533,
          color: "ff3b14",
          description: "Tr Ruderal Forest-Southeast Hardwood and Conifer",
        },
        {
          value: 2534,
          color: "9e430e",
          description: "Tr Managed Tree Plantation-Northern and Central Hardwood and Conifer Plantation Group",
        },
        {
          value: 2535,
          color: "9e430e",
          description: "Tr Managed Tree Plantation-Southeast Conifer and Hardwood Plantation Group",
        },
        {
          value: 2536,
          color: "0084a8",
          description: "Tr Introduced Wetland Vegetation-Tree",
        },
        {
          value: 2538,
          color: "0084a8",
          description: "He Introduced Wetland Vegetation-Herbaceous",
        },
        {
          value: 2539,
          color: "ffcc00",
          description: "Sh Modified/Managed Northern Tallgrass Grassland",
        },
        {
          value: 2540,
          color: "ffcc00",
          description: "Sh Modified/Managed Southern Tallgrass Grassland",
        },
        {
          value: 2543,
          color: "d8d8bf",
          description: "Tr Laurentian-Acadian Calcareous Rocky Outcrop",
        },
        {
          value: 2544,
          color: "aef5e0",
          description: "Tr Boreal Jack Pine-Black Spruce-Hardwood Forest",
        },
        {
          value: 2545,
          color: "74d6cc",
          description: "Tr East Gulf Coastal Plain Near-Coast Pine Wet Flatwoods",
        },
        {
          value: 2546,
          color: "74d6be",
          description: "Tr East Gulf Coastal Plain Interior Shortleaf Pine-Oak Forest",
        },
        {
          value: 2547,
          color: "74d6cc",
          description: "Tr Central Florida Pine Wet Flatwoods",
        },
        {
          value: 2548,
          color: "74d6cc",
          description: "Tr South Florida Pine Wet Flatwoods",
        },
        {
          value: 2549,
          color: "5bc3c7",
          description: "Tr Southeastern Coastal Plain Natural Lakeshore",
        },
        {
          value: 2550,
          color: "91ff73",
          description: "Tr Pinus taeda Forest Alliance",
        },
        {
          value: 2551,
          color: "0d4585",
          description: "Tr Pinus elliottii Saturated Temperate Woodland Alliance",
        },
        {
          value: 2552,
          color: "74d6cc",
          description: "Tr Pinus palustris-Pinus elliottii Forest Alliance",
        },
        {
          value: 2553,
          color: "74d6cc",
          description: "Tr Mixed Loblolly-Slash Pine",
        },
        {
          value: 2554,
          color: "ba360e",
          description: "Tr Acadian Low-Elevation Hardwood Forest",
        },
        {
          value: 2555,
          color: "ba360e",
          description: "Tr Acadian Low-Elevation Spruce-Fir-Hardwood Forest",
        },
        {
          value: 2556,
          color: "0d4585",
          description: "Tr Central Appalachian Rocky Oak Woodland",
        },
        {
          value: 2557,
          color: "0d4585",
          description: "Tr Central Appalachian Rocky Pine-Oak Woodland",
        },
        {
          value: 2558,
          color: "523422",
          description: "Tr Northern Appalachian-Acadian Rocky Heath Outcrop",
        },
        {
          value: 2559,
          color: "000000",
          description: "Tr Laurentian Acidic Rocky Outcrop",
        },
        {
          value: 2560,
          color: "55bbc2",
          description: "Tr North-Central Interior Quartzite Glade",
        },
        {
          value: 2561,
          color: "00ff69",
          description: "Sh Great Plains Comanchian Ruderal Grassland & Shrubland",
        },
        {
          value: 2562,
          color: "9e430e",
          description: "Tr Northeastern North American Temperate Forest Plantation",
        },
        {
          value: 2564,
          color: "00ff69",
          description: "Tr Northern & Central Exotic Ruderal Forest",
        },
        {
          value: 2565,
          color: "00ff69",
          description: "Tr Northern & Central Native Ruderal Flooded & Swamp Forest",
        },
        {
          value: 2566,
          color: "00ff69",
          description: "Tr Northern & Central Native Ruderal Forest",
        },
        {
          value: 2567,
          color: "00ff69",
          description: "Sh Northern & Central Plains Ruderal & Planted Grassland & Shrubland",
        },
        {
          value: 2568,
          color: "00ff69",
          description: "Sh Northern & Central Ruderal Meadow & Shrubland",
        },
        {
          value: 2569,
          color: "00ff69",
          description: "He Northern & Central Ruderal Wet Meadow & Marsh",
        },
        {
          value: 2570,
          color: "000084",
          description: "Tr Southeastern Exotic Ruderal Flooded & Swamp Forest",
        },
        {
          value: 2571,
          color: "00ff69",
          description: "Tr Southeastern Exotic Ruderal Forest",
        },
        {
          value: 2572,
          color: "0084a8",
          description: "Tr Southeastern Native Ruderal Flooded & Swamp Forest",
        },
        {
          value: 2573,
          color: "00ff69",
          description: "Tr Southeastern Native Ruderal Forest",
        },
        {
          value: 2574,
          color: "9e430e",
          description: "Tr Southeastern North American Temperate Forest Plantation",
        },
        {
          value: 2575,
          color: "00ff69",
          description: "Sh Southeastern Ruderal Grassland & Shrubland",
        },
        {
          value: 2576,
          color: "ff692e",
          description: "He Southeastern Ruderal Wet Meadow & Marsh",
        },
        {
          value: 2577,
          color: "002673",
          description: "Tr Southern and Central Appalachian Mafic Glade and Barrens",
        },
        {
          value: 2578,
          color: "002673",
          description: "Tr Southern Ridge and Valley Calcareous Glade and Woodland",
        },
        {
          value: 2580,
          color: "91ff73",
          description: "Tr Northern Atlantic Coastal Plain Calcareous Ravine",
        },
        {
          value: 2581,
          color: "74d6cc",
          description: "Tr Panhandle Florida Limestone Glade",
        },
        {
          value: 2582,
          color: "74d6be",
          description: "Tr Ozark-Ouachita Oak Forest and Woodland",
        },
        {
          value: 2583,
          color: "74d6be",
          description: "Tr Ozark-Ouachita Shortleaf Pine-Oak Forest and Woodland",
        },
        {
          value: 2584,
          color: "91ff73",
          description: "Tr West Gulf Coastal Plain Hardwood Forest",
        },
        {
          value: 2585,
          color: "91ff73",
          description: "Tr West Gulf Coastal Plain Pine-Hardwood Forest",
        },
        {
          value: 2586,
          color: "74d6be",
          description: "Tr West Gulf Coastal Plain Sandhill Oak Forest and Woodland",
        },
        {
          value: 2587,
          color: "74d6be",
          description: "Tr West Gulf Coastal Plain Sandhill Oak and Shortleaf Pine Forest and Woodland",
        },
        {
          value: 2588,
          color: "64ccce",
          description: "Tr East Gulf Coastal Plain Southern Hardwood Flatwoods",
        },
        {
          value: 2589,
          color: "64ccce",
          description: "Tr East Gulf Coastal Plain Southern Loblolly-Hardwood Flatwoods",
        },
        {
          value: 2590,
          color: "91ff73",
          description: "Tr West Gulf Coastal Plain Hardwood Flatwoods",
        },
        {
          value: 2591,
          color: "91ff73",
          description: "Tr West Gulf Coastal Plain Pine-Hardwood Flatwoods",
        },
        {
          value: 2592,
          color: "ff9900",
          description: "He West Gulf Coastal Plain Flatwoods Pond",
        },
        {
          value: 2593,
          color: "ff9900",
          description: "He East Gulf Coastal Plain Depression Pondshore",
        },
        {
          value: 2594,
          color: "ff9900",
          description: "He Southeastern Coastal Plain Interdunal Wetland",
        },
        {
          value: 2595,
          color: "91ff73",
          description: "Tr Southern Coastal Plain Oak Dome and Hammock",
        },
        {
          value: 2596,
          color: "ff9900",
          description: "He Florida River Floodplain Marsh",
        },
        {
          value: 2597,
          color: "ff9900",
          description: "He West Gulf Coastal Plain Herbaceous Seep and Bog",
        },
        {
          value: 2598,
          color: "ff9900",
          description: "He Southern Atlantic Coastal Plain Depression Pondshore",
        },
        {
          value: 2599,
          color: "ff9900",
          description: "He Central Florida Wet Prairie and Herbaceous Seep",
        },
        {
          value: 2600,
          color: "b6fae3",
          description: "Tr Western North American Boreal White Spruce Forest",
        },
        {
          value: 2601,
          color: "b6fae3",
          description: "Tr Western North American Boreal Treeline White Spruce Woodland",
        },
        {
          value: 2602,
          color: "b6fae3",
          description: "Tr Western North American Boreal Spruce-Lichen Woodland",
        },
        {
          value: 2603,
          color: "b6fae3",
          description: "Tr Alaska Boreal White Spruce Forest",
        },
        {
          value: 2604,
          color: "b6fae3",
          description: "Tr Western North American Boreal Mesic Black Spruce Forest",
        },
        {
          value: 2605,
          color: "005c00",
          description: "Tr Western North American Boreal Mesic Birch-Aspen Forest",
        },
        {
          value: 2606,
          color: "c0ff8a",
          description: "Sh Western North American Boreal Dry Aspen-Steppe Bluff",
        },
        {
          value: 2607,
          color: "124c87",
          description: "Tr Western North American Boreal Subalpine Balsam Poplar-Aspen Woodland",
        },
        {
          value: 2608,
          color: "92ede0",
          description: "Sh Alaska Sub-boreal Avalanche Slope Shrubland",
        },
        {
          value: 2609,
          color: "92ede0",
          description: "Sh Alaska Sub-boreal Mesic Subalpine Alder Shrubland",
        },
        {
          value: 2610,
          color: "49afbc",
          description: "Sh Western North American Boreal Mesic Scrub Birch-Willow Shrubland",
        },
        {
          value: 2611,
          color: "ff1908",
          description: "He Western North American Sub-boreal Mesic Bluejoint Meadow",
        },
        {
          value: 2612,
          color: "ff7230",
          description: "He Western North American Boreal Dry Grassland",
        },
        {
          value: 2617,
          color: "ff9900",
          description: "Sh Western North American Boreal Shrub and Herbaceous Floodplain",
        },
        {
          value: 2618,
          color: "ffcd70",
          description: "Sh Western North American Boreal Shrub-Sedge Rich and Alkaline Fen",
        },
        {
          value: 2621,
          color: "4f241a",
          description: "Tr Western North American Boreal Black Spruce Bog and Dwarf-Tree Peatland",
        },
        {
          value: 2623,
          color: "b6faff",
          description: "Tr Western North American Boreal Black Spruce-Tamarack Fen",
        },
        {
          value: 2624,
          color: "a64c11",
          description: "Sh Western North American Boreal Shrub Swamp",
        },
        {
          value: 2626,
          color: "ffcd70",
          description: "He Western North American Boreal Wet Meadow",
        },
        {
          value: 2630,
          color: "b6faff",
          description: "Tr Western North American Boreal Wet Black Spruce-Tussock Woodland",
        },
        {
          value: 2631,
          color: "d48122",
          description: "Sh Western North American Boreal Alpine Dwarf-Shrub Summit",
        },
        {
          value: 2633,
          color: "ffd377",
          description: "He Western North American Boreal Alpine Mesic Herbaceous Meadow",
        },
        {
          value: 2634,
          color: "ff6600",
          description: "Sh Western North American Boreal Alpine Dryas Dwarf-Shrubland",
        },
        {
          value: 2635,
          color: "d48122",
          description: "Sh Western North American Boreal Alpine Ericaceous Dwarf-Shrubland",
        },
        {
          value: 2636,
          color: "d48122",
          description: "Sh Western North American Boreal Alpine Dwarf-Shrub-Lichen Shrubland",
        },
        {
          value: 2638,
          color: "92ede0",
          description: "Sh Alaska Arctic Mesic Alder Shrubland",
        },
        {
          value: 2639,
          color: "49afbc",
          description: "Sh North American Arctic Mesic-Wet Low Willow Shrubland",
        },
        {
          value: 2640,
          color: "49afbc",
          description: "Sh Aleutian Mesic-Wet Willow Shrubland",
        },
        {
          value: 2641,
          color: "9fff80",
          description: "Tr Western North American Boreal Treeline White Spruce-Hardwood Woodland",
        },
        {
          value: 2642,
          color: "005c00",
          description: "Tr Aleutian Kenai Birch-Cottonwood-Poplar Forest",
        },
        {
          value: 2643,
          color: "d48122",
          description: "Sh Alaskan Pacific Maritime Alpine Dwarf-Shrubland",
        },
        {
          value: 2644,
          color: "007500",
          description: "Tr Alaskan Pacific Maritime Sitka Spruce Forest",
        },
        {
          value: 2645,
          color: "ffd377",
          description: "He Alaska Sub-boreal and Maritime Alpine Mesic Herbaceous Meadow",
        },
        {
          value: 2646,
          color: "042d75",
          description: "Tr Alaskan Pacific Maritime Western Hemlock Forest",
        },
        {
          value: 2648,
          color: "005c00",
          description: "Tr Alaskan Pacific Maritime Mountain Hemlock Forest",
        },
        {
          value: 2649,
          color: "005c00",
          description: "Tr Alaskan Pacific Maritime Subalpine Mountain Hemlock Woodland",
        },
        {
          value: 2650,
          color: "007500",
          description: "Tr Alaskan Pacific Maritime Periglacial Woodland and Shrubland",
        },
        {
          value: 2651,
          color: "ff5521",
          description: "He Aleutian Mesic Herbaceous Meadow",
        },
        {
          value: 2652,
          color: "92ede0",
          description: "Sh Alaskan Pacific Maritime Subalpine Alder-Salmonberry Shrubland",
        },
        {
          value: 2653,
          color: "ff5521",
          description: "He Alaskan Pacific Maritime Mesic Herbaceous Meadow",
        },
        {
          value: 2654,
          color: "007500",
          description: "Tr Alaskan Pacific Maritime Sitka Spruce Beach Ridge",
        },
        {
          value: 2662,
          color: "ff9900",
          description: "He Temperate Pacific Freshwater Emergent Marsh",
        },
        {
          value: 2663,
          color: "a64c11",
          description: "Sh North Pacific Shrub Swamp",
        },
        {
          value: 2665,
          color: "ff0000",
          description: "He Alaskan Pacific Maritime Coastal Meadow and Slough-Levee",
        },
        {
          value: 2667,
          color: "9fff80",
          description: "Tr Alaska Sub-boreal White-Lutz Spruce-Hardwood Forest and Woodland",
        },
        {
          value: 2668,
          color: "ff990a",
          description: "He Temperate Pacific Tidal Salt and Brackish Marsh",
        },
        {
          value: 2671,
          color: "ff0000",
          description: "He Aleutian American Dunegrass Grassland",
        },
        {
          value: 2672,
          color: "92ede0",
          description: "Sh Alaskan Pacific Maritime Subalpine Copperbush Shrubland",
        },
        {
          value: 2674,
          color: "d48122",
          description: "Sps Alaskan Pacific Maritime Alpine Sparse Shrub and Fell-field",
        },
        {
          value: 2675,
          color: "124c87",
          description: "Tr Western North American Boreal Treeline Hardwood-White Spruce Woodland",
        },
        {
          value: 2676,
          color: "ff9900",
          description: "Sh Alaskan Pacific Maritime Alpine Floodplain",
        },
        {
          value: 2677,
          color: "b6fae3",
          description: "Tr Alaska Sub-boreal White-Lutz Spruce Forest and Woodland",
        },
        {
          value: 2678,
          color: "b6fae3",
          description: "Tr Alaska Sub-boreal Mountain Hemlock-White Spruce Forest",
        },
        {
          value: 2679,
          color: "9fff80",
          description: "Tr Alaska Sub-boreal White Spruce-Hardwood Forest",
        },
        {
          value: 2680,
          color: "92ede0",
          description: "Sh Alaskan Pacific Maritime Avalanche Slope Shrubland",
        },
        {
          value: 2681,
          color: "4f241a",
          description: "Tr Alaskan Pacific Poorly Drained Conifer Woodland",
        },
        {
          value: 2682,
          color: "d48122",
          description: "Sh North American Arctic Scrub Birch-Ericaceous Shrubland",
        },
        {
          value: 2683,
          color: "c24415",
          description: "Sh North American Arctic Mesic Sedge-Willow Tundra",
        },
        {
          value: 2684,
          color: "c24415",
          description: "Sh Alaska Arctic Mesic Sedge-Dryas Tundra",
        },
        {
          value: 2685,
          color: "ff6600",
          description: "Sps Alaska Arctic Acidic Sparse Tundra",
        },
        {
          value: 2686,
          color: "ff6600",
          description: "Sps Alaska Arctic Non-Acidic Sparse Tundra",
        },
        {
          value: 2687,
          color: "ff250d",
          description: "He North American Arctic Lichen Tundra",
        },
        {
          value: 2688,
          color: "ff6600",
          description: "Sh Alaska Arctic Acidic Dryas Dwarf-Shrubland",
        },
        {
          value: 2689,
          color: "ff6600",
          description: "Sh Alaska Arctic Non-Acidic Dryas Dwarf-Shrubland",
        },
        {
          value: 2690,
          color: "ff6600",
          description: "Sh Alaska Arctic Dwarf-Shrubland",
        },
        {
          value: 2691,
          color: "ff250d",
          description: "Sh Alaska Arctic Acidic Dwarf-Shrub Lichen Tundra",
        },
        {
          value: 2692,
          color: "ff250d",
          description: "Sh Alaska Arctic Non-Acidic Dwarf-Shrub Lichen Tundra",
        },
        {
          value: 2699,
          color: "ff5521",
          description: "He North American Arctic Mesic Herbaceous Meadow",
        },
        {
          value: 2701,
          color: "ffcd70",
          description: "Sh Alaska Arctic Coastal Sedge-Dwarf-Shrubland",
        },
        {
          value: 2704,
          color: "ff250d",
          description: "Sh Alaska Arctic Permafrost Plateau Dwarf-Shrub Lichen Tundra",
        },
        {
          value: 2709,
          color: "ff0000",
          description: "He Alaska Arctic Marine Beach and Beach Meadow",
        },
        {
          value: 2710,
          color: "ff990a",
          description: "Sps Alaska Arctic Tidal Flat",
        },
        {
          value: 2714,
          color: "124c87",
          description: "Tr Alaska Arctic Large River Floodplain",
        },
        {
          value: 2715,
          color: "124c87",
          description: "Sh Alaska Arctic Floodplain",
        },
        {
          value: 2718,
          color: "92ede0",
          description: "Sh Aleutian Mesic Alder-Salmonberry Shrubland",
        },
        {
          value: 2719,
          color: "4f241a",
          description: "Sh Aleutian Crowberry-Herbaceous Heath",
        },
        {
          value: 2720,
          color: "d48122",
          description: "Sh Aleutian Mixed Dwarf-Shrub-Herbaceous Shrubland",
        },
        {
          value: 2721,
          color: "ff1908",
          description: "He Western North American Boreal Mesic Bluejoint-Forb Meadow",
        },
        {
          value: 2725,
          color: "ff0000",
          description: "He Aleutian Marine Beach and Beach Meadow",
        },
        {
          value: 2730,
          color: "4f241a",
          description: "Sps Aleutian Sparse Heath and Fell-Field",
        },
        {
          value: 2731,
          color: "49afbc",
          description: "Sh Aleutian Oval-leaf Blueberry Shrubland",
        },
        {
          value: 2736,
          color: "646464",
          description: "Sps Unconsolidated Shore",
        },
        {
          value: 2737,
          color: "646464",
          description: "Sps North American Glacial Outwash",
        },
        {
          value: 2740,
          color: "ff9900",
          description: "He Boreal Aquatic Beds",
        },
        {
          value: 2741,
          color: "ff990a",
          description: "He Polar Tidal Marshes and Aquatic Beds",
        },
        {
          value: 2742,
          color: "ff990a",
          description: "He Temperate Pacific Tidal Marshes, Aquatic Beds, and Intertidal Flats",
        },
        {
          value: 2743,
          color: "ff9900",
          description: "He Aleutian Herbaceous Wetlands",
        },
        {
          value: 2744,
          color: "ff9900",
          description: "He Arctic Herbaceous Wetlands",
        },
        {
          value: 2745,
          color: "ffcd70",
          description: "He Boreal Herbaceous Wetlands",
        },
        {
          value: 2746,
          color: "ff9900",
          description: "He Pacific Maritime Herbaceous Wetlands",
        },
        {
          value: 2747,
          color: "ffcd70",
          description: "Sh Arctic Sedge Meadows",
        },
        {
          value: 2748,
          color: "b6fae3",
          description: "Tr Western North American Boreal Mesic White Spruce Forest",
        },
        {
          value: 2749,
          color: "ff0000",
          description: "He Pacific Maritime Coastal Meadows and Slough-Levee",
        },
        {
          value: 2750,
          color: "9fff80",
          description: "Tr Alaska Sub-boreal White Spruce-Hardwood Forest",
        },
        {
          value: 2751,
          color: "4f241a",
          description: "Tr Boreal Coniferous Woody Wetland",
        },
        {
          value: 2752,
          color: "4f241a",
          description: "Tr Pacific Maritime Coniferous Woody Wetland",
        },
        {
          value: 2753,
          color: "b6fae3",
          description: "Tr Boreal Coniferous-Deciduous Woody Wetland",
        },
        {
          value: 2756,
          color: "ffcd70",
          description: "Sh Arctic Dwarf Shrub Wetland",
        },
        {
          value: 2757,
          color: "963a0c",
          description: "Sh Boreal Dwarf Shrub Wetland",
        },
        {
          value: 2758,
          color: "963a0c",
          description: "Sh Pacific Maritime Dwarf Shrub Wetland",
        },
        {
          value: 2761,
          color: "ff9900",
          description: "Tr Aleutian Floodplains",
        },
        {
          value: 2762,
          color: "124c87",
          description: "Sh Arctic Floodplains",
        },
        {
          value: 2763,
          color: "124c87",
          description: "Tr Boreal Floodplains",
        },
        {
          value: 2764,
          color: "124c87",
          description: "Tr Pacific Maritime Floodplains",
        },
        {
          value: 2771,
          color: "852708",
          description: "Sh Aleutian Peatlands",
        },
        {
          value: 2772,
          color: "852708",
          description: "Sh Arctic Peatlands",
        },
        {
          value: 2773,
          color: "852708",
          description: "Sh Boreal Peatlands",
        },
        {
          value: 2774,
          color: "4f241a",
          description: "Tr Pacific Maritime Peatlands",
        },
        {
          value: 2776,
          color: "124c87",
          description: "Tr Boreal Riparian Stringer Forest and Shrubland",
        },
        {
          value: 2777,
          color: "a64c11",
          description: "Sh Boreal Shrub Swamp",
        },
        {
          value: 2778,
          color: "a64c11",
          description: "Sh Pacific Maritime Shrub Swamp",
        },
        {
          value: 2779,
          color: "9fff80",
          description: "Tr Alaska Boreal Hardwood Forest",
        },
        {
          value: 2780,
          color: "9fff80",
          description: "Tr Alaska Boreal White Spruce-Hardwood Forest",
        },
        {
          value: 2781,
          color: "ff3112",
          description: "Sh Arctic Sedge-Tussock-Lichen Tundra",
        },
        {
          value: 2782,
          color: "ff491c",
          description: "He Boreal Tussock Tundra",
        },
        {
          value: 2783,
          color: "ff491c",
          description: "Sh Arctic Tussock Tundra",
        },
        {
          value: 2784,
          color: "ff491c",
          description: "Sh Arctic Shrub-Tussock Tundra",
        },
        {
          value: 2785,
          color: "c24415",
          description: "Sh Arctic Shrub Tundra",
        },
        {
          value: 2786,
          color: "b6fae3",
          description: "Tr Boreal Shrub-Tussock Tundra and Woodland",
        },
        {
          value: 2787,
          color: "9fff80",
          description: "Tr Western North American Boreal Mesic Hardwood-White Spruce Forest",
        },
        {
          value: 2788,
          color: "9fff80",
          description: "Tr Western North American Boreal Mesic White Spruce-Hardwood Forest",
        },
        {
          value: 2789,
          color: "9fff80",
          description: "Tr Alaska Sub-boreal White Spruce-Hardwood Forest",
        },
        {
          value: 2790,
          color: "9fff80",
          description: "Tr Alaska Sub-boreal Hardwood-White-Lutz Spruce Forest and Woodland",
        },
        {
          value: 2791,
          color: "646464",
          description: "Sps Aleutian Sparsely Vegetated",
        },
        {
          value: 2792,
          color: "646464",
          description: "Sps Arctic Sparsely Vegetated",
        },
        {
          value: 2793,
          color: "646464",
          description: "Sps Boreal Sparsely Vegetated",
        },
        {
          value: 2794,
          color: "646464",
          description: "Sps Pacific Maritime Sparsely Vegetated",
        },
        {
          value: 2800,
          color: "ff692e",
          description: "Tr Hawai'i Floodplain Forest",
        },
        {
          value: 2802,
          color: "ff692e",
          description: "Tr Hawai'i Riparian Forest and Shrubland",
        },
        {
          value: 2804,
          color: "ff9900",
          description: "He Hawai'i Freshwater Marsh",
        },
        {
          value: 2806,
          color: "ff7230",
          description: "He Hawai'i Bog",
        },
        {
          value: 2807,
          color: "ff990a",
          description: "He Northern Polynesia Tidal Salt Marsh",
        },
        {
          value: 2808,
          color: "c0ff8a",
          description: "Tr Hawai'i Lowland Rainforest",
        },
        {
          value: 2809,
          color: "c0ff8a",
          description: "Tr Hawai'i Montane Cloud Forest",
        },
        {
          value: 2810,
          color: "c0ff8a",
          description: "Tr Hawai'i Montane Rainforest",
        },
        {
          value: 2811,
          color: "963a0c",
          description: "Sh Hawai'i Wet Cliff and Ridge Crest Shrubland",
        },
        {
          value: 2812,
          color: "005c00",
          description: "Tr Hawai'i Mesic Coastal Forest",
        },
        {
          value: 2813,
          color: "baa377",
          description: "Tr Hawai'i Lowland Dry Forest",
        },
        {
          value: 2814,
          color: "005c00",
          description: "Tr Hawai'i Lowland Mesic Forest",
        },
        {
          value: 2815,
          color: "baa377",
          description: "Tr Hawai'i Montane-Subalpine Dry Forest and Woodland",
        },
        {
          value: 2816,
          color: "005c00",
          description: "Tr Hawai'i Montane-Subalpine Mesic Forest",
        },
        {
          value: 2817,
          color: "9c805c",
          description: "Sh Hawai'i Lowland Dry Shrubland",
        },
        {
          value: 2818,
          color: "963a0c",
          description: "Sh Hawai'i Lowland Mesic Shrubland",
        },
        {
          value: 2819,
          color: "fb7936",
          description: "He Hawai'i Lowland Dry Grassland",
        },
        {
          value: 2820,
          color: "ff7230",
          description: "He Hawai'i Lowland Mesic Grassland",
        },
        {
          value: 2821,
          color: "9c805c",
          description: "Sh Hawai'i Montane-Subalpine Dry Shrubland",
        },
        {
          value: 2822,
          color: "fb7936",
          description: "He Hawai'i Montane-Subalpine Dry Grassland",
        },
        {
          value: 2823,
          color: "ff7230",
          description: "He Hawai'i Montane-Subalpine Mesic Grassland",
        },
        {
          value: 2824,
          color: "963a0c",
          description: "Sh Hawai'i Alpine Dwarf-Shrubland",
        },
        {
          value: 2825,
          color: "9c805c",
          description: "Sh Hawai'i Dry Cliff",
        },
        {
          value: 2826,
          color: "963a0c",
          description: "Sh Hawai'i Dry Coastal Strand Shrubland",
        },
        {
          value: 2827,
          color: "963a0c",
          description: "Sh Hawai'i Wet-Mesic Coastal Strand",
        },
        {
          value: 2828,
          color: "ff7230",
          description: "Sh Hawai'i Subalpine Mesic Shrubland",
        },
        {
          value: 2829,
          color: "646464",
          description: "Sps Hawai'i Alpine Bedrock and Scree",
        },
        {
          value: 2830,
          color: "646464",
          description: "Sh Hawai'i Dry Coastal Strand Sparse Vegetation",
        },
        {
          value: 2831,
          color: "646464",
          description: "Sps Hawai'i Dry-Site Lava Flow",
        },
        {
          value: 2833,
          color: "3fff2e",
          description: "Tr Pacific Islands Limestone Forest",
        },
        {
          value: 2834,
          color: "2aff1f",
          description: "Tr Pacific Islands Littoral/Strand Vegetation",
        },
        {
          value: 2835,
          color: "e0fcc0",
          description: "Tr Pacific Islands Lowland Forest",
        },
        {
          value: 2836,
          color: "ff692e",
          description: "Tr Hawai'i Islands Introduced Wetland Vegetation-Tree",
        },
        {
          value: 2837,
          color: "ff692e",
          description: "Sh Hawai'i Introduced Wetland Vegetation-Shrub",
        },
        {
          value: 2838,
          color: "ff692e",
          description: "He Hawai'i Introduced Wetland Vegetation-Herbaceous",
        },
        {
          value: 2839,
          color: "00ed00",
          description: "Tr Pacific Islands Ravine Forest",
        },
        {
          value: 2840,
          color: "00de00",
          description: "Tr Pacific Islands Savannah",
        },
        {
          value: 2841,
          color: "00cc00",
          description: "Tr Pacific Islands Scrub Forest/Shrub",
        },
        {
          value: 2842,
          color: "43a2b5",
          description: "Sh Pacific Islands Swamp/Marsh",
        },
        {
          value: 2843,
          color: "00bd00",
          description: "Tr Pacific Islands Upland Forest",
        },
        {
          value: 2844,
          color: "79ff5e",
          description: "Tr Pacific Islands Palm Forest",
        },
        {
          value: 2845,
          color: "ff692e",
          description: "Tr Hawai'i Introduced Dry Forest",
        },
        {
          value: 2846,
          color: "ff692e",
          description: "Tr Hawai'i Introduced Wet-Mesic Forest",
        },
        {
          value: 2847,
          color: "ff692e",
          description: "Sh Hawai'i Introduced Deciduous Shrubland",
        },
        {
          value: 2848,
          color: "ff692e",
          description: "He Hawai'i Introduced Perennial Grassland",
        },
        {
          value: 2849,
          color: "ff692e",
          description: "Sh Hawai'i Introduced Evergreen Shrubland",
        },
        {
          value: 2850,
          color: "00ad00",
          description: "Tr Pacific Islands Introduced Forest",
        },
        {
          value: 2851,
          color: "00ed00",
          description: "Tr Pacific Islands Mangrove Forest",
        },
        {
          value: 2852,
          color: "ff692e",
          description: "Tr Hawai'i Introduced Coastal Wetland Vegetation - Tree",
        },
        {
          value: 2853,
          color: "ff692e",
          description: "Sh Hawai'i Introduced Coastal Wetland Vegetation - Shrub",
        },
        {
          value: 2854,
          color: "ff692e",
          description: "He Hawai'i Introduced Coastal Wetland Vegetation - Herbaceous",
        },
        {
          value: 2855,
          color: "9e430e",
          description: "Tr Hawai'i Managed Tree Plantation",
        },
        {
          value: 2856,
          color: "9e430e",
          description: "Tr Pacific Islands Plantation Forest",
        },
        {
          value: 2857,
          color: "9e430e",
          description: "Tr Tropical Pacific Forest Plantation",
        },
        {
          value: 2858,
          color: "00ed00",
          description: "Tr Hawaiian Ruderal Mangrove",
        },
        {
          value: 2859,
          color: "ff692e",
          description: "He Hawaiian Ruderal Coastal Salt Marsh",
        },
        {
          value: 2860,
          color: "343434",
          description: "Bau Caribbean High-medium density urban",
        },
        {
          value: 2861,
          color: "343434",
          description: "Bau Caribbean Low-medium density urban",
        },
        {
          value: 2862,
          color: "ffeb99",
          description: "Dab Caribbean Herbaceous agriculture - cultivated lands",
        },
        {
          value: 2863,
          color: "cbffab",
          description: "Dab Caribbean Active sun coffee and mixed woody agriculture",
        },
        {
          value: 2864,
          color: "ffd277",
          description: "Dab Caribbean Pasture, hay or inactive agriculture",
        },
        {
          value: 2865,
          color: "ffd277",
          description: "Dab Caribbean Pasture, hay or other grassy areas",
        },
        {
          value: 2866,
          color: "83de6e",
          description: "Tr Caribbean Drought deciduous open woodland",
        },
        {
          value: 2867,
          color: "79d9cf",
          description: "Tr Caribbean Drought deciduous dense woodland",
        },
        {
          value: 2868,
          color: "b4ff94",
          description: "Tr Caribbean Deciduous, evergreen coastal and mixed forest or shrubland with succulents",
        },
        {
          value: 2869,
          color: "bfffe9",
          description: "Tr Caribbean Semi-deciduous and drought deciduous forest on alluvium and non-carbonate substrates",
        },
        {
          value: 2870,
          color: "79d9cf",
          description: "Tr Caribbean Semi-deciduous and drought deciduous forest on karst (includes semi-evergreen forest)",
        },
        {
          value: 2871,
          color: "00de00",
          description: "Tr Caribbean Drought deciduous, semi-deciduous and seasonal evergreen forest on serpentine",
        },
        {
          value: 2872,
          color: "60ff47",
          description: "Tr Caribbean Seasonal evergreen and semi-deciduous forest on karst",
        },
        {
          value: 2873,
          color: "003300",
          description: "Tr Caribbean Seasonal evergreen and evergreen forest",
        },
        {
          value: 2874,
          color: "b4ff94",
          description: "Tr Caribbean Seasonal evergreen forest with coconut palm",
        },
        {
          value: 2875,
          color: "aef5e0",
          description: "Tr Caribbean Evergreen and seasonal evergreen forest on karst",
        },
        {
          value: 2876,
          color: "005c00",
          description: "Tr Caribbean Evergreen forest on serpentine",
        },
        {
          value: 2877,
          color: "aef5e0",
          description: "Tr Caribbean Elfin, sierra palm, transitional and tall cloud forest",
        },
        {
          value: 2878,
          color: "ffd277",
          description: "Sh Caribbean Emergent wetlands including seasonnally flooded pasture",
        },
        {
          value: 2879,
          color: "646464",
          description: "Sps Caribbean Salt or mud flats",
        },
        {
          value: 2880,
          color: "00ed00",
          description: "Tr Caribbean Mangrove",
        },
        {
          value: 2881,
          color: "9c805c",
          description: "Tr Caribbean Seasonally flooded savannahs and woodlands",
        },
        {
          value: 2882,
          color: "ffeb99",
          description: "Tr Caribbean Pterocarpus swamp",
        },
        {
          value: 2883,
          color: "705239",
          description: "Sh Caribbean Tidally flooded evergreen dwarf-shrubland and forb vegetation",
        },
        {
          value: 2884,
          color: "91ff73",
          description: "Sh Caribbean & Mesoamerican Lowland Ruderal Grassland & Shrubland",
        },
        {
          value: 2885,
          color: "00de00",
          description: "Tr Caribbean Forest Plantation",
        },
        {
          value: 2886,
          color: "00de00",
          description: "Tr Caribbean Lowland Ruderal Rainforest",
        },
        {
          value: 2887,
          color: "00de00",
          description: "Tr Caribbean Montane Ruderal Forest",
        },
        {
          value: 2888,
          color: "00de00",
          description: "Tr Caribbean Ruderal Dry Forest",
        },
        {
          value: 2889,
          color: "705239",
          description: "He Caribbean Ruderal Freshwater Wet Meadow & Marsh",
        },
        {
          value: 2890,
          color: "00de00",
          description: "Tr Tropical Agroforestry Plantation",
        },
        {
          value: 2892,
          color: "ff692e",
          description: "Sh Polynesian Ruderal Scrub & Herb Coastal Strand",
        },
        {
          value: 2893,
          color: "ff692e",
          description: "Sh Polynesian Ruderal Subalpine-Montane Shrubland & Grassland",
        },
        {
          value: 2894,
          color: "ff692e",
          description: "Tr Hawaiian Montane Ruderal Forest & Woodland",
        },
        {
          value: 2895,
          color: "ff692e",
          description: "Tr Hawaiian Ruderal Flooded & Swamp Forest",
        },
        {
          value: 2896,
          color: "ff692e",
          description: "He Hawaiian Ruderal Freshwater Wet Meadow & Marsh",
        },
        {
          value: 2897,
          color: "ff692e",
          description: "Tr Polynesian Ruderal Dry Woodland & Scrub",
        },
        {
          value: 2898,
          color: "ff692e",
          description: "Tr Polynesian Ruderal Lowland Rainforest",
        },
        {
          value: 2899,
          color: "ff692e",
          description: "Sh Polynesian Ruderal Lowland Shrubland Grassland & Savanna",
        },
        {
          value: 2901,
          color: "343434",
          description: "Bau Developed-Open Space",
        },
        {
          value: 2902,
          color: "ff7a8f",
          description: "Bau Developed-Low Intensity",
        },
        {
          value: 2903,
          color: "fd2c4f",
          description: "Bau Developed-Medium Intensity",
        },
        {
          value: 2904,
          color: "ad001c",
          description: "Bau Developed-High Intensity",
        },
        {
          value: 2905,
          color: "010101",
          description: "Bau Developed-Roads",
        },
        {
          value: 2908,
          color: "403da8",
          description: "Dtd Developed Deciduous Forest",
        },
        {
          value: 2909,
          color: "6677cd",
          description: "Dtc Developed Evergreen Forest",
        },
        {
          value: 2910,
          color: "444f89",
          description: "Dtm Developed Mixed Deciduous-Evergreen Forest",
        },
        {
          value: 2911,
          color: "9eaad7",
          description: "Dgr Developed Herbaceous",
        },
        {
          value: 2912,
          color: "7a8ef5",
          description: "Dsh Developed Shrubland",
        },
        {
          value: 2913,
          color: "704489",
          description: "Dtd Urban Deciduous Forest",
        },
        {
          value: 2914,
          color: "aa66cd",
          description: "Dtc Urban Evergreen Forest",
        },
        {
          value: 2915,
          color: "c29ed7",
          description: "Dtm Urban Mixed Deciduous-Evergreen Forest",
        },
        {
          value: 2916,
          color: "ca7af5",
          description: "Dgr Urban Herbaceous",
        },
        {
          value: 2917,
          color: "cfabd7",
          description: "Dsh Urban Shrubland",
        },
        {
          value: 2923,
          color: "403da8",
          description: "Dtd Developed Ruderal Deciduous Forest",
        },
        {
          value: 2924,
          color: "6677cd",
          description: "Dtc Developed Ruderal Evergreen Forest",
        },
        {
          value: 2925,
          color: "444f89",
          description: "Dtm Developed Ruderal Deciduous-Evergreen Forest",
        },
        {
          value: 2926,
          color: "9eaad7",
          description: "Dsh Developed Ruderal Shrubland",
        },
        {
          value: 2927,
          color: "7a8ef5",
          description: "Dgr Developed Ruderal Grassland",
        },
        {
          value: 2928,
          color: "444f89",
          description: "Dtw Developed Ruderal Forested Wetland",
        },
        {
          value: 2929,
          color: "9eaad7",
          description: "Dsw Developed Ruderal Shrub Wetland",
        },
        {
          value: 2930,
          color: "7a8ef5",
          description: "Dhw Developed Ruderal Herbaceous Wetland",
        },
        {
          value: 2933,
          color: "ffbee8",
          description: "Dtd Undeveloped Ruderal Deciduous Forest",
        },
        {
          value: 2934,
          color: "ff00c5",
          description: "Dtc Undeveloped Ruderal Evergreen Forest",
        },
        {
          value: 2935,
          color: "ff73df",
          description: "Dtm Undeveloped Ruderal Deciduous-Evergreen Forest",
        },
        {
          value: 2936,
          color: "a80084",
          description: "Dsh Undeveloped Ruderal Shrubland",
        },
        {
          value: 2937,
          color: "e600a9",
          description: "Dgr Undeveloped Ruderal Grassland",
        },
        {
          value: 2943,
          color: "444f89",
          description: "Dtd Developed Ruderal Deciduous Forested Wetland",
        },
        {
          value: 2944,
          color: "444f89",
          description: "Dtc Developed Ruderal Evergreen Forested Wetland",
        },
        {
          value: 2945,
          color: "444f89",
          description: "Dtm Developed Ruderal Deciduous-Evergreen Forested Wetland",
        },
        {
          value: 2946,
          color: "9eaad7",
          description: "Dsh Developed Ruderal Shrub Wetland",
        },
        {
          value: 2947,
          color: "7a8ef5",
          description: "Dgr Developed Ruderal Herbaceous Wetland",
        },
        {
          value: 2960,
          color: "d21c5e",
          description: "Dab Orchard",
        },
        {
          value: 2961,
          color: "a80084",
          description: "Da Vineyard",
        },
        {
          value: 2962,
          color: "d21c77",
          description: "Dab Bush Fruit and Berries",
        },
        {
          value: 2963,
          color: "fff58c",
          description: "Da Row Crop - Close Grown Crop",
        },
        {
          value: 2964,
          color: "faff77",
          description: "Da Row Crop",
        },
        {
          value: 2965,
          color: "ffed77",
          description: "Da Close Grown Crop",
        },
        {
          value: 2966,
          color: "ffff77",
          description: "Dab Fallow/Idle Cropland",
        },
        {
          value: 2967,
          color: "e3d41c",
          description: "Dab Pasture and Hayland",
        },
        {
          value: 2968,
          color: "fae3a3",
          description: "Da Wheat",
        },
        {
          value: 2969,
          color: "d2ffed",
          description: "Da Aquaculture",
        },
        {
          value: 2970,
          color: "faff77",
          description: "Dab Sugar Cane",
        },
        {
          value: 2972,
          color: "005c00",
          description: "Tr Caribbean Coastal Dry Evergreen Forest",
        },
        {
          value: 2973,
          color: "646464",
          description: "Sps Caribbean Coastal Rocky Shore",
        },
        {
          value: 2974,
          color: "91ff73",
          description: "Sh Caribbean Coastal Thornscrub",
        },
        {
          value: 2975,
          color: "91ff73",
          description: "Sh Caribbean Dry Karst Shrubland",
        },
        {
          value: 2976,
          color: "60ff47",
          description: "Tr Caribbean Edapho-Xerophilous \"Mogote\" Complex",
        },
        {
          value: 2977,
          color: "705239",
          description: "He Caribbean Emergent Herbaceous Estuary",
        },
        {
          value: 2978,
          color: "9c805c",
          description: "Tr Caribbean Floodplain Forest",
        },
        {
          value: 2979,
          color: "705239",
          description: "He Caribbean Freshwater Marsh",
        },
        {
          value: 2980,
          color: "00de00",
          description: "Tr Caribbean Lowland Moist Serpentine Woodland",
        },
        {
          value: 2981,
          color: "74d6cc",
          description: "He Caribbean Montane Meadow",
        },
        {
          value: 2982,
          color: "aef5e0",
          description: "Tr Caribbean Montane Wet Elfin Forest",
        },
        {
          value: 2983,
          color: "00de00",
          description: "Tr Caribbean Montane Wet Serpentine Woodland",
        },
        {
          value: 2984,
          color: "705239",
          description: "Sh Caribbean Montane Wet Short Shrubland",
        },
        {
          value: 2985,
          color: "9c805c",
          description: "Tr Caribbean Riparian Forest and Shrubland",
        },
        {
          value: 2986,
          color: "646464",
          description: "Sps Caribbean Salt Flat and Pond",
        },
        {
          value: 2987,
          color: "646464",
          description: "Sps Caribbean Sand Beach Vegetation",
        },
        {
          value: 2988,
          color: "83de6e",
          description: "Tr Caribbean Sand Savanna",
        },
        {
          value: 2989,
          color: "00de00",
          description: "Tr Caribbean Seasonal Evergreen Lowland Forest",
        },
        {
          value: 2990,
          color: "00de00",
          description: "Tr Caribbean Seasonal Evergreen Submontane/Lowland Forest",
        },
        {
          value: 2991,
          color: "b4ff94",
          description: "Tr Caribbean Semi-deciduous Lowland Forest",
        },
        {
          value: 2992,
          color: "91ff73",
          description: "Sh Caribbean Serpentine Dry Scrub",
        },
        {
          value: 2993,
          color: "aef5e0",
          description: "Tr Caribbean Submontane/Montane Karstic Forest",
        },
        {
          value: 2994,
          color: "9c805c",
          description: "Tr Caribbean Wet Montane Forest",
        },
        {
          value: 2995,
          color: "9c805c",
          description: "Tr Caribbean Wet Submontane/Lowland Forest",
        },
        {
          value: 2996,
          color: "646464",
          description: "Sps Stabilized Caribbean Dunes",
        },
        {
          value: 4408,
          color: "92ede0",
          description: "Sh Alaska Sub-boreal Mesic Subalpine Alder Shrubland",
        },
        {
          value: 4411,
          color: "852708",
          description: "Sh Alaskan Pacific Acidic Shrub-Sedge Peatland",
        },
        {
          value: 4412,
          color: "d48122",
          description: "Sh Alaskan Pacific Alpine-Subalpine Dwarf-shrubland & Heath",
        },
        {
          value: 4413,
          color: "124c87",
          description: "Tr Alaskan Pacific Floodplain Conifer Forest",
        },
        {
          value: 4418,
          color: "852708",
          description: "Tr Alaskan Pacific Maritime Mountain Hemlock-Shore Pine Peatland",
        },
        {
          value: 4421,
          color: "005c00",
          description: "Tr Alaskan Pacific Mountain Hemlock Forest and Subalpine Woodland",
        },
        {
          value: 4423,
          color: "007500",
          description: "Tr Alaskan Pacific Sitka Spruce Forest and Beach Ridge",
        },
        {
          value: 4424,
          color: "ff9900",
          description: "Sh Alaskan Pacific Wet Low Shrubland & Floodplain Wetland",
        },
        {
          value: 4425,
          color: "92ede0",
          description: "Sh Alaskan Pacific-Aleutian Alder-Salmonberry-Copperbush Shrubland",
        },
        {
          value: 4426,
          color: "ff0000",
          description: "He Alaskan Pacific-Aleutian Coastal Dune Beach and Beach Meadow",
        },
        {
          value: 4427,
          color: "ffcd70",
          description: "He Alaskan Pacific-Aleutian Fen and Wet Meadow",
        },
        {
          value: 4429,
          color: "4f241a",
          description: "Sh Aleutian Ericaceous Dwarf-shrubland Heath and Fell-field",
        },
        {
          value: 4435,
          color: "c24415",
          description: "Sh North American Arctic Dryas Tundra",
        },
        {
          value: 4436,
          color: "ff6600",
          description: "Sh North American Arctic Dwarf-Shrub Lichen Tundra",
        },
        {
          value: 4437,
          color: "852708",
          description: "Sh North American Arctic Dwarf-shrub-Wet Sedge-Sphagnum Peatland",
        },
        {
          value: 4438,
          color: "ff9900",
          description: "He North American Arctic Freshwater Marsh",
        },
        {
          value: 4443,
          color: "c24415",
          description: "Sh North American Arctic Polygonal Ground Shrub & Tussock Tundra",
        },
        {
          value: 4445,
          color: "ff6600",
          description: "Sh North American Arctic Sparse Tundra",
        },
        {
          value: 4446,
          color: "ffcd70",
          description: "He North American Arctic Wet Sedge Tundra and Polygonal Ground",
        },
        {
          value: 4447,
          color: "ff0000",
          description: "He North American Arctic-Subarctic Coastal Dune & Beach",
        },
        {
          value: 4448,
          color: "ff491c",
          description: "Sh North American Arctic and Subarctic Shrub-Tussock Tundra",
        },
        {
          value: 4449,
          color: "ff990a",
          description: "He North American Arctic-Subarctic Tidal Salt and Brackish Marsh",
        },
        {
          value: 4450,
          color: "ff491c",
          description: "He North American Arctic and Subarctic Tussock Tundra",
        },
        {
          value: 4453,
          color: "d48122",
          description: "Sh Western North American Boreal Alpine Dwarf-shrubland",
        },
        {
          value: 4461,
          color: "ff9900",
          description: "He Western North American Boreal Freshwater Emergent Marsh",
        },
        {
          value: 4462,
          color: "124c87",
          description: "Tr Western North American Boreal Lowland Large River Floodplain Conifer Forest",
        },
        {
          value: 4467,
          color: "b6fae3",
          description: "Tr Western North American Boreal Mesic-Wet Black Spruce Forest and Woodland",
        },
        {
          value: 4468,
          color: "124c87",
          description: "Tr Western North American Boreal Montane Floodplain Conifer Forest",
        },
        {
          value: 4469,
          color: "124c87",
          description: "Tr Western North American Boreal Riparian Stringer Conifer Forest",
        },
        {
          value: 4472,
          color: "963a0c",
          description: "Sh Western North American Boreal Shrub-Sedge Bog & Acidic Fen",
        },
        {
          value: 4484,
          color: "b6fae3",
          description: "Tr Western North American Boreal Mesic-Wet Black Spruce-Hardwood Forest and Woodland",
        },
        {
          value: 4485,
          color: "124c87",
          description: "Tr Alaskan Pacific Floodplain Deciduous Forest",
        },
        {
          value: 4486,
          color: "124c87",
          description: "Tr Alaskan Pacific Floodplain Mixed Forest",
        },
        {
          value: 4487,
          color: "124c87",
          description: "Tr Western North American Boreal Lowland Large River Floodplain Deciduous Forest",
        },
        {
          value: 4488,
          color: "124c87",
          description: "Tr Western North American Boreal Lowland Large River Floodplain Mixed Forest",
        },
        {
          value: 4489,
          color: "124c87",
          description: "Tr Western North American Boreal Montane Floodplain Deciduous Forest",
        },
        {
          value: 4490,
          color: "124c87",
          description: "Tr Western North American Boreal Montane Floodplain Mixed Forest",
        },
        {
          value: 4491,
          color: "124c87",
          description: "Tr Western North American Boreal Riparian Stringer Deciduous Forest",
        },
        {
          value: 4492,
          color: "124c87",
          description: "Tr Western North American Boreal Riparian Stringer Mixed Forest",
        },
        {
          value: 4601,
          color: "646464",
          description: "Sps Micronesian Dry Cliff",
        },
        {
          value: 4602,
          color: "646464",
          description: "Sps Micronesian Dry-Site Lava Flow",
        },
        {
          value: 4603,
          color: "2aff1f",
          description: "Sh Micronesian Dry Coastal Strand",
        },
        {
          value: 4604,
          color: "00bd00",
          description: "Tr Micronesian Lowland Rain Forest",
        },
        {
          value: 4605,
          color: "3fff2e",
          description: "Tr Micronesian Lowland Limestone Forest",
        },
        {
          value: 4606,
          color: "00bd00",
          description: "Tr Central and Southern Polynesian Montane Rainforest",
        },
        {
          value: 4609,
          color: "00ed00",
          description: "Tr Micronesian Ravine and Riparian Forest and Shrubland",
        },
        {
          value: 4610,
          color: "ff9900",
          description: "He Polynesian Freshwater Marsh",
        },
        {
          value: 4611,
          color: "43a2b5",
          description: "Tr Micronesian Swamp Forest",
        },
        {
          value: 4612,
          color: "00ed00",
          description: "Tr Western Pacific Mangrove",
        },
        {
          value: 4614,
          color: "00bd00",
          description: "Tr Central and Southern Polynesian Coastal Wooded Strand",
        },
        {
          value: 4615,
          color: "646464",
          description: "Sps Central and Southern Polynesian Cliff",
        },
        {
          value: 4616,
          color: "646464",
          description: "Sps Central and Southern Polynesian Lava Flow",
        },
        {
          value: 4617,
          color: "646464",
          description: "Sh Central and Southern Polynesian Dry Coastal Strand",
        },
        {
          value: 4618,
          color: "e0fcc0",
          description: "Tr Central and Southern Polynesian Lowland Rain Forest",
        },
        {
          value: 4620,
          color: "00cc00",
          description: "Tr Central and Southern Polynesian Cloud Forest",
        },
        {
          value: 4621,
          color: "2aff1f",
          description: "Tr Central and Southern Polynesian Littoral Forest",
        },
        {
          value: 4622,
          color: "00ed00",
          description: "Tr Pacific Islands Ravine Forest",
        },
        {
          value: 4623,
          color: "43a2b5",
          description: "Tr Central and Southern Polynesian Swamp Forest",
        },
        {
          value: 4627,
          color: "2aff1f",
          description: "Sh Central and Southern Polynesian Dry Coastal Strand Shrubland",
        },
        {
          value: 4628,
          color: "2aff1f",
          description: "Sh Central and Southern Polynesian Dry Coastal Strand Shrubland",
        },
        {
          value: 4800,
          color: "ff692e",
          description: "Tr 2815, 2817, 2821, 2899 Exotic - Short Herb",
        },
        {
          value: 4801,
          color: "ff692e",
          description: "Tr 2815, 2817, 2821, 2899 Exotic - Medium Herb",
        },
        {
          value: 4802,
          color: "ff692e",
          description: "Tr 2815, 2817, 2821, 2899 Exotic - Tall Herb",
        },
      ],
    },
    {
      name: "PDist_raw",
      description: "Code that denotes general category of disturbance, type, and severity. Raw value from the original Landfire products, equivalent to \"Preliminary Annual Disturbance 2024 (PDist24)\".",
      "gee:units": units.dimensionless,
      "gee:classes": [
        {
          value: 0,
          color: "000000",
          description: "Background",
        },
        {
          value: 2001,
          color: "0000ff",
          description: "Water body or other non-mappable land cover type",
        },
        {
          value: 2011,
          color: "ff0000",
          description: "MTBS Provisional Initial Assessment (PIA)-mapped wildfire; replaced by MTBS Extended Assessment data if available",
        },
        {
          value: 2012,
          color: "ff0000",
          description: "MTBS Provisional Initial Assessment (PIA)-mapped wildfire; replaced by MTBS Extended Assessment data if available",
        },
        {
          value: 2013,
          color: "ff0000",
          description: "MTBS Provisional Initial Assessment (PIA)-mapped wildfire; replaced by MTBS Extended Assessment data if available",
        },
        {
          value: 2014,
          color: "ff0000",
          description: "MTBS Provisional Initial Assessment (PIA)-mapped wildfire; replaced by MTBS Extended Assessment data if available",
        },
        {
          value: 2015,
          color: "ff0000",
          description: "MTBS Provisional Initial Assessment (PIA)-mapped wildfire; replaced by MTBS Extended Assessment data if available",
        },
        {
          value: 2021,
          color: "ff0000",
          description: "MTBS Provisional Initial Assessment (PIA)-mapped wildfire; replaced by MTBS Extended Assessment data if available",
        },
        {
          value: 2022,
          color: "ff0000",
          description: "MTBS Provisional Initial Assessment (PIA)-mapped wildfire; replaced by MTBS Extended Assessment data if available",
        },
        {
          value: 2023,
          color: "ff0000",
          description: "MTBS Provisional Initial Assessment (PIA)-mapped wildfire; replaced by MTBS Extended Assessment data if available",
        },
        {
          value: 2024,
          color: "ff0000",
          description: "MTBS Provisional Initial Assessment (PIA)-mapped wildfire; replaced by MTBS Extended Assessment data if available",
        },
        {
          value: 2025,
          color: "ff0000",
          description: "MTBS Provisional Initial Assessment (PIA)-mapped wildfire; replaced by MTBS Extended Assessment data if available",
        },
        {
          value: 2031,
          color: "ff0000",
          description: "MTBS Provisional Initial Assessment (PIA) no-data gaps filled with See5-modeled severity; replaced by Extended Assessment data if available",
        },
        {
          value: 2032,
          color: "ff0000",
          description: "MTBS Provisional Initial Assessment (PIA) no-data gaps filled with See5-modeled severity; replaced by Extended Assessment data if available",
        },
        {
          value: 2033,
          color: "ff0000",
          description: "MTBS Provisional Initial Assessment (PIA) no-data gaps filled with See5-modeled severity; replaced by Extended Assessment data if available",
        },
        {
          value: 2034,
          color: "ff0000",
          description: "MTBS Provisional Initial Assessment (PIA) no-data gaps filled with See5-modeled severity; replaced by Extended Assessment data if available",
        },
        {
          value: 2035,
          color: "ff0000",
          description: "MTBS Provisional Initial Assessment (PIA) no-data gaps filled with See5-modeled severity; replaced by Extended Assessment data if available",
        },
        {
          value: 2041,
          color: "ff0000",
          description: "MTBS Provisional Initial Assessment (PIA) no-data gaps filled with See5-modeled severity; replaced by Extended Assessment data if available",
        },
        {
          value: 2042,
          color: "ff0000",
          description: "MTBS Provisional Initial Assessment (PIA) no-data gaps filled with See5-modeled severity; replaced by Extended Assessment data if available",
        },
        {
          value: 2043,
          color: "ff0000",
          description: "MTBS Provisional Initial Assessment (PIA) no-data gaps filled with See5-modeled severity; replaced by Extended Assessment data if available",
        },
        {
          value: 2044,
          color: "ff0000",
          description: "MTBS Provisional Initial Assessment (PIA) no-data gaps filled with See5-modeled severity; replaced by Extended Assessment data if available",
        },
        {
          value: 2045,
          color: "ff0000",
          description: "MTBS Provisional Initial Assessment (PIA) no-data gaps filled with See5-modeled severity; replaced by Extended Assessment data if available",
        },
        {
          value: 2051,
          color: "ff0000",
          description: "MTBS Provisional Initial Assessment (PIA)-mapped prescribed fire; replaced by MTBS Extended Assessment data if available",
        },
        {
          value: 2052,
          color: "ff0000",
          description: "MTBS Provisional Initial Assessment (PIA)-mapped prescribed fire; replaced by MTBS Extended Assessment data if available",
        },
        {
          value: 2053,
          color: "ff0000",
          description: "MTBS Provisional Initial Assessment (PIA)-mapped prescribed fire; replaced by MTBS Extended Assessment data if available",
        },
        {
          value: 2054,
          color: "ff0000",
          description: "MTBS Provisional Initial Assessment (PIA)-mapped prescribed fire; replaced by MTBS Extended Assessment data if available",
        },
        {
          value: 2055,
          color: "ff0000",
          description: "MTBS Provisional Initial Assessment (PIA)-mapped prescribed fire; replaced by MTBS Extended Assessment data if available",
        },
        {
          value: 2061,
          color: "ff0000",
          description: "MTBS Provisional Initial Assessment (PIA)-mapped prescribed fire; replaced by MTBS Extended Assessment data if available",
        },
        {
          value: 2062,
          color: "ff0000",
          description: "MTBS Provisional Initial Assessment (PIA)-mapped prescribed fire; replaced by MTBS Extended Assessment data if available",
        },
        {
          value: 2063,
          color: "ff0000",
          description: "MTBS Provisional Initial Assessment (PIA)-mapped prescribed fire; replaced by MTBS Extended Assessment data if available",
        },
        {
          value: 2064,
          color: "ff0000",
          description: "MTBS Provisional Initial Assessment (PIA)-mapped prescribed fire; replaced by MTBS Extended Assessment data if available",
        },
        {
          value: 2065,
          color: "ff0000",
          description: "MTBS Provisional Initial Assessment (PIA)-mapped prescribed fire; replaced by MTBS Extended Assessment data if available",
        },
        {
          value: 2071,
          color: "ff0000",
          description: "MTBS Provisional Initial Assessment (PIA) no-data gaps filled with See5-modeled severity; replaced by Extended Assessment data if available",
        },
        {
          value: 2072,
          color: "ff0000",
          description: "MTBS Provisional Initial Assessment (PIA) no-data gaps filled with See5-modeled severity; replaced by Extended Assessment data if available",
        },
        {
          value: 2073,
          color: "ff0000",
          description: "MTBS Provisional Initial Assessment (PIA) no-data gaps filled with See5-modeled severity; replaced by Extended Assessment data if available",
        },
        {
          value: 2074,
          color: "ff0000",
          description: "MTBS Provisional Initial Assessment (PIA) no-data gaps filled with See5-modeled severity; replaced by Extended Assessment data if available",
        },
        {
          value: 2075,
          color: "ff0000",
          description: "MTBS Provisional Initial Assessment (PIA) no-data gaps filled with See5-modeled severity; replaced by Extended Assessment data if available",
        },
        {
          value: 2081,
          color: "ff0000",
          description: "MTBS Provisional Initial Assessment (PIA) no-data gaps filled with See5-modeled severity; replaced by Extended Assessment data if available",
        },
        {
          value: 2082,
          color: "ff0000",
          description: "MTBS Provisional Initial Assessment (PIA) no-data gaps filled with See5-modeled severity; replaced by Extended Assessment data if available",
        },
        {
          value: 2083,
          color: "ff0000",
          description: "MTBS Provisional Initial Assessment (PIA) no-data gaps filled with See5-modeled severity; replaced by Extended Assessment data if available",
        },
        {
          value: 2084,
          color: "ff0000",
          description: "MTBS Provisional Initial Assessment (PIA) no-data gaps filled with See5-modeled severity; replaced by Extended Assessment data if available",
        },
        {
          value: 2085,
          color: "ff0000",
          description: "MTBS Provisional Initial Assessment (PIA) no-data gaps filled with See5-modeled severity; replaced by Extended Assessment data if available",
        },
        {
          value: 2091,
          color: "ff0000",
          description: "National Park Service-mapped fire",
        },
        {
          value: 2092,
          color: "ff0000",
          description: "National Park Service-mapped fire",
        },
        {
          value: 2093,
          color: "ff0000",
          description: "National Park Service-mapped fire",
        },
        {
          value: 2094,
          color: "ff0000",
          description: "National Park Service-mapped fire",
        },
        {
          value: 2095,
          color: "ff0000",
          description: "National Park Service-mapped fire",
        },
        {
          value: 2101,
          color: "ff0000",
          description: "National Park Service-mapped fire",
        },
        {
          value: 2102,
          color: "ff0000",
          description: "National Park Service-mapped fire",
        },
        {
          value: 2103,
          color: "ff0000",
          description: "National Park Service-mapped fire",
        },
        {
          value: 2104,
          color: "ff0000",
          description: "National Park Service-mapped fire",
        },
        {
          value: 2105,
          color: "ff0000",
          description: "National Park Service-mapped fire",
        },
        {
          value: 2111,
          color: "ff0000",
          description: "NPS no-data gaps filled with See5-modeled severity",
        },
        {
          value: 2112,
          color: "ff0000",
          description: "NPS no-data gaps filled with See5-modeled severity",
        },
        {
          value: 2113,
          color: "ff0000",
          description: "NPS no-data gaps filled with See5-modeled severity",
        },
        {
          value: 2114,
          color: "ff0000",
          description: "NPS no-data gaps filled with See5-modeled severity",
        },
        {
          value: 2115,
          color: "ff0000",
          description: "NPS no-data gaps filled with See5-modeled severity",
        },
        {
          value: 2121,
          color: "ff0000",
          description: "NPS no-data gaps filled with See5-modeled severity",
        },
        {
          value: 2122,
          color: "ff0000",
          description: "NPS no-data gaps filled with See5-modeled severity",
        },
        {
          value: 2123,
          color: "ff0000",
          description: "NPS no-data gaps filled with See5-modeled severity",
        },
        {
          value: 2124,
          color: "ff0000",
          description: "NPS no-data gaps filled with See5-modeled severity",
        },
        {
          value: 2125,
          color: "ff0000",
          description: "NPS no-data gaps filled with See5-modeled severity",
        },
        {
          value: 2131,
          color: "ff0000",
          description: "RAVG-mapped fire",
        },
        {
          value: 2132,
          color: "ff0000",
          description: "RAVG-mapped fire",
        },
        {
          value: 2133,
          color: "ff0000",
          description: "RAVG-mapped fire",
        },
        {
          value: 2134,
          color: "ff0000",
          description: "RAVG-mapped fire",
        },
        {
          value: 2141,
          color: "ff0000",
          description: "RAVG-mapped fire",
        },
        {
          value: 2142,
          color: "ff0000",
          description: "RAVG-mapped fire",
        },
        {
          value: 2143,
          color: "ff0000",
          description: "RAVG-mapped fire",
        },
        {
          value: 2144,
          color: "ff0000",
          description: "RAVG-mapped fire",
        },
        {
          value: 2151,
          color: "ff0000",
          description: "RAVG no-data gaps filled with See5-modeled severity",
        },
        {
          value: 2152,
          color: "ff0000",
          description: "RAVG no-data gaps filled with See5-modeled severity",
        },
        {
          value: 2153,
          color: "ff0000",
          description: "RAVG no-data gaps filled with See5-modeled severity",
        },
        {
          value: 2154,
          color: "ff0000",
          description: "RAVG no-data gaps filled with See5-modeled severity",
        },
        {
          value: 2161,
          color: "ff0000",
          description: "RAVG no-data gaps filled with See5-modeled severity",
        },
        {
          value: 2162,
          color: "ff0000",
          description: "RAVG no-data gaps filled with See5-modeled severity",
        },
        {
          value: 2163,
          color: "ff0000",
          description: "RAVG no-data gaps filled with See5-modeled severity",
        },
        {
          value: 2164,
          color: "ff0000",
          description: "RAVG no-data gaps filled with See5-modeled severity",
        },
        {
          value: 2171,
          color: "ff0000",
          description: "BARC-mapped fire",
        },
        {
          value: 2172,
          color: "ff0000",
          description: "BARC-mapped fire",
        },
        {
          value: 2173,
          color: "ff0000",
          description: "BARC-mapped fire",
        },
        {
          value: 2174,
          color: "ff0000",
          description: "BARC-mapped fire",
        },
        {
          value: 2181,
          color: "ff0000",
          description: "BARC-mapped fire",
        },
        {
          value: 2182,
          color: "ff0000",
          description: "BARC-mapped fire",
        },
        {
          value: 2183,
          color: "ff0000",
          description: "BARC-mapped fire",
        },
        {
          value: 2184,
          color: "ff0000",
          description: "BARC-mapped fire",
        },
        {
          value: 2191,
          color: "ff0000",
          description: "BARC no-data gaps filled with See5-modeled severity",
        },
        {
          value: 2192,
          color: "ff0000",
          description: "BARC no-data gaps filled with See5-modeled severity",
        },
        {
          value: 2193,
          color: "ff0000",
          description: "BARC no-data gaps filled with See5-modeled severity",
        },
        {
          value: 2194,
          color: "ff0000",
          description: "BARC no-data gaps filled with See5-modeled severity",
        },
        {
          value: 2201,
          color: "ff0000",
          description: "BARC no-data gaps filled with See5-modeled severity",
        },
        {
          value: 2202,
          color: "ff0000",
          description: "BARC no-data gaps filled with See5-modeled severity",
        },
        {
          value: 2203,
          color: "ff0000",
          description: "BARC no-data gaps filled with See5-modeled severity",
        },
        {
          value: 2204,
          color: "ff0000",
          description: "BARC no-data gaps filled with See5-modeled severity",
        },
        {
          value: 2400,
          color: "bfbfbf",
          description: "No image-based change/severity detected within Development LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2401,
          color: "bfbfbf",
          description: "Image-based change detected within Development LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2402,
          color: "bfbfbf",
          description: "Image-based change detected within Development LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2403,
          color: "bfbfbf",
          description: "Image-based change detected within Development LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2404,
          color: "bfbfbf",
          description: "No image-based change/severity detected within Development LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2405,
          color: "bfbfbf",
          description: "Image-based change detected within Development LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2406,
          color: "bfbfbf",
          description: "Image-based change detected within Development LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2407,
          color: "bfbfbf",
          description: "Image-based change detected within Development LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2410,
          color: "806145",
          description: "No image-based change/severity detected within Clearcut LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2411,
          color: "806145",
          description: "Image-based change detected within Clearcut LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2412,
          color: "806145",
          description: "Image-based change detected within Clearcut LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2413,
          color: "806145",
          description: "Image-based change detected within Clearcut LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2414,
          color: "806145",
          description: "No image-based change/severity detected within Clearcut LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2415,
          color: "806145",
          description: "Image-based change detected within Clearcut LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2416,
          color: "806145",
          description: "Image-based change detected within Clearcut LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2417,
          color: "806145",
          description: "Image-based change detected within Clearcut LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2420,
          color: "ffff77",
          description: "No image-based change/severity detected within Harvest LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2421,
          color: "ffff77",
          description: "Image-based change detected within Harvest LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2422,
          color: "ffff77",
          description: "Image-based change detected within Harvest LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2423,
          color: "ffff77",
          description: "Image-based change detected within Harvest LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2424,
          color: "ffff77",
          description: "No image-based change/severity detected within Harvest LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2425,
          color: "ffff77",
          description: "Image-based change detected within Harvest LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2426,
          color: "ffff77",
          description: "Image-based change detected within Harvest LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2427,
          color: "ffff77",
          description: "Image-based change detected within Harvest LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2430,
          color: "b59c72",
          description: "No image-based change/severity detected within Thinning LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2431,
          color: "b59c72",
          description: "Image-based change detected within Thinning LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2432,
          color: "b59c72",
          description: "Image-based change detected within Thinning LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2433,
          color: "b59c72",
          description: "Image-based change detected within Thinning LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2434,
          color: "b59c72",
          description: "No image-based change/severity detected within Thinning LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2435,
          color: "b59c72",
          description: "Image-based change detected within Thinning LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2436,
          color: "b59c72",
          description: "Image-based change detected within Thinning LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2437,
          color: "b59c72",
          description: "Image-based change detected within Thinning LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2440,
          color: "ff6600",
          description: "No image-based change/severity detected within Mastication LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2441,
          color: "ff6600",
          description: "Image-based change detected within Mastication LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2442,
          color: "ff6600",
          description: "Image-based change detected within Mastication LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2443,
          color: "ff6600",
          description: "Image-based change detected within Mastication LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2444,
          color: "ff6600",
          description: "No image-based change/severity detected within Mastication LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2445,
          color: "ff6600",
          description: "Image-based change detected within Mastication LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2446,
          color: "ff6600",
          description: "Image-based change detected within Mastication LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2447,
          color: "ff6600",
          description: "Image-based change detected within Mastication LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2450,
          color: "60ff47",
          description: "No image-based change/severity detected within Mechanical Add LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2451,
          color: "60ff47",
          description: "Image-based change detected within Mechanical Add LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2452,
          color: "60ff47",
          description: "Image-based change detected within Mechanical Add LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2453,
          color: "60ff47",
          description: "Image-based change detected within Mechanical Add LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2454,
          color: "60ff47",
          description: "No image-based change/severity detected within Mechanical Add LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2455,
          color: "60ff47",
          description: "Image-based change detected within Mechanical Add LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2456,
          color: "60ff47",
          description: "Image-based change detected within Mechanical Add LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2457,
          color: "60ff47",
          description: "Image-based change detected within Mechanical Add LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2460,
          color: "60ff47",
          description: "No image-based change/severity detected within Mechanical Remove LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2461,
          color: "60ff47",
          description: "Image-based change detected within Mechanical Remove LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2462,
          color: "60ff47",
          description: "Image-based change detected within Mechanical Remove LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2463,
          color: "60ff47",
          description: "Image-based change detected within Mechanical Remove LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2464,
          color: "60ff47",
          description: "No image-based change/severity detected within Mechanical Remove LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2465,
          color: "60ff47",
          description: "Image-based change detected within Mechanical Remove LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2466,
          color: "60ff47",
          description: "Image-based change detected within Mechanical Remove LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2467,
          color: "60ff47",
          description: "Image-based change detected within Mechanical Remove LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2470,
          color: "60ff47",
          description: "No image-based change/severity detected within Mechanical Unknown LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2471,
          color: "60ff47",
          description: "Image-based change detected within Mechanical Unknown LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2472,
          color: "60ff47",
          description: "Image-based change detected within Mechanical Unknown LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2473,
          color: "60ff47",
          description: "Image-based change detected within Mechanical Unknown LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2474,
          color: "60ff47",
          description: "No image-based change/severity detected within Mechanical Unknown LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2475,
          color: "60ff47",
          description: "Image-based change detected within Mechanical Unknown LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2476,
          color: "60ff47",
          description: "Image-based change detected within Mechanical Unknown LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2477,
          color: "60ff47",
          description: "Image-based change detected within Mechanical Unknown LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2480,
          color: "ff0000",
          description: "No image-based change/severity detected within Wildfire LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2481,
          color: "ff0000",
          description: "Image-based change detected within Wildfire LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2482,
          color: "ff0000",
          description: "Image-based change detected within Wildfire LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2483,
          color: "ff0000",
          description: "Image-based change detected within Wildfire LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2484,
          color: "ff0000",
          description: "No image-based change/severity detected within Wildfire LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2485,
          color: "ff0000",
          description: "Image-based change detected within Wildfire LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2486,
          color: "ff0000",
          description: "Image-based change detected within Wildfire LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2487,
          color: "ff0000",
          description: "Image-based change detected within Wildfire LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2490,
          color: "ff0000",
          description: "No image-based change/severity detected within Wildland Fire Use LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2491,
          color: "ff0000",
          description: "Image-based change detected within Wildland Fire Use LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2492,
          color: "ff0000",
          description: "Image-based change detected within Wildland Fire Use LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2493,
          color: "ff0000",
          description: "Image-based change detected within Wildland Fire Use LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2494,
          color: "ff0000",
          description: "No image-based change/severity detected within Wildland Fire Use LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2495,
          color: "ff0000",
          description: "Image-based change detected within Wildland Fire Use LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2496,
          color: "ff0000",
          description: "Image-based change detected within Wildland Fire Use LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2497,
          color: "ff0000",
          description: "Image-based change detected within Wildland Fire Use LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2500,
          color: "ad001c",
          description: "No image-based change/severity detected within Prescribed Fire LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2501,
          color: "ad001c",
          description: "Image-based change detected within Prescribed Fire LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2502,
          color: "ad001c",
          description: "Image-based change detected within Prescribed Fire LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2503,
          color: "ad001c",
          description: "Image-based change detected within Prescribed Fire LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2504,
          color: "ad001c",
          description: "No image-based change/severity detected within Prescribed Fire LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2505,
          color: "ad001c",
          description: "Image-based change detected within Prescribed Fire LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2506,
          color: "ad001c",
          description: "Image-based change detected within Prescribed Fire LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2507,
          color: "ad001c",
          description: "Image-based change detected within Prescribed Fire LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2510,
          color: "bfbfbf",
          description: "No image-based change/severity detected within Weather LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2511,
          color: "bfbfbf",
          description: "Image-based change detected within Weather LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2512,
          color: "bfbfbf",
          description: "Image-based change detected within Weather LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2513,
          color: "bfbfbf",
          description: "Image-based change detected within Weather LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2514,
          color: "bfbfbf",
          description: "No image-based change/severity detected within Weather LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2515,
          color: "bfbfbf",
          description: "Image-based change detected within Weather LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2516,
          color: "bfbfbf",
          description: "Image-based change detected within Weather LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2517,
          color: "bfbfbf",
          description: "Image-based change detected within Weather LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2520,
          color: "43a2b5",
          description: "No image-based change/severity detected within Insecticide LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2521,
          color: "43a2b5",
          description: "Image-based change detected within Insecticide LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2522,
          color: "43a2b5",
          description: "Image-based change detected within Insecticide LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2523,
          color: "43a2b5",
          description: "Image-based change detected within Insecticide LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2524,
          color: "43a2b5",
          description: "No image-based change/severity detected within Insecticide LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2525,
          color: "43a2b5",
          description: "Image-based change detected within Insecticide LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2526,
          color: "43a2b5",
          description: "Image-based change detected within Insecticide LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2527,
          color: "43a2b5",
          description: "Image-based change detected within Insecticide LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2530,
          color: "ffff00",
          description: "No image-based change/severity detected within Chemical LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2531,
          color: "ffff00",
          description: "Image-based change detected within Chemical LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2532,
          color: "ffff00",
          description: "Image-based change detected within Chemical LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2533,
          color: "ffff00",
          description: "Image-based change detected within Chemical LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2534,
          color: "ffff00",
          description: "No image-based change/severity detected within Chemical LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2535,
          color: "ffff00",
          description: "Image-based change detected within Chemical LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2536,
          color: "ffff00",
          description: "Image-based change detected within Chemical LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2537,
          color: "ffff00",
          description: "Image-based change detected within Chemical LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2540,
          color: "92e8d7",
          description: "No image-based change/severity detected within Insects LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2541,
          color: "92e8d7",
          description: "Image-based change detected within Insects LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2542,
          color: "92e8d7",
          description: "Image-based change detected within Insects LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2543,
          color: "92e8d7",
          description: "Image-based change detected within Insects LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2544,
          color: "92e8d7",
          description: "No image-based change/severity detected within Insects LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2545,
          color: "92e8d7",
          description: "Image-based change detected within Insects LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2546,
          color: "92e8d7",
          description: "Image-based change detected within Insects LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2547,
          color: "92e8d7",
          description: "Image-based change detected within Insects LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2550,
          color: "042d75",
          description: "No image-based change/severity detected within Disease LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2551,
          color: "042d75",
          description: "Image-based change detected within Disease LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2552,
          color: "042d75",
          description: "Image-based change detected within Disease LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2553,
          color: "042d75",
          description: "Image-based change detected within Disease LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2554,
          color: "042d75",
          description: "No image-based change/severity detected within Disease LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2555,
          color: "042d75",
          description: "Image-based change detected within Disease LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2556,
          color: "042d75",
          description: "Image-based change detected within Disease LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2557,
          color: "042d75",
          description: "Image-based change detected within Disease LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2560,
          color: "0000ff",
          description: "No image-based change/severity detected within Insect/Disease LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2561,
          color: "0000ff",
          description: "Image-based change detected within Insect/Disease LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2562,
          color: "0000ff",
          description: "Image-based change detected within Insect/Disease LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2563,
          color: "0000ff",
          description: "Image-based change detected within Insect/Disease LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2564,
          color: "0000ff",
          description: "No image-based change/severity detected within Insect/Disease LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2565,
          color: "0000ff",
          description: "Image-based change detected within Insect/Disease LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2566,
          color: "0000ff",
          description: "Image-based change detected within Insect/Disease LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2567,
          color: "0000ff",
          description: "Image-based change detected within Insect/Disease LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2570,
          color: "c0ff8a",
          description: "No image-based change/severity detected within Herbicide LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2571,
          color: "c0ff8a",
          description: "Image-based change detected within Herbicide LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2572,
          color: "c0ff8a",
          description: "Image-based change detected within Herbicide LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2573,
          color: "c0ff8a",
          description: "Image-based change detected within Herbicide LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2574,
          color: "c0ff8a",
          description: "No image-based change/severity detected within Herbicide LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2575,
          color: "c0ff8a",
          description: "Image-based change detected within Herbicide LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2576,
          color: "c0ff8a",
          description: "Image-based change detected within Herbicide LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2577,
          color: "c0ff8a",
          description: "Image-based change detected within Herbicide LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2580,
          color: "003300",
          description: "No image-based change/severity detected within Biological LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2581,
          color: "003300",
          description: "Image-based change detected within Biological LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2582,
          color: "003300",
          description: "Image-based change detected within Biological LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2583,
          color: "003300",
          description: "Image-based change detected within Biological LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2584,
          color: "003300",
          description: "No image-based change/severity detected within Biological LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2585,
          color: "003300",
          description: "Image-based change detected within Biological LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2586,
          color: "003300",
          description: "Image-based change detected within Biological LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2587,
          color: "003300",
          description: "Image-based change detected within Biological LANDFIRE Events Geodatabase polygon",
        },
        {
          value: 2701,
          color: "7a7f75",
          description: "Image-based change detected overlapping USGS Burned Area data where the burn probability is 95% or greater",
        },
        {
          value: 2702,
          color: "7a7f75",
          description: "Image-based change detected overlapping USGS Burned Area data where the burn probability is 95% or greater",
        },
        {
          value: 2703,
          color: "7a7f75",
          description: "Image-based change detected overlapping USGS Burned Area data where the burn probability is 95% or greater",
        },
        {
          value: 2711,
          color: "7a7f75",
          description: "Image-based change detected overlapping USGS Burned Area data where the burn probability is 95% or greater",
        },
        {
          value: 2712,
          color: "7a7f75",
          description: "Image-based change detected overlapping USGS Burned Area data where the burn probability is 95% or greater",
        },
        {
          value: 2713,
          color: "7a7f75",
          description: "Image-based change detected overlapping USGS Burned Area data where the burn probability is 95% or greater",
        },
        {
          value: 2721,
          color: "7a7f75",
          description: "Image-based change detected without an overlapping LANDFIRE Event or Burned Area data",
        },
        {
          value: 2722,
          color: "7a7f75",
          description: "Image-based change detected without an overlapping LANDFIRE Event or Burned Area data",
        },
        {
          value: 2723,
          color: "7a7f75",
          description: "Image-based change detected without an overlapping LANDFIRE Event or Burned Area data",
        },
        {
          value: 2731,
          color: "7a7f75",
          description: "Image-based change detected without an overlapping LANDFIRE Event or Burned Area data",
        },
        {
          value: 2732,
          color: "7a7f75",
          description: "Image-based change detected without an overlapping LANDFIRE Event or Burned Area data",
        },
        {
          value: 2733,
          color: "7a7f75",
          description: "Image-based change detected without an overlapping LANDFIRE Event or Burned Area data",
        },
      ],
    },
    {
      name: "PDist_status",
      description: "Code representing disturbance occurrence and presence/absence of mapped disturbance data. Derived from PDist_raw.",
      "gee:units": units.dimensionless,
      "gee:classes": [
        {
          value: 0,
          color: "e8e8e8",
          description: "No Disturbance",
        },
        {
          value: 1,
          color: "ff7c80",
          description: "Disturbance",
        },
        {
          value: 2,
          color: "0070c0",
          description: "Water",
        },
        {
          value: 3,
          color: "d86dcd",
          description: "Not Mapped",
        },
      ],
    },
    {
      name: "PDist_type_L1",
      description: "Disturbance type represented as a first-order class. Derived categorical view from PDist_raw.",
      "gee:units": units.dimensionless,
      "gee:classes": [
        {
          value: 0,
          color: "e8e8e8",
          description: "No Disturbance",
        },
        {
          value: 1,
          color: "d6604d",
          description: "Fire",
        },
        {
          value: 2,
          color: "f4a582",
          description: "Mechanical Add",
        },
        {
          value: 3,
          color: "b88712",
          description: "Mechanical Remove",
        },
        {
          value: 4,
          color: "d1e5f0",
          description: "Windthrow",
        },
        {
          value: 5,
          color: "6eaac8",
          description: "Insects-Disease",
        },
        {
          value: 6,
          color: "6a3d9a",
          description: "Mechanical Unknown",
        },
        {
          value: 7,
          color: "9c27b0",
          description: "Mastication",
        },
        {
          value: 8,
          color: "003300",
          description: "Biological",
        },
        {
          value: 9,
          color: "ffff00",
          description: "Chemical",
        },
        {
          value: 10,
          color: "6f6f6f",
          description: "Development",
        },
      ],
    },
    {
      name: "PDist_type_L2",
      description: "Disturbance type represented as a second-order class. Derived categorical view from PDist_raw.",
      "gee:units": units.dimensionless,
      "gee:classes": [
        {
          value: 0,
          color: "e8e8e8",
          description: "No Disturbance",
        },
        {
          value: 11,
          color: "d6604d",
          description: "Fire",
        },
        {
          value: 12,
          color: "ff0000",
          description: "Wildfire",
        },
        {
          value: 13,
          color: "d6604d",
          description: "Wildland Fire Use",
        },
        {
          value: 14,
          color: "ad001c",
          description: "Prescribed Fire",
        },
        {
          value: 15,
          color: "c73f00",
          description: "Unknown Fire",
        },
        {
          value: 21,
          color: "f4a582",
          description: "Mechanical Add",
        },
        {
          value: 22,
          color: "e7a77a",
          description: "Mechanical Other",
        },
        {
          value: 31,
          color: "b88712",
          description: "Mechanical Remove",
        },
        {
          value: 32,
          color: "806145",
          description: "Clearcut",
        },
        {
          value: 33,
          color: "ffff77",
          description: "Harvest",
        },
        {
          value: 34,
          color: "b59c72",
          description: "Thinning",
        },
        {
          value: 41,
          color: "d1e5f0",
          description: "Windthrow",
        },
        {
          value: 51,
          color: "0000ff",
          description: "Insects-Disease",
        },
        {
          value: 52,
          color: "92e8d7",
          description: "Insects",
        },
        {
          value: 53,
          color: "042d75",
          description: "Disease",
        },
        {
          value: 61,
          color: "6a3d9a",
          description: "Mechanical Unknown",
        },
        {
          value: 62,
          color: "8e63bf",
          description: "Unknown",
        },
        {
          value: 71,
          color: "9c27b0",
          description: "Mastication",
        },
        {
          value: 81,
          color: "003300",
          description: "Biological",
        },
        {
          value: 91,
          color: "ffff00",
          description: "Chemical",
        },
        {
          value: 92,
          color: "fff176",
          description: "Insecticide",
        },
        {
          value: 93,
          color: "ffee58",
          description: "Herbicide",
        },
        {
          value: 101,
          color: "6f6f6f",
          description: "Development",
        },
      ],
    },
    {
      name: "PDist_severity",
      description: "Disturbance severity. Derived categorical view from PDist_raw.",
      "gee:units": units.dimensionless,
      "gee:classes": [
        {
          value: 0,
          color: "f0f0f0",
          description: "Not Applicable",
        },
        {
          value: 1,
          color: "009e73",
          description: "Increased Green",
        },
        {
          value: 2,
          color: "56b4e9",
          description: "Unburned/Low",
        },
        {
          value: 3,
          color: "f0e442",
          description: "Low",
        },
        {
          value: 4,
          color: "e69f00",
          description: "Moderate",
        },
        {
          value: 5,
          color: "d55e00",
          description: "High",
        },
        {
          value: 6,
          color: "999999",
          description: "No Severity",
        },
      ],
    },
    {
      name: "SClass",
      description: "Current vegetation composition and structure, repreented by successional classes.",
      "gee:units": units.dimensionless,
      "gee:classes": [
        {
          value: -1111,
          color: "6f6f6f",
          description: "Fill-Not Mapped",
        },
        {
          value: 1,
          color: "a16333",
          description: "A",
        },
        {
          value: 2,
          color: "38a800",
          description: "B",
        },
        {
          value: 3,
          color: "c9deab",
          description: "C",
        },
        {
          value: 4,
          color: "fff8a6",
          description: "D",
        },
        {
          value: 5,
          color: "004a4d",
          description: "E",
        },
        {
          value: 6,
          color: "a00000",
          description: "UN",
        },
        {
          value: 7,
          color: "ff0000",
          description: "UE",
        },
        {
          value: 111,
          color: "0000ff",
          description: "Water",
        },
        {
          value: 112,
          color: "9fa1f0",
          description: "Snow/Ice",
        },
        {
          value: 120,
          color: "84008a",
          description: "Developed",
        },
        {
          value: 132,
          color: "bfbfbf",
          description: "Barren or Sparse",
        },
        {
          value: 180,
          color: "df73ff",
          description: "Agriculture",
        },
      ],
    },
    {
      name: "VCC",
      description: "A derivative of VDep; indicates the general level to which current vegetation is different from the simulated historical reference condition.",
      "gee:units": units.dimensionless,
      "gee:classes": [
        {
          value: -1111,
          color: "6f6f6f",
          description: "Fill-Not Mapped",
        },
        {
          value: 1,
          color: "38a800",
          description: "Vegetation Condition Class I.A",
        },
        {
          value: 2,
          color: "4ce600",
          description: "Vegetation Condition Class I.B",
        },
        {
          value: 3,
          color: "ffff00",
          description: "Vegetation Condition Class II.A",
        },
        {
          value: 4,
          color: "ffaa00",
          description: "Vegetation Condition Class II.B",
        },
        {
          value: 5,
          color: "ff0000",
          description: "Vegetation Condition Class III.A",
        },
        {
          value: 6,
          color: "a80000",
          description: "Vegetation Condition Class III.B",
        },
        {
          value: 111,
          color: "0000ff",
          description: "Water",
        },
        {
          value: 112,
          color: "9fa1f0",
          description: "Snow/Ice",
        },
        {
          value: 120,
          color: "8400a8",
          description: "Developed",
        },
        {
          value: 132,
          color: "bfbfbf",
          description: "Barren or Sparse",
        },
        {
          value: 180,
          color: "df73ff",
          description: "Agriculture",
        },
      ],
    },
    {
      name: "VDep",
      description: "Departure between current vegetation condition and reference vegetation condition.",
      "gee:units": units.percent,
    },
  ]),
  visualizations: [
    {
      display_name: "EVT classes",
      lookat: {
        lon: -112.0,
        lat: 45.0,
        zoom: 5,
      },
      image_visualization: {
        band_vis: {
          bands: [
            "EVT",
          ],
        },
      },
    },
    {
      display_name: "EVC classes",
      lookat: {
        lon: -112.0,
        lat: 45.0,
        zoom: 5,
      },
      image_visualization: {
        band_vis: {
          bands: [
            "EVC",
          ],
        },
      },
    },
    {
      display_name: "FBFM40 classes",
      lookat: {
        lon: -112.0,
        lat: 45.0,
        zoom: 5,
      },
      image_visualization: {
        band_vis: {
          bands: [
            "FBFM40",
          ],
        },
      },
    },
    {
      display_name: "Dist_type_L1 classes",
      lookat: {
        lon: -112.0,
        lat: 45.0,
        zoom: 5,
      },
      image_visualization: {
        band_vis: {
          bands: [
            "Dist_type_L1",
          ],
        },
      },
    },
    {
      display_name: "Dist_severity classes",
      lookat: {
        lon: -112.0,
        lat: 45.0,
        zoom: 5,
      },
      image_visualization: {
        band_vis: {
          bands: [
            "Dist_severity",
          ],
        },
      },
    },
  ],
}
