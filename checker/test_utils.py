"""Helpers for tests."""

import pathlib
from typing import Any, Optional, Union

from checker import stac
import unittest

_CATALOG = stac.StacType.CATALOG
_COLLECTION = stac.StacType.COLLECTION
_IMAGE = stac.GeeType.IMAGE

_CATALOG_ID = 'a/catalog'
_COLLECTION_ID = 'a/collection'
_FILE_PATH = pathlib.Path('test/path/should/be/ignored')


class NodeTest(unittest.TestCase):
  """Encapsulate most node checks."""
  check: stac.NodeCheck

  def _assert_stac(
      self,
      stac_type: stac.StacType,
      stac_data: dict[str, Any],
      messages: Optional[Union[str, list[str]]],
      dataset_id: str,
      file_path: Union[pathlib.Path, str],
      gee_type: stac.GeeType,
      issue_level: stac.IssueLevel) -> None:
    """Fail if a checker run does not generate the expected messages."""
    if isinstance(file_path, str):
      file_path = pathlib.Path(file_path)
    node = stac.Node(dataset_id, file_path, stac_type, gee_type, stac_data)

    issues = list(self.check.run(node))
    issues_str = '  \n'.join(str(issue) for issue in issues)
    if not messages:
      if issues:
        self.fail(f'Expected no issues, but found:\n  {issues_str}')
    else:
      if isinstance(messages, str):
        messages = [messages]
      expect = [
          self.check.new_issue(node, message, issue_level)
          for message in messages]
      if expect != issues:
        expect_str = '\n  '.join(str(issue) for issue in expect)
        self.fail(f'\n\nExpected:\n  {expect_str}\n\nFound:\n  {issues_str}')

  def assert_catalog(
      self,
      stac_data: dict[str, Any],
      messages: Optional[Union[str, list[str]]] = None,
      dataset_id: str = _CATALOG_ID,
      file_path: Union[pathlib.Path, str] = _FILE_PATH,
      issue_level: stac.IssueLevel = stac.IssueLevel.ERROR) -> None:
    """Fails if a checker run does not generate the expected messages.

    Provides a unittest for checkers for STAC Catalogs in checker/node.

    Args:
      stac_data: Data representing what would be in a STAC Catalog JSON file.
      messages: List of issue messages that must be generated or None if no
        messages. If a single message is expected, a str is allowed.
      dataset_id: Set if the check needs a specific STAC 'id'
      file_path: Set to a str or pathlib Path if the check needs a specific
        file path for the location of the STAC Catalog JSON file
      issue_level: Set to WARNING if a check generates warnings rather than
        errors.

    Raises:
      AssertionError: The checker run did not produce the expected messages.
    """
    gee_type = stac.GeeType.NONE
    self._assert_stac(
        _CATALOG, stac_data, messages, dataset_id, file_path, gee_type,
        issue_level)

  def assert_collection(
      self,
      stac_data: dict[str, Any],
      messages: Optional[Union[str, list[str]]] = None,
      dataset_id: str = _COLLECTION_ID,
      file_path: Union[pathlib.Path, str] = _FILE_PATH,
      gee_type: stac.GeeType = _IMAGE,
      issue_level: stac.IssueLevel = stac.IssueLevel.ERROR) -> None:
    """Fails if a checker run does not generate the expected messages.

    Provides a unittest for checkers for STAC Collections in checker/node.

    Args:
      stac_data: Data representing what would be in a STAC Catalog JSON file.
      messages: List of issue messages that must be generated or None if no
        messages. If a single message is expected, a str is allowed.
      dataset_id: Set if the check needs a specific STAC 'id'
      file_path: Set to a str or pathlib Path if the check needs a specific
        file path for the location of the STAC Catalog JSON file
      gee_type: Specify a GeeType if the test needs a specific type other than
        Image.
      issue_level: Set to WARNING if a check generates warnings rather than
        errors.

    Raises:
      AssertionError: The checker run did not produce the expected messages.
    """
    self._assert_stac(
        _COLLECTION, stac_data, messages, dataset_id, file_path, gee_type,
        issue_level)
