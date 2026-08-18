local id = 'COPERNICUS/DEM/GLO30_2024_1';
local versions = import 'versions.libsonnet';
local version_table = import 'COPERNICUS_DEM_GLO30_versions.libsonnet';

local subdir = 'COPERNICUS';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';
local glo30 = import 'COPERNICUS_DEM_GLO30.libsonnet';

local license = spdx.proprietary;
local version_config = versions(subdir, version_table, id);

local basename = std.strReplace(id, '/', '_');
local self_ee_catalog_url = ee_const.ee_catalog_url + basename;

local description = |||
  The Copernicus DEM is a Digital Surface Model (DSM) which represents the
  surface of the Earth including buildings, infrastructure and vegetation.
  This DEM is derived from an edited DSM named WorldDEM&trade;, i.e., flattening of
  water bodies and consistent flow of rivers has been included. Editing of
  shore- and coastlines, special features such as airports and implausible
  terrain structures has also been applied.

  The WorldDEM product is based on the radar satellite data acquired during
  the TanDEM-X Mission, which is funded by a Public Private Partnership
  between the German State, represented by the German Aerospace Centre (DLR)
  and Airbus Defence and Space. More details are available in the dataset
  [documentation](https://dataspace.copernicus.eu/sites/default/files/media/files/2024-06/geo1988-copernicusdem-spe-002_producthandbook_i5.0.pdf).

  The DSM uses the EGM2008 vertical datum:
  [EPSG:3855](https://spatialreference.org/ref/epsg/3855/). This means a 0
  elevation at a location does not imply the location is at a mean sea level.

  Earth Engine asset has been ingested from the DGED files.

  Note: See the code example for the recommended way of computing slope.
  Unlike most DEMs in Earth Engine, this is an image collection due to
  multiple resolutions of source files that make it impossible to mosaic them
  into a single asset, so the slope computations need a reprojection.
|||;

local terms_of_use = |||
  The GLO-30 dataset is available worldwide with a free license. [See the terms
  under 'Licence for the use of the Copernicus
  WorldDEM-30'](https://dataspace.copernicus.eu/sites/default/files/media/files/2025-06/copernicus_contributing_mission_data_access_v2_cop_dem_licenses.pdf).

  When communicating to the General Public or distributing the Copernicus WorldDEM-30,
  the User shall inform the General Public of the source by using the following notice:
  © DLR e.V. 2010-2014 and © Airbus Defence and Space GmbH 2014-2018 provided under COPERNICUS
  by the European Union and ESA; all rights reserved.

  Where the Copernicus WorldDEM-30 data have been adapted or modified, the User shall
  provide the following notice:
  "produced using Copernicus WorldDEM-30 © DLR e.V. 2010-2014 and © Airbus Defence and Space GmbH
  2014-2018 provided under COPERNICUS by the European Union and ESA; all rights reserved”.

  The following sentence or its translation in any language shall be added by such Users
  in a licence or any legal warning or notice covering their distribution or communication
  to the General Public of the Copernicus WorldDEM30:
  "The organisations in charge of the Copernicus programme by law or by delegation do not
  incur any liability for any use of the Copernicus WorldDEM-30".
|||;

glo30.common(
  id=id,
  subdir=subdir,
  title='Copernicus DEM GLO-30 (2024_1): Global 30m Digital Elevation Model',
  description=description,
  self_ee_catalog_url=self_ee_catalog_url,
  extent=ee.extent_global('2010-12-01T00:00:00Z', '2020-11-13T00:00:00Z'),
  terms_of_use=terms_of_use,
  license=license.id,
  version_config=version_config
) + {
  summaries+: {
    'gee:schema': [
      {
        name: 'tile_version',
        description: 'The release version of the Copernicus DEM tile (e.g., 02).',
        type: ee_const.var_type.string,
      },
    ],
  },
}
