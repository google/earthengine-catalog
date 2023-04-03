"""Checks file paths.

STAC Catalogs:
- The top-level is catalog.json with an id of 'GEE_catalog'
- Datasets are under an organization directory with a catalog.json:
  ORG/catalog.json
- The `id` of the catalog is the same as the top-level directory

STAC Collections:
- A dataset with an `id` of ORG/b will have a STAC collection of ORG/ORG_b.json
- Datasets with deeper `id`'s clamp at one subdirectory.  e.g.
  ORG/b/c/d will have a file ORG/ORG_b_c_d.json
- FIRMS is a special case in that the catalog and the collection have the id
  of just 'FIRMS'
"""

import pathlib
from typing import Iterator

from checker import stac

GEE_CATALOG = 'GEE_catalog'
CATALOG_NAME = 'catalog.json'
GEE_CATALOG_PATH = pathlib.Path(CATALOG_NAME)


class Check(stac.NodeCheck):
  """Checks file paths."""
  name = 'file_path'

  @classmethod
  def run(cls, node: stac.Node) -> Iterator[stac.Issue]:
    # id errors will be reported by id_field.py
    if not node.id: return
    if not isinstance(node.id, str): return

    id_field = node.id
    id_path = pathlib.Path(id_field)
    id_parts = id_path.parts

    if node.type == stac.StacType.CATALOG:
      # The top-level catalog is special.
      if node.id == GEE_CATALOG:
        if node.path != GEE_CATALOG_PATH:
          yield cls.new_issue(node, f'"{GEE_CATALOG}" in the wrong place')
        return
      if node.path == GEE_CATALOG_PATH and node.id != GEE_CATALOG:
        yield cls.new_issue(node, f'Root must have an id of {GEE_CATALOG}')
        return

      # This may need to change if the catalog ever starts having more than one
      # STAC Catalog per directory.
      if node.path.name != CATALOG_NAME:
        yield cls.new_issue(node, f'Catalog file must be {CATALOG_NAME}')
        return
      if len(id_parts) > 1:
        yield cls.new_issue(node, 'Catalog too deep')
        return

      if len(id_parts) > 1:
        yield cls.new_issue(
            node,
            f'More than 1 directory level: {list(id_parts)}')
      else:
        expected_path = pathlib.Path(id_parts[0]) / 'catalog.json'
        if node.path != expected_path:
          # The directory doesn't match the id.
          # e.g. for a file of A/catalog.json, found and id of B
          yield cls.new_issue(
              node, f'expected path: {expected_path} found: {node.path}')

      return  # Done with catalog

    # Collection
    # Datasets ids starting with 'projects' lose their first directory part.
    expected_subdir = pathlib.Path(
        id_parts[1] if id_parts[0] == 'projects' else id_parts[0])

    expected_path = (
        pathlib.Path(expected_subdir) / (node.id.replace('/', '_') + '.json'))
    if expected_path != node.path:
      # Expect A/A_B_C.json, but found A/B/A_B_C.json
      message = (
          f'Collection: expected 1-level path: {expected_path} '
          f'found: {node.path}')
      yield cls.new_issue(node, message)
