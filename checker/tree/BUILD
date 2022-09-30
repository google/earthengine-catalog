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
    name = "parent_child_test",
    srcs = ["parent_child_test.py"],
    deps = [
        ":tree",
        "//checker:stac",
    ],
)
