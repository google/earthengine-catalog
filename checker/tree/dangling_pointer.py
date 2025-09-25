"""Checks for catalog child links that do not have a corresponding STAC file."""

from typing import Iterator

from checker import stac
from checker.tree import parent_child

LINKS = 'links'


class Check(stac.TreeCheck):
  """Checks for dangling pointers."""

  name = 'dangling_pointers'

  @classmethod
  def run(cls, nodes: list[stac.Node]) -> Iterator[stac.Issue]:
    nodes = [
        node
        for node in nodes
        if LINKS in node.stac and isinstance(node.stac[LINKS], list)
    ]

    nodes_by_url = {parent_child.self_url(n): n for n in nodes}
    self_urls = set(nodes_by_url)

    for node in nodes:
      if node.type != stac.StacType.CATALOG:
        continue

      for child_url in parent_child.child_urls(node):
        if child_url not in self_urls:
          yield cls.new_issue(node, f'Child not found: {child_url}')
