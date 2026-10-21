// Asset ID prefixes belonging to share-alike datasets.
//
// Currently, this is:
//
// - CC-BY-SA-4.0
// - CC-BY-NC-SA-4.0
// - ODbL-1.0
//
// Collected via:
//
//   bazel build //...
//
//   find bazel-bin/catalog -name \*.json | \
//     xargs grep -E -l '"license": "(CC-BY-SA-4.0|CC-BY-NC-SA-4.0|ODbL-1.0)"' | \
//     xargs grep '"id":' | \
//     cut -d\" -f4 | \
//     sort | \
//     xargs -I % echo "  '%',"
//
// See also:
//
// - https://github.com/google/earthengine-catalog/blob/main/checker/node/share_alike.py

[
  'CSIRO/BHI/v4',
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
  'GFW/GFF/V1/fishing_hours',
  'GFW/GFF/V1/vessel_hours',
  'JAXA/ALOS/PALSAR-2/Level2_1/StripMap_202401',
  'MERIT/DEM/v1_0_3',
  'MERIT/Hydro/v1_0_1',
  'MERIT/Hydro_reduced/v1_0_1',
  'OpenLandMap/CLM/CLM_LST_MOD11A2-DAYNIGHT_M/v01',
  'OpenLandMap/CLM/CLM_LST_MOD11A2-DAY_M/v01',
  'OpenLandMap/CLM/CLM_LST_MOD11A2-DAY_SD/v01',
  'OpenLandMap/CLM/CLM_PRECIPITATION_SM2RAIN_M/v01',
  'OpenLandMap/PNV/PNV_BIOME-TYPE_BIOME00K_C/v01',
  'OpenLandMap/PNV/PNV_FAPAR_PROBA-V_D/v01',
  'OpenLandMap/SOL/SOL_BULKDENS-FINEEARTH_USDA-4A1H_M/v02',
  'OpenLandMap/SOL/SOL_CLAY-WFRACTION_USDA-3A1A1A_M/v02',
  'OpenLandMap/SOL/SOL_GRTGROUP_USDA-SOILTAX-HAPLUDALFS_P/v01',
  'OpenLandMap/SOL/SOL_GRTGROUP_USDA-SOILTAX_C/v01',
  'OpenLandMap/SOL/SOL_ORGANIC-CARBON_USDA-6A1C_M/v02',
  'OpenLandMap/SOL/SOL_PH-H2O_USDA-4C1A2A_M/v02',
  'OpenLandMap/SOL/SOL_SAND-WFRACTION_USDA-3A1A1A_M/v02',
  'OpenLandMap/SOL/SOL_TEXTURE-CLASS_USDA-TT_M/v02',
  'OpenLandMap/SOL/SOL_WATERCONTENT-33KPA_USDA-4B1C_M/v01',
  'Oxford/MAP/EVI_5km_Monthly',
  'Oxford/MAP/IGBP_Fractional_Landcover_5km_Annual',
  'Oxford/MAP/LST_Day_5km_Monthly',
  'Oxford/MAP/LST_Night_5km_Monthly',
  'Oxford/MAP/TCB_5km_Monthly',
  'Oxford/MAP/TCW_5km_Monthly',
  'WCMC/biomass_carbon_density/v1_0',
  'WORLDCLIM/V1/BIO',
  'WORLDCLIM/V1/MONTHLY',
  'WRI/SBTN/naturalLands/v1/2020',
  'WRI/SBTN/naturalLands/v1_1/2020',
  'overture-maps/places_place',
  'projects/malariaatlasproject/assets/EVI_v061',
  'projects/malariaatlasproject/assets/LST_Day_v061',
  'projects/malariaatlasproject/assets/LST_Night_v061',
  'projects/malariaatlasproject/assets/TCB_v061',
  'projects/malariaatlasproject/assets/TCW_v061',
]
