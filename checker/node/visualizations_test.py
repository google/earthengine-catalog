"""Tests for visualizations."""

from checker import stac
from checker import test_utils
from checker.node import visualizations
from absl.testing import absltest

TABLE = stac.GeeType.TABLE


class BboxTest(absltest.TestCase):

  def test_valid(self):
    stac_data = {
        'extent': {'spatial': {'bbox': [[-1, -2, 3, 4]]}}}
    self.assertEqual((-1, -2, 3, 4), visualizations.get_bbox(stac_data))

  def test_empty(self):
    self.assertIsNone(visualizations.get_bbox({}))

  def test_extent_empty(self):
    self.assertIsNone(visualizations.get_bbox({'extent': {}}))

  def test_extent_not_a_dict(self):
    self.assertIsNone(visualizations.get_bbox({'extent': 'not a dict'}))

  def test_spatial_empty(self):
    self.assertIsNone(visualizations.get_bbox({'extent': {'spatial': {}}}))

  def test_spatial_not_a_dict(self):
    self.assertIsNone(visualizations.get_bbox(
        {'extent': {'spatial': 'not a dict'}}))

  def test_bbox_empty(self):
    self.assertIsNone(visualizations.get_bbox(
        {'extent': {'spatial': {'bbox': []}}}))

  def test_bbox_not_a_list(self):
    self.assertIsNone(visualizations.get_bbox(
        {'extent': {'spatial': {'bbox': 'not a list'}}}))

  def test_bbox_empty2(self):
    self.assertIsNone(visualizations.get_bbox(
        {'extent': {'spatial': {'bbox': [[]]}}}))

  def test_bbox_not_a_list2(self):
    self.assertIsNone(visualizations.get_bbox(
        {'extent': {'spatial': {'bbox': ['not a list']}}}))

  def test_wrong_number_coords(self):
    self.assertIsNone(visualizations.get_bbox(
        {'extent': {'spatial': {'bbox': [[-1, -2]]}}}))


class ValidVisualizationsTest(test_utils.NodeTest):

  def setUp(self):
    super().setUp()
    self.check = visualizations.Check

  def test_no_summaries(self):
    self.assert_collection({})

  def test_summaries_not_dict(self):
    self.assert_collection({'summaries': 'not a dict'})

  def test_image_visualization(self):
    self.assert_collection(
        {'summaries': {'gee:visualizations': [{
            'display_name': 'Display name',
            'image_visualization': {},
            'lookat': {'lat': 1, 'lon': 2, 'zoom': 3}}]}})

  def test_table_visualization(self):
    self.assert_collection(
        {'summaries': {'gee:visualizations': [{
            'display_name': 'Display name',
            'table_visualization': {},
            'lookat': {'lat': 1, 'lon': 2, 'zoom': 3}}]}},
        gee_type=TABLE)

  def test_polygon_visualization(self):
    self.assert_collection(
        {'summaries': {'gee:visualizations': [{
            'display_name': 'Display name',
            'polygon_visualization': {},
            'lookat': {'lat': 1, 'lon': 2, 'zoom': 3}}]}},
        gee_type=TABLE)

  def test_missing_lookat_exception(self):
    self.assert_collection(
        {'summaries': {'gee:visualizations': [{
            'display_name': 'Display name',
            'image_visualization': {}}]}},
        dataset_id='NASA_USDA/HSL/soil_moisture')


class ErrorsVisualizationsTest(test_utils.NodeTest):

  def setUp(self):
    super().setUp()
    self.check = visualizations.Check

  def test_missing_visualizations(self):
    self.assert_collection(
        {'summaries': {}}, 'Missing gee:visualizations field')

  def test_visualizations_not_list(self):
    self.assert_collection(
        {'summaries': {'gee:visualizations': 'not a list'}},
        'gee:visualizations must be a list')

  def test_visualizations_empty_list(self):
    self.assert_collection(
        {'summaries': {'gee:visualizations': []}},
        'gee:visualizations must have at least 1 entry')

  def test_visualizations_too_many(self):
    vis = {
        'display_name': 'Display name',
        'image_visualization': {},
        'lookat': {'lat': 1, 'lon': 2, 'zoom': 3}}
    self.assert_collection(
        {'summaries': {'gee:visualizations': [vis] * 51}},
        'gee:visualizations has too many entries: 51',
    )

  def test_visualization_not_dict(self):
    self.assert_collection(
        {'summaries': {'gee:visualizations': ['not a dict']}},
        'Visualization must be a dict')

  def test_missing_display_name(self):
    self.assert_collection(
        {'summaries': {'gee:visualizations': [{
            'image_visualization': {},
            'lookat': {'lat': 1, 'lon': 2, 'zoom': 3}}]}},
        'Visualization must have a display_name')

  def test_display_name_not_str(self):
    self.assert_collection(
        {'summaries': {'gee:visualizations': [{
            'display_name': 123,
            'image_visualization': {},
            'lookat': {'lat': 1, 'lon': 2, 'zoom': 3}}]}},
        'display_name must be a str')

  def test_display_name_invalid_character(self):
    self.assert_collection(
        {'summaries': {'gee:visualizations': [{
            'display_name': '++++',
            'image_visualization': {},
            'lookat': {'lat': 1, 'lon': 2, 'zoom': 3}}]}},
        'Invalid display_name: "++++"')

  def test_display_name_too_short(self):
    self.assert_collection(
        {'summaries': {'gee:visualizations': [{
            'display_name': 'a',
            'image_visualization': {},
            'lookat': {'lat': 1, 'lon': 2, 'zoom': 3}}]}},
        'Invalid display_name: "a"')

  def test_display_name_too_long(self):
    display_name = 'b' * 72
    self.assert_collection(
        {'summaries': {'gee:visualizations': [{
            'display_name': display_name,
            'image_visualization': {},
            'lookat': {'lat': 1, 'lon': 2, 'zoom': 3}}]}},
        f'Invalid display_name: "{display_name}"')

  def test_missing_lookat(self):
    self.assert_collection(
        {'summaries': {'gee:visualizations': [{
            'display_name': 'abc',
            'image_visualization': {}}]}},
        '"abc" missing lookat')

  def test_lookat_not_dict(self):
    self.assert_collection(
        {'summaries': {'gee:visualizations': [{
            'display_name': 'bcd',
            'image_visualization': {},
            'lookat': 'not a dict'}]}},
        '"bcd" lookat not a dict')

  def test_lookat_missing_lat(self):
    self.assert_collection(
        {'summaries': {'gee:visualizations': [{
            'display_name': 'bcd',
            'image_visualization': {},
            'lookat': {'lon': 2, 'zoom': 3}}]}},
        'lookat must have lon, lat, and zoom')

  def test_lookat_missing_lon(self):
    self.assert_collection(
        {'summaries': {'gee:visualizations': [{
            'display_name': 'bcd',
            'image_visualization': {},
            'lookat': {'lat': 1, 'zoom': 3}}]}},
        'lookat must have lon, lat, and zoom')

  def test_lookat_missing_zoom(self):
    self.assert_collection(
        {'summaries': {'gee:visualizations': [{
            'display_name': 'bcd',
            'image_visualization': {},
            'lookat': {'lat': 1, 'lon': 2}}]}},
        'lookat must have lon, lat, and zoom')

  def test_lookat_missing_lat_not_number(self):
    self.assert_collection(
        {'summaries': {'gee:visualizations': [{
            'display_name': 'bcd',
            'image_visualization': {},
            'lookat': {'lat': '9', 'lon': 2, 'zoom': 3}}]}},
        'lon and lat must be floats and zoom must be an int: 2, 9, 3')

  def test_lookat_lon_not_number(self):
    self.assert_collection(
        {'summaries': {'gee:visualizations': [{
            'display_name': 'bcd',
            'image_visualization': {},
            'lookat': {'lat': 1, 'lon': '8', 'zoom': 3}}]}},
        'lon and lat must be floats and zoom must be an int: 8, 1, 3')

  def test_lookat_zoom_not_number(self):
    self.assert_collection(
        {'summaries': {'gee:visualizations': [{
            'display_name': 'bcd',
            'image_visualization': {},
            'lookat': {'lat': 1, 'lon': 2, 'zoom': '4'}}]}},
        'lon and lat must be floats and zoom must be an int: 2, 1, 4')

  def test_lookat_missing_lat_too_low(self):
    self.assert_collection(
        {'summaries': {'gee:visualizations': [{
            'display_name': 'bcd',
            'image_visualization': {},
            'lookat': {'lat': -90.01, 'lon': 2, 'zoom': 3}}]}},
        'lat must be in [-90, 90]')

  def test_lookat_missing_lat_too_high(self):
    self.assert_collection(
        {'summaries': {'gee:visualizations': [{
            'display_name': 'bcd',
            'image_visualization': {},
            'lookat': {'lat': 90.01, 'lon': 2, 'zoom': 3}}]}},
        'lat must be in [-90, 90]')

  def test_lookat_missing_lon_too_low(self):
    self.assert_collection(
        {'summaries': {'gee:visualizations': [{
            'display_name': 'bcd',
            'image_visualization': {},
            'lookat': {'lat': 3, 'lon': -180.1, 'zoom': 3}}]}},
        'lon must be in [-180, 180]')

  def test_lookat_missing_lon_too_high(self):
    self.assert_collection(
        {'summaries': {'gee:visualizations': [{
            'display_name': 'bcd',
            'image_visualization': {},
            'lookat': {'lat': 3, 'lon': 180.1, 'zoom': 3}}]}},
        'lon must be in [-180, 180]')

  def test_lookat_missing_zoom_too_small(self):
    self.assert_collection(
        {'summaries': {'gee:visualizations': [{
            'display_name': 'bcd',
            'image_visualization': {},
            'lookat': {'lat': 3, 'lon': -4, 'zoom': 0}}]}},
        'zoom must be in [1, 19]; found: 0')

  def test_lookat_missing_zoom_too_large(self):
    self.assert_collection(
        {'summaries': {'gee:visualizations': [{
            'display_name': 'bcd',
            'image_visualization': {},
            'lookat': {'lat': 3, 'lon': -4, 'zoom': 20}}]}},
        'zoom must be in [1, 19]; found: 20')

  def test_lookat_bbox_zoom_outside_lat_below(self):
    self.assert_collection(
        {
            'extent': {'spatial': {'bbox': [[-120, -45, 130, 45]]}},
            'summaries': {'gee:visualizations': [{
                'display_name': 'bcd',
                'image_visualization': {},
                'lookat': {'lat': -50, 'lon': -4, 'zoom': 1}}]}},
        'lat must be in (-45..45)')

  def test_lookat_bbox_zoom_outside_lat_above(self):
    self.assert_collection(
        {
            'extent': {'spatial': {'bbox': [[-120, -45, 130, 45]]}},
            'summaries': {'gee:visualizations': [{
                'display_name': 'bcd',
                'image_visualization': {},
                'lookat': {'lat': 62, 'lon': -4, 'zoom': 1}}]}},
        'lat must be in (-45..45)')

  def test_lookat_bbox_zoom_outside_lon_below(self):
    self.assert_collection(
        {
            'extent': {'spatial': {'bbox': [[-120, -45, 130, 45]]}},
            'summaries': {'gee:visualizations': [{
                'display_name': 'bcd',
                'image_visualization': {},
                'lookat': {'lat': 2, 'lon': -167, 'zoom': 1}}]}},
        'lon must be in (-120..130)')

  def test_lookat_bbox_zoom_outside_lon_above(self):
    self.assert_collection(
        {
            'extent': {'spatial': {'bbox': [[-120, -45, 130, 45]]}},
            'summaries': {'gee:visualizations': [{
                'display_name': 'bcd',
                'image_visualization': {},
                'lookat': {'lat': 2, 'lon': 158, 'zoom': 1}}]}},
        'lon must be in (-120..130)')

  def test_image_with_polygon_visualization(self):
    self.assert_collection(
        {'summaries': {'gee:visualizations': [{
            'display_name': 'Display name',
            'polygon_visualization': {},
            'lookat': {'lat': 1, 'lon': 2, 'zoom': 3}}]}},
        'image must have an image_visualization')

  def test_image_with_table_visualization(self):
    self.assert_collection(
        {'summaries': {'gee:visualizations': [{
            'display_name': 'Display name',
            'table_visualization': {},
            'lookat': {'lat': 1, 'lon': 2, 'zoom': 3}}]}},
        'image must have an image_visualization')

  def test_table_with_image_visualization(self):
    self.assert_collection(
        {'summaries': {'gee:visualizations': [{
            'display_name': 'Display name',
            'image_visualization': {},
            'lookat': {'lat': 1, 'lon': 2, 'zoom': 3}}]}},
        'table must have one of polygon_visualization or table_visualization',
        gee_type=TABLE)

  def test_table_with_both_polygon_and_table_visualization(self):
    self.assert_collection(
        {'summaries': {'gee:visualizations': [{
            'display_name': 'Display name',
            'polygon_visualization': {},
            'table_visualization': {},
            'lookat': {'lat': 1, 'lon': 2, 'zoom': 3}}]}},
        'Other fields must be one of [\'image_visualization\', '
        '\'polygon_visualization\', \'table_visualization\'] - '
        'found: [\'polygon_visualization\', \'table_visualization\']',
        gee_type=TABLE)

  def test_extra_field(self):
    self.assert_collection(
        {'summaries': {'gee:visualizations': [{
            'display_name': 'Display name',
            'table_visualization': {},
            'bogus': True,
            'lookat': {'lat': 1, 'lon': 2, 'zoom': 3}}]}},
        'Other fields must be one of [\'image_visualization\', '
        '\'polygon_visualization\', \'table_visualization\'] - '
        'found: [\'bogus\', \'table_visualization\']',
        gee_type=TABLE)


if __name__ == '__main__':
  absltest.main()
