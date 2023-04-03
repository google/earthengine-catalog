"""Tests for titles."""

import pathlib

from checker import stac
from checker.tree import title
from absl.testing import absltest

Check = title.Check

COLLECTION = stac.StacType.COLLECTION
IMAGE = stac.GeeType.IMAGE

ID = 'a/collection'
FILE_PATH = pathlib.Path('test/path/should/be/ignored')


class TitleTest(absltest.TestCase):

  def test_valid(self):
    stac_data_a = {'title': ['Title A']}
    collection_a = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data_a)
    stac_data_b = {'title': ['Title B']}
    collection_b = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data_b)

    nodes = [collection_a, collection_b]
    issues = list(Check.run(nodes))
    self.assertEqual(0, len(issues))

  def test_catch_duplicate(self):
    stac_data_a = {'title': ['Title A']}
    collection_a = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data_a)
    collection_b = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data_a)

    nodes = [collection_a, collection_b]
    issues = list(Check.run(nodes))
    expect = [
        Check.new_issue(collection_a, 'Non-unique title: "[\'Title A\']"'),
        Check.new_issue(collection_b, 'Non-unique title: "[\'Title A\']"')]
    self.assertEqual(expect, issues)

if __name__ == '__main__':
  absltest.main()
