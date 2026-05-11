# Adding new publisher or community catalogs

## Steps to add a new catalog

1.  Make sure the
    [eligibility criteria](https://developers.google.com/earth-engine/publisher_data_catalogs_eligibility)
    are satisfied.
1.  Get approval from the EE Data team (email earthengine-data@google.com)
1.  Send the EE Data team two catalog images:
 *  A 720x405 image to use in the
        [publisher catalog list](https://developers.google.com/earth-engine/datasets/publisher)
 *  An arbitrary logo image to be used
        [on the dataset pages](https://developers.google.com/earth-engine/datasets/publisher/forestdatapartnership.)
1.  Create a pull request with the catalog configuration and the first dataset.
    [See example PR.](https://github.com/google/earthengine-catalog/pull/997/files)

## Initial pull request

The pull request should create a new directory with the same name as
your project's Earth Engine home folder name. It should contain the
following changes:

1.  At least one dataset description. See the docs on [adding new datasets](adding_datasets.md) for details of
        writing a new dataset description.
1.  A new JSON file in the owners/ directory named `<yourproject>.jsonnet`
        with the following fields:

    ```
      {
          "id": "<yourproject>",
          "homeBucket": "projects/<yourproject>",
          "description": "<Catalog description>",
          "type": "PUBLISHER",
          "link": "<Link to the external publisher page>",
          "contactDisplay": "<Contact display>",
          "contactLink": "<Contact mailto: or https: link">
    }
    ```

    Note: The human-readable name of the catalog should be specified as the `title` field in the catalog's `catalog.jsonnet` file, not in the owners file.

## Reporting usage statistics

If a data provider supplies EE Data team with a Google group name, we can start
reporting daily usage stats showing 30DA counts for each of of the provider's
datasets. "30DA" means the count of unique users over 30 days who accessed
the datasets (when the number of users is over 50).

They will be named like this:
```
gs://earthengine-stats/providers/provider-name/earthengine_stats_2025-02-03.csv
```
and will be shared with the supplied Google group.

The full list of files will be in
gs://earthengine-stats/providers/provider-name/index.txt

File contents will look like this:
```
Interval,Dataset,30-day active users
2025-01-05/2025-02-03,projects/provider-name/assets/dataset1,110
2025-01-05/2025-02-03,projects/provider-name/assets/dataset2,66
```

To read the files, use [gcloud storage](https://docs.cloud.google.com/sdk/docs/install-sdk).
There are no charges for reading these files.

## Dataset deletion protection

To protect datasets in publisher and community catalogs from accidental deletion, Earth Engine uses a special asset property called `dataset_admin_delete_protected`.

When this property is set to any value other than `pending_update`, the asset is locked and cannot be deleted. For individual images and tables, this applies directly to the asset itself. For image collections, setting this property protects all images within the collection from deletion.

If you need to delete an asset for legitimate reasons, you can temporarily disable the protection by setting `dataset_admin_delete_protected` to `pending_update`. This allows you to make necessary changes while still maintaining a safety net. You can update this property using the Code Editor UI or the `earthengine` command-line tool (using the [`asset set`](https://developers.google.com/earth-engine/guides/command_line#asset) subcommand).

The Earth Engine Data team handles setting this property for user-owned datasets once they are activated in the public catalog.
