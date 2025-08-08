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


def get_added_filenames(pr_number: int, repo: str) -> list[str]:
    """
    Uses the GitHub CLI ('gh') to fetch a list of ONLY newly added files in a PR.

    Args:
        pr_number: The number of the pull request.
        repo: The owner/repo name (e.g., 'google/earthengine-catalog').

    Returns:
        A list of filenames that were added in the PR.
    """
    print(f"Fetching added files for PR #{pr_number} in repo {repo}...")
    
    # Construct the command to get the file status (Added, Modified, Deleted)
    command = [
        "gh",
        "pr",
        "diff",
        str(pr_number),
        "--repo",
        repo,
        "--name-status"
    ]

    try:
        # Execute the 'gh' command. It will use the GITHUB_TOKEN from the environment.
        result = subprocess.run(
            command,
            capture_output=True,
            text=True,
            check=True  # Raise an exception if the command fails
        )

        # Process the output
        added_files = []
        output_lines = result.stdout.strip().split('\n')

        for line in output_lines:
            if not line:
                continue
            
            # The output is tab-separated: "A\tpath/to/file.txt"
            parts = line.split('\t')
            status = parts[0]
            filename = parts[1]

            # We only care about added files
            if status == 'A':
                added_files.append(filename)

        return added_files

    except FileNotFoundError:
        logging.error("Error: 'gh' command not found. Ensure the GitHub CLI is installed.")
        raise
    except subprocess.CalledProcessError as e:
        logging.error(f"Error executing 'gh' command. Exit code: {e.returncode}")
        logging.error(f"Stderr: {e.stderr}")
        raise


class Check(stac.NodeCheck):
  """Checks for gee:status."""
  name = 'gee_status'

  @classmethod
  def run(cls, node: stac.Node) -> Iterator[stac.Issue]:
    # TODO(simonf): add a github-only check that new datasets
    # must have status 'incompete' or 'beta'
    if os.environ.get('GITHUB_ACTIONS') == 'true':
      pr_number = os.environ.get("GITHUB_EVENT_PULL_REQUEST_NUMBER")
      repo = os.environ.get("GITHUB_REPOSITORY")      
      if pr_number and repo:
        logging.info('Files added in this PR: %s', get_added_filenames(pr_number, repo))
      else:
        logging.error('Could not read GITHUB_EVENT_PULL_REQUEST_NUMBER or GITHUB_REPOSITORY values')

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
