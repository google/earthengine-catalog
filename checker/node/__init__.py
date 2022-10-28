"""Runs all the single node checks on one Node."""

from typing import Iterator

from checker import stac
from checker.node import description
from checker.node import extensions
from checker.node import extent
from checker.node import file_path
from checker.node import gee_classes
from checker.node import gee_type
from checker.node import id_field
from checker.node import interval
from checker.node import keywords
from checker.node import license_field
from checker.node import providers
from checker.node import required
from checker.node import schema
from checker.node import sci_extension
from checker.node import stac_version
from checker.node import title
from checker.node import top_level
from checker.node import type_field
from checker.node import version_extension
from checker.node import visualizations
from checker.node import visualizations_table

TYPE = 'type'

_CHECKS = [
    required.Check,
    gee_type.Check,
    top_level.Check,
    stac_version.Check,
    id_field.Check,
    file_path.Check,

    extensions.Check,
    extent.Check,
    keywords.Check,
    title.Check,
    description.Check,
    license_field.Check,
    providers.Check,

    # extensions
    sci_extension.Check,
    version_extension.Check,

    # gee extensions
    gee_classes.Check,
    schema.Check,
    interval.Check,
    visualizations.Check,
    visualizations_table.Check,
]


def run_checks(
    node: stac.Node, checks: list[str]) -> Iterator[stac.Issue]:
  """Runs all checks on one STAC node."""

  # Most of the checks depend on the type being set for the Issues to make
  # sense, so check it first and do not continue if the type is not set
  yield from type_field.Check.run(node)
  if not node.type:
    return

  for check in _CHECKS:
    if checks and check.name not in checks:
      continue
    yield from check.run(node)
