"""Tests for uniqueness of URL-suitable ids."""

import pathlib

from absl.testing import absltest
from checker import stac
from checker.tree import url_id
from stac import stac_lib

Check = url_id.Check

COLLECTION = stac.StacType.COLLECTION
IMAGE = stac_lib.GeeType.IMAGE

ID = 'a/collection'
FILE_PATH = pathlib.Path('test/path/should/be/ignored')


class TitleTest(absltest.TestCase):

  def test_valid(self):
    stac_data_a = {'id': 'ID A'}
    collection_a = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data_a)
    stac_data_b = {'id': 'ID B'}
    collection_b = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data_b)

    nodes = [collection_a, collection_b]
    issues = list(Check.run(nodes))
    self.assertEqual(0, len(issues))

  def test_catch_duplicate(self):
    stac_data_a = {'id': 'X/Y_Z'}
    collection_a = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data_a)
    stac_data_b = {'id': 'X_Y/Z'}
    collection_b = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data_b)

    nodes = [collection_a, collection_b]
    issues = list(Check.run(nodes))
    expect = [
        Check.new_issue(
            collection_a, 'Non-unique URL-suitable id: "X/Y_Z" becomes "X_Y_Z"'
        ),
        Check.new_issue(
            collection_a, 'Non-unique URL-suitable id: "X_Y/Z" becomes "X_Y_Z"'
        ),
    ]
    self.assertEqual(expect, issues)

if __name__ == '__main__':
  absltest.main()
