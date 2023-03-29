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

// Things to make it easier to generate STAC json for Earth Engine.

local ee_const = import 'earthengine_const.libsonnet';

{
  orEmptyArray(condition, arr):
    if condition then arr else [],
  orEmptyDict(condition, d):
    if condition then d else {},

  producer_provider(name, url):
    {
      name: name,
      roles: [ee_const.provider_type.licensor, ee_const.provider_type.producer],
      url: url
    },
  processor_provider(name, url):
    { name: name, roles: [ee_const.provider_type.processor], url: url },
  host_provider(ee_catalog_url):
    {
      name: 'Google Earth Engine',
      roles: [ee_const.provider_type.host],
      url: ee_catalog_url
    },

  extent(xmin, ymin, xmax, ymax, start, end):: {
    spatial: { bbox: [[xmin, ymin, xmax, ymax]] },
    temporal: { interval: [[start, end]] },
  },

  extent_global(start, end):: {
    spatial: { bbox: [[-180, -90, 180, 90]] },
    temporal: { interval: [[start, end]] },
  },

  gee_terms_of_use(license): '[' + license.id + '](' + license.reference + ')',

  link: {
    // Cannot use 'self' as it is special.
    self_link(url):: {
      rel: ee_const.rel.self_rel,
      href: url,
      type: ee_const.media_type.stac,
    },
    parent(url):: {
      rel: ee_const.rel.parent,
      href: url,
      type: ee_const.media_type.stac,
    },
    child_catalog(id, base_url):: {
      rel: ee_const.rel.child,
      title: id,
      href: base_url + id + '/catalog.json',
      type: ee_const.media_type.stac
    },
    child_collection(id, base_url):: {
      rel: ee_const.rel.child,
      title: id,
      href: base_url + id + '.json',
      type: ee_const.media_type.stac,
    },
    root():: {
      rel: ee_const.rel.root,
      href: ee_const.catalog_url,
      type: ee_const.media_type.stac,
    },
    example(id, basename):: {
      title: 'Run the example for ' + id + ' in the Earth Engine Code Editor',
      rel: ee_const.rel.related,
      href: ee_const.example_base_url + basename,
      type: ee_const.media_type.html,
      code: ee_const.code_type.javascript,
    },
    preview(subdir, basename):: {
      rel: ee_const.rel.preview,
      href: ee_const.sample_url(subdir, basename),
      type: ee_const.media_type.png,
    },
    license(url):: {
      rel: ee_const.rel.license,
      href: url,
      type: ee_const.media_type.terms,
    },
    terms_of_use(url):: {
      rel: ee_const.rel.license,
      href: url + '#terms-of-use',
      type: ee_const.media_type.terms,
    },
    // Version links
    latest(id, url):: {
      rel: ee_const.rel.latest,
      href: url,
      title: id,
      type: ee_const.media_type.stac
    },
    predecessor(id, url):: {
      rel: ee_const.rel.predecessor,
      href: url,
      title: id,
      type: ee_const.media_type.stac
    },
    successor(id, url):: {
      rel: ee_const.rel.successor,
      href: url,
      title: id,
      type: ee_const.media_type.stac
    },
  },

  standardLinks(subdir, dataset_id)::
    local basename = std.strReplace(dataset_id, '/', '_');
    local self_ee_catalog_url = ee_const.ee_catalog_url + basename;
    local parent_url = ee_const.catalog_base + subdir + '/catalog.json';
    local base_filename = basename + '.json';
    local self_url = ee_const.catalog_base + subdir + '/' + base_filename;
    [
      $.link.self_link(self_url),
      $.link.parent(parent_url),
      $.link.root(),
      $.link.example(dataset_id, basename),
      $.link.preview(subdir, basename),
      $.link.terms_of_use(self_ee_catalog_url),
    ],
}
