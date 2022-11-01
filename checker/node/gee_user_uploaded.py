"""Checks gee:user_uploaded.

This field is present and set to true when a dataset is uploaded by a
non-Google user.

- This is a boolean field
- It can only be present if it is set to true
"""

from typing import Iterator

from checker import stac

GEE_USER_UPLOADED = 'gee:user_uploaded'


class Check(stac.NodeCheck):
  """Checks the gee:user_uploaded field."""
  name = 'gee_user_uploaded'

  @classmethod
  def run(cls, node: stac.Node) -> Iterator[stac.Issue]:
    print('node type', node.type)
    if node.type == stac.StacType.CATALOG:
      if GEE_USER_UPLOADED in node.stac:
        yield cls.new_issue(
            node, f'{stac.StacType.CATALOG} cannot have {GEE_USER_UPLOADED}')
      return

    if GEE_USER_UPLOADED not in node.stac:
      return

    user_uploaded = node.stac[GEE_USER_UPLOADED]
    if not isinstance(user_uploaded, bool):
      yield cls.new_issue(node, f'{GEE_USER_UPLOADED} must be a bool')
      return

    if not user_uploaded:
      yield cls.new_issue(
          node, f'{GEE_USER_UPLOADED} can only be present as true')
