"""Load STAC entries for the Earth Engine public data catalog.

NOTE: FIRMS catalog and FIRMS collection have the same id.
"""

import dataclasses
import enum
import json
import pathlib
from typing import Iterator, Optional

import os

GEE_TYPE = 'gee:type'
TYPE = 'type'
# This is an intentionally invalid dataset_id.
UNKNOWN_ID = '> UNKNOWN ID: '
UNKNOWN_PATH = pathlib.Path('> UNKNOWN PATH')

# List loaded from non_commercial_datasets.jsonnet
NON_COMMERCIAL_LIST = []

SKIP_FEATUREVIEW_GENERATION = 'gee:skip_featureview_generation'


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


def data_root() -> pathlib.Path:
  return (
      pathlib.Path(os.path.dirname(__file__)) /
      '..')


def stac_root() -> pathlib.Path:
  return data_root() / 'catalog'


def examples_root() -> pathlib.Path:
  # First try for a local path for bazel.
  path = pathlib.Path('examples')
  if path.is_dir(): return path

  # blaze has Fileset support
  return data_root() / 'examples/javascript_examples'


def previews_root() -> pathlib.Path:
  # First try for a local path for bazel.
  path = pathlib.Path('examples')
  if path.is_dir(): return path

  # blaze has Fileset support
  return data_root() / 'examples/javascript_previews'


@dataclasses.dataclass
class Node:
  """Container for one STAC Catalog or STAC Collection."""
  id: str
  path: pathlib.Path
  type: StacType
  gee_type: GeeType
  stac: dict[str, object]  # The result of json.load


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
    gee_type: Optional[GeeType]
    try:
      gee_type = GeeType(gee_type_str)
    except ValueError:
      gee_type = GeeType.NONE
    nodes.append(Node(dataset_id, relative_path, asset_type, gee_type, stac))
  return nodes


def is_in_non_commercial(dataset_id: str) -> bool:
  global NON_COMMERCIAL_LIST
  if not NON_COMMERCIAL_LIST:
    non_commerical_file = data_root() / 'non_commercial_datasets.json'
    NON_COMMERCIAL_LIST = json.loads(non_commerical_file.read_text())
  return dataset_id in NON_COMMERCIAL_LIST
