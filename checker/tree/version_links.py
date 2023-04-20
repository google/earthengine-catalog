"""Checks for version links across STAC Collections.

"""

from typing import Iterator

from checker import stac

COLLECTION = stac.StacType.COLLECTION

REL = 'rel'
HREF = 'href'
LINKS = 'links'
SELF = 'self'

LATEST = 'latest-version'
PREDECESSOR = 'predecessor-version'
SUCCESSOR = 'successor-version'
VERSION_REL = frozenset({LATEST, PREDECESSOR, SUCCESSOR})

PREFIX = 'https://storage.googleapis.com/earthengine-stac/catalog/'
SUFFIX = '.json'
NO_SELF_URL = 'No self url found'


def version_urls(node: stac.Node) -> Iterator[tuple[str, str]]:
  links = node.stac[LINKS]
  for link in links:
    rel = link.get(REL, 'None')
    if rel in VERSION_REL and HREF in link:
      yield rel, link[HREF].removeprefix(PREFIX).removesuffix(SUFFIX)


def self_url(node: stac.Node) -> str:
  links = node.stac[LINKS]
  for link in links:
    if link.get(REL, 'None') == SELF and HREF in link:
      return link[HREF].removeprefix(PREFIX).removesuffix(SUFFIX)
  return NO_SELF_URL


class Check(stac.TreeCheck):
  """Checks that version url targets exist."""
  name = 'version_links'

  @classmethod
  def run(cls, nodes: list[stac.Node]) -> Iterator[stac.Issue]:
    # Nodes without links will cause an error in the 'required' check
    nodes = [
        node for node in nodes
        if LINKS in node.stac and isinstance(node.stac[LINKS], list)]

    node_urls = {self_url(n) for n in nodes}

    for node in nodes:
      if node.type != COLLECTION: continue
      for rel, url in version_urls(node):
        if url not in node_urls:
          yield cls.new_issue(node, f'{rel} url has no destination: {url}')
