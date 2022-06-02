<!--
Copyright 2019 The Google Earth Engine Community Authors

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
-->

# Google Earth Engine Public Data Catalog

This repository contains content submitted and/or maintained by the Earth Engine
user community.

https://github.com/google/earthengine-catalog


# STAC

[SpatioTemporal Asset Catalogs (STAC)](https://stacspec.org/) is a standard for
describing spatial dataset in a catalog.

Earth Engine uses STAC Jsonnet templates to generate the Earth Engine Public
Datacatalog and a STAC json catalog.  Using [Jsonnet](https://jsonnet.org)
allows repetitive content to be written one time and used across multiple
collections and items.

- https://developers.google.com/earth-engine/datasets/catalog
- https://console.cloud.google.com/storage/browser/earthengine-stac

You can use [stac-browser](https://github.com/radiantearth/stac-browser) and
point it at:

    https://storage.googleapis.com/earthengine-stac/catalog/catalog.json

Or you can use an externally hosted service:

- [RadiantEarth](https://radiantearth.github.io/stac-browser/#/external/storage.googleapis.com/earthengine-stac/catalog/catalog.json)
- [gee.stac.cloud](https://gee.stac.cloud/)
- [STAC Index](https://stacindex.org/catalogs/google-earth-engine)

# See also

https://github.com/google/earthengine-community
