"""Checks for links.

An example minimal link dictionary in Jsonnet to aid in reading the rules:

  {
    href: 'https://example.test',
    rel: 'source',
  }

General Rules
- 'links' contains a list of dictionaries where each dictionary is a link
- All link dictionaries must have both the key and value be strings
- All links must have an 'href' with a URL and a 'rel' that defines the
  relationship with the data at the URL
- Every STAC node must have at least 3 rels.  These required rels can only
  occur once in the list of links
  - self - where the current node can be found
  - root - the top of the STAC Catalog (except the root, which does not have it)
  - parent - the catalog node above the current one. One exception is the
    root 'GEE_catalog' node that does not have a parent
- The href keys' URLs must start with an allowed protocol. One of ftp://,
  http://, https://, or s3://.  Prefer https to http or ftp whenever possible
- There are optional relations:
  - code - Contains the programming language found at the URL
  - title - The title to display for the link
  - type - the media type of the content found at the link (formerly known as
    mimetype). All links to other STAC Nodes must have a media type of
    'application/json'. If new media types are needed, add them to MEDIA_TYPES

Rules for STAC Catalogs:
- Must have at least one child link. A child is a STAC Catalog or STAC
  Collection that is a descendent of this catalog
  - All child href urls must be unique
  - The title should match the path.stem of the url
  - TODO(schwehr): Links should be sorted by title
- Extra rel links are not allowed

- TODO(schwehr): Add Rules for STAC Collections:

See also:

- https://github.com/radiantearth/stac-spec/blob/master/catalog-spec/catalog-spec.md#link-object
- https://github.com/radiantearth/stac-spec/blob/master/collection-spec/collection-spec.md#link-object
- https://github.com/stac-extensions/version#relation-types

Jsonnet examples:

A catalog with two children:

'links': [
  {
    href: 'https://storage.googleapis.com/earthengine-stac/catalog/catalog.json',
    rel: 'root',
    type: 'application/json'
  }, {
    href: 'https://storage.googleapis.com/earthengine-stac/catalog/catalog.json',
    rel: 'parent',
    type: 'application/json'
  }, {
    href: 'https://storage.googleapis.com/earthengine-stac/catalog/USDOS/catalog.json',
    rel: 'self',
    type: 'application/json'
  }, {
    href: 'https://storage.googleapis.com/earthengine-stac/catalog/USDOS/USDOS_LSIB_2013.json',
    rel: 'child',
    title: 'USDOS_LSIB_2013',
    type: 'application/json'
  }, {
    href: 'https://storage.googleapis.com/earthengine-stac/catalog/USDOS/USDOS_LSIB_2021.json',
    rel: 'child',
    title: 'USDOS_LSIB_2021',
    type: 'application/json'
  }]
"""

import collections
import pathlib
from typing import Iterator

from checker import stac

CATALOG = stac.StacType.CATALOG

LINKS = 'links'

CODE = 'code'
HREF = 'href'
REL = 'rel'
TITLE = 'title'
TYPE = 'type'

REQUIRED_KEYS = frozenset({HREF, REL})
OPTIONAL_KEYS = frozenset({CODE, TITLE, TYPE})
ALL_KEYS = REQUIRED_KEYS.union(OPTIONAL_KEYS)

CHILD = 'child'
PARENT = 'parent'
ROOT = 'root'
SELF = 'self'

REQUIRED_REL = frozenset({PARENT, ROOT, SELF})
OPTIONAL_CATALOG_REL = frozenset({CHILD})
ALL_CATALOG_REL = REQUIRED_REL.union(OPTIONAL_CATALOG_REL)

CITE_AS = 'cite-as'
LATEST_VERSION = 'latest-version'
LICENSE = 'license'
PREDECESSOR_VERSION = 'predecessor-version'
PREVIEW = 'preview'
RELATED = 'related'
SOURCE = 'source'
SUCCESSOR_VERSION = 'successor-version'

REQUIRED_COLLECTION_REL = REQUIRED_REL.union({LICENSE, PREVIEW, RELATED})
OPTIONAL_COLLECTION_REL = frozenset({
    CITE_AS, LATEST_VERSION, PREDECESSOR_VERSION, SOURCE, SUCCESSOR_VERSION})
ALL_COLLECTION_REL = REQUIRED_COLLECTION_REL.union(OPTIONAL_COLLECTION_REL)

# Note: ftp and http should be avoided if at all possible.
HREF_PREFIXES = ('ftp://', 'gs://', 'http://', 'https://', 's3://')

# https://en.wikipedia.org/wiki/Media_type
HTML = 'text/html'
JSON = 'application/json'
PDF = 'application/pdf'
PNG = 'image/png'

MEDIA_TYPES = frozenset({
    HTML,
    JSON,
    PDF,
    PNG,
})

DEV_URL = 'https://developers.google.com/earth-engine/datasets/'
IMAGE_BASE = DEV_URL + 'images/'
SAMPLE_SUFFIX = '_sample.png'
TERMS_BASE = DEV_URL + 'catalog/'
TERMS_SUFFIX = '#terms-of-use'
CODE_URL = (
    'https://code.earthengine.google.com/?scriptPath=Examples:Datasets/')
FEATURE_VIEW = '_FeatureView'

FEATURE_VIEW_EXCEPTIONS = frozenset({
    'JRC/GWIS/GlobFire/v2/DailyPerimeters',
    'JRC/GWIS/GlobFire/v2/FinalPerimeters',
    'JRC/LUCAS_HARMO/COPERNICUS_POLYGONS/V1/2018',
    'LARSE/GEDI/GEDI02_A_002',
    'LARSE/GEDI/GEDI02_A_002_INDEX',
    'LARSE/GEDI/GEDI02_B_002',
    'LARSE/GEDI/GEDI02_B_002_INDEX',
    'LARSE/GEDI/GEDI04_A_002',
    'LARSE/GEDI/GEDI04_A_002_INDEX',
    'TIGER/2010/BG',
})


def feature_view_exception(dataset_id: str) -> bool:
  return dataset_id in FEATURE_VIEW_EXCEPTIONS


class Check(stac.NodeCheck):
  """Checks the keywords field."""
  name = 'links'

  @classmethod
  def run(cls, node: stac.Node) -> Iterator[stac.Issue]:

    if LINKS not in node.stac:
      yield cls.new_issue(node, 'Missing links')
      return

    links = node.stac[LINKS]

    if not isinstance(links, list):
      yield cls.new_issue(node, f'{LINKS} must be a list')
      return

    if not links:
      yield cls.new_issue(node, f'{LINKS} cannot be empty')
      return

    for link in links:
      if not isinstance(link, dict):
        yield cls.new_issue(node, 'link must be a dict')
        return

      for key, value in link.items():
        if not isinstance(key, str):
          yield cls.new_issue(node, 'link key must be a str')
          return
        if not isinstance(value, str):
          yield cls.new_issue(node, 'link value must be a str')
          return

      keys = set(link)
      missing_required = REQUIRED_KEYS.difference(keys)
      if missing_required:
        yield cls.new_issue(
            node,
            'link missing required key(s): ' +
            ', '.join(sorted(missing_required)))
        return

      if not link[HREF].startswith(HREF_PREFIXES):
        yield cls.new_issue(
            node,
            f'{HREF} must start with {", ".join(sorted(HREF_PREFIXES))}: ' +
            'found: ' + link[HREF])

      extra_keys = keys.difference(ALL_KEYS)
      if extra_keys:
        yield cls.new_issue(
            node, 'unexpected link key(s): ' + ', '.join(sorted(extra_keys)))
        return

      if TYPE in link:
        link_type = link[TYPE]
        if link_type not in MEDIA_TYPES:
          yield cls.new_issue(
              node, f'{TYPE} must be one of {sorted(MEDIA_TYPES)}: {link_type}')

    links_by_rel = collections.defaultdict(list)
    for link in links:
      links_by_rel[link[REL]].append(link)

    # All links must have root, self, and parent
    rels = set(links_by_rel)
    missing_required_rels = set(REQUIRED_REL.difference(rels))
    if node.id == 'GEE_catalog':
      missing_required_rels.remove(PARENT)
    if missing_required_rels:
      yield cls.new_issue(
          node,
          'missing required rel(s): ' +
          ', '.join(sorted(missing_required_rels)))
      return

    for rel in REQUIRED_REL:
      if node.id == 'GEE_catalog' and rel == PARENT:
        # The root node does not have a parent
        continue
      if len(links_by_rel[rel]) != 1:
        yield cls.new_issue(node, f'link must have only one {rel}')
      else:
        link = links_by_rel[rel][0]
        if TYPE not in link:
          yield cls.new_issue(node, f'link {rel} must have a {TYPE}')
        elif link[TYPE] != JSON:
          yield cls.new_issue(node, f'link {rel} must have {TYPE} of {JSON}')

    if node.type == CATALOG:
      if CHILD not in links_by_rel:
        yield cls.new_issue(
            node, f'{CATALOG} must contain at least one {CHILD} link',
            stac.IssueLevel.WARNING)

      extra_rel = rels.difference(ALL_CATALOG_REL)
      if extra_rel:
        yield cls.new_issue(
            node,
            'catalog: unexpected link rel(s): ' + ', '.join(sorted(extra_rel)))
        return

      for child in links_by_rel[CHILD]:
        if TITLE not in child:
          yield cls.new_issue(node, f'{CHILD} must have a title')
        else:
          href = pathlib.Path(child[HREF])
          expect = href.stem
          if href.name == 'catalog.json':
            expect = href.parts[-2]
          if child[TITLE] != expect:
            yield cls.new_issue(node, f'{CHILD} {TITLE} must be "{expect}"')

      url_counts = collections.Counter(
          [link[HREF] for link in links_by_rel[CHILD] if HREF in link])
      for url, count in url_counts.items():
        if count > 1:
          yield cls.new_issue(node, f'{CHILD} url repeated: {url}')

      return

    # Checks for STAC Collections

    missing_required = REQUIRED_COLLECTION_REL.difference(set(rels))
    if missing_required:
      yield cls.new_issue(
          node,
          'collection: missing required rel(s): ' +
          ', '.join(sorted(missing_required)))
      return

    extra_rel = rels.difference(ALL_COLLECTION_REL)
    if extra_rel:
      yield cls.new_issue(
          node,
          'collection: unexpected link rel(s): ' + ', '.join(sorted(extra_rel)))
      return

    # preview

    previews = links_by_rel[PREVIEW]
    if len(previews) != 1:
      yield cls.new_issue(node, f'more than one preview found: {len(previews)}')
    else:
      preview = previews[0]
      parents = str(node.path.parents[0])
      expected_url = IMAGE_BASE + parents + '/' + node.path.stem + SAMPLE_SUFFIX

      url = preview[HREF]
      if url != expected_url:
        yield cls.new_issue(
            node, f'{PREVIEW} {HREF} must be {expected_url}. Found: {url}')

      if TYPE not in preview:
        yield cls.new_issue(node, f'preview missing {TYPE}')
      elif preview[TYPE] != PNG:
        yield cls.new_issue(
            node, f'{PREVIEW} {TYPE} not {PNG}: {preview[TYPE]}')

      keys = set(preview)
      extra_keys = keys.difference(REQUIRED_KEYS.union({TYPE}))
      if extra_keys:
        yield cls.new_issue(
            node, 'unexpected preview key(s): ' + ', '.join(sorted(extra_keys)))

    # terms-of-use

    all_terms = [
        l for l in links_by_rel[LICENSE] if l[HREF].endswith(TERMS_SUFFIX)]

    if len(all_terms) > 1:
      yield cls.new_issue(
          node, f'Only one terms {LICENSE} link allowed')
    terms = all_terms[0] if all_terms else None

    if not terms:
      yield cls.new_issue(
          node, f'cannot find terms {LICENSE} ending in {TERMS_SUFFIX}')
    else:
      name = node.id.replace('/', '_')
      expected_url = TERMS_BASE + name + TERMS_SUFFIX

      url = terms[HREF]
      if url != expected_url:
        yield cls.new_issue(
            node,
            f'terms {LICENSE} {HREF} must be {expected_url}. Found: {url}')

      if TYPE not in terms:
        yield cls.new_issue(node, f'terms {LICENSE} missing {TYPE}')
      elif terms[TYPE] != HTML:
        yield cls.new_issue(
            node, f'terms {LICENSE} {TYPE} not {HTML}: {terms[TYPE]}')

      keys = set(terms)
      extra_keys = keys.difference(REQUIRED_KEYS.union({TYPE}))
      if extra_keys:
        yield cls.new_issue(
            node,
            'unexpected terms key(s): ' + ', '.join(sorted(extra_keys)))

    # example script

    example_name = node.id.replace('/', '_')

    example_links = [
        l for l in links_by_rel[RELATED]
        if CODE in l and not l[HREF].endswith(FEATURE_VIEW)
    ]

    if not example_links:
      yield cls.new_issue(node, f'Missing example {RELATED} link')
    else:
      num_example_links = len(example_links)
      if num_example_links > 1:
        yield cls.new_issue(
            node, f'More than 1 example {RELATED} link: {num_example_links}')
      example = example_links[0]

      subdir = (node.id.split('/')[1] if node.id.startswith('projects/')
                else node.id.split('/')[0])
      expected_url = CODE_URL + subdir + '/' + example_name
      url = example[HREF]
      if url != expected_url:
        yield cls.new_issue(
            node, f'{CODE} {HREF} must be {expected_url}. Found: {url}')

      if TITLE not in example:
        yield cls.new_issue(node, f'Missing example {TITLE}')
      else:
        expected_title = (
            f'Run the example for {node.id} in the Earth Engine Code Editor')
        title = example[TITLE]
        if title != expected_title:
          yield cls.new_issue(
              node, f'{TITLE} must be {expected_title}. Found: {title}')

    # feature view script

    feature_view_links = [
        l for l in links_by_rel[RELATED]
        if CODE in l and l[HREF].endswith(FEATURE_VIEW)
    ]
    if node.gee_type in (stac.GeeType.IMAGE, stac.GeeType.IMAGE_COLLECTION):
      if feature_view_links:
        yield cls.new_issue(
            node,
            f'{node.gee_type} cannot have example {RELATED} a FeatureView link')
    if node.gee_type in (stac.GeeType.TABLE, stac.GeeType.TABLE_COLLECTION):
      if not feature_view_links:
        if not feature_view_exception(node.id):
          yield cls.new_issue(
              node, f'Missing example {RELATED} FeatureView link')
      else:
        if feature_view_exception(node.id):
          yield cls.new_issue(node, 'Remove node from feature view exceptions')
        num_feature_view_links = len(feature_view_links)
        if num_feature_view_links > 1:
          yield cls.new_issue(
              node,
              f'More than 1 example {RELATED} FeatureView link: ' +
              f'{num_feature_view_links}')
        feature_view = feature_view_links[0]

        expected_url = CODE_URL + subdir + '/' + example_name + FEATURE_VIEW
        url = feature_view[HREF]
        if url != expected_url:
          yield cls.new_issue(
              node, f'{CODE} {HREF} must be {expected_url}. Found: {url}')

        if TITLE not in feature_view:
          yield cls.new_issue(
              node, f'Missing example {RELATED} FeatureView {TITLE}')
        else:
          expected_title = (
              f'Run the example for {node.id} in the Earth Engine Code Editor')
          title = feature_view[TITLE]
          if title != expected_title:
            yield cls.new_issue(
                node, f'{TITLE} must be {expected_title}. Found: {title}')

    for link in example_links + feature_view_links:
      if TYPE not in link:
        yield cls.new_issue(node, f'example missing {TYPE}')
      elif link[TYPE] != HTML:
        yield cls.new_issue(
            node, f'example {TYPE} not {HTML}: {terms[TYPE]}')

    # TODO(b/185832969): Allowed - license.  Any number
    # TODO(b/185832969): Allowed - cite-as.  Any number
    # TODO(b/185832969): Allowed - source. Any number
    # TODO(b/185832969): Allowed - version: latest, predecessor, successor
    #   Only one of each
