"""Tests for version_links."""

import pathlib

from absl.testing import absltest
from checker import stac
from checker.tree import version_links
from stac import stac_lib

Check = version_links.Check

COLLECTION = stac.StacType.COLLECTION
IMAGE = stac_lib.GeeType.IMAGE

HREF = version_links.HREF
LINKS = version_links.LINKS
PREFIX = version_links.PREFIX
REL = version_links.REL
SELF = version_links.SELF

SUCCESSOR = version_links.SUCCESSOR

COLLECTION_DATA = {LINKS: [
    {REL: SELF, HREF: PREFIX + 'AAFC/AAFC_ACI.json'}]}


COLLECTION_ID = 'AAFC/AAFC_ACI'
FILE_PATH = pathlib.Path('test/path/should/be/ignored')


def collection_node(catalog_stac) -> stac.Node:
  return stac.Node(COLLECTION_ID, FILE_PATH, COLLECTION, IMAGE, catalog_stac)


class VersionLinksTest(absltest.TestCase):

  def test_valid(self):
    nodes = [
        collection_node(COLLECTION_DATA),
        collection_node({LINKS: [
            {REL: SUCCESSOR, HREF: PREFIX + 'AAFC/AAFC_ACI.json'}]})
    ]
    issues = list(Check.run(nodes))
    self.assertEqual(0, len(issues))

  def test_no_nodes(self):
    issues = list(Check.run([]))
    self.assertEqual(0, len(issues))

  def test_empty_node(self):
    # The node/links checker handles these.
    issues = list(Check.run([collection_node({})]))
    self.assertEqual(0, len(issues))

  def test_links_not_list(self):
    # The node/links checker handles these.
    issues = list(Check.run([collection_node({LINKS: 'not a list'})]))
    self.assertEqual(0, len(issues))

  def test_does_not_exist_successor(self):
    bad_node = collection_node({LINKS: [
        {REL: SUCCESSOR, HREF: PREFIX + 'DOES/NOT_EXIST.json'}]})
    nodes = [collection_node(COLLECTION_DATA), bad_node]
    issues = list(Check.run(nodes))
    message='successor-version url has no destination: DOES/NOT_EXIST'
    expect = [Check.new_issue(bad_node, message)]
    self.assertEqual(expect, issues)


if __name__ == "__main__":
  absltest.main()
