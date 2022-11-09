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
// See also:
//
// - checker/node/gee_unusual_terms_of_use.py
// - checker/node/non_commercial.py

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
  'Oxford/MAP/EVI_5km_Monthly',
  'Oxford/MAP/IGBP_Fractional_Landcover_5km_Annual',
  'Oxford/MAP/LST_Day_5km_Monthly',
  'Oxford/MAP/LST_Night_5km_Monthly',
  'Oxford/MAP/TCB_5km_Monthly',
  'Oxford/MAP/TCW_5km_Monthly',
]
