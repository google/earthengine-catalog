"""Tests for extensions."""

from checker import test_utils
from checker.node import extensions
import unittest

EXTENSIONS = extensions.EXTENSIONS
STAC_EXTENSIONS = extensions.STAC_EXTENSIONS


class ExtensionsTest(test_utils.NodeTest):

  def setUp(self):
    super().setUp()
    self.check = extensions.Check

  def test_has_all_the_extensions(self):
    self.assert_collection({STAC_EXTENSIONS: EXTENSIONS})

  def test_catalogs_cannot_have_extensions(self):
    self.assert_catalog(
        {STAC_EXTENSIONS: EXTENSIONS}, 'Catalogs cannot have extensions')

  def test_unknown_extension(self):
    extension = 'some extension'
    self.assert_collection(
        {STAC_EXTENSIONS: [extension]}, f'Extension not allowed: "{extension}"')

  def test_unsorted(self):
    unsorted = [EXTENSIONS[1], EXTENSIONS[0]]
    self.assert_collection(
        {STAC_EXTENSIONS: unsorted}, 'Extensions must be sorted')

  def test_duplicate(self):
    duplicate = [EXTENSIONS[0], EXTENSIONS[0]]
    self.assert_collection(
        {STAC_EXTENSIONS: duplicate}, 'Duplicate extensions not allowed')


if __name__ == '__main__':
  unittest.main()
