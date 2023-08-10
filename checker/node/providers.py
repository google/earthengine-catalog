"""Check for the providers field.

Providers are described here:

https://github.com/radiantearth/stac-spec/blob/master/collection-spec/collection-spec.md#provider-object

> A provider is any of the organizations that captures or processes the content
> of the Collection and therefore influences the data offered by this
> Collection. May also include information about the final storage provider
> hosting the data.

The rules for providers:
- 'providers' is a list of dictionaries
- There must be at least 2 providers with the last one being the Google host
- Each provider dictionary has 3 required fields: 'name', 'roles', and 'url'
- The name is a string that starts with a capital letter, is 2 to 181 letters
  long, and can contain ASCII letters, numbers, and characters in " -_ '.,:"
- The roles section is a list of one more of these strings:
  host, licensor, processor, and producer
- The roles for each provider must be sorted and there cannot be duplicates
  within one provider.  There can be multiple providers with any of the roles.
- The processor role is optional.  All three of the others must appear at least
  once in one of the providers
- The url must start with https or http.  Please use https unless the site
  absolutely cannot use TLS
- The Google host entry at the end must have the URL for the dataset in the
  html devsite public data catalog.
- Please use the jsonnet functions from earthengine.libsonnet whenever possible

https://github.com/radiantearth/stac-spec/blob/master/collection-spec/collection-spec.md#provider-object

Example in Jsonnet:

  providers: [
    ee.producer_provider(
      'A provider name', 'https://example.com'),
    ee.host_provider(self_ee_catalog_url)],

Example in JSON:

   "providers": [
      {
         "name": "A provider name",
         "roles": ["licensor", "producer"],
         "url": "https://example.com"
      }, {
         "name": "Google Earth Engine",
         "roles": ["host"],
         "url": "https://developers.google.com/earth-engine/datasets/catalog/ORG_THING"
      }],
"""

import re
from typing import Iterator

from checker import stac

BASE_URL = 'https://developers.google.com/earth-engine/datasets/catalog/'
EARTH_ENGINE = 'Google Earth Engine'
NAME = 'name'
PROVIDERS = 'providers'
ROLES = 'roles'
URL = 'url'
UNKNOWN = 'unknown'

HOST = 'host'
LICENSOR = 'licensor'
PROCESSOR = 'processor'
PRODUCER = 'producer'

ALL_ROLES = frozenset({HOST, LICENSOR, PROCESSOR, PRODUCER})
REQUIRED_ROLES = frozenset({HOST, LICENSOR, PRODUCER})


class Check(stac.NodeCheck):
  """Checks the providers field."""
  name = 'providers'

  @classmethod
  def run(cls, node: stac.Node) -> Iterator[stac.Issue]:
    if node.type == stac.StacType.CATALOG:
      if PROVIDERS in node.stac:
        yield cls.new_issue(node, f'Catalogs cannot have "{PROVIDERS}"')
      return

    if PROVIDERS not in node.stac:
      yield cls.new_issue(node, f'Collections must have "{PROVIDERS}"')
      return

    providers = node.stac[PROVIDERS]
    if not isinstance(providers, list):
      yield cls.new_issue(node, f'"{PROVIDERS}" must be a list')
      return

    if len(providers) < 2:
      yield cls.new_issue(node, f'"{PROVIDERS}" must have at least 2 entries')
      return

    last_provider = providers[-1]
    if isinstance(last_provider, dict):
      if NAME in last_provider and last_provider[NAME] != EARTH_ENGINE:
        yield cls.new_issue(
            node, f'The last provider must be "{EARTH_ENGINE}"')
      if ROLES in last_provider:
        roles = last_provider[ROLES]
        if isinstance(roles, list) and HOST not in roles:
          yield cls.new_issue(
              node, f'The last provider must be a "{HOST}"')
          return

    roles_set = set()
    # This is a bit tricky: Avoid complaining about missing roles if there
    # are any other issues related to roles.
    found_roles_issue = False

    for provider in providers:
      if not isinstance(provider, dict):
        yield cls.new_issue(node, 'A provider must be a dict')
        found_roles_issue = True
        continue
      name = provider.get(NAME, UNKNOWN)
      if NAME not in provider:
        yield cls.new_issue(node, f'A provider must have a "{NAME}"')
      else:
        if not isinstance(name, str):
          yield cls.new_issue(node, f'"{NAME}" must be a str')
        # iSDA, LANDFIRE, and DLR/WSF are currently the only exceptions to the
        # naming rules.  Please try to avoid making more exceptions.
        elif (name != 'iSDA' and
              'LANDFIRE' not in node.id and
              'DLR/WSF' not in node.id):
          # Restrict the validnames to start with capital letter.
          # Then letters, numbers, and a few more characters
          if not re.fullmatch(r'[A-Z][-_ \'.,:a-zA-Z0-9\(\)/]{1,180}', name):
            yield cls.new_issue(node, f'Invalid {NAME}: "{name}"')

      if ROLES not in provider:
        yield cls.new_issue(node, f'A provider must have a "{ROLES}" list')
        found_roles_issue = True
      else:
        roles = provider[ROLES]
        if not isinstance(roles, list):
          yield cls.new_issue(node, f'{ROLES} must be a list')
          found_roles_issue = True
        else:
          roles_set.update(roles)
          if len(roles) < 1:
            yield cls.new_issue(
                node, f'{ROLES} list must have at least 1 entry')
            found_roles_issue = True
          if len(set(roles)) != len(roles):
            yield cls.new_issue(
                node, f'{ROLES} list must not have duplicates')
            found_roles_issue = True
          for role in roles:
            if role not in ALL_ROLES:
              yield cls.new_issue(node, f'Unknown role: "{role}"')
              found_roles_issue = True
          if sorted(roles) != roles:
            yield cls.new_issue(node, 'Roles must be sorted')
            found_roles_issue = True

        if URL not in provider:
          yield cls.new_issue(node, f'A provider must have a "{URL}"')
        else:
          url = provider[URL]
          if not isinstance(url, str):
            yield cls.new_issue(node, f'{URL} must be a str')
          else:
            if not url.startswith('https://') and not url.startswith('http://'):
              yield cls.new_issue(node, f'{URL} must start with https or http')

        if HOST in roles:
          if URL not in provider:
            yield cls.new_issue(node, f'{HOST} provider must have a "{URL}"')
          else:
            if not url.startswith(BASE_URL):
              yield cls.new_issue(
                  node, f'{HOST} provider {URL} must start with "{BASE_URL}"')

    diff = ', '.join(sorted(REQUIRED_ROLES.difference(roles_set)))
    if diff and not found_roles_issue:
      yield cls.new_issue(node, f'Missing the required role(s): {diff}')
