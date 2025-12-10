local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';

{
  license: spdx.cc_by_4_0,
  subdir: 'COPERNICUS',
  quality_control_flag_description(field): |||
    Quality control flag for %s.

    * 0: No QC was performed
    * 1: good
    * 2: probably good
    * 3: Bad data that are potentially correctable
    * 4: Bad data
    * 5: value changed
    * 6: Not used
    * 7: nominal
    * 8: interpolated
    * 9: Missing value

    Note that a valid value for the corresponding variable has a QC bit
    equal to 1, 2, 5, 7, or 8.
  ||| % field,
  keywords: [
    'copernicus',
    'currents',
    'marine',
    'ocean',
    'insitu',
  ],
  providers(self_ee_catalog_url): [
    ee.producer_provider('Copernicus', 'https://marine.copernicus.eu/'),
    ee.host_provider(self_ee_catalog_url),
  ],
  description: |||
    The In Situ TAC is a distributed centre organized around 7 oceanographic
    regions: the global ocean and the 6 EUROGOOS regional alliances. It involves
    14 partners from 11 countries in Europe. It doesn't deploy any observing
    system and relies on data, exclusively funded by other sources than
    Copernicus Marine Service.
  |||,
  terms_of_use: |||
    The data is provided free of charge by the Copernicus Marine Service.
    Users must acknowledge the Copernicus Marine Service as the data source
    when using the data. More details on the terms of use can be found on
    the [Copernicus Marine Service website](https://marine.copernicus.eu/user-corner/service-commitments-and-licence).
  |||,
}
