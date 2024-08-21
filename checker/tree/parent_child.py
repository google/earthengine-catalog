"""Checks for parent-child links.

- For each child in catalog, the child should point back to the parent catalog
- For each parent link in a node, parent should have a link to the child node.
- There should be no child link in the catalog for nodes with
'gee:status'='incomplete'.
"""

from typing import Iterator

from checker import stac

CATALOG = stac.StacType.CATALOG
COLLECTION = stac.StacType.COLLECTION

REL = 'rel'
HREF = 'href'
LINKS = 'links'

CHILD = 'child'
PARENT = 'parent'
SELF = 'self'

GEE_CATALOG = 'GEE_catalog'

PREFIX = 'https://storage.googleapis.com/earthengine-stac/catalog/'
SUFFIX = '.json'

NO_CHILD_URL = 'No child url found'
NO_PARENT_URL = 'No parent url found'
NO_SELF_URL = 'No self url found'


def self_url(node: stac.Node) -> str:
  links = node.stac[LINKS]
  for link in links:
    if link[REL] == SELF:
      return link[HREF].removeprefix(PREFIX).removesuffix(SUFFIX)
  return NO_SELF_URL


def parent_url(node: stac.Node) -> str:
  links = node.stac[LINKS]
  for link in links:
    if link[REL] == PARENT:
      return link[HREF].removeprefix(PREFIX).removesuffix(SUFFIX)
  return NO_PARENT_URL


def child_urls(node: stac.Node) -> list[str]:
  result = []
  for link in node.stac[LINKS]:
    if link[REL] == CHILD:
      result.append(link[HREF].removeprefix(PREFIX).removesuffix(SUFFIX))
  return result


class Check(stac.TreeCheck):
  """Checks parent-child relationship."""
  name = 'parent_child'

  @classmethod
  def run(cls, nodes: list[stac.Node]) -> Iterator[stac.Issue]:
    # Nodes without links will cause an error in the 'required' check
    nodes = [
        node for node in nodes
        if LINKS in node.stac and isinstance(node.stac[LINKS], list)]

    nodes_by_url = {self_url(n): n for n in nodes}

    child_link_to_catalog = {}
    for node in nodes:
      if node.type != stac.StacType.CATALOG:
        continue
      a_self_url = self_url(node)

      for child_link in child_urls(node):
        child_link_to_catalog[child_link] = a_self_url

    self_to_parent = {self_url(node): parent_url(node) for node in nodes}

    for a_self_url, a_parent_url in self_to_parent.items():
      node = nodes_by_url[a_self_url]
      if a_self_url in child_link_to_catalog:
        catalog_url = child_link_to_catalog[a_self_url]
        if catalog_url != a_parent_url:
          yield cls.new_issue(
              node,
              f'catalog_url != parent_url: {catalog_url} {a_parent_url}')
        elif node.stac.get(stac.GEE_STATUS) == stac.Status.INCOMPLETE.value:
          message = (
              "Please don't reference in catalog.jsonnet datasets that have "
              f'{stac.GEE_STATUS} set to "{stac.Status.INCOMPLETE.value}": '
              f'{catalog_url} {a_self_url}'
          )
          yield cls.new_issue(node, message)
      else:
        if (
            node.id != GEE_CATALOG
            and node.stac.get(stac.GEE_STATUS) != stac.Status.INCOMPLETE.value
            and not node.id.startswith('TEMPLATE')
        ):
          yield cls.new_issue(node, 'Not in any catalog as a child link')
