"""Checks for the scientific extension.

https://github.com/stac-extensions/scientific

This extension adds citations/references for datasets and includes the ability
to add Digital Object Identifiers (DOIs) for the references.

Citations should be in APA Style format if possible. https://apastyle.apa.org/

- sci:doi is the primary DOI for the dataset
- sci:citation is the primary reference for the data
  - The citation section is in commonmark / markdown formatted text
- sci:publications are extra citations with an optional DOI field
- gee:extra_dois are replaced with the ability to have sci:publications and
  should no longer be added. The existing entries will likely be removed in
  the future.

DOIs are defined in ANSI/NISO Z39.84-2000 and ISO 26324. A DOI starts with a
'prefix' section. The prefix begins with '10.', which is the 'directory code'.
Then comes a 4 or more digit integer that is the 'registrant' code. A '/'
separates the prefix from the 'suffix' that is hard to validate offline as it
is arbitrary text defined by the 'registrant' organization designated by the
prefix. Organizations that give out DOIs are permitted to use almost any string
for the suffix.

To access a DOI, add the DOI string to the end of https://doi.org/.

In the citation section, use this format to give the DOI:

  [doi:10.1016/j.rse.2019.111493](https://doi.org/10.1016/j.rse.2019.111493)

You can use this doi.py tool to more closely inspect DOI entries:

https://gist.github.com/schwehr/22ce6080eb9e730ef04fccfa25072e3a

The checker here does not yet enforce the requirement of the scientific
extension to have matching link entries in the links section for each DOI.

See also:

- https://en.wikipedia.org/wiki/Digital_object_identifier
- https://www.doi.org/doi_handbook/2_Numbering.html#2.2.2

TODO(schwehr): Enforce URLs in the links section for each DOI.
"""

import re
from typing import Iterator

from checker import stac

EXTENSION_VERSION = '1.0.0'

SCI_DOI = 'sci:doi'
SCI_CITATION = 'sci:citation'
SCI_PUBLICATIONS = 'sci:publications'
GEE_EXTRA_DOIS = 'gee:extra_dois'

# Fields in SCI_PUBLICATIONS entries
CITATION = 'citation'
DOI = 'doi'

# Do not add more datasets to this set.
EXTRA_DOIS_EXCEPTIONS = frozenset({
    'COPERNICUS/Landcover/100m/Proba-V-C3/Global',
    'CSIRO/SLGA',
    'NASA/GPM_L3/IMERG_V06',
    'NASA/OCEANDATA/MODIS-Aqua/L3SMI',
    'NASA/OCEANDATA/MODIS-Terra/L3SMI',
    'NASA/OCEANDATA/SeaWiFS/L3SMI',
    'RUB/RUBCLIM/LCZ/global_lcz_map/v1',
})


def doi_valid(doi: str) -> bool:
  """Returns true if a doi passes a minimal test."""
  if doi.endswith('.html'): return False
  if doi.endswith('.pdf'): return False
  return bool(re.fullmatch('10.[0-9]{4}[0-9]*/.*', doi))


class Check(stac.NodeCheck):
  """Checks for the scientific extension."""
  name = 'sci_extension'

  @classmethod
  def run(cls, node: stac.Node) -> Iterator[stac.Issue]:

    # # TODO(schwehr): Factor out as a function when primary checkers are in?
    extensions = node.stac.get('stac_extensions', [])
    for extension in extensions:
      if not isinstance(extension, str):
        yield cls.new_issue(node, 'Extensions must be a url str')
        return
    extension_list = [ex for ex in extensions if 'github.io/scientific' in ex]
    extension_url = extension_list[0] if extension_list else None
    has_scientific_extension = bool(extension_list)

    if node.type == stac.StacType.CATALOG:
      if has_scientific_extension:
        yield cls.new_issue(
            node, 'Catalog must not have the scientific extension')

      # TODO(schwehr): Make sure none of the sci or gee:extra_doi fields
      # end up in catalogs
      return

    if has_scientific_extension:
      # TODO(schwehr): Factor out as a function when primary checkers are in?
      search = re.search(r'v([0-9]+\.[0-9]+\.[0-9]+)', extension_url)
      if search:
        extension_version = search.groups()[0]
        if extension_version != EXTENSION_VERSION:
          yield cls.new_issue(
              node, f'Extension\'s version must be: "{EXTENSION_VERSION}"')
          return

    # gee:extra_dois is not a part of the scientific extension, so check first.
    if GEE_EXTRA_DOIS in node.stac:
      extra_dois = node.stac[GEE_EXTRA_DOIS]
      if node.id not in EXTRA_DOIS_EXCEPTIONS:
        # Use sci:publications and links
        yield cls.new_issue(node, f'No new uses of {GEE_EXTRA_DOIS} allowed')
      elif not isinstance(extra_dois, list):
        yield cls.new_issue(node, f'{GEE_EXTRA_DOIS} must be a list')
      else:
        if not extra_dois:
          # Delete it or add some dois
          yield cls.new_issue(node, f'Empty {GEE_EXTRA_DOIS} not allowed')
        for doi in extra_dois:
          if not isinstance(doi, str):
            yield cls.new_issue(node, f'{GEE_EXTRA_DOIS} doi must be a str')
          elif not doi_valid(doi):
            yield cls.new_issue(node, f'{GEE_EXTRA_DOIS} doi not valid: {doi}')
        if len(extra_dois) != len(set(extra_dois)):
          yield cls.new_issue(node, f'{GEE_EXTRA_DOIS} has duplicates')
        if sorted(extra_dois) != extra_dois:
          yield cls.new_issue(node, f'{GEE_EXTRA_DOIS} not sorted')

    if not has_scientific_extension:
      if SCI_DOI in node.stac:
        yield cls.new_issue(
            node, f'scientific extension not found, but has "{SCI_DOI}"')
      if SCI_CITATION in node.stac:
        yield cls.new_issue(
            node, f'scientific extension not found, but has "{SCI_CITATION}"')
      if SCI_PUBLICATIONS in node.stac:
        yield cls.new_issue(
            node,
            f'scientific extension not found, but has "{SCI_PUBLICATIONS}"')
      return

    doi = node.stac.get(SCI_DOI)
    citation = node.stac.get(SCI_CITATION)

    if not doi and not citation and SCI_PUBLICATIONS not in node.stac:
      yield cls.new_issue(node, 'scientific extension, but no sci fields found')

    if SCI_DOI in node.stac:
      if not isinstance(doi, str):
        yield cls.new_issue(node, f'{SCI_DOI} must be a str')
      else:
        if not doi_valid(doi):
          yield cls.new_issue(node, f'{SCI_DOI} not valid: {doi}')

    if SCI_PUBLICATIONS in node.stac:
      publications = node.stac.get(SCI_PUBLICATIONS, [])
      if not isinstance(publications, list):
        yield cls.new_issue(node, f'{SCI_PUBLICATIONS} must be a list')
      elif not publications:
        yield cls.new_issue(
            node, f'{SCI_PUBLICATIONS} must have at least one entry')
      else:
        for pub in publications:
          if not isinstance(pub, dict):
            yield cls.new_issue(
                node, f'{SCI_PUBLICATIONS} entry must be a dict')
          else:
            if DOI in pub:
              # TODO(schwehr): Ensure there is a link in the links section
              doi = pub[DOI]
              if not isinstance(doi, str):
                yield cls.new_issue(
                    node, f'{SCI_PUBLICATIONS} entry {DOI} must be a str')
              elif not doi_valid(doi):
                yield cls.new_issue(
                    node, f'{SCI_PUBLICATIONS} entry {DOI} not valid: {doi}')

            citation = pub.get(CITATION)
            if CITATION not in pub:
              yield cls.new_issue(
                  node, f'{SCI_PUBLICATIONS} entry must have a {CITATION}')
            elif not isinstance(citation, str):
              yield cls.new_issue(
                  node, f'{SCI_PUBLICATIONS} entry {CITATION} must be a str')
            else:
              # TODO(schwehr): Possible to use a generic str field length check?
              # TODO(schwehr): Need to see if we can better check citations.
              size = len(citation)
              if size < 5:
                yield cls.new_issue(
                    node, f'{CITATION} too short: {size} - "{citation}"')
              if size > 600:
                yield cls.new_issue(
                    node, f'{CITATION} too long: {size} - "{citation[:50]}..."')
