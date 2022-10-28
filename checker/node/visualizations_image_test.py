"""Tests for visualizations_image."""

import pathlib

from checker import stac
from checker.node import visualizations_image
import unittest

Check = visualizations_image.Check

COLLECTION = stac.StacType.COLLECTION
IMAGE = stac.GeeType.IMAGE
IMAGE_COLLECTION = stac.GeeType.IMAGE_COLLECTION
TABLE = stac.GeeType.TABLE

ID = 'a/collection'
FILE_PATH = pathlib.Path('test/path/should/be/ignored')


class VisualizationsImageValidTest(unittest.TestCase):

  def test_empty(self):
    stac_data = {}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    self.assertEqual(0, len(issues))

  def test_summaries_not_a_dict(self):
    stac_data = {'summaries': 'not a dict'}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    self.assertEqual(0, len(issues))

  def test_no_bands(self):
    stac_data = {'summaries': {}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    self.assertEqual(0, len(issues))

  def test_bands_not_list(self):
    stac_data = {'summaries': {'eo:bands': 'not a list'}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    self.assertEqual(0, len(issues))

  def test_band_not_a_dict(self):
    stac_data = {'summaries': {'eo:bands': ['not a dict']}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    self.assertEqual(0, len(issues))

  def test_band_name_not_str(self):
    stac_data = {'summaries': {'eo:bands': [{'name': 123}]}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    self.assertEqual(0, len(issues))

  def test_no_visualizations(self):
    stac_data = {'summaries': {'eo:bands': [{'name': 'B1'}]}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    self.assertEqual(0, len(issues))

  def test_visualizations_not_list(self):
    stac_data = {'summaries': {
        'eo:bands': [{'name': 'B1'}], 'gee:visualizations': 234}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    self.assertEqual(0, len(issues))

  def test_visualizations_empty_list(self):
    stac_data = {'summaries': {
        'eo:bands': [{'name': 'B1'}], 'gee:visualizations': []}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    self.assertEqual(0, len(issues))

  def test_visualization_not_dict(self):
    stac_data = {'summaries': {
        'eo:bands': [{'name': 'B1'}], 'gee:visualizations': [1, 2]}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    self.assertEqual(0, len(issues))

  def test_visualization_empty_dict(self):
    stac_data = {'summaries': {
        'eo:bands': [{'name': 'B1'}], 'gee:visualizations': [{}]}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    self.assertEqual(0, len(issues))

  def test_1_band(self):
    stac_data = {'summaries': {
        'eo:bands': [{'name': 'B1'}],
        'gee:visualizations': [{
            'display_name': 'Display name',
            'image_visualization': {'band_vis': {'bands': ['B1']}}}]}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    self.assertEqual(0, len(issues))

  def test_3_band(self):
    stac_data = {'summaries': {
        'eo:bands': [{'name': 'B1'}, {'name': 'B2'}, {'name': 'B3'}],
        'gee:visualizations': [{
            'display_name': 'Display name',
            'image_visualization': {'band_vis': {
                'bands': ['B2', 'B3', 'B1']}}}]}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    self.assertEqual(0, len(issues))

  def test_gamma_gain(self):
    image_visualization = {'band_vis': {
        'gamma': [1.2], 'gain': [600.0], 'bands': ['B3', 'B2', 'B1']}}
    stac_data = {'summaries': {
        'eo:bands': [{'name': 'B1'}, {'name': 'B2'}, {'name': 'B3'}],
        'gee:visualizations': [{
            'display_name': 'Display name',
            'image_visualization': image_visualization}]}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    self.assertEqual(0, len(issues))

  def test_bias(self):
    stac_data = {'summaries': {
        'eo:bands': [{'name': 'B1'}],
        'gee:visualizations': [{
            'display_name': 'Display name',
            'image_visualization': {'band_vis': {
                'bands': ['B1'], 'gain': [0.1], 'bias': [456]}}}]}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    self.assertEqual(0, len(issues))

  def test_palette_hex(self):
    stac_data = {'summaries': {
        'eo:bands': [{'name': 'B1'}],
        'gee:visualizations': [{
            'display_name': 'Display name',
            'image_visualization': {'band_vis': {
                'bands': ['B1'], 'palette': ['000088', 'ffffff']}}}]}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    self.assertEqual(0, len(issues))

  def test_palette_hex_with_alpha(self):
    stac_data = {'summaries': {
        'eo:bands': [{'name': 'B1'}],
        'gee:visualizations': [{
            'display_name': 'Display name',
            'image_visualization': {'band_vis': {
                'bands': ['B1'], 'palette': ['ff000088', 'ff8800ff']}}}]}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    self.assertEqual(0, len(issues))

  def test_palette_color_names(self):
    stac_data = {'summaries': {
        'eo:bands': [{'name': 'B1'}],
        'gee:visualizations': [{
            'display_name': 'Display name',
            'image_visualization': {'band_vis': {
                'bands': ['B1'], 'palette': ['darkorchid', 'cadetblue']}}}]}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    self.assertEqual(0, len(issues))


class VisualizationsImageErrorsTest(unittest.TestCase):

  def test_visualization_missing_image_visualization(self):
    stac_data = {'summaries': {
        'eo:bands': [{'name': 'B1'}], 'gee:visualizations': [{1: 2}]}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'image must have a image_visualization')]
    self.assertEqual(expect, issues)

  def test_visualization_missing_image_collection_visualization(self):
    stac_data = {'summaries': {
        'eo:bands': [{'name': 'B1'}], 'gee:visualizations': [{1: 2}]}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE_COLLECTION, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(
        node, 'image_collection must have a image_visualization')]
    self.assertEqual(expect, issues)

  def test_visualization_image_visualization_not_dict(self):
    stac_data = {'summaries': {
        'eo:bands': [{'name': 'B1'}], 'gee:visualizations': [{
            'image_visualization': 'not a dict'}]}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'image_visualization must be a dict')]
    self.assertEqual(expect, issues)

  def test_visualization_no_band(self):
    stac_data = {'summaries': {
        'eo:bands': [{'name': 'B1'}], 'gee:visualizations': [{
            'image_visualization': {1: 2}}]}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE_COLLECTION, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'Missing band_vis in Unknown')]
    self.assertEqual(expect, issues)

  def test_visualization_band_viz_not_dict(self):
    stac_data = {'summaries': {
        'eo:bands': [{'name': 'B1'}], 'gee:visualizations': [{
            'image_visualization': {'band_vis': 'not a dict'}}]}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE_COLLECTION, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'Unknown band_vis must be a dict')]
    self.assertEqual(expect, issues)

  def test_visualization_band_viz_empty_dict(self):
    stac_data = {'summaries': {
        'eo:bands': [{'name': 'B1'}], 'gee:visualizations': [{
            'image_visualization': {'band_vis': {}}}]}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE_COLLECTION, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'Unknown band_vis must have bands')]
    self.assertEqual(expect, issues)

  def test_visualization_bands_not_list(self):
    stac_data = {'summaries': {
        'eo:bands': [{'name': 'B1'}], 'gee:visualizations': [{
            'image_visualization': {'band_vis': {'bands': 'not a list'}}}]}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE_COLLECTION, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'Unknown bands must be a list')]
    self.assertEqual(expect, issues)

  def test_visualization_bands_empty(self):
    stac_data = {'summaries': {
        'eo:bands': [{'name': 'B1'}], 'gee:visualizations': [{
            'image_visualization': {'band_vis': {
                'bands': []}}}]}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE_COLLECTION, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'There must be 1 or 3 bands')]
    self.assertEqual(expect, issues)

  def test_visualization_bands_2(self):
    stac_data = {'summaries': {
        'eo:bands': [{'name': 'B1'}], 'gee:visualizations': [{
            'image_visualization': {'band_vis': {
                'bands': [1, 2]}}}]}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE_COLLECTION, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'There must be 1 or 3 bands')]
    self.assertEqual(expect, issues)

  def test_visualization_bands_not_str(self):
    stac_data = {'summaries': {
        'eo:bands': [{'name': 'B1'}], 'gee:visualizations': [{
            'image_visualization': {'band_vis': {
                'bands': [1]}}}]}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE_COLLECTION, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'band not a str')]
    self.assertEqual(expect, issues)

  def test_visualization_bands_not_in_eo_bands(self):
    stac_data = {'summaries': {
        'eo:bands': [{'name': 'B1'}], 'gee:visualizations': [{
            'image_visualization': {'band_vis': {
                'bands': ['B2']}}}]}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE_COLLECTION, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'band B2 not in eo:bands')]
    self.assertEqual(expect, issues)

  def test_min_not_list(self):
    stac_data = {'summaries': {
        'eo:bands': [{'name': 'B1'}], 'gee:visualizations': [{
            'image_visualization': {'band_vis': {
                'bands': ['B1'], 'min': 'not a list'}}}]}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE_COLLECTION, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'bands must be a list')]
    self.assertEqual(expect, issues)

  def test_min_empty_list(self):
    stac_data = {'summaries': {
        'eo:bands': [{'name': 'B1'}], 'gee:visualizations': [{
            'image_visualization': {'band_vis': {
                'bands': ['B1'], 'min': []}}}]}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE_COLLECTION, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'min must be length 1')]
    self.assertEqual(expect, issues)

  def test_min_1_or_3(self):
    stac_data = {'summaries': {
        'eo:bands': [{'name': 'B1'}, {'name': 'B2'}], 'gee:visualizations': [{
            'image_visualization': {'band_vis': {
                'bands': ['B1', 'B2', 'B2'], 'min': []}}}]}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE_COLLECTION, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'min must be length 1 or 3')]
    self.assertEqual(expect, issues)

  def test_min_not_number(self):
    stac_data = {'summaries': {
        'eo:bands': [{'name': 'B1'}], 'gee:visualizations': [{
            'image_visualization': {'band_vis': {
                'bands': ['B1'], 'min': ['not a number']}}}]}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE_COLLECTION, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'min values must be numbers')]
    self.assertEqual(expect, issues)

  def test_max_not_list(self):
    stac_data = {'summaries': {
        'eo:bands': [{'name': 'B1'}], 'gee:visualizations': [{
            'image_visualization': {'band_vis': {
                'bands': ['B1'], 'max': 'not a list'}}}]}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE_COLLECTION, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'bands must be a list')]
    self.assertEqual(expect, issues)

  def test_max_empty_list(self):
    stac_data = {'summaries': {
        'eo:bands': [{'name': 'B1'}], 'gee:visualizations': [{
            'image_visualization': {'band_vis': {
                'bands': ['B1'], 'max': []}}}]}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE_COLLECTION, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'max must be length 1')]
    self.assertEqual(expect, issues)

  def test_max_1_or_3(self):
    stac_data = {'summaries': {
        'eo:bands': [{'name': 'B1'}, {'name': 'B2'}], 'gee:visualizations': [{
            'image_visualization': {'band_vis': {
                'bands': ['B1', 'B2', 'B2'], 'max': []}}}]}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE_COLLECTION, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'max must be length 1 or 3')]
    self.assertEqual(expect, issues)

  def test_max_not_number(self):
    stac_data = {'summaries': {
        'eo:bands': [{'name': 'B1'}], 'gee:visualizations': [{
            'image_visualization': {'band_vis': {
                'bands': ['B1'], 'max': ['not a number']}}}]}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE_COLLECTION, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'max values must be numbers')]
    self.assertEqual(expect, issues)

  def test_min_max_different_sizes(self):
    stac_data = {'summaries': {
        'eo:bands': [{'name': 'B1'}], 'gee:visualizations': [{
            'image_visualization': {'band_vis': {
                'bands': ['B1'], 'min': [1], 'max': [2, 3, 4]}}}]}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE_COLLECTION, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'min and max lists must be the same size')]
    self.assertEqual(expect, issues)

  def test_min_gt_max(self):
    stac_data = {'summaries': {
        'eo:bands': [{'name': 'B1'}], 'gee:visualizations': [{
            'image_visualization': {'band_vis': {
                'bands': ['B1'], 'min': [2], 'max': [1]}}}]}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE_COLLECTION, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'min > max: 2 > 1')]
    self.assertEqual(expect, issues)

  def test_gamma_not_list(self):
    stac_data = {'summaries': {
        'eo:bands': [{'name': 'B1'}], 'gee:visualizations': [{
            'image_visualization': {'band_vis': {
                'bands': ['B1'], 'min': [1], 'gamma': 'not a list'}}}]}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE_COLLECTION, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'gamma must be a list')]
    self.assertEqual(expect, issues)

  def test_gamma_empty_list(self):
    stac_data = {'summaries': {
        'eo:bands': [{'name': 'B1'}], 'gee:visualizations': [{
            'image_visualization': {'band_vis': {
                'bands': ['B1'], 'min': [1], 'gamma': []}}}]}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE_COLLECTION, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'gamma must be length 1')]
    self.assertEqual(expect, issues)

  def test_gamma_not_a_number(self):
    stac_data = {'summaries': {
        'eo:bands': [{'name': 'B1'}], 'gee:visualizations': [{
            'image_visualization': {'band_vis': {
                'bands': ['B1'], 'min': [1], 'gamma': ['not a number']}}}]}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE_COLLECTION, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'gamma value must be a number')]
    self.assertEqual(expect, issues)

  def test_gamma_not_one_element(self):
    stac_data = {'summaries': {
        'eo:bands': [{'name': 'B1'}], 'gee:visualizations': [{
            'image_visualization': {'band_vis': {
                'bands': ['B1'], 'min': [1], 'gamma': [1, 2, 3]}}}]}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE_COLLECTION, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'gamma must be length 1')]
    self.assertEqual(expect, issues)

  def test_gamma_too_small(self):
    stac_data = {'summaries': {
        'eo:bands': [{'name': 'B1'}], 'gee:visualizations': [{
            'image_visualization': {'band_vis': {
                'bands': ['B1'], 'min': [1], 'gamma': [0.9]}}}]}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE_COLLECTION, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'gamma must be in the range of 1..5')]
    self.assertEqual(expect, issues)

  def test_gamma_too_large(self):
    stac_data = {'summaries': {
        'eo:bands': [{'name': 'B1'}], 'gee:visualizations': [{
            'image_visualization': {'band_vis': {
                'bands': ['B1'], 'min': [1], 'gamma': [5.01]}}}]}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE_COLLECTION, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'gamma must be in the range of 1..5')]
    self.assertEqual(expect, issues)

  def test_gain_not_list(self):
    stac_data = {'summaries': {
        'eo:bands': [{'name': 'B1'}], 'gee:visualizations': [{
            'image_visualization': {'band_vis': {
                'bands': ['B1'], 'min': [1], 'gain': 'not a list'}}}]}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE_COLLECTION, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'gain must be a list')]
    self.assertEqual(expect, issues)

  def test_gain_empty_list(self):
    stac_data = {'summaries': {
        'eo:bands': [{'name': 'B1'}], 'gee:visualizations': [{
            'image_visualization': {'band_vis': {
                'bands': ['B1'], 'min': [1], 'gain': []}}}]}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE_COLLECTION, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'gain must be length 1 or 3')]
    self.assertEqual(expect, issues)

  def test_gain_length_not_1_or_3(self):
    stac_data = {'summaries': {
        'eo:bands': [{'name': 'B1'}], 'gee:visualizations': [{
            'image_visualization': {'band_vis': {
                'bands': ['B1'], 'min': [1], 'gain': [1, 2]}}}]}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE_COLLECTION, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'gain must be length 1 or 3')]
    self.assertEqual(expect, issues)

  def test_gain_length_not_1_for_1_band_vis(self):
    stac_data = {'summaries': {
        'eo:bands': [{'name': 'B1'}], 'gee:visualizations': [{
            'image_visualization': {'band_vis': {
                'bands': ['B1'], 'min': [1], 'gain': [1, 2, 3]}}}]}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE_COLLECTION, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'gain must be length 1 for 1 band')]
    self.assertEqual(expect, issues)

  def test_gain_not_number(self):
    stac_data = {'summaries': {
        'eo:bands': [{'name': 'B1'}], 'gee:visualizations': [{
            'image_visualization': {'band_vis': {
                'bands': ['B1'], 'min': [1], 'gain': ['not a number']}}}]}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE_COLLECTION, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'gain value must be a number')]
    self.assertEqual(expect, issues)

  def test_gain_too_small(self):
    stac_data = {'summaries': {
        'eo:bands': [{'name': 'B1'}], 'gee:visualizations': [{
            'image_visualization': {'band_vis': {
                'bands': ['B1'], 'min': [1], 'gain': [0]}}}]}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE_COLLECTION, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(
        node, 'gain must be in the range of 0.0001..1000')]
    self.assertEqual(expect, issues)

  def test_gain_too_large(self):
    stac_data = {'summaries': {
        'eo:bands': [{'name': 'B1'}], 'gee:visualizations': [{
            'image_visualization': {'band_vis': {
                'bands': ['B1'], 'min': [1], 'gain': [1001]}}}]}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE_COLLECTION, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(
        node, 'gain must be in the range of 0.0001..1000')]
    self.assertEqual(expect, issues)

  def test_bias_not_list(self):
    stac_data = {'summaries': {
        'eo:bands': [{'name': 'B1'}], 'gee:visualizations': [{
            'image_visualization': {'band_vis': {
                'bands': ['B1'], 'min': [1], 'bias': 'not a list'}}}]}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE_COLLECTION, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'bias must be a list')]
    self.assertEqual(expect, issues)

  def test_bias_empty_list(self):
    stac_data = {'summaries': {
        'eo:bands': [{'name': 'B1'}], 'gee:visualizations': [{
            'image_visualization': {'band_vis': {
                'bands': ['B1'], 'min': [1], 'bias': []}}}]}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE_COLLECTION, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'bias must be length 1')]
    self.assertEqual(expect, issues)

  def test_bias_length_not_1(self):
    stac_data = {'summaries': {
        'eo:bands': [{'name': 'B1'}, {'name': 'B2'}, {'name': 'B3'}],
        'gee:visualizations': [{
            'image_visualization': {'band_vis': {
                'bands': ['B1', 'B2', 'B3'],
                'min': [1, 2, 3],
                'bias': [4, 5, 6]}}}]}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE_COLLECTION, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'bias must be length 1')]
    self.assertEqual(expect, issues)

  def test_bias_not_number(self):
    stac_data = {'summaries': {
        'eo:bands': [{'name': 'B1'}], 'gee:visualizations': [{
            'image_visualization': {'band_vis': {
                'bands': ['B1'], 'min': [1], 'bias': ['not a number']}}}]}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE_COLLECTION, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'bias value must be a number')]
    self.assertEqual(expect, issues)

  def test_palette_not_1_band(self):
    stac_data = {'summaries': {
        'eo:bands': [{'name': 'B1'}, {'name': 'B2'}, {'name': 'B3'}],
        'gee:visualizations': [{
            'image_visualization': {'band_vis': {
                'bands': ['B1', 'B2', 'B3'],
                'min': [1, 2, 3],
                'palette': ['000088', 'ffffff']}}}]}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE_COLLECTION, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'palette can only have one band')]
    self.assertEqual(expect, issues)

  def test_palette_too_large(self):
    palette = [f'0000{c:02x}' for c in range(251)]
    stac_data = {'summaries': {
        'eo:bands': [{'name': 'B1'}],
        'gee:visualizations': [{
            'image_visualization': {'band_vis': {
                'bands': ['B1'],
                'min': [1],
                'palette': palette}}}]}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE_COLLECTION, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(node, 'palette size should be <= 250')]
    self.assertEqual(expect, issues)

  def test_palette_bad_color(self):
    stac_data = {'summaries': {
        'eo:bands': [{'name': 'B1'}],
        'gee:visualizations': [{
            'image_visualization': {'band_vis': {
                'bands': ['B1'],
                'min': [1],
                'palette': ['red', 'bogus']}}}]}}
    node = stac.Node(ID, FILE_PATH, COLLECTION, IMAGE_COLLECTION, stac_data)
    issues = list(Check.run(node))
    expect = [Check.new_issue(
        node,
        'color must be a 6 (or 8) character hex or color name - '
        'found "bogus"')]
    self.assertEqual(expect, issues)


if __name__ == '__main__':
  unittest.main()
