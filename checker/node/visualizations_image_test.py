"""Tests for visualizations_image."""

from absl.testing import absltest
from checker import stac
from checker import test_utils
from checker.node import visualizations_image

IMAGE_COLLECTION = stac.GeeType.IMAGE_COLLECTION


class ValidVisualizationsImageTest(test_utils.NodeTest):

  def setUp(self):
    super().setUp()
    self.check = visualizations_image.Check

  def test_empty(self):
    self.assert_collection({})

  def test_summaries_not_a_dict(self):
    self.assert_collection({'summaries': 'not a dict'})

  def test_no_bands(self):
    self.assert_collection({'summaries': {}})

  def test_bands_not_list(self):
    self.assert_collection({'summaries': {'eo:bands': 'not a list'}})

  def test_band_not_a_dict(self):
    self.assert_collection({'summaries': {'eo:bands': ['not a dict']}})

  def test_band_name_not_str(self):
    self.assert_collection({'summaries': {'eo:bands': [{'name': 123}]}})

  def test_no_visualizations(self):
    self.assert_collection({'summaries': {'eo:bands': [{'name': 'B1'}]}})

  def test_visualizations_not_list(self):
    self.assert_collection({'summaries': {
        'eo:bands': [{'name': 'B1'}], 'gee:visualizations': 234}})

  def test_visualizations_empty_list(self):
    self.assert_collection({'summaries': {
        'eo:bands': [{'name': 'B1'}], 'gee:visualizations': []}})

  def test_visualization_not_dict(self):
    self.assert_collection({'summaries': {
        'eo:bands': [{'name': 'B1'}], 'gee:visualizations': [1, 2]}})

  def test_visualization_empty_dict(self):
    self.assert_collection({'summaries': {
        'eo:bands': [{'name': 'B1'}], 'gee:visualizations': [{}]}})

  def test_1_band(self):
    self.assert_collection({'summaries': {
        'eo:bands': [{'name': 'B1'}],
        'gee:visualizations': [{
            'display_name': 'Display name',
            'image_visualization': {'band_vis': {'bands': ['B1']}}}]}})

  def test_3_band(self):
    self.assert_collection({'summaries': {
        'eo:bands': [{'name': 'B1'}, {'name': 'B2'}, {'name': 'B3'}],
        'gee:visualizations': [{
            'display_name': 'Display name',
            'image_visualization': {'band_vis': {
                'bands': ['B2', 'B3', 'B1']}}}]}})

  def test_gamma_gain(self):
    image_visualization = {'band_vis': {
        'gamma': [1.2], 'gain': [600.0], 'bands': ['B3', 'B2', 'B1']}}
    self.assert_collection({'summaries': {
        'eo:bands': [{'name': 'B1'}, {'name': 'B2'}, {'name': 'B3'}],
        'gee:visualizations': [{
            'display_name': 'Display name',
            'image_visualization': image_visualization}]}})

  def test_bias(self):
    self.assert_collection({'summaries': {
        'eo:bands': [{'name': 'B1'}],
        'gee:visualizations': [{
            'display_name': 'Display name',
            'image_visualization': {'band_vis': {
                'bands': ['B1'], 'gain': [0.1], 'bias': [456]}}}]}})

  def test_palette_hex(self):
    self.assert_collection({'summaries': {
        'eo:bands': [{'name': 'B1'}],
        'gee:visualizations': [{
            'display_name': 'Display name',
            'image_visualization': {'band_vis': {
                'bands': ['B1'], 'palette': ['000088', 'FFFFFF']}}}]}})

  def test_palette_color_names(self):
    self.assert_collection({'summaries': {
        'eo:bands': [{'name': 'B1'}],
        'gee:visualizations': [{
            'display_name': 'Display name',
            'image_visualization': {'band_vis': {
                'bands': ['B1'], 'palette': ['darkorchid', 'cadetblue']}}}]}})


class ErrorVisualizationsImageTest(test_utils.NodeTest):

  def setUp(self):
    super().setUp()
    self.check = visualizations_image.Check

  def test_visualization_missing_image_visualization(self):
    self.assert_collection(
        {'summaries': {
            'eo:bands': [{'name': 'B1'}], 'gee:visualizations': [{1: 2}]}},
        'image must have a image_visualization')

  def test_visualization_missing_image_collection_visualization(self):
    self.assert_collection(
        {'summaries': {
            'eo:bands': [{'name': 'B1'}], 'gee:visualizations': [{1: 2}]}},
        'image_collection must have a image_visualization',
        gee_type=IMAGE_COLLECTION)

  def test_visualization_image_visualization_not_dict(self):
    self.assert_collection(
        {'summaries': {
            'eo:bands': [{'name': 'B1'}], 'gee:visualizations': [{
                'image_visualization': 'not a dict'}]}},
        'image_visualization must be a dict')

  def test_visualization_no_band(self):
    self.assert_collection(
        {'summaries': {
            'eo:bands': [{'name': 'B1'}], 'gee:visualizations': [{
                'image_visualization': {1: 2}}]}},
        'Missing band_vis in Unknown')

  def test_visualization_band_viz_not_dict(self):
    self.assert_collection(
        {'summaries': {
            'eo:bands': [{'name': 'B1'}], 'gee:visualizations': [{
                'image_visualization': {'band_vis': 'not a dict'}}]}},
        'Unknown band_vis must be a dict')

  def test_visualization_band_viz_empty_dict(self):
    self.assert_collection(
        {'summaries': {
            'eo:bands': [{'name': 'B1'}], 'gee:visualizations': [{
                'image_visualization': {'band_vis': {}}}]}},
        'Unknown band_vis must have bands')

  def test_visualization_bands_not_list(self):
    self.assert_collection(
        {'summaries': {
            'eo:bands': [{'name': 'B1'}], 'gee:visualizations': [{
                'image_visualization': {
                    'band_vis': {'bands': 'not a list'}}}]}},
        'Unknown bands must be a list')

  def test_visualization_bands_empty(self):
    self.assert_collection(
        {'summaries': {
            'eo:bands': [{'name': 'B1'}], 'gee:visualizations': [{
                'image_visualization': {'band_vis': {
                    'bands': []}}}]}},
        'There must be 1 or 3 bands')

  def test_visualization_bands_2(self):
    self.assert_collection(
        {'summaries': {
            'eo:bands': [{'name': 'B1'}], 'gee:visualizations': [{
                'image_visualization': {'band_vis': {
                    'bands': [1, 2]}}}]}},
        'There must be 1 or 3 bands')

  def test_visualization_bands_not_str(self):
    self.assert_collection(
        {'summaries': {
            'eo:bands': [{'name': 'B1'}], 'gee:visualizations': [{
                'image_visualization': {'band_vis': {
                    'bands': [1]}}}]}},
        'band not a str')

  def test_visualization_bands_not_in_eo_bands(self):
    self.assert_collection(
        {'summaries': {
            'eo:bands': [{'name': 'B1'}], 'gee:visualizations': [{
                'image_visualization': {'band_vis': {
                    'bands': ['B2']}}}]}},
        'band B2 not in eo:bands')

  def test_min_not_list(self):
    self.assert_collection(
        {'summaries': {
            'eo:bands': [{'name': 'B1'}], 'gee:visualizations': [{
                'image_visualization': {'band_vis': {
                    'bands': ['B1'], 'min': 'not a list'}}}]}},
        'bands must be a list')

  def test_min_empty_list(self):
    self.assert_collection(
        {'summaries': {
            'eo:bands': [{'name': 'B1'}], 'gee:visualizations': [{
                'image_visualization': {'band_vis': {
                    'bands': ['B1'], 'min': []}}}]}},
        'min must be length 1')

  def test_min_1_or_3(self):
    self.assert_collection(
        {'summaries': {
            'eo:bands': [{'name': 'B1'}, {'name': 'B2'}],
            'gee:visualizations': [{
                'image_visualization': {'band_vis': {
                    'bands': ['B1', 'B2', 'B2'], 'min': []}}}]}},
        'min must be length 1 or 3')

  def test_min_not_number(self):
    self.assert_collection(
        {'summaries': {
            'eo:bands': [{'name': 'B1'}], 'gee:visualizations': [{
                'image_visualization': {'band_vis': {
                    'bands': ['B1'], 'min': ['not a number']}}}]}},
        'min values must be numbers')

  def test_max_not_list(self):
    self.assert_collection(
        {'summaries': {
            'eo:bands': [{'name': 'B1'}], 'gee:visualizations': [{
                'image_visualization': {'band_vis': {
                    'bands': ['B1'], 'max': 'not a list'}}}]}},
        'bands must be a list')

  def test_max_empty_list(self):
    self.assert_collection(
        {'summaries': {
            'eo:bands': [{'name': 'B1'}], 'gee:visualizations': [{
                'image_visualization': {'band_vis': {
                    'bands': ['B1'], 'max': []}}}]}},
        'max must be length 1')

  def test_max_1_or_3(self):
    self.assert_collection(
        {'summaries': {
            'eo:bands': [{'name': 'B1'}, {'name': 'B2'}],
            'gee:visualizations': [{
                'image_visualization': {'band_vis': {
                    'bands': ['B1', 'B2', 'B2'], 'max': []}}}]}},
        'max must be length 1 or 3')

  def test_max_not_number(self):
    self.assert_collection(
        {'summaries': {
            'eo:bands': [{'name': 'B1'}], 'gee:visualizations': [{
                'image_visualization': {'band_vis': {
                    'bands': ['B1'], 'max': ['not a number']}}}]}},
        'max values must be numbers')

  def test_min_max_different_sizes(self):
    self.assert_collection(
        {'summaries': {
            'eo:bands': [{'name': 'B1'}], 'gee:visualizations': [{
                'image_visualization': {'band_vis': {
                    'bands': ['B1'], 'min': [1], 'max': [2, 3, 4]}}}]}},
        'min and max lists must be the same size')

  def test_min_gt_max(self):
    self.assert_collection(
        {'summaries': {
            'eo:bands': [{'name': 'B1'}], 'gee:visualizations': [{
                'image_visualization': {'band_vis': {
                    'bands': ['B1'], 'min': [2], 'max': [1]}}}]}},
        'min > max: 2 > 1')

  def test_gamma_not_list(self):
    self.assert_collection(
        {'summaries': {
            'eo:bands': [{'name': 'B1'}], 'gee:visualizations': [{
                'image_visualization': {'band_vis': {
                    'bands': ['B1'], 'min': [1], 'gamma': 'not a list'}}}]}},
        'gamma must be a list')

  def test_gamma_empty_list(self):
    self.assert_collection(
        {'summaries': {
            'eo:bands': [{'name': 'B1'}], 'gee:visualizations': [{
                'image_visualization': {'band_vis': {
                    'bands': ['B1'], 'min': [1], 'gamma': []}}}]}},
        'gamma must be length 1')

  def test_gamma_not_a_number(self):
    self.assert_collection(
        {'summaries': {
            'eo:bands': [{'name': 'B1'}], 'gee:visualizations': [{
                'image_visualization': {'band_vis': {
                    'bands': ['B1'], 'min': [1],
                    'gamma': ['not a number']}}}]}},
        'gamma value must be a number')

  def test_gamma_not_one_element(self):
    self.assert_collection(
        {'summaries': {
            'eo:bands': [{'name': 'B1'}], 'gee:visualizations': [{
                'image_visualization': {'band_vis': {
                    'bands': ['B1'], 'min': [1], 'gamma': [1, 2, 3]}}}]}},
        'gamma must be length 1')

  def test_gamma_too_small(self):
    self.assert_collection(
        {'summaries': {
            'eo:bands': [{'name': 'B1'}], 'gee:visualizations': [{
                'image_visualization': {'band_vis': {
                    'bands': ['B1'], 'min': [1], 'gamma': [0.9]}}}]}},
        'gamma must be in the range of [1..5]')

  def test_gamma_too_large(self):
    self.assert_collection(
        {'summaries': {
            'eo:bands': [{'name': 'B1'}], 'gee:visualizations': [{
                'image_visualization': {'band_vis': {
                    'bands': ['B1'], 'min': [1], 'gamma': [5.01]}}}]}},
        'gamma must be in the range of [1..5]')

  def test_gain_not_list(self):
    self.assert_collection(
        {'summaries': {
            'eo:bands': [{'name': 'B1'}], 'gee:visualizations': [{
                'image_visualization': {'band_vis': {
                    'bands': ['B1'], 'min': [1], 'gain': 'not a list'}}}]}},
        'gain must be a list')

  def test_gain_empty_list(self):
    self.assert_collection(
        {'summaries': {
            'eo:bands': [{'name': 'B1'}], 'gee:visualizations': [{
                'image_visualization': {'band_vis': {
                    'bands': ['B1'], 'min': [1], 'gain': []}}}]}},
        'gain must be length 1 or 3')

  def test_gain_length_not_1_or_3(self):
    self.assert_collection(
        {'summaries': {
            'eo:bands': [{'name': 'B1'}], 'gee:visualizations': [{
                'image_visualization': {'band_vis': {
                    'bands': ['B1'], 'min': [1], 'gain': [1, 2]}}}]}},
        'gain must be length 1 or 3')

  def test_gain_length_not_1_for_1_band_vis(self):
    self.assert_collection(
        {'summaries': {
            'eo:bands': [{'name': 'B1'}], 'gee:visualizations': [{
                'image_visualization': {'band_vis': {
                    'bands': ['B1'], 'min': [1], 'gain': [1, 2, 3]}}}]}},
        'gain must be length 1 for 1 band')

  def test_gain_not_number(self):
    self.assert_collection(
        {'summaries': {
            'eo:bands': [{'name': 'B1'}], 'gee:visualizations': [{
                'image_visualization': {'band_vis': {
                    'bands': ['B1'], 'min': [1], 'gain': ['not a number']}}}]}},
        'gain value must be a number')

  def test_gain_too_small(self):
    self.assert_collection(
        {'summaries': {
            'eo:bands': [{'name': 'B1'}], 'gee:visualizations': [{
                'image_visualization': {'band_vis': {
                    'bands': ['B1'], 'min': [1], 'gain': [0]}}}]}},
        'gain must be in the range of [0.0001..1000]',
        gee_type=IMAGE_COLLECTION)

  def test_gain_too_large(self):
    self.assert_collection(
        {'summaries': {
            'eo:bands': [{'name': 'B1'}], 'gee:visualizations': [{
                'image_visualization': {'band_vis': {
                    'bands': ['B1'], 'min': [1], 'gain': [1001]}}}]}},
        'gain must be in the range of [0.0001..1000]',
        gee_type=IMAGE_COLLECTION)

  def test_bias_not_list(self):
    self.assert_collection(
        {'summaries': {
            'eo:bands': [{'name': 'B1'}], 'gee:visualizations': [{
                'image_visualization': {'band_vis': {
                    'bands': ['B1'], 'min': [1], 'bias': 'not a list'}}}]}},
        'bias must be a list')

  def test_bias_empty_list(self):
    self.assert_collection(
        {'summaries': {
            'eo:bands': [{'name': 'B1'}], 'gee:visualizations': [{
                'image_visualization': {'band_vis': {
                    'bands': ['B1'], 'min': [1], 'bias': []}}}]}},
        'bias must be length 1')

  def test_bias_length_not_1(self):
    self.assert_collection(
        {'summaries': {
            'eo:bands': [{'name': 'B1'}, {'name': 'B2'}, {'name': 'B3'}],
            'gee:visualizations': [{
                'image_visualization': {'band_vis': {
                    'bands': ['B1', 'B2', 'B3'],
                    'min': [1, 2, 3],
                    'bias': [4, 5, 6]}}}]}}, 'bias must be length 1')

  def test_bias_not_number(self):
    self.assert_collection(
        {'summaries': {
            'eo:bands': [{'name': 'B1'}], 'gee:visualizations': [{
                'image_visualization': {'band_vis': {
                    'bands': ['B1'], 'min': [1], 'bias': ['not a number']}}}]}},
        'bias value must be a number')

  def test_palette_not_1_band(self):
    self.assert_collection(
        {'summaries': {
            'eo:bands': [{'name': 'B1'}, {'name': 'B2'}, {'name': 'B3'}],
            'gee:visualizations': [{
                'image_visualization': {'band_vis': {
                    'bands': ['B1', 'B2', 'B3'],
                    'min': [1, 2, 3],
                    'palette': ['000088', 'ffffff']}}}]}},
        'palette can only have one band')

  def test_palette_too_large(self):
    palette = [f'0000{c:02x}' for c in range(251)]
    self.assert_collection(
        {'summaries': {
            'eo:bands': [{'name': 'B1'}],
            'gee:visualizations': [{
                'image_visualization': {'band_vis': {
                    'bands': ['B1'],
                    'min': [1],
                    'palette': palette}}}]}}, 'palette size should be <= 250')

  def test_palette_bad_color(self):
    self.assert_collection(
        {'summaries': {
            'eo:bands': [{'name': 'B1'}],
            'gee:visualizations': [{
                'image_visualization': {'band_vis': {
                    'bands': ['B1'],
                    'min': [1],
                    'palette': ['red', 'bogus']}}}]}},
        'color must be a 6 character hex or color name - '
        'found "bogus"',
        gee_type=IMAGE_COLLECTION)

  def test_palette_hex_with_alpha(self):
    self.assert_collection(
        {'summaries': {
            'eo:bands': [{'name': 'B1'}],
            'gee:visualizations': [{
                'display_name': 'Display name',
                'image_visualization': {'band_vis': {
                    'bands': ['B1'], 'palette': ['violet', 'ff000088']}}}]}},
        'color must be a 6 character hex or color name - found "ff000088"')

  def test_palette_color_name_and_hex(self):
    self.assert_collection(
        {'summaries': {
            'eo:bands': [{'name': 'B1'}],
            'gee:visualizations': [{
                'image_visualization': {'band_vis': {
                    'bands': ['B1'],
                    'min': [1],
                    'palette': ['violet', 'aa22ff']}}}]}},
        'colors must be all hex or all color names. Found a mix of both')



if __name__ == '__main__':
  absltest.main()
