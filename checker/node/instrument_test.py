"""Tests for instrument."""

from checker import test_utils
from checker.node import instrument
import unittest


class ValidInstrumentTest(test_utils.NodeTest):

  def setUp(self):
    super().setUp()
    self.check = instrument.Check

  def test_empty_catalog(self):
    self.assert_catalog({})

  def test_empty_collection(self):
    self.assert_collection({})

  def test_empty_summaries(self):
    self.assert_collection({'summaries': {}})

  def test_summaries_not_dict(self):
    self.assert_collection({'summaries': 'not a dict'})

  def test_one_of_each(self):
    self.assert_collection({'summaries': {
        'platform': ['Platform_1'],
        'instruments': ['Intruments_1'],
        'constellation': ['Constellation_1']}})
  def test_two_of_each(self):
    self.assert_collection({'summaries': {
        'platform': ['Platform_1', 'Platform_2'],
        'instruments': ['Intruments_1', 'Intruments_2'],
        'constellation': ['Constellation_1', 'Constellation_2']}})


class ErrorInstrumentTest(test_utils.NodeTest):

  def setUp(self):
    super().setUp()
    self.check = instrument.Check

  def test_platform_not_list(self):
    self.assert_collection(
        {'summaries': {'platform': 'not a list'}},
        'platform must be a list')

  def test_platform_empty(self):
    self.assert_collection(
        {'summaries': {'platform': []}},
        'platform must have at least 1 entry')

  def test_platforms_not_str(self):
    self.assert_collection(
        {'summaries': {'platform': [123]}},
        'platforms must be a str')

  def test_platforms_not_valid(self):
    self.assert_collection(
        {'summaries': {'platform': ['must start with capital']}},
        '"must start with capital" not valid')

  def test_too_many_platforms(self):
    self.assert_collection(
        {'summaries': {'platform': [
            'P1', 'P2', 'P3', 'P4', 'P5', 'P6', 'P7', 'P8']}},
        'Too many platforms: 8 > 7')

  def test_platforms_not_sorted(self):
    self.assert_collection(
        {'summaries': {'platform': ['P2', 'P1']}},
        'platform entries must be sorted')

  def test_platforms_duplicates(self):
    self.assert_collection(
        {'summaries': {'platform': ['P1', 'P1']}}, 'platform duplicates: P1')

  def test_instrument_not_list(self):
    self.assert_collection(
        {'summaries': {'instruments': 'not a list'}},
        'instruments must be a list')

  def test_instrument_empty(self):
    self.assert_collection(
        {'summaries': {'instruments': []}},
        'instruments must have at least 1 entry')

  def test_instruments_not_str(self):
    self.assert_collection(
        {'summaries': {'instruments': [123]}},
        'instruments must be a str')

  def test_instruments_not_valid(self):
    self.assert_collection(
        {'summaries': {'instruments': ['must start with capital']}},
        '"must start with capital" not valid')

  def test_too_many_instruments(self):
    self.assert_collection(
        {'summaries': {'instruments': [
            'I1', 'I2', 'I3', 'I4', 'I5', 'I6', 'I7', 'I8']}},
        'Too many instruments: 8 > 7')

  def test_instruments_not_sorted(self):
    self.assert_collection(
        {'summaries': {'instruments': ['P2', 'P1']}},
        'instruments entries must be sorted')

  def test_instruments_duplicates(self):
    self.assert_collection(
        {'summaries': {'instruments': ['P1', 'P1']}},
        'instruments duplicates: P1')

  def test_constellation_not_list(self):
    self.assert_collection(
        {'summaries': {'constellation': 'not a list'}},
        'constellation must be a list')

  def test_constellation_empty(self):
    self.assert_collection(
        {'summaries': {'constellation': []}},
        'constellation must have at least 1 entry')

  def test_constellations_not_str(self):
    self.assert_collection(
        {'summaries': {'constellation': [123]}},
        'constellations must be a str')

  def test_constellations_not_valid(self):
    self.assert_collection(
        {'summaries': {'constellation': ['must start with capital']}},
        '"must start with capital" not valid')

  def test_too_many_constellations(self):
    self.assert_collection(
        {'summaries': {'constellation': [
            'C1', 'C2', 'C3', 'C4', 'C5', 'C6', 'C7', 'C8']}},
        'Too many constellations: 8 > 7')

  def test_constellations_not_sorted(self):
    self.assert_collection(
        {'summaries': {'constellation': ['P2', 'P1']}},
        'constellation entries must be sorted')

  def test_constellations_duplicates(self):
    self.assert_collection(
        {'summaries': {'constellation': ['P1', 'P1']}},
        'constellation duplicates: P1')

  def test_mission_not_allowed(self):
    self.assert_collection(
        {'summaries': {'mission': ['Mission_1']}},
        'mission not currently allowed')


if __name__ == '__main__':
  unittest.main()
