"""Runs all the single node checks on one Node."""

from typing import Iterator

from checker import stac
from checker.node import extensions
from checker.node import extent
from checker.node import id_field
from checker.node import keywords
from checker.node import license_field
from checker.node import required
from checker.node import stac_version
from checker.node import title

_CHECKS = [
    required.Check,
    stac_version.Check,
    id_field.Check,
    extensions.Check,
    extent.Check,
    keywords.Check,
    title.Check,
    license_field.Check,
]


def run_checks(
    node: stac.Node, checks: list[str]) -> Iterator[stac.Issue]:
  """Runs all checks on one STAC node."""

  for check in _CHECKS:
    if checks and check.name not in checks:
      continue
    yield from check.run(node)
