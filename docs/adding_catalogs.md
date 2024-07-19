# Adding new publisher or community catalogs

## Steps to add a new catalog

1.  Make sure the
    [eligibility criteria](https://developers.google.com/earth-engine/reference/publisher_data_catalogs_eligibility)
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
        with the followng fields:

    ```
      {
          "id": "<yourproject>",
          "homeBucket": "projects/<yourproject>",
          "name": "<Catalog name>",
          "description": "<Catalog description>",
          "type": "PUBLISHER",
          "link": "<Link to the external publisher page>",
          "contactDisplay": "<Contact display>",
          "contactLink": "<Contact mailto: or https: link">
    }
    ```

## Dataset deletion protection

To safeguard datasets added to publisher and community catalogs, Earth Engine
uses a special asset property called `dataset_admin_delete_protected`. This
property determines whether assets added to the catalog can be deleted.

* **Protected Datasets:** Datasets with the `dataset_admin_delete_protected`
 property set (to any value other than `pending_update`) are protected.
 Attempts to delete these datasets will be blocked.

* **Asset types**. If this property is set on individual images and tables,
 they cannot be deleted. If it's set on image collections, images in those
 collections cannot be deleted.

* **Temporary Disabling:**  The protection can be temporarily disabled by
 setting the `dataset_admin_delete_protected` property to `pending_update`.
 This allows intentional changes while still guarding against accidental
 deletion. You can set the property via the `earthengine` command line tool
(using the
["asset set"](https://developers.google.com/earth-engine/guides/command_line#asset)
subcommand) or in the Code Editor UI.

* **Administrative Management:** The Earth Engine Data team sets this
  property for user-owned datasets listed in the data catalog once these
  datasets have been activated.
