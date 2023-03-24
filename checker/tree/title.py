"""Checks for titles.

Each title should occur in only one STAC node to aid search.
"""

import collections
from typing import Iterator

from checker import stac

TITLE = 'title'


class Check(stac.TreeCheck):
  """Checks titles across collections."""
  name = 'title_tree'

  @classmethod
  def run(cls, nodes: list[stac.Node]) -> Iterator[stac.Issue]:
    title_counts = collections.Counter([
        str(node.stac[TITLE]) for node in nodes])

    duplicate_titles: set[str] = {
        title for title, count in title_counts.items() if count > 1}

    duplicate_nodes = [
        node for node in nodes if str(node.stac[TITLE]) in duplicate_titles]

    for node in duplicate_nodes:
      title = str(node.stac[TITLE])
      if title in duplicate_titles:
        yield cls.new_issue(node, f'Non-unique title: "{title}"')
