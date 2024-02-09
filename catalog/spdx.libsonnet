// Support for the Software Package Data Exchange (SPDX)
//
// SPDX is an open standard for software bill of materials (SBOM).
//
// https://spdx.dev/
// https://en.wikipedia.org/wiki/Software_Package_Data_Exchange

{
  // License entries.
  // Only includes a subset of the possible entries.
  //
  // SPDX catalog version:
  //   licenseListVersion: f9911cd
  //   releaseDate: 2021-11-19

  // "Proprietary" is for any non-standard license, both open and closed.
  proprietary: {
    id: 'proprietary',
    name: 'Non-standard license',
    reference: 'Use a custom URL for the non-standard license',
  },
  // "Various" indicates that multiple licenses apply to the data. It is
  // recommended to put the details in gee:terms_of_use.
  various: {
    id: 'various',
    name: 'Various licenses',
    reference: 'Use a custom URL for the multiple licenses',
  },
  cc_by_4_0: {
    id: 'CC-BY-4.0',
    name: 'Creative Commons Attribution 4.0 International',
    reference: 'https://spdx.org/licenses/CC-BY-4.0.html',
  },
  cc_by_nc_4_0: {
    id: 'CC-BY-NC-4.0',
    name: 'Creative Commons Attribution Non Commercial 4.0 International',
    reference: 'https://spdx.org/licenses/CC-BY-NC-4.0.html',
  },
  cc_by_nc_sa_4_0: {
    id: 'CC-BY-NC-SA-4.0',
    name: 'Creative Commons Attribution Non Commercial Share Alike 4.0 International',
    reference: 'https://spdx.org/licenses/CC-BY-NC-SA-4.0.html',
  },
  cc_by_sa_4_0: {
    id: 'CC-BY-SA-4.0',
    name: 'Creative Commons Attribution Share Alike 4.0 International',
    reference: 'https://spdx.org/licenses/CC-BY-SA-4.0.html',
  },
  cc_pddc: {
    id: 'CC-PDDC',
    name: 'Creative Commons Public Domain Dedication and Certification',
    reference: 'https://spdx.org/licenses/CC-PDDC.html',
  },
  cc0_1_0: {
    id: 'CC0-1.0',
    name: 'Creative Commons Zero v1.0 Universal',
    reference: 'https://spdx.org/licenses/CC0-1.0.html',
  },
  etalab_2_0: {
    id: 'etalab-2.0',
    name: 'Etalab Open License 2.0',
    reference: 'https://spdx.org/licenses/etalab-2.0.html',
  },
  odbl_1_0: {
    id: 'ODbL-1.0',
    name: 'Open Data Commons Open Database License v1.0',
    reference: 'https://spdx.org/licenses/ODbL-1.0.html',
  },
  ogl_canada_2_0: {
    id: 'OGL-Canada-2.0',
    name: 'Open Government Licence - Canada',
    reference: 'https://spdx.org/licenses/OGL-Canada-2.0.html',
  },
  pddl_1_0: {
    id: 'PDDL-1.0',
    name: 'Open Data Commons Public Domain Dedication & License 1.0',
    reference: 'https://spdx.org/licenses/PDDL-1.0.html',
  },
}
