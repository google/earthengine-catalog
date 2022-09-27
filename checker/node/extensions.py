"""Checks the stac_extensions field.

Only the exceptions listed in EXTENSIONS may be used in the Earth Engine public
data catalog.

Extensions are defined here: https://github.com/stac-extensions/
"""

from typing import Iterator

from checker import stac

STAC_EXTENSIONS = 'stac_extensions'

EXTENSIONS = [
    'https://stac-extensions.github.io/eo/v1.0.0/schema.json',
    'https://stac-extensions.github.io/sar/v1.0.0/schema.json',
    'https://stac-extensions.github.io/scientific/v1.0.0/schema.json',
    'https://stac-extensions.github.io/version/v1.0.0/schema.json'
]


class Check(stac.NodeCheck):
  """Checks the stac_extensions field."""
  name = 'extensions'

  @classmethod
  def run(cls, node: stac.Node) -> Iterator[stac.Issue]:
    if node.type == stac.StacType.CATALOG:
      if STAC_EXTENSIONS in node.stac:
        yield cls.new_issue(node, 'Catalogs cannot have extensions')
      return

    extensions = node.stac.get(STAC_EXTENSIONS, [])

    for extension in extensions:
      if extension not in EXTENSIONS:
        yield cls.new_issue(node, f'Extension not allowed: "{extension}"')

    if extensions != sorted(extensions):
      yield cls.new_issue(node, 'Extensions must be sorted')

    if len(extensions) != len(set(extensions)):
      yield cls.new_issue(node, 'Duplicate extensions not allowed')
