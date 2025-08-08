"""Checks for gee:status validity.

gee:status specifies whether a dataset is not completely active.

Requirements and specification:
- If the node is a catalog, it cannot have the field.
- If the field is set, its value must be one of several enum values.
"""

import json
import os
import subprocess
from typing import Iterator

from absl import logging

from checker import stac

def get_added_filenames_for_pr_repo(pr_number: int, repo: str) -> list[str]:
    """
    Uses the GitHub CLI ('gh') to fetch a list of ONLY newly added files in a PR.

    Args:
        pr_number: The number of the pull request.
        repo: The owner/repo name (e.g., 'google/earthengine-catalog').

    Returns:
        A list of filenames that were added in the PR.
    """
    try:
        result = subprocess.run(
            ['gh', 'api', f'repos/:owner/:repo/pulls/{pr_number}/files'],
            capture_output=True, text=True
        )
        
        if result.returncode != 0:
            logging.error(f"Failed to get PR files: {result.stderr}")
            return []
        
        files = json.loads(result.stdout)
        logging.info('API response: %s', files)
        
        return [f['filename'] for f in files if f['status'] == 'added']

    except FileNotFoundError:
        logging.error("Error: 'gh' command not found. Ensure the GitHub CLI is installed.")
        return []
    except subprocess.CalledProcessError as e:
        logging.error(f"Error executing 'gh' command. Exit code: {e.returncode}")
        logging.error(f"Stderr: {e.stderr}")
        return []

def get_added_filenames():
    if os.environ.get('GITHUB_ACTIONS') != 'true':
        return []
    event_name = os.environ.get('GITHUB_EVENT_NAME')
    if event_name != 'pull_request':
        return []
    github_ref = os.environ.get('GITHUB_REF', '')
    if not github_ref.startswith('refs/pull/'):
        logging.error('Unexpected ref format %s', github_ref)
        return []
    # Format: refs/pull/123/merge
    pr_number = github_ref.split('/')[2]        
    if not pr_number:
        logging.error('Could not get PR number from GITHUB_EVENT_PATH')
        return []
    repo = os.environ.get("GITHUB_REPOSITORY")      
    if repo:
        logging.info('REPO %s', repo)
    else:
        logging.error('Could not read GITHUB_REPOSITORY value')
        return []  
    return get_added_filenames_for_pr_repo(pr_number, repo)
    
    
class Check(stac.NodeCheck):
  """Checks for gee:status."""
  name = 'gee_status'

  @classmethod
  def run(cls, node: stac.Node) -> Iterator[stac.Issue]:
    # TODO(simonf): add a github-only check that new datasets
    # must have status 'incompete' or 'beta'
    logging.info('Files added in this PR: %s', get_added_filenames())
      
    if stac.GEE_STATUS in node.stac:
      if node.type == stac.StacType.CATALOG:
        yield cls.new_issue(
            node, f'Catalogs may not have a {stac.GEE_STATUS} field'
        )
      elif node.type == stac.StacType.COLLECTION:
        field_value = node.stac.get(stac.GEE_STATUS)
        if field_value not in stac.Status.allowed_statuses():
          yield cls.new_issue(
              node,
              f'{stac.GEE_STATUS}, if set, must be one of'
              f' {sorted(stac.Status.allowed_statuses())}',
          )
