"""Run the STAC checker on the Earth Engine Public Data Catalog.

STATUS: Experimental - For feedback
"""

from collections.abc import Sequence
import sys
from typing import Iterator

from absl import app
from absl import flags

from checker import node
from checker import stac
from checker import tree

_CHECKS = flags.DEFINE_multi_string(
    'checks', [], 'List of checks to run or empty to run all checks.')


def find_issues(checks: list[str]) -> Iterator[stac.Issue]:
  stac_root = stac.stac_root()
  nodes = stac.load(stac_root)

  for a_node in nodes:
    yield from node.run_checks(a_node, checks)

  yield from tree.run_checks(nodes, checks)


def main(argv: Sequence[str]) -> None:
  if len(argv) > 1:
    raise app.UsageError('Too many command-line arguments.')

  warning_count = 0
  error_count = 0
  for issue in find_issues(_CHECKS.value):
    print(issue)

    if issue.level == stac.IssueLevel.WARNING:
      warning_count += 1

    if issue.level == stac.IssueLevel.ERROR:
      error_count += 1

  if warning_count:
    print('Warning count:', warning_count)

  if error_count:
    print('Error count:', error_count)
    sys.exit(1)


if __name__ == '__main__':
  app.run(main)
