import pathlib

from absl.testing import absltest
from checker import stac
from checker.tree import dangling_pointer
from checker.tree import parent_child

Check = dangling_pointer.Check

CATALOG = stac.StacType.CATALOG
COLLECTION = stac.StacType.COLLECTION
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
CATALOG_ID = 'A_CATALOG'
COLLECTION_ID = 'A_CATALOG/A_COLLECTION'
FILE_PATH = pathlib.Path('test/path/should/be/ignored')


def catalog_node(catalog_stac) -> stac.Node:
  return stac.Node(CATALOG_ID, FILE_PATH, CATALOG, NONE, catalog_stac)


def collection_node(collection_stac) -> stac.Node:
  return stac.Node(COLLECTION_ID, FILE_PATH, COLLECTION, IMAGE, collection_stac)


CATALOG_DATA = {
    LINKS: [
        {REL: SELF, HREF: PREFIX + 'A_CATALOG/catalog.json'},
        {REL: CHILD, HREF: PREFIX + 'A_CATALOG/A_COLLECTION.json'},
        {REL: PARENT, HREF: PREFIX + 'catalog.json'},
    ]
}
COLLECTION_DATA = {
    LINKS: [
        {REL: SELF, HREF: PREFIX + 'A_CATALOG/A_COLLECTION.json'},
        {REL: PARENT, HREF: PREFIX + 'A_CATALOG/catalog.json'},
    ]
}

CATALOG_NODE = catalog_node(CATALOG_DATA)
COLLECTION_NODE = collection_node(COLLECTION_DATA)


class DanglingChildTest(absltest.TestCase):

  def test_valid(self):
    nodes = [CATALOG_NODE, COLLECTION_NODE]
    issues = list(Check.run(nodes))
    self.assertEqual(0, len(issues))

  def test_dangling_pointer(self):
    nodes = [CATALOG_NODE]  # COLLECTION_NODE is missing
    issues = list(Check.run(nodes))
    message = 'Child not found: A_CATALOG/A_COLLECTION'
    expect = [Check.new_issue(CATALOG_NODE, message)]
    self.assertEqual(expect, issues)

  def test_links_not_a_list(self):
    a_catalog_node = catalog_node({LINKS: 'not a list'})
    nodes = [a_catalog_node, COLLECTION_NODE]
    issues = list(Check.run(nodes))
    self.assertEqual(0, len(issues))


if __name__ == '__main__':
  absltest.main()
