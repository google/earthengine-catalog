local id = 'ISDASOIL/Africa/v1/fcc';
local subdir = 'ISDASOIL';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';

local license = spdx.cc_by_4_0;

local basename = std.strReplace(id, '/', '_');
local base_filename = basename + '.json';
local self_ee_catalog_url = ee_const.ee_catalog_url + basename;
local catalog_subdir_url = ee_const.catalog_base + subdir + '/';
local parent_url = catalog_subdir_url + 'catalog.json';
local self_url = catalog_subdir_url + base_filename;

{
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.collection,
  stac_extensions: [
    ee_const.ext_eo,
    ee_const.ext_sci,
    ee_const.ext_ver,
  ],
  id: id,
  title: 'iSDAsoil Fertility Capability Classification',
  version: 'v1',
  'gee:type': ee_const.gee_type.image,
  description: |||
    Soil fertility capability classification derived using slope, chemical,
    and physical soil properties.  For more information about this layer, please
    visit [this page](https://www.isda-africa.com/isdasoil/faqs/#faq7).

    The classes for the 'fcc' band apply to pixel values that must be
    back-transformed with `x modulo 3000`.

    In areas of dense jungle (generally over central Africa), model accuracy is
    low and therefore artifacts such as banding (striping) might be seen.

    Soil property predictions were made by
    [Innovative Solutions for Decision Agriculture Ltd. (iSDA)](https://isda-africa.com/)
    at 30 m pixel size using machine learning coupled with remote sensing data
    and a training set of over 100,000 analyzed soil samples.

    Further information can be found in the
    [FAQ](https://www.isda-africa.com/isdasoil/faqs/) and
    [technical information documentation](https://www.isda-africa.com/isdasoil/technical-information/). To submit an issue or request support, please visit
    [the iSDAsoil site](https://isda-africa.com/isdasoil).
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    ee.link.license(license.reference),
  ],
  keywords: [
    'africa',
    'fcc',
    'isda',
    'soil',
  ],
  providers: [
    ee.producer_provider('iSDA', 'https://isda-africa.com/'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent(-31.46, -35.22, 57.08, 37.98,
                    '2001-01-01T00:00:00Z', '2017-01-01T00:00:00Z'),
  summaries: {
    gsd: [
      30.0,
    ],
    'eo:bands': [
      {
        name: 'fcc',
        description: |||
          Fertility Capability Classification.

          Styling has been made according to the number of fertility constraints:

          * 0 constraints: #1a9641
          * 1 constraint: #fff1af
          * 2 constraints: #feb66a
          * 3 constraints: #f3854e
          * 4 constraints: #e54f35
          * 5 or more constraints: #d7191c
        |||,
        'gee:classes': [
          {
            color: '1a9641',
            description: 'No constraints',
            value: 0,
          },
          {
            value: 2,
            color: 'fff1af',
            description: 'Gravel',
          },
          {
            value: 4,
            color: 'fff1af',
            description: 'Slope',
          },
          {
            value: 6,
            color: 'feb66a',
            description: 'Gravel, Slope',
          },
          {
            value: 8,
            color: 'fff1af',
            description: 'High erosion risk: textual contrast',
          },
          {
            value: 10,
            color: 'feb66a',
            description: 'Gravel, High erosion risk: textual contrast',
          },
          {
            value: 12,
            color: 'feb66a',
            description: 'Slope, High erosion risk: textual contrast',
          },
          {
            value: 14,
            color: 'f3854e',
            description: 'Gravel, Slope, High erosion risk: textual contrast',
          },
          {
            value: 17,
            color: 'feb66a',
            description: 'Shallow, High erosion risk: shallow depth',
          },
          {
            value: 19,
            color: 'f3854e',
            description: 'Shallow, Gravel, High erosion risk: shallow depth',
          },
          {
            value: 21,
            color: 'f3854e',
            description: 'Shallow, Slope, High erosion risk: shallow depth',
          },
          {
            value: 23,
            color: 'e54f35',
            description: 'Shallow, Gravel, Slope, High erosion risk: shallow depth',
          },
          {
            value: 25,
            color: 'f3854e',
            description: 'Shallow, High erosion risk: textual contrast, High erosion risk: shallow depth',
          },
          {
            value: 27,
            color: 'e54f35',
            description: 'Shallow, Gravel, High erosion risk: textual contrast, High erosion risk: shallow depth',
          },
          {
            value: 29,
            color: 'e54f35',
            description: 'Shallow, Slope, High erosion risk: textual contrast, High erosion\nrisk: shallow depth',
          },
          {
            value: 31,
            color: 'd7191c',
            description: 'Shallow, Gravel, Slope, High erosion risk: textual contrast, High\nerosion risk: shallow depth',
          },
          {
            value: 36,
            color: 'feb66a',
            description: 'Slope, High erosion risk: steep slope',
          },
          {
            value: 38,
            color: 'f3854e',
            description: 'Gravel, Slope, High erosion risk: steep slope',
          },
          {
            value: 44,
            color: 'f3854e',
            description: 'Slope, High erosion risk: textual contrast, High erosion risk:\nsteep slope',
          },
          {
            value: 46,
            color: 'e54f35',
            description: 'Gravel, Slope, High erosion risk: textual contrast, High erosion\nrisk: steep slope',
          },
          {
            value: 53,
            color: 'e54f35',
            description: 'Shallow, Slope, High erosion risk: shallow depth, High erosion\nrisk: steep slope',
          },
          {
            value: 55,
            color: 'd7191c',
            description: 'Shallow, Gravel, Slope, High erosion risk: shallow depth, High\nerosion risk: steep slope',
          },
          {
            value: 61,
            color: 'd7191c',
            description: |||
              Shallow, Slope, High erosion risk: textual contrast, High erosion
              risk: shallow depth, High erosion risk: steep slope
            |||,
          },
          {
            value: 63,
            color: 'd7191c',
            description: |||
              Shallow, Gravel, Slope, High erosion risk: textual contrast, High
              erosion risk: shallow depth, High erosion risk: steep slope
            |||,
          },
          {
            value: 128,
            color: 'fff1af',
            description: 'Al Toxicity',
          },
          {
            value: 130,
            color: 'feb66a',
            description: 'Gravel, Al Toxicity',
          },
          {
            value: 132,
            color: 'feb66a',
            description: 'Slope, Al Toxicity',
          },
          {
            value: 134,
            color: 'f3854e',
            description: 'Gravel, Slope, Al Toxicity',
          },
          {
            value: 136,
            color: 'feb66a',
            description: 'High erosion risk: textual contrast, Al Toxicity',
          },
          {
            value: 140,
            color: 'f3854e',
            description: 'Slope, High erosion risk: textual contrast, Al Toxicity',
          },
          {
            value: 164,
            color: 'f3854e',
            description: 'Slope, High erosion risk: steep slope, Al Toxicity',
          },
          {
            value: 166,
            color: 'e54f35',
            description: 'Gravel, Slope, High erosion risk: steep slope, Al Toxicity',
          },
          {
            value: 172,
            color: 'e54f35',
            description: 'Slope, High erosion risk: textual contrast, High erosion risk:\nsteep slope, Al Toxicity',
          },
          {
            value: 256,
            color: 'fff1af',
            description: 'Calcareous',
          },
          {
            value: 258,
            color: 'feb66a',
            description: 'Gravel, Calcareous',
          },
          {
            value: 260,
            color: 'feb66a',
            description: 'Slope, Calcareous',
          },
          {
            value: 262,
            color: 'f3854e',
            description: 'Gravel, Slope, Calcareous',
          },
          {
            value: 264,
            color: 'feb66a',
            description: 'High erosion risk: textual contrast, Calcareous',
          },
          {
            value: 266,
            color: 'f3854e',
            description: 'Gravel, High erosion risk: textual contrast, Calcareous',
          },
          {
            value: 268,
            color: 'f3854e',
            description: 'Slope, High erosion risk: textual contrast, Calcareous',
          },
          {
            value: 270,
            color: 'e54f35',
            description: 'Gravel, Slope, High erosion risk: textual contrast, Calcareous',
          },
          {
            value: 273,
            color: 'f3854e',
            description: 'Shallow, High erosion risk: shallow depth, Calcareous',
          },
          {
            value: 275,
            color: 'e54f35',
            description: 'Shallow, Gravel, High erosion risk: shallow depth, Calcareous',
          },
          {
            value: 277,
            color: 'e54f35',
            description: 'Shallow, Slope, High erosion risk: shallow depth, Calcareous',
          },
          {
            value: 279,
            color: 'd7191c',
            description: 'Shallow, Gravel, Slope, High erosion risk: shallow depth, Calcareous',
          },
          {
            value: 281,
            color: 'e54f35',
            description: 'Shallow, High erosion risk: textual contrast, High erosion risk:\nshallow depth, Calcareous',
          },
          {
            value: 283,
            color: 'd7191c',
            description: 'Shallow, Gravel, High erosion risk: textual contrast, High erosion\nrisk: shallow depth, Calcareous',
          },
          {
            value: 285,
            color: 'd7191c',
            description: 'Shallow, Slope, High erosion risk: textual contrast, High erosion\nrisk: shallow depth, Calcareous',
          },
          {
            value: 287,
            color: 'd7191c',
            description: |||
              Shallow, Gravel, Slope, High erosion risk: textual contrast, High
              erosion risk: shallow depth, Calcareous
            |||,
          },
          {
            value: 292,
            color: 'f3854e',
            description: 'Slope, High erosion risk: steep slope, Calcareous',
          },
          {
            value: 294,
            color: 'e54f35',
            description: 'Gravel, Slope, High erosion risk: steep slope, Calcareous',
          },
          {
            value: 300,
            color: 'e54f35',
            description: 'Slope, High erosion risk: textual contrast, High erosion risk:\nsteep slope, Calcareous',
          },
          {
            value: 302,
            color: 'd7191c',
            description: 'Gravel, Slope, High erosion risk: textual contrast, High erosion\nrisk: steep slope, Calcareous',
          },
          {
            value: 309,
            color: 'd7191c',
            description: 'Shallow, Slope, High erosion risk: shallow depth, High erosion\nrisk: steep slope, Calcareous',
          },
          {
            value: 311,
            color: 'd7191c',
            description: 'Shallow, Gravel, Slope, High erosion risk: shallow depth, High\nerosion risk: steep slope, Calcareous',
          },
          {
            value: 317,
            color: 'd7191c',
            description: |||
              Shallow, Slope, High erosion risk: textual contrast, High erosion
              risk: shallow depth, High erosion risk: steep slope, Calcareous
            |||,
          },
          {
            value: 319,
            color: 'd7191c',
            description: |||
              Shallow, Gravel, Slope, High erosion risk: textual contrast, High
              erosion risk: shallow depth, High erosion risk: steep slope, Calcareous
            |||,
          },
          {
            value: 512,
            color: 'fff1af',
            description: 'Low K',
          },
          {
            value: 514,
            color: 'feb66a',
            description: 'Gravel, Low K',
          },
          {
            value: 516,
            color: 'feb66a',
            description: 'Slope, Low K',
          },
          {
            value: 518,
            color: 'f3854e',
            description: 'Gravel, Slope, Low K',
          },
          {
            value: 520,
            color: 'feb66a',
            description: 'High erosion risk: textual contrast, Low K',
          },
          {
            value: 522,
            color: 'f3854e',
            description: 'Gravel, High erosion risk: textual contrast, Low K',
          },
          {
            value: 524,
            color: 'f3854e',
            description: 'Slope, High erosion risk: textual contrast, Low K',
          },
          {
            value: 526,
            color: 'e54f35',
            description: 'Gravel, Slope, High erosion risk: textual contrast, Low K',
          },
          {
            value: 529,
            color: 'f3854e',
            description: 'Shallow, High erosion risk: shallow depth, Low K',
          },
          {
            value: 531,
            color: 'e54f35',
            description: 'Shallow, Gravel, High erosion risk: shallow depth, Low K',
          },
          {
            value: 533,
            color: 'e54f35',
            description: 'Shallow, Slope, High erosion risk: shallow depth, Low K',
          },
          {
            value: 535,
            color: 'd7191c',
            description: 'Shallow, Gravel, Slope, High erosion risk: shallow depth, Low K',
          },
          {
            value: 537,
            color: 'e54f35',
            description: 'Shallow, High erosion risk: textual contrast, High erosion risk:\nshallow depth, Low K',
          },
          {
            value: 539,
            color: 'd7191c',
            description: 'Shallow, Gravel, High erosion risk: textual contrast, High erosion\nrisk: shallow depth, Low K',
          },
          {
            value: 541,
            color: 'd7191c',
            description: 'Shallow, Slope, High erosion risk: textual contrast, High erosion\nrisk: shallow depth, Low K',
          },
          {
            value: 543,
            color: 'd7191c',
            description: 'Shallow, Gravel, Slope, High erosion risk: textual contrast, High\nerosion risk: shallow depth, Low K',
          },
          {
            value: 548,
            color: 'f3854e',
            description: 'Slope, High erosion risk: steep slope, Low K',
          },
          {
            value: 550,
            color: 'e54f35',
            description: 'Gravel, Slope, High erosion risk: steep slope, Low K',
          },
          {
            value: 556,
            color: 'e54f35',
            description: 'Slope, High erosion risk: textual contrast, High erosion risk:\nsteep slope, Low K',
          },
          {
            value: 558,
            color: 'd7191c',
            description: 'Gravel, Slope, High erosion risk: textual contrast, High erosion\nrisk: steep slope, Low K',
          },
          {
            value: 565,
            color: 'd7191c',
            description: 'Shallow, Slope, High erosion risk: shallow depth, High erosion\nrisk: steep slope, Low K',
          },
          {
            value: 567,
            color: 'd7191c',
            description: 'Shallow, Gravel, Slope, High erosion risk: shallow depth, High\nerosion risk: steep slope, Low K',
          },
          {
            value: 573,
            color: 'd7191c',
            description: |||
              Shallow, Slope, High erosion risk: textual contrast, High erosion
              risk: shallow depth, High erosion risk: steep slope, Low K
            |||,
          },
          {
            value: 575,
            color: 'd7191c',
            description: |||
              Shallow, Gravel, Slope, High erosion risk: textual contrast, High
              erosion risk: shallow depth, High erosion risk: steep slope, Low K
            |||,
          },
          {
            value: 640,
            color: 'feb66a',
            description: 'Al Toxicity, Low K',
          },
          {
            value: 642,
            color: 'f3854e',
            description: 'Gravel, Al Toxicity, Low K',
          },
          {
            value: 644,
            color: 'f3854e',
            description: 'Slope, Al Toxicity, Low K',
          },
          {
            value: 646,
            color: 'e54f35',
            description: 'Gravel, Slope, Al Toxicity, Low K',
          },
          {
            value: 648,
            color: 'f3854e',
            description: 'High erosion risk: textual contrast, Al Toxicity, Low K',
          },
          {
            value: 650,
            color: 'e54f35',
            description: 'Gravel, High erosion risk: textual contrast, Al Toxicity, Low K',
          },
          {
            value: 652,
            color: 'e54f35',
            description: 'Slope, High erosion risk: textual contrast, Al Toxicity, Low K',
          },
          {
            value: 676,
            color: 'e54f35',
            description: 'Slope, High erosion risk: steep slope, Al Toxicity, Low K',
          },
          {
            value: 678,
            color: 'd7191c',
            description: 'Gravel, Slope, High erosion risk: steep slope, Al Toxicity, Low K',
          },
          {
            value: 684,
            color: 'd7191c',
            description: 'Slope, High erosion risk: textual contrast, High erosion risk:\nsteep slope, Al Toxicity, Low K',
          },
          {
            value: 768,
            color: 'feb66a',
            description: 'Calcareous, Low K',
          },
          {
            value: 770,
            color: 'f3854e',
            description: 'Gravel, Calcareous, Low K',
          },
          {
            value: 772,
            color: 'f3854e',
            description: 'Slope, Calcareous, Low K',
          },
          {
            value: 774,
            color: 'e54f35',
            description: 'Gravel, Slope, Calcareous, Low K',
          },
          {
            value: 776,
            color: 'f3854e',
            description: 'High erosion risk: textual contrast, Calcareous, Low K',
          },
          {
            value: 778,
            color: 'e54f35',
            description: 'Gravel, High erosion risk: textual contrast, Calcareous, Low K',
          },
          {
            value: 780,
            color: 'e54f35',
            description: 'Slope, High erosion risk: textual contrast, Calcareous, Low K',
          },
          {
            value: 782,
            color: 'd7191c',
            description: 'Gravel, Slope, High erosion risk: textual contrast, Calcareous, Low K',
          },
          {
            value: 785,
            color: 'e54f35',
            description: 'Shallow, High erosion risk: shallow depth, Calcareous, Low K',
          },
          {
            value: 787,
            color: 'd7191c',
            description: 'Shallow, Gravel, High erosion risk: shallow depth, Calcareous, Low K',
          },
          {
            value: 789,
            color: 'd7191c',
            description: 'Shallow, Slope, High erosion risk: shallow depth, Calcareous, Low K',
          },
          {
            value: 791,
            color: 'd7191c',
            description: 'Shallow, Gravel, Slope, High erosion risk: shallow depth, Calcareous, Low K',
          },
          {
            value: 793,
            color: 'd7191c',
            description: 'Shallow, High erosion risk: textual contrast, High erosion risk:\nshallow depth, Calcareous, Low K',
          },
          {
            value: 795,
            color: 'd7191c',
            description: |||
              Shallow, Gravel, High erosion risk: textual contrast, High erosion
              risk: shallow depth, Calcareous, Low K
            |||,
          },
          {
            value: 797,
            color: 'd7191c',
            description: |||
              Shallow, Slope, High erosion risk: textual contrast, High erosion
              risk: shallow depth, Calcareous, Low K
            |||,
          },
          {
            value: 799,
            color: 'd7191c',
            description: |||
              Shallow, Gravel, Slope, High erosion risk: textual contrast, High
              erosion risk: shallow depth, Calcareous, Low K
            |||,
          },
          {
            value: 804,
            color: 'e54f35',
            description: 'Slope, High erosion risk: steep slope, Calcareous, Low K',
          },
          {
            value: 806,
            color: 'd7191c',
            description: 'Gravel, Slope, High erosion risk: steep slope, Calcareous, Low K',
          },
          {
            value: 812,
            color: 'd7191c',
            description: 'Slope, High erosion risk: textual contrast, High erosion risk:\nsteep slope, Calcareous, Low K',
          },
          {
            value: 814,
            color: 'd7191c',
            description: 'Gravel, Slope, High erosion risk: textual contrast, High erosion\nrisk: steep slope, Calcareous, Low K',
          },
          {
            value: 821,
            color: 'd7191c',
            description: 'Shallow, Slope, High erosion risk: shallow depth, High erosion\nrisk: steep slope, Calcareous, Low K',
          },
          {
            value: 823,
            color: 'd7191c',
            description: |||
              Shallow, Gravel, Slope, High erosion risk: shallow depth, High
              erosion risk: steep slope, Calcareous, Low K
            |||,
          },
          {
            value: 829,
            color: 'd7191c',
            description: |||
              Shallow, Slope, High erosion risk: textual contrast, High erosion
              risk: shallow depth, High erosion risk: steep slope, Calcareous, Low K
            |||,
          },
          {
            value: 831,
            color: 'd7191c',
            description: |||
              Shallow, Gravel, Slope, High erosion risk: textual contrast, High
              erosion risk: shallow depth, High erosion risk: steep slope, Calcareous, Low K
            |||,
          },
          {
            value: 1024,
            color: 'fff1af',
            description: 'High leaching potential',
          },
          {
            value: 1026,
            color: 'feb66a',
            description: 'Gravel, High leaching potential',
          },
          {
            value: 1028,
            color: 'feb66a',
            description: 'Slope, High leaching potential',
          },
          {
            value: 1030,
            color: 'f3854e',
            description: 'Gravel, Slope, High leaching potential',
          },
          {
            value: 1032,
            color: 'feb66a',
            description: 'High erosion risk: textual contrast, High leaching potential',
          },
          {
            value: 1036,
            color: 'f3854e',
            description: 'Slope, High erosion risk: textual contrast, High leaching potential',
          },
          {
            value: 1041,
            color: 'f3854e',
            description: 'Shallow, High erosion risk: shallow depth, High leaching potential',
          },
          {
            value: 1060,
            color: 'f3854e',
            description: 'Slope, High erosion risk: steep slope, High leaching potential',
          },
          {
            value: 1152,
            color: 'feb66a',
            description: 'Al Toxicity, High leaching potential',
          },
          {
            value: 1154,
            color: 'f3854e',
            description: 'Gravel, Al Toxicity, High leaching potential',
          },
          {
            value: 1156,
            color: 'f3854e',
            description: 'Slope, Al Toxicity, High leaching potential',
          },
          {
            value: 1160,
            color: 'f3854e',
            description: 'High erosion risk: textual contrast, Al Toxicity, High leaching potential',
          },
          {
            value: 1164,
            color: 'e54f35',
            description: 'Slope, High erosion risk: textual contrast, Al Toxicity, High leaching potential',
          },
          {
            value: 1188,
            color: 'e54f35',
            description: 'Slope, High erosion risk: steep slope, Al Toxicity, High leaching potential',
          },
          {
            value: 1280,
            color: 'feb66a',
            description: 'Calcareous, High leaching potential',
          },
          {
            value: 1281,
            color: 'f3854e',
            description: 'Shallow, Calcareous, High leaching potential',
          },
          {
            value: 1282,
            color: 'f3854e',
            description: 'Gravel, Calcareous, High leaching potential',
          },
          {
            value: 1284,
            color: 'f3854e',
            description: 'Slope, Calcareous, High leaching potential',
          },
          {
            value: 1286,
            color: 'e54f35',
            description: 'Gravel, Slope, Calcareous, High leaching potential',
          },
          {
            value: 1288,
            color: 'f3854e',
            description: 'High erosion risk: textual contrast, Calcareous, High leaching potential',
          },
          {
            value: 1290,
            color: 'e54f35',
            description: 'Gravel, High erosion risk: textual contrast, Calcareous, High leaching potential',
          },
          {
            value: 1292,
            color: 'e54f35',
            description: 'Slope, High erosion risk: textual contrast, Calcareous, High leaching potential',
          },
          {
            value: 1294,
            color: 'd7191c',
            description: 'Gravel, Slope, High erosion risk: textual contrast, Calcareous, High leaching potential',
          },
          {
            value: 1297,
            color: 'e54f35',
            description: 'Shallow, High erosion risk: shallow depth, Calcareous, High leaching potential',
          },
          {
            value: 1299,
            color: 'd7191c',
            description: 'Shallow, Gravel, High erosion risk: shallow depth, Calcareous, High leaching potential',
          },
          {
            value: 1301,
            color: 'd7191c',
            description: 'Shallow, Slope, High erosion risk: shallow depth, Calcareous,\nHigh leaching potential',
          },
          {
            value: 1303,
            color: 'd7191c',
            description: 'Shallow, Gravel, Slope, High erosion risk: shallow depth, Calcareous,\nHigh leaching potential',
          },
          {
            value: 1305,
            color: 'd7191c',
            description: |||
              Shallow, High erosion risk: textual contrast, High erosion risk:
              shallow depth, Calcareous, High leaching potential
            |||,
          },
          {
            value: 1307,
            color: 'd7191c',
            description: |||
              Shallow, Gravel, High erosion risk: textual contrast, High erosion
              risk: shallow depth, Calcareous, High leaching potential
            |||,
          },
          {
            value: 1309,
            color: 'd7191c',
            description: |||
              Shallow, Slope, High erosion risk: textual contrast, High erosion
              risk: shallow depth, Calcareous, High leaching potential
            |||,
          },
          {
            value: 1316,
            color: 'e54f35',
            description: 'Slope, High erosion risk: steep slope, Calcareous, High leaching potential',
          },
          {
            value: 1318,
            color: 'd7191c',
            description: 'Gravel, Slope, High erosion risk: steep slope, Calcareous, High\nleaching potential',
          },
          {
            value: 1324,
            color: 'd7191c',
            description: |||
              Slope, High erosion risk: textual contrast, High erosion risk:
              steep slope, Calcareous, High leaching potential
            |||,
          },
          {
            value: 1326,
            color: 'd7191c',
            description: |||
              Gravel, Slope, High erosion risk: textual contrast, High erosion
              risk: steep slope, Calcareous, High leaching potential
            |||,
          },
          {
            value: 1333,
            color: 'd7191c',
            description: |||
              Shallow, Slope, High erosion risk: shallow depth, High erosion
              risk: steep slope, Calcareous, High leaching potential
            |||,
          },
          {
            value: 1335,
            color: 'd7191c',
            description: |||
              Shallow, Gravel, Slope, High erosion risk: shallow depth, High
              erosion risk: steep slope, Calcareous, High leaching potential
            |||,
          },
          {
            value: 1341,
            color: 'd7191c',
            description: |||
              Shallow, Slope, High erosion risk: textual contrast, High erosion
              risk: shallow depth, High erosion risk: steep slope, Calcareous, High leaching
              potential
            |||,
          },
          {
            value: 1536,
            color: 'feb66a',
            description: 'Low K, High leaching potential',
          },
          {
            value: 1537,
            color: 'f3854e',
            description: 'Shallow, Low K, High leaching potential',
          },
          {
            value: 1538,
            color: 'f3854e',
            description: 'Gravel, Low K, High leaching potential',
          },
          {
            value: 1540,
            color: 'f3854e',
            description: 'Slope, Low K, High leaching potential',
          },
          {
            value: 1541,
            color: 'e54f35',
            description: 'Shallow, Slope, Low K, High leaching potential',
          },
          {
            value: 1542,
            color: 'e54f35',
            description: 'Gravel, Slope, Low K, High leaching potential',
          },
          {
            value: 1544,
            color: 'f3854e',
            description: 'High erosion risk: textual contrast, Low K, High leaching potential',
          },
          {
            value: 1546,
            color: 'e54f35',
            description: 'Gravel, High erosion risk: textual contrast, Low K, High leaching potential',
          },
          {
            value: 1548,
            color: 'e54f35',
            description: 'Slope, High erosion risk: textual contrast, Low K, High leaching potential',
          },
          {
            value: 1550,
            color: 'd7191c',
            description: 'Gravel, Slope, High erosion risk: textual contrast, Low K, High leaching potential',
          },
          {
            value: 1553,
            color: 'e54f35',
            description: 'Shallow, High erosion risk: shallow depth, Low K, High leaching potential',
          },
          {
            value: 1555,
            color: 'd7191c',
            description: 'Shallow, Gravel, High erosion risk: shallow depth, Low K, High leaching potential',
          },
          {
            value: 1557,
            color: 'd7191c',
            description: 'Shallow, Slope, High erosion risk: shallow depth, Low K, High leaching potential',
          },
          {
            value: 1559,
            color: 'd7191c',
            description: 'Shallow, Gravel, Slope, High erosion risk: shallow depth, Low\nK, High leaching potential',
          },
          {
            value: 1561,
            color: 'd7191c',
            description: |||
              Shallow, High erosion risk: textual contrast, High erosion risk:
              shallow depth, Low K, High leaching potential
            |||,
          },
          {
            value: 1563,
            color: 'd7191c',
            description: |||
              Shallow, Gravel, High erosion risk: textual contrast, High erosion
              risk: shallow depth, Low K, High leaching potential
            |||,
          },
          {
            value: 1565,
            color: 'd7191c',
            description: |||
              Shallow, Slope, High erosion risk: textual contrast, High erosion
              risk: shallow depth, Low K, High leaching potential
            |||,
          },
          {
            value: 1567,
            color: 'd7191c',
            description: |||
              Shallow, Gravel, Slope, High erosion risk: textual contrast, High
              erosion risk: shallow depth, Low K, High leaching potential
            |||,
          },
          {
            value: 1572,
            color: 'e54f35',
            description: 'Slope, High erosion risk: steep slope, Low K, High leaching potential',
          },
          {
            value: 1573,
            color: 'd7191c',
            description: 'Shallow, Slope, High erosion risk: steep slope, Low K, High leaching potential',
          },
          {
            value: 1574,
            color: 'd7191c',
            description: 'Gravel, Slope, High erosion risk: steep slope, Low K, High leaching potential',
          },
          {
            value: 1580,
            color: 'd7191c',
            description: |||
              Slope, High erosion risk: textual contrast, High erosion risk:
              steep slope, Low K, High leaching potential
            |||,
          },
          {
            value: 1582,
            color: 'd7191c',
            description: |||
              Gravel, Slope, High erosion risk: textual contrast, High erosion
              risk: steep slope, Low K, High leaching potential
            |||,
          },
          {
            value: 1589,
            color: 'd7191c',
            description: |||
              Shallow, Slope, High erosion risk: shallow depth, High erosion
              risk: steep slope, Low K, High leaching potential
            |||,
          },
          {
            value: 1591,
            color: 'd7191c',
            description: |||
              Shallow, Gravel, Slope, High erosion risk: shallow depth, High
              erosion risk: steep slope, Low K, High leaching potential
            |||,
          },
          {
            value: 1597,
            color: 'd7191c',
            description: |||
              Shallow, Slope, High erosion risk: textual contrast, High erosion
              risk: shallow depth, High erosion risk: steep slope, Low K, High leaching
              potential
            |||,
          },
          {
            value: 1599,
            color: 'd7191c',
            description: |||
              Shallow, Gravel, Slope, High erosion risk: textual contrast, High
              erosion risk: shallow depth, High erosion risk: steep slope, Low K, High leaching
              potential
            |||,
          },
          {
            value: 1664,
            color: 'f3854e',
            description: 'Al Toxicity, Low K, High leaching potential',
          },
          {
            value: 1666,
            color: 'e54f35',
            description: 'Gravel, Al Toxicity, Low K, High leaching potential',
          },
          {
            value: 1668,
            color: 'e54f35',
            description: 'Slope, Al Toxicity, Low K, High leaching potential',
          },
          {
            value: 1670,
            color: 'd7191c',
            description: 'Gravel, Slope, Al Toxicity, Low K, High leaching potential',
          },
          {
            value: 1672,
            color: 'e54f35',
            description: 'High erosion risk: textual contrast, Al Toxicity, Low K, High leaching potential',
          },
          {
            value: 1674,
            color: 'd7191c',
            description: 'Gravel, High erosion risk: textual contrast, Al Toxicity, Low K, High leaching potential',
          },
          {
            value: 1676,
            color: 'd7191c',
            description: 'Slope, High erosion risk: textual contrast, Al Toxicity, Low K, High leaching potential',
          },
          {
            value: 1700,
            color: 'd7191c',
            description: 'Slope, High erosion risk: steep slope, Al Toxicity, Low K, High leaching potential',
          },
          {
            value: 1702,
            color: 'd7191c',
            description: 'Gravel, Slope, High erosion risk: steep slope, Al Toxicity, Low K, High leaching potential',
          },
          {
            value: 1708,
            color: 'd7191c',
            description: |||
              Slope, High erosion risk: textual contrast, High erosion risk:
              steep slope, Al Toxicity, Low K, High leaching potential
            |||,
          },
          {
            value: 1792,
            color: 'f3854e',
            description: 'Calcareous, Low K, High leaching potential',
          },
          {
            value: 1793,
            color: 'e54f35',
            description: 'Shallow, Calcareous, Low K, High leaching potential',
          },
          {
            value: 1794,
            color: 'e54f35',
            description: 'Gravel, Calcareous, Low K, High leaching potential',
          },
          {
            value: 1796,
            color: 'e54f35',
            description: 'Slope, Calcareous, Low K, High leaching potential',
          },
          {
            value: 1798,
            color: 'd7191c',
            description: 'Gravel, Slope, Calcareous, Low K, High leaching potential',
          },
          {
            value: 1800,
            color: 'e54f35',
            description: 'High erosion risk: textual contrast, Calcareous, Low K, High leaching potential',
          },
          {
            value: 1802,
            color: 'd7191c',
            description: 'Gravel, High erosion risk: textual contrast, Calcareous, Low K, High leaching potential',
          },
          {
            value: 1804,
            color: 'd7191c',
            description: 'Slope, High erosion risk: textual contrast, Calcareous, Low K, High leaching potential',
          },
          {
            value: 1806,
            color: 'd7191c',
            description: 'Gravel, Slope, High erosion risk: textual contrast, Calcareous,\nLow K, High leaching potential',
          },
          {
            value: 1809,
            color: 'd7191c',
            description: 'Shallow, High erosion risk: shallow depth, Calcareous, Low K, High leaching potential',
          },
          {
            value: 1811,
            color: 'd7191c',
            description: 'Shallow, Gravel, High erosion risk: shallow depth, Calcareous, Low K, High leaching potential',
          },
          {
            value: 1813,
            color: 'd7191c',
            description: 'Shallow, Slope, High erosion risk: shallow depth, Calcareous, Low K, High leaching potential',
          },
          {
            value: 1815,
            color: 'd7191c',
            description: 'Shallow, Gravel, Slope, High erosion risk: shallow depth, Calcareous,\nLow K, High leaching potential',
          },
          {
            value: 1817,
            color: 'd7191c',
            description: |||
              Shallow, High erosion risk: textual contrast, High erosion risk:
              shallow depth, Calcareous, Low K, High leaching potential
            |||,
          },
          {
            value: 1821,
            color: 'd7191c',
            description: |||
              Shallow, Slope, High erosion risk: textual contrast, High erosion
              risk: shallow depth, Calcareous, Low K, High leaching potential
            |||,
          },
          {
            value: 1828,
            color: 'd7191c',
            description: 'Slope, High erosion risk: steep slope, Calcareous, Low K, High leaching potential',
          },
          {
            value: 1830,
            color: 'd7191c',
            description: 'Gravel, Slope, High erosion risk: steep slope, Calcareous, Low K, High leaching potential',
          },
          {
            value: 1836,
            color: 'd7191c',
            description: |||
              Slope, High erosion risk: textual contrast, High erosion risk:
              steep slope, Calcareous, Low K, High leaching potential
            |||,
          },
          {
            value: 1838,
            color: 'd7191c',
            description: |||
              Gravel, Slope, High erosion risk: textual contrast, High erosion
              risk: steep slope, Calcareous, Low K, High leaching potential
            |||,
          },
          {
            value: 1845,
            color: 'd7191c',
            description: |||
              Shallow, Slope, High erosion risk: shallow depth, High erosion
              risk: steep slope, Calcareous, Low K, High leaching potential
            |||,
          },
          {
            value: 1847,
            color: 'd7191c',
            description: |||
              Shallow, Gravel, Slope, High erosion risk: shallow depth, High
              erosion risk: steep slope, Calcareous, Low K, High leaching potential
            |||,
          },
          {
            value: 1853,
            color: 'd7191c',
            description: |||
              Shallow, Slope, High erosion risk: textual contrast, High erosion
              risk: shallow depth, High erosion risk: steep slope, Calcareous, Low K, High
              leaching potential
            |||,
          },
        ],
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Fertility Capability Classification',
        lookat: {
          lat: 25.0,
          lon: -3.0,
          zoom: 2,
        },
        image_visualization: {
          band_vis: {
            bands: [
              'fcc',
            ],
          },
        },
      },
    ],
    fcc: {
      minimum: 0.0,
      maximum: 1853.0,
      'gee:estimated_range': false,
    },
  },
  'sci:citation': |||
    Hengl, T., Miller, M.A.E., Križan, J., et al. African soil properties and nutrients
    mapped at 30 m spatial resolution using two-scale ensemble machine learning.
    Sci Rep 11, 6130 (2021).
    [doi:10.1038/s41598-021-85639-y](https://doi.org/10.1038/s41598-021-85639-y)
  |||,
  'gee:terms_of_use': 'CC-BY-4.0',
  'gee:user_uploaded': true,
}
