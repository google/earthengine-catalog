/*
Asset ID prefixes belonging to non-commercial datasets, collected via:
$ cs 'f:earthengine_cat.*jsonnet +license...spdx\.\w*cc_by_nc -f:merit' \
  -h --non 2>&1 | grep 'id =' | awk '{ print $4 }' | sed -e 's/;/,/' | sort

`AssetNameEncoder.isNonCommercialAsset` will match the paths below and any
files within these directories, i.e. {prefix} or {prefix/.*}.

There is a presubmit check to remind catalog contributors to update this list,
which is currently manual.
*/
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
