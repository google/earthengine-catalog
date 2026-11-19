"""Tests for the share_alike node check."""

from unittest import mock

from absl.testing import absltest
from checker import stac
from checker import test_utils
from checker.node import share_alike


class ShareAlikeTest(test_utils.NodeTest):

  def setUp(self):
    super().setUp()
    self.check = share_alike.Check  # pyrefly: ignore[bad-assignment]

  def test_valid_real_member_cc_by_sa(self):
    self.assert_collection(
        {'license': 'CC-BY-SA-4.0'}, dataset_id='GFW/GFF/V1/fishing_hours'
    )

  def test_valid_real_member_nc_sa(self):
    self.assert_collection(
        {'license': 'CC-BY-NC-SA-4.0'}, dataset_id='CSIRO/BHI/v4'
    )

  def test_valid_real_member_odbl(self):
    self.assert_collection(
        {'license': 'ODbL-1.0'}, dataset_id='overture-maps/places_place'
    )

  def test_valid_real_member_prefix(self):
    self.assert_collection(
        {'license': 'CC-BY-NC-SA-4.0'},
        dataset_id='projects/malariaatlasproject/assets/EVI_v061/1km/Annual',
    )

  def test_valid_not_member_proprietary(self):
    self.assert_collection({'license': 'proprietary'})

  def test_valid_not_member_cc_by(self):
    self.assert_collection({'license': 'CC-BY-4.0'})

  def test_valid_catalog(self):
    self.assert_catalog({})

  def test_collection_without_license(self):
    self.assert_collection({})

  def test_collection_with_non_string_license(self):
    self.assert_collection({'license': 123})

  @mock.patch.object(stac, 'is_in_share_alike', return_value=False)
  def test_not_in_list(self, mock_is_in_share_alike):
    del mock_is_in_share_alike  # not used
    self.assert_collection(
        {'license': 'CC-BY-SA-4.0'},
        'Dataset with share-alike license must be listed in '
        'share_alike_datasets.jsonnet',
    )

  @mock.patch.object(stac, 'is_in_share_alike', return_value=False)
  def test_not_in_list_nc_sa(self, mock_is_in_share_alike):
    del mock_is_in_share_alike  # not used
    self.assert_collection(
        {'license': 'CC-BY-NC-SA-4.0'},
        'Dataset with share-alike license must be listed in '
        'share_alike_datasets.jsonnet',
    )

  @mock.patch.object(stac, 'is_in_share_alike', return_value=False)
  def test_not_in_list_odbl(self, mock_is_in_share_alike):
    del mock_is_in_share_alike  # not used
    self.assert_collection(
        {'license': 'ODbL-1.0'},
        'Dataset with share-alike license must be listed in '
        'share_alike_datasets.jsonnet',
    )

  @mock.patch.object(stac, 'is_in_share_alike', return_value=True)
  def test_in_list_but_should_not_be(self, mock_is_in_share_alike):
    del mock_is_in_share_alike  # not used
    self.assert_collection(
        {'license': 'CC-BY-4.0'}, 'Cannot be in share-alike dataset list'
    )

  @mock.patch.object(stac, 'is_in_share_alike', return_value=True)
  def test_catalog_in_list(self, mock_is_in_share_alike):
    del mock_is_in_share_alike  # not used
    self.assert_catalog({}, 'Catalog cannot be in share-alike dataset list')


if __name__ == '__main__':
  absltest.main()
