"""Checks that the keywords field is valid.

Keyword list should have no duplicates.

- Each keyword must:
  - Be 2 to 50 characters
  - All letters must be lower case
  - Must start with a letter or number
  - Contain letters, numbers, dashes, and underscores
  - Be used in at least two datasets (see checker/tree/keywords.py)

Example Jsonnet:

  keywords: ['goes_18', 'noaa', 'weather'],
"""

import re
from typing import Iterator

from checker import stac

KEYWORDS = 'keywords'


class Check(stac.NodeCheck):
  """Checks the keywords field."""
  name = 'keywords'

  @classmethod
  def run(cls, node: stac.Node) -> Iterator[stac.Issue]:
    if node.type == stac.StacType.CATALOG:
      if KEYWORDS in node.stac:
        yield cls.new_issue(node, f'Catalogs cannot have "{KEYWORDS}"')
      return

    if KEYWORDS not in node.stac:
      yield cls.new_issue(node, f'Collections must have "{KEYWORDS}"')
      return

    keywords = node.stac[KEYWORDS]
    if not isinstance(keywords, list):
      yield cls.new_issue(node, f'"{KEYWORDS}" must be a list')
      return

    if not keywords:
      yield cls.new_issue(node, f'"{KEYWORDS}" must have at least one keyword')

    for keyword in keywords:
      if not isinstance(keyword, str):
        yield cls.new_issue(node, f'keyword must be a string: "{keyword}"')
      else:
        if not re.fullmatch('[a-z0-9][-_a-z0-9]{1,49}', keyword):
          yield cls.new_issue(
              node,
              'keyword must contain only lowercase letters, digits, dashes, '
              f'and underscores and be at most 50 characters long: "{keyword}"'
          )

    if len(keywords) != len(set(keywords)):
      yield cls.new_issue(node, 'duplicate keyword found')
