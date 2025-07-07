load("@pip//:requirements.bzl", "requirement")
load("@rules_python//python:defs.bzl", "py_library", "py_test")

# Checks working on two or more STAC nodes at a time.

py_library(
    name = "tree",
    srcs = glob(
        ["*.py"],
        exclude = ["*_test.py"],
    ),
    visibility = ["//visibility:public"],
)

py_test(
    name = "keywords_test",
    srcs = ["keywords_test.py"],
    deps = [
        ":tree",
        "//checker:stac",
        requirement("absl-py"),
    ],
)

py_test(
    name = "parent_child_test",
    srcs = ["parent_child_test.py"],
    deps = [
        ":tree",
        "//checker:stac",
        requirement("absl-py"),
    ],
)

py_test(
    name = "title_test",
    srcs = ["title_test.py"],
    deps = [
        ":tree",
        "//checker:stac",
        requirement("absl-py"),
    ],
)

py_test(
    name = "url_id_test",
    srcs = ["url_id_test.py"],
    deps = [
        ":tree",
        "//checker:stac",
        requirement("absl-py"),
    ],
)

py_test(
    name = "version_links_test",
    srcs = ["version_links_test.py"],
    deps = [
        ":tree",
        "//checker:stac",
        requirement("absl-py"),
    ],
)
