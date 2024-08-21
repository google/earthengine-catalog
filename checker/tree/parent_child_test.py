"""Tests for parent_child."""

import pathlib

from checker import stac
from checker.tree import parent_child
from absl.testing import absltest

Check = parent_child.Check

CATALOG = stac.StacType.CATALOG
COLLECTION = stac.StacType.COLLECTION
GEE_CATALOG = parent_child.GEE_CATALOG
IMAGE = stac.GeeType.IMAGE
NONE = stac.GeeType.NONE

CHILD = parent_child.CHILD
HREF = parent_child.HREF
LINKS = parent_child.LINKS
PARENT = parent_child.PARENT
PREFIX = parent_child.PREFIX
REL = parent_child.REL
SELF = parent_child.SELF

ID = 'id'
CATALOG_ID = 'AAFC'
COLLECTION_ID = 'AAFC/AAFC_ACI'
FILE_PATH = pathlib.Path('test/path/should/be/ignored')


def root_node(catalog_stac) -> stac.Node:
  return stac.Node(GEE_CATALOG, FILE_PATH, CATALOG, NONE, catalog_stac)


def catalog_node(catalog_stac) -> stac.Node:
  return stac.Node(CATALOG_ID, FILE_PATH, CATALOG, NONE, catalog_stac)


def collection_node(catalog_stac) -> stac.Node:
  return stac.Node(COLLECTION_ID, FILE_PATH, COLLECTION, IMAGE, catalog_stac)

ROOT_DATA = {LINKS: [
    {REL: SELF, HREF: PREFIX + 'catalog.json'},
    {REL: CHILD, HREF: PREFIX + 'AAFC/catalog.json'}]}
CATALOG_DATA = {LINKS: [
    {REL: SELF, HREF: PREFIX + 'AAFC/catalog.json'},
    {REL: CHILD, HREF: PREFIX + 'AAFC/AAFC_ACI.json'},
    {REL: PARENT, HREF: PREFIX + 'catalog.json'}]}
COLLECTION_DATA = {LINKS: [
    {REL: SELF, HREF: PREFIX + 'AAFC/AAFC_ACI.json'},
    {REL: PARENT, HREF: PREFIX + 'AAFC/catalog.json'}]}

ROOT_NODE = root_node(ROOT_DATA)
CATALOG_NODE = catalog_node(CATALOG_DATA)
COLLECTION_NODE = collection_node(COLLECTION_DATA)


class HelperTest(absltest.TestCase):

  def test_self_url_does_not_find(self):
    # This is the one case that was not obvious on how to trigger.
    node = root_node(
        {LINKS: [{REL: CHILD, HREF: PREFIX + 'AAFC/catalog.json'}]})
    self.assertEqual(parent_child.NO_SELF_URL, parent_child.self_url(node))


class ParentChildTest(absltest.TestCase):

  def test_valid(self):
    nodes = [ROOT_NODE, CATALOG_NODE, COLLECTION_NODE]
    issues = list(Check.run(nodes))
    self.assertEqual(0, len(issues))

  def test_gee_status(self):
    catalog = {LINKS: [
        {REL: SELF, HREF: PREFIX + 'AAFC/catalog.json'},
        # Correctly leave out child link.
        {REL: PARENT, HREF: PREFIX + 'catalog.json'}]}
    collection = {
        'gee:status': 'incomplete',
        LINKS: [
            {REL: SELF, HREF: PREFIX + 'AAFC/AAFC_ACI.json'},
            {REL: PARENT, HREF: PREFIX + 'AAFC/catalog.json'},
        ],
    }

    nodes = [ROOT_NODE, catalog_node(catalog), collection_node(collection)]

    issues = list(Check.run(nodes))
    self.assertEqual(0, len(issues))

  def test_root_missing_links(self):
    root = root_node({})
    nodes = [root, CATALOG_NODE, COLLECTION_NODE]
    issues = list(Check.run(nodes))
    message = 'Not in any catalog as a child link'
    expect = [Check.new_issue(CATALOG_NODE, message)]
    self.assertEqual(expect, issues)

  def test_catalog_missing_links(self):
    catalog = catalog_node({})
    nodes = [ROOT_NODE, catalog, COLLECTION_NODE]
    issues = list(Check.run(nodes))
    message = 'Not in any catalog as a child link'
    expect = [Check.new_issue(COLLECTION_NODE, message)]
    self.assertEqual(expect, issues)

  # TODO(schwehr): This should generate an error.
  def test_collection_missing_links(self):
    collection = collection_node({})
    nodes = [ROOT_NODE, CATALOG_NODE, collection]
    issues = list(Check.run(nodes))
    self.assertEqual(0, len(issues))

  def test_collection_links_not_list(self):
    collection = collection_node({LINKS: 'not a list'})
    nodes = [ROOT_NODE, CATALOG_NODE, collection]
    issues = list(Check.run(nodes))
    self.assertEqual(0, len(issues))

  def test_missing_child(self):
    catalog = {LINKS: [
        {REL: SELF, HREF: PREFIX + 'AAFC/catalog.json'},
        # Leave out child triggering an issue.
        {REL: PARENT, HREF: PREFIX + 'catalog.json'}]}
    nodes = [ROOT_NODE, catalog_node(catalog), COLLECTION_NODE]

    issues = list(Check.run(nodes))
    message = 'Not in any catalog as a child link'
    expect = [Check.new_issue(COLLECTION_NODE, message)]
    self.assertEqual(expect, issues)

  def test_incorrect_parent(self):
    incorrect = 'WRONG/catalog'
    collection = {LINKS: [
        {REL: SELF, HREF: PREFIX + 'AAFC/AAFC_ACI.json'},
        {REL: PARENT, HREF: PREFIX + incorrect + '.json'}]}
    a_collection_node = collection_node(collection)
    nodes = [ROOT_NODE, CATALOG_NODE, a_collection_node]

    issues = list(Check.run(nodes))
    message = 'catalog_url != parent_url: AAFC/catalog ' + incorrect
    expect = [Check.new_issue(a_collection_node, message)]
    self.assertEqual(expect, issues)

  def test_incorrectly_have_child_link_with_skip_indexing(self):
    collection = {
        'gee:status': 'incomplete',
        LINKS: [
            {REL: SELF, HREF: PREFIX + 'AAFC/AAFC_ACI.json'},
            {REL: PARENT, HREF: PREFIX + 'AAFC/catalog.json'},
        ],
    }
    a_collection_node = collection_node(collection)
    nodes = [ROOT_NODE, CATALOG_NODE, a_collection_node]

    issues = list(Check.run(nodes))
    message = (
        "Please don't reference in catalog.jsonnet datasets that have "
        'gee:status set to "incomplete": AAFC/catalog AAFC/AAFC_ACI'
    )
    expect = [Check.new_issue(a_collection_node, message)]
    self.assertEqual(expect, issues)


if __name__ == '__main__':
  absltest.main()
