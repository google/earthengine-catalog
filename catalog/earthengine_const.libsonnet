// Copyright 2022 The Google Earth Engine Community Authors
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     https://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

local bucket = 'earthengine-stac';
local catalog = 'catalog/';  // Trailing '/' required.

local image_base_url = 'https://developers.google.com/earth-engine/datasets/images/';

{
  stac_version: '1.0.0',
  stac_type: {
    catalog: 'Catalog',
    collection: 'Collection',
    item: 'Item',
  },

  // Earth Engine human readable catalog
  ee_catalog_url:
    'https://developers.google.com/earth-engine/datasets/catalog/',

  // STAC Catalog
  catalog_base: 'https://storage.googleapis.com/' + bucket + '/' + catalog,
  catalog_url: self.catalog_base + 'catalog.json',

  sample_url(subdir, basename): image_base_url + subdir + '/' + basename + '_sample.png',
  example_base_url: 'https://code.earthengine.google.com/?scriptPath=Examples:Datasets',

  // Values for gee:type
  gee_type: {
    image: 'image',
    image_collection: 'image_collection',
    table: 'table',
    table_collection: 'table_collection',
    bigquery_table: 'bigquery_table',
  },

  ext_base: 'https://stac-extensions.github.io/',
  ext_eo: self.ext_base + 'eo/v1.0.0/schema.json',
  ext_sar: self.ext_base + 'sar/v1.0.0/schema.json',
  ext_sci: self.ext_base + 'scientific/v1.0.0/schema.json',
  ext_ver: self.ext_base + 'version/v1.0.0/schema.json',

  version_unknown: 'Unknown',

  provider_type: {
    host: 'host',
    licensor: 'licensor',
    processor: 'processor',
    producer: 'producer',
  },

  // MIME types
  // https://en.wikipedia.org/wiki/Media_type
  // https://github.com/radiantearth/stac-spec/blob/master/collection-spec/collection-spec.md#media-type-for-stac-collections
  // https://github.com/radiantearth/stac-spec/blob/master/catalog-spec/catalog-spec.md#media-types
  media_type: {
    html: 'text/html',
    pdf: 'application/pdf',
    png: 'image/png',
    stac: 'application/json',
    terms: 'text/html',
  },

  // URL Relations
  // https://www.iana.org/assignments/link-relations/link-relations.xhtml
  rel: {
    child: 'child',
    cite_as: 'cite-as',
    license: 'license',
    parent: 'parent',
    preview: 'preview',
    related: 'related',
    root: 'root',
    self_rel: 'self',

    // Where to find the data.
    source: 'source',

    // ext_ver
    latest: 'latest-version',
    predecessor: 'predecessor-version',
    successor: 'successor-version',
  },

  code_type: {
    javascript: 'JavaScript',
    python: 'Python',
  },

  var_type: {
    property_type_unspecified: 'PROPERTY_TYPE_UNSPECIFIED',
    string: 'STRING',
    int: 'INT',
    double: 'DOUBLE',
    record: 'RECORD',
    string_list: 'STRING_LIST',
    int_list: 'INT_LIST',
    double_list: 'DOUBLE_LIST',
    record_list: 'RECORD_LIST',
    geometry: 'GEOMETRY',
    datetime: 'DATETIME',
  },
}
