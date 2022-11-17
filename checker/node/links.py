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
    'application/json'

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
ALL_KEYS = frozenset(REQUIRED_KEYS.union(OPTIONAL_KEYS))

CHILD = 'child'
PARENT = 'parent'
ROOT = 'root'
SELF = 'self'

REQUIRED_REL = frozenset({PARENT, ROOT, SELF})
OPTIONAL_CATALOG_REL = frozenset({CHILD})
ALL_CATALOG_REL = frozenset(REQUIRED_REL.union(OPTIONAL_CATALOG_REL))

JSON = 'application/json'

HREF_PREFIXES = ('ftp://', 'http://', 'https://', 's3://')


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
        yield cls.new_issue(node, f'{CATALOG} must at least one {CHILD} link')

      extra_rel = rels.difference(ALL_CATALOG_REL)
      if extra_rel:
        yield cls.new_issue(
            node, 'unexpected link rel(s): ' + ', '.join(sorted(extra_rel)))
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


    # TODO(schwehr): Add checks for STAC Collections
