"""Runs all the single node checks on one Node."""

from typing import Iterator

from checker import stac
from checker.node import description
from checker.node import eo_extension
from checker.node import examples
from checker.node import extensions
from checker.node import extent
from checker.node import feature_view
from checker.node import file_path
from checker.node import gee_bitmask
from checker.node import gee_classes
from checker.node import gee_is_derived
from checker.node import gee_provider_ids
from checker.node import gee_status
from checker.node import gee_terms_of_use
from checker.node import gee_type
from checker.node import gee_unusual_terms_of_use
from checker.node import gee_user_uploaded
from checker.node import id_field
from checker.node import instrument
from checker.node import interval
from checker.node import keywords
from checker.node import license_field
from checker.node import links
from checker.node import non_commercial
from checker.node import providers
from checker.node import required
from checker.node import sar_extension
from checker.node import schema
from checker.node import sci_extension
from checker.node import stac_version
from checker.node import summaries
from checker.node import title
from checker.node import top_level
from checker.node import type_field
from checker.node import version_extension
from checker.node import visualizations
from checker.node import visualizations_image
from checker.node import visualizations_table

TYPE = 'type'

_CHECKS = [
    # Core components that must be checked first
    required.Check,
    gee_type.Check,
    top_level.Check,
    stac_version.Check,
    id_field.Check,
    file_path.Check,
    extensions.Check,
    # Primary STAC components
    extent.Check,
    keywords.Check,
    title.Check,
    description.Check,
    license_field.Check,
    providers.Check,
    links.Check,
    summaries.Check,
    instrument.Check,
    # extensions
    eo_extension.Check,
    sar_extension.Check,
    sci_extension.Check,
    version_extension.Check,
    # gee extensions
    gee_bitmask.Check,
    gee_classes.Check,
    gee_is_derived.Check,
    gee_provider_ids.Check,
    gee_status.Check,
    gee_terms_of_use.Check,
    gee_unusual_terms_of_use.Check,
    gee_user_uploaded.Check,
    non_commercial.Check,
    schema.Check,
    interval.Check,
    visualizations.Check,
    visualizations_image.Check,
    visualizations_table.Check,
    feature_view.Check,
    examples.Check,
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
