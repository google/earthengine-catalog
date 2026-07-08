local id = 'COPERNICUS/DEM/GLO30';
local subdir = 'COPERNICUS';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';
local glo30 = import 'COPERNICUS_DEM_GLO30.libsonnet';

local license = spdx.proprietary;

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
  The GLO-30 dataset is available worldwide with a free license with the
  exception of two countries (Armenia and Azerbaijan). [License for Copernicus
  DEM](https://docs.sentinel-hub.com/api/latest/static/files/data/dem/resources/license/License-COPDEM-30.pdf).

  © DLR e.V. 2010-2014 and © Airbus Defence and Space GmbH 2014-2018 provided
  under COPERNICUS by the European Union and ESA; all rights reserved.
|||;

glo30.common(
  id=id,
  subdir=subdir,
  title='Copernicus DEM GLO-30: Global 30m Digital Elevation Model',
  description=description,
  self_ee_catalog_url=self_ee_catalog_url,
  extent=ee.extent_global('2010-12-01T00:00:00Z', '2015-01-31T00:00:00Z'),
  terms_of_use=terms_of_use,
  license=license.id
)
