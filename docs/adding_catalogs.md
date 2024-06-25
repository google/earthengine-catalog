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

The pull request should create a new directory with the same name as
your project's Earth Engine home folder name. It should contain the
following changes:

1.  At least one dataset description. See the docs on [adding new datasets](adding_datasets.md) for details of
        writing a new dataset description.
2.  A new JSON file in the owners/ directory named `<yourproject>.jsonnet`
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
