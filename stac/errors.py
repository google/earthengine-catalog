"""Common Earth Engine Catalog exception classes."""

from typing import Any, Optional, Union


class Error(Exception):
  """Base exception class."""

  message_template: Optional[str]
  template_args: Union[list[Any], None, tuple[Any]]

  def display_message(self) -> Optional[str]:
    if self.message_template:
      return self.message_template.format(*self.template_args)
    elif self.args:
      return self.args[0]

  def __init__(self, *args):
    if len(args) > 1:
      self.message_template = str(args[0])
      self.template_args = args[1:]
      super(Error, self).__init__(self.display_message())
    else:
      self.message_template = None
      self.template_args = None
      super(Error, self).__init__(*args)

  def __eq__(self, other):
    return (
        other is not None
        and self.message_template == other.message_template
        and self.template_args == other.template_args
    )


class InputError(Error):
  pass
