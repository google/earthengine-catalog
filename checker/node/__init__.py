"""Runs all the single node checks on one Node."""

from typing import Iterator

from google3.third_party.earthengine_catalog.checker import stac
from google3.third_party.earthengine_catalog.checker.node import extensions
from google3.third_party.earthengine_catalog.checker.node import extent
from google3.third_party.earthengine_catalog.checker.node import id_field
from google3.third_party.earthengine_catalog.checker.node import keywords
from google3.third_party.earthengine_catalog.checker.node import license_field
from google3.third_party.earthengine_catalog.checker.node import required
from google3.third_party.earthengine_catalog.checker.node import stac_version
from google3.third_party.earthengine_catalog.checker.node import title

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
