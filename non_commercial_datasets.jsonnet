// Asset ID prefixes belonging to non-commercial datasets.
//
// Currently, this is:
//
// - CC-BY-NC-4.0
// - CC-BY-NC-SA-4.0
//
// Collected via:
//
//   bazel build //...
//
//   find bazel-bin/catalog -name \*.json | \
//     xargs grep -l '"license": "CC-BY-NC' | \
//     xargs grep '"id":' | \
//     cut -d\" -f4 | \
//     sort | \
//     xargs -I % echo "  '%',"
//
// There are also some non-commercial datasets with non-standard licenses
// that need to be added manually.
//
// See also:
//
// - https://github.com/google/earthengine-catalog/blob/main/checker/node/gee_unusual_terms_of_use.py
// - https://github.com/google/earthengine-catalog/blob/main/checker/node/non_commercial.py

[
  'CSP/ERGo/1_0/Global/ALOS_CHILI',
  'CSP/ERGo/1_0/Global/ALOS_landforms',
  'CSP/ERGo/1_0/Global/ALOS_mTPI',
  'CSP/ERGo/1_0/Global/ALOS_topoDiversity',
  'CSP/ERGo/1_0/Global/SRTM_CHILI',
  'CSP/ERGo/1_0/Global/SRTM_landforms',
  'CSP/ERGo/1_0/Global/SRTM_mTPI',
  'CSP/ERGo/1_0/Global/SRTM_topoDiversity',
  'CSP/ERGo/1_0/US/CHILI',
  'CSP/ERGo/1_0/US/landforms',
  'CSP/ERGo/1_0/US/lithology',
  'CSP/ERGo/1_0/US/mTPI',
  'CSP/ERGo/1_0/US/physioDiversity',
  'CSP/ERGo/1_0/US/physiography',
  'CSP/ERGo/1_0/US/topoDiversity',
  'CSP/HM/GlobalHumanModification',
  'GLOBAL_FLOOD_DB/MODIS_EVENTS/V1',
  'GOOGLE/AirView/California_Unified_2015_2019',
  'JAXA/ALOS/PALSAR-2/Level2_1/StripMap_202401',
  'Oxford/MAP/EVI_5km_Monthly',
  'Oxford/MAP/IGBP_Fractional_Landcover_5km_Annual',
  'Oxford/MAP/LST_Day_5km_Monthly',
  'Oxford/MAP/LST_Night_5km_Monthly',
  'Oxford/MAP/TCB_5km_Monthly',
  'Oxford/MAP/TCW_5km_Monthly',
  'projects/nature-trace/assets/farmscapes/england_v1_0',
  'UN/Geodata/BNDA_simplified/current',
  'WCMC/WDOECM',
  'WRI/SBTN/naturalLands/v1/2020',
  'projects/malariaatlasproject/assets/LST_Day_v061',
  'projects/malariaatlasproject/assets/LST_Night_v061',
  'projects/malariaatlasproject/assets/EVI_v061',
  'projects/malariaatlasproject/assets/TCB_v061',
  'projects/malariaatlasproject/assets/TCW_v061',
]
