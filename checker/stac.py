"""load STAC entries for the Earth Engine public data catalog.

NOTE: FIRMS catalog and FIRMS collection have the same id.
"""

import dataclasses
import enum
import json
import pathlib
from typing import Iterator

import os

GEE_TYPE = 'gee:type'
TYPE = 'type'
# This is an intentionally invalid dataset_id.
UNKNOWN_ID = '> UNKNOWN ID: '

_TWO_LEVEL_FOLDERS: list[str] = ['NASA', 'NOAA', 'USGS']


class StacType(str, enum.Enum):
  CATALOG = 'Catalog'
  COLLECTION = 'Collection'
  # TODO(schwehr): We may eventually have STAC Items:
  # ITEM = 'Item'


class GeeType(str, enum.Enum):
  IMAGE = 'image'
  IMAGE_COLLECTION = 'image_collection'
  TABLE = 'table'
  TABLE_COLLECTION = 'table_collection'
  # For catalogs
  NONE = 'none'


def stac_root() -> pathlib.Path:
  return (
      pathlib.Path(os.path.dirname(__file__)) /
      '../catalog')


@dataclasses.dataclass
class Node:
  """Container for one STAC Catalog or STAC Collection."""
  id: str
  path: pathlib.Path
  type: StacType
  gee_type: GeeType
  stac: dict[str, object]  # The result of json.load

  def is_two_level(self):
    """Returns true if the asset id is a 2nd direcotry level asset."""
    parts = pathlib.Path(self.id).parts
    if not parts:
      return False
    if parts[0] not in _TWO_LEVEL_FOLDERS:
      return False

    if self.type == StacType.CATALOG:
      return len(parts) == 2
    elif self.type == StacType.COLLECTION:
      return len(parts) > 2


class IssueLevel(str, enum.Enum):
  """How serious is an issue."""
  WARNING = 'warning'
  ERROR = 'error'


@dataclasses.dataclass
class Issue:
  """A record of one issue found in a STAC node."""
  id: str
  path: pathlib.Path
  check_name: str
  message: str
  level: IssueLevel = IssueLevel.ERROR

  def __str__(self):
    return (
        f'Issue(\'{self.id}\', \'{str(self.path)}\', \'{self.check_name}\', '
        f'\'{self.message}\', IssueLevel.{self.level})')


class Check:
  """Parent class for all checks."""
  name: str = 'unknown'

  @classmethod
  def new_issue(cls,
                node: Node,
                message: str,
                level: IssueLevel = IssueLevel.ERROR) -> Issue:
    return Issue(node.id, node.path, cls.name, message, level)


class NodeCheck(Check):
  """One node check."""

  @classmethod
  def run(cls, node: Node) -> Iterator[Issue]:
    raise NotImplementedError


class TreeCheck(Check):
  """One tree check."""

  @classmethod
  def run(cls, nodes: list[Node]) -> Iterator[Issue]:
    raise NotImplementedError


# TODO(schwehr): Allow a list of regex for the ids.
def load(root: pathlib.Path) -> list[Node]:
  """Returns a list of Nodes."""
  root_len = len(root.parts)
  nodes: list[Node] = []
  for path in root.rglob('*.json'):
    relative_path = pathlib.Path(*path.parts[root_len:])

    stac = json.loads(path.read_text())
    dataset_id = stac.get('id', UNKNOWN_ID + str(relative_path))
    asset_type = stac.get(TYPE)
    gee_type_str = stac.get(GEE_TYPE)
    gee_type = GeeType(gee_type_str) if gee_type_str else GeeType.NONE
    nodes.append(Node(dataset_id, relative_path, asset_type, gee_type, stac))
  return nodes
