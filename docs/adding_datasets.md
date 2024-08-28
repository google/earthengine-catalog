These instructions outline the workflow of adding a new dataset
to the Earth Engine catalog. See [docs on making simple edits](simple_edits.md)
for pointers on creating pull requests in GitHub.

## Overview

Currently, adding user-uploaded assets to the public catalog
involves mirroring these assets into public Earth Engine folders.
However, the source user-uploaded assets still need to be kept in user folders
for as long as the dataset is present in the catalog.

To add a new dataset:

* File a request and get confirmation that the dataset will be accepted.
* Write a jsonnet file describing the dataset. Write example JS scripts.
* Create and submit a GitHub pull request with these files.

See also
[dataset acceptance criteria](https://developers.google.com/earth-engine/help_collection_criteria).

## Detailed steps for adding a new dataset:

1. File a bug
[to add a new dataset](https://issuetracker.google.com/issues?q=status:(open%20%7C%20new%20%7C%20assigned%20%7C%20accepted)%20componentid:1161680&p=1)
or
[to update an existing one](https://issuetracker.google.com/issues?q=status:(open%20%7C%20new%20%7C%20assigned%20%7C%20accepted)%20componentid:1161653).
Reference the existing user-uploaded asset id and make sure the asset is
publicly readable.

1. Get a general confirmation from the Earth Engine Data team that the dataset
will be accepted.

1. Choose a public dataset id that the data will be mirrored to.

1. Wait until Earth Engine Data team configures asset mirroring.

1. If your github account was created recently, the repo might not allow you
to run tests on your pull requests (PRs) automatically. To address this,
create and submit a trivial PR modifying [this file](spaces.md) (for example,
add or remove a space).

1. Create a jsonnet file describing the dataset using any of the existing files
as a starting point. See also [template files with field
annotations](../catalog/TEMPLATE). The order of the fields that are located
at the same level does not matter.

1. The text fields support
[markdown syntax](https://www.markdownguide.org/cheat-sheet/).
If editing markdown in jsonnet fields becomes too cumbersome, you can use
'importstr' to import text from a separate .md file
([see example](https://github.com/google/earthengine-catalog/blob/main/catalog/JRC/catalog.jsonnet#L16)).
Use tools like [markdownlivepreview.com](https://markdownlivepreview.com/)
to preview your markdown content.

1. Make sure the `gee:terms_of_use` field describes the data license and the
`links` fields contains `ee.link.license()` pointing at the URL with the
licensing terms.

1. New dataset will not be activated at first. To indicate that, set
`'gee:status': 'incomplete'` at the top level. Don't yet add the new dataset
to the `catalog.jsonnet` file.

1. In the examples/ directory, create a JavaScript file that will be used as
the main example.

1. In the same directory, create another JavaScript file that generates a
256x256 preview thumbnail. This thumbnail will be used in the catalog to
identify the dataset, so choose a representative and good-looking
visualization. Make sure to hide the basemap (e.g., by using a single-color
background).

1. Create a GitHub pull request with all the files you changed or added.

1. This will trigger automatic syntax and validity checks. Their results can be
seen in the "Checks" section of the pull request UI. Fix as many issues as you
can, and ask the Earth Engine Data team for help with the rest.

1. When all the checks pass, ask the Earth Engine Data team to review the PR.

1. When the PR is approved, submit it. Wait for the Earth Engine Data team to
activate the dataset (this usually simply means adding the thumbnails generated
by the preview script).

1. If your jsonnet file specified classification band colors or image
attributes that you'd like to preserve on catalog datasets, make sure the Earth
Engine Data team runs the mirroring job once again to set those fields.

1. Review the dataset page in the [HTML catalog](https://developers.google.com/earth-engine/datasets) to make sure everything looks good.

## Data normalization

One of the benefits of Earth Engine for end users is uniform presentation of
data with few surprises. This is achieved by making sure the datasets are
normalized to a common form as much as possible during the
ingestion/preparation phase, which means a little bit more work up front for
data producers.

Here is some advice for data normalization.

1. For global datasets, prefer single assets over tiled mosaics.

1. Images with the same band signatures should be in the same image collection.
However, collections should be homogenous - if not all assets in a collection
have the same band names and types, either reingest the assets to make the
bands the same or use multiple collections.

1. Use human-readable band names, not the default 'b1', 'b2', etc.

1. Set UTC start and end times on all assets.

1. Make sure bands with non-continuous values (e.g., classification or bitmask
bands) are ingested with the pyramiding policy MODE, not the default policy
MEAN.

1. Don't mix continuous and classification values in the same band - create two
separate bands in such cases.

1. If your datasets have multiple versions, create successor/predecessor links
using the versioning approach [similar to this
one](https://github.com/google/earthengine-catalog/tree/main/catalog/UMD): put
a version map into a file named `dataset.libsonnet`, then use this map in
every jsonnet file. Mark all but the most recent versions with `"gee_status":
"deprecated"`.

1. Don't create new single-use keywords. If you feel a new keyword would make sense, propose other existing datasets where it should also be added.
