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

This repository contains Earth Engine catalog content.

## Quick links

- [Edit existing entries](docs/simple_edits.md).
- [Add new datasets](docs/adding_datasets.md).
- [See annotated examples](catalog/TEMPLATE).
- [Request to add a new dataset](https://issuetracker.google.com/issues?q=status:(open%20%7C%20new%20%7C%20assigned%20%7C%20accepted)%20componentid:1161680&p=1). If you'd like to maintain this dataset, make a note in the request.
- [Report a problem with an existing dataset](https://issuetracker.google.com/issues?q=status:(open%20%7C%20new%20%7C%20assigned%20%7C%20accepted)%20componentid:1161653).


# STAC and Jsonnet

[SpatioTemporal Asset Catalogs (STAC)](https://stacspec.org/) is a standard for
describing spatial datasets in a catalog.

Earth Engine uses STAC [Jsonnet](https://jsonnet.org) templates to generate the
[Earth Engine Public Data Catalog](https://developers.google.com/earth-engine/datasets/catalog)
and the
[STAC JSON catalog](https://console.cloud.google.com/storage/browser/earthengine-stac).
Using Jsonnet
allows repetitive content to be written one time and used across multiple
collections and items.

You can use these external services to browse the EE STAC catalog:

- [RadiantEarth STAC Browser](https://radiantearth.github.io/stac-browser/#/external/storage.googleapis.com/earthengine-stac/catalog/catalog.json)
- [STAC Index](https://stacindex.org/catalogs/google-earth-engine)
- [gee.stac.cloud](https://gee.stac.cloud/)


# Local Install Instructions

If you'd like to run validity checks locally (not via GitHub actions), see
[the local installation instructions](docs/install.md). Most people won't
need this.

# Non-commercial datasets

[non_commercial_datasets.jsonnet](https://github.com/google/earthengine-catalog/blob/main/non_commercial_datasets.jsonnet)
contains a list of datasets that have
licenses known to exclude commercial use. If you are using Earth Engine
in a commercial capacity, these datasets are not available.

# Other Earth Engine Github repositories

- Community tutorials: https://github.com/google/earthengine-community
- Earth Engine API: https://github.com/google/earthengine-api
