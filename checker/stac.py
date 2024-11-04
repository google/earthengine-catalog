"""Load STAC entries for the Earth Engine public data catalog.

NOTE: FIRMS catalog and FIRMS collection have the same id.
"""

import dataclasses
import enum
import json
import pathlib
import sys
from typing import Iterator, Optional

import os

GEE_TYPE = 'gee:type'
GEE_STATUS = 'gee:status'
TYPE = 'type'
# This is an intentionally invalid dataset_id.
UNKNOWN_ID = '> UNKNOWN ID: '
UNKNOWN_PATH = pathlib.Path('> UNKNOWN PATH')

# List loaded from non_commercial_datasets.jsonnet
NON_COMMERCIAL_LIST = []

SKIP_FEATUREVIEW_GENERATION = 'gee:skip_featureview_generation'

CHECKER_CODE_ROOT = 'https://github.com/google/earthengine-catalog/blob/main'

# Legacy id for a top-level dataset
FIRMS = 'FIRMS'


_StrEnum = (
    (enum.StrEnum,) if sys.version_info[:2] >= (3, 11) else (str, enum.Enum)
)


class StacType(*_StrEnum):
  CATALOG = 'Catalog'
  COLLECTION = 'Collection'


class GeeType(*_StrEnum):
  IMAGE = 'image'
  IMAGE_COLLECTION = 'image_collection'
  TABLE = 'table'
  TABLE_COLLECTION = 'table_collection'
  # For catalogs
  NONE = 'none'

  @classmethod
  def allowed_collection_types(cls):
    return frozenset(x.value for x in cls if x != cls.NONE)


class Status(*_StrEnum):
  BETA = 'beta'
  DEPRECATED = 'deprecated'
  INCOMPLETE = 'incomplete'

  @classmethod
  def allowed_statuses(cls):
    return frozenset(x.value for x in cls)


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


def url_id_for_dataset_id(dataset_id: str) -> str:
  """Converts a dataset id into a string suitable for use in a URL."""
  assert dataset_id
  return dataset_id.replace('/', '_')


@dataclasses.dataclass
class Node:
  """Container for one STAC Catalog or STAC Collection."""
  id: str
  path: pathlib.Path
  type: StacType
  gee_type: GeeType
  stac: dict[str, object]  # The result of json.load


class IssueLevel(*_StrEnum):
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
    """Creates a new Issue for the given arguments."""

    # Find the relative path to the checker that produced the error.
    relative_path = []
    for component in reversed(cls.__module__.split('.')):
      if component == 'earthengine_catalog':
        break
      relative_path.insert(0, component)
    module = '/'.join(relative_path)
    link = f'{CHECKER_CODE_ROOT}/{module}.py'
    # Changing the checker filename to have extension .jsonnet rather than .json
    return Issue(
        node.id, node.path.with_suffix('.jsonnet'), link, message, level
    )


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
