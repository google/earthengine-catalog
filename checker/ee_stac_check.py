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

INSTRUCTIONS_FOR_HANDLING_ERRORS = """
ee_stac_check has encountered some issues.  Here are some suggestions for how to
handle the issues.

* If you get stuck, please ask us for help. It's okay to create a pull
  request (PR) with checker errors to start the conversation. We can work with
  you to get a PR to a finished state.

* Start from the top down.  The system is designed to guide people through the
  fixing process in that order.

* The issue messages may be difficult to understand. The checker is new and
  the messages are under active development. Please ask questions and we will
  work with you. We plan to open the issues feature on GitHub, but are not yet
  ready to do so.  For now, ask here:

  https://developers.google.com/earth-engine/help#dataset_problem

* Some issues are purely because a value was outside of what has been seen with
  the catalog before.  It is okay to change the range of a check or add a new
  value to a list of accepted values.  We may ask you to explain the change
  so we understand it.  A big part of the checker is capturing knowledge for
  the entire community.

* We welcome comments and suggestions on the checker.
"""


def find_issues(checks: list[str]) -> Iterator[stac.Issue]:
  """Runs all of the checkers and yields any issues found."""
  stac_root = stac.stac_root()
  nodes = stac.load(stac_root)

  print('Number of STAC nodes loaded:', len(nodes))
  print()

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
    print()
    print('===============')
    print('Error count:', error_count)
    print('===============')

    print(INSTRUCTIONS_FOR_HANDLING_ERRORS)

    sys.exit(1)


if __name__ == '__main__':
  app.run(main)
