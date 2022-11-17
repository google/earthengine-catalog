"""Check for the description field.

The description must be:
- a string
- between 40 and 8000 characters inclusive

Possible additions:
- Start with a capital letter
- End with a '.'

TODO(schwehr): Check the markdown.
"""

from typing import Iterator

from checker import stac

DESCRIPTION = 'description'
MIN_LEN = 40
MAX_LEN = 8000


class Check(stac.NodeCheck):
  """Checks the description field."""
  name = 'description'

  @classmethod
  def run(cls, node: stac.Node) -> Iterator[stac.Issue]:
    if DESCRIPTION not in node.stac:
      yield cls.new_issue(node, f'Missing: {DESCRIPTION}')
      return

    description = node.stac[DESCRIPTION]
    if not isinstance(description, str):
      yield cls.new_issue(node, 'Description must be a str')
      return

    size = len(description)
    if size < MIN_LEN:
      yield cls.new_issue(node, f'{DESCRIPTION} too short: {size}')
    if size > MAX_LEN:
      yield cls.new_issue(node, f'{DESCRIPTION} too long: {size}')
