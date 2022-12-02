"""Runs all the tree checks."""

from typing import Iterator

from checker import stac
from checker.tree import parent_child

_CHECKS = [
    parent_child.Check,
]


def run_checks(
    nodes: list[stac.Node], checks: list[str]) -> Iterator[stac.Issue]:
  """Runs all checks on that operate on the tree of STAC nodes."""

  for check in _CHECKS:
    if checks and check.name not in checks:
      continue
    yield from check.run(nodes)
