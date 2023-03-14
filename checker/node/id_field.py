"""Checks that an asset ID is valid.

Detailed description of what makes a valid id here.

New datasets are encouraged, but not required, to use underscores ('_') rather
than dashes ('-') in folder and dataset names.

TODO(schwehr): id_field.py should enforce that the top level directory is
  at least 3 characters.
"""

import pathlib
import re
from typing import Iterator

from checker import stac

ID = 'id'
UNKNOWN_ID = 'unknown'
FIRMS = 'FIRMS'

MIN_COLLECTION_LEN = 2
MAX_COLLECTION_LEN = 7


class Check(stac.NodeCheck):
  """Checks the id field."""
  name = 'id'

  @classmethod
  def run(cls, node: stac.Node) -> Iterator[stac.Issue]:
    if ID not in node.stac:
      yield cls.new_issue(node, f'Missing: {ID}')
      return

    id_field = node.stac.get(ID)
    if not isinstance(id_field, str):
      yield cls.new_issue(node, f'{ID} must be a str')
      return

    if not id_field:
      yield cls.new_issue(node, f'Empty {ID}')
      return

    if id_field == FIRMS:
      # FIRMS is the only dataset outside of the allowed structure.
      return

    if id_field.startswith('/'):
      # pathlib.Path treats this as root path, so catch it early.
      yield cls.new_issue(node, 'id cannot start with "/"')
      return

    id_path = pathlib.Path(id_field)
    id_parts = id_path.parts
    for part in id_parts:
      if not re.fullmatch('[a-zA-Z0-9][-_a-zA-Z0-9]{0,50}', part):
        yield cls.new_issue(node, f'id part not valid: "{part}"')

    if node.type == stac.StacType.CATALOG:
      if len(id_path.parts) != 1:
        message = (
            f'id length must be 1 for catalogs: "{id_field}": {len(id_parts)}')
        yield cls.new_issue(node, message)

    elif node.type == stac.StacType.COLLECTION:
      if len(id_parts) < MIN_COLLECTION_LEN:
        message = (
            f'id length less than {MIN_COLLECTION_LEN} for collection: '
            f'{id_field}: {len(id_parts)}')
        yield cls.new_issue(node, message)
      if len(id_parts) > MAX_COLLECTION_LEN:
        message = (
            f'id length greater than {MAX_COLLECTION_LEN} for collection: '
            f'{id_field}: {len(id_parts)}')
        yield cls.new_issue(node, message)
