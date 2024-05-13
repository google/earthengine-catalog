"""Checks all URL-friendly ids.

Each id with '/' changed to '_' should occur in only one STAC node.

That is, having both X_Y/Z and X/Y_Z isn't allowed because they would both
map to X_Y_Z in URLs.
"""

import collections
from typing import Iterator

from checker import stac

ID = 'id'


def url_suitable_id(node: stac.Node) -> str:
  return stac.url_id_for_dataset_id(str(node.stac[ID]))


class Check(stac.TreeCheck):
  """Checks URL-suitable ids across collections."""
  name = 'url_id'

  @classmethod
  def run(cls, nodes: list[stac.Node]) -> Iterator[stac.Issue]:
    id_counts = collections.Counter(
        [url_suitable_id(node) for node in nodes if node.stac[ID] != stac.FIRMS]
    )

    duplicate_ids: set[str] = {
        id for id, count in id_counts.items() if count > 1
    }

    duplicate_nodes = [
        node for node in nodes if url_suitable_id(node) in duplicate_ids
    ]

    for node in duplicate_nodes:
      dataset_id = str(node.stac[ID])
      url_id = url_suitable_id(node)
      if url_id in duplicate_ids:
        yield cls.new_issue(
            node,
            f'Non-unique URL-suitable id: "{dataset_id}" becomes "{url_id}"',
        )
