# Checks that operate on only a single STAC node at a time.

py_library(
    name = "node",
    srcs = glob(
        ["*.py"],
        exclude = ["*_test.py"],
    ),
    visibility = ["//visibility:public"],
)

py_test(
    name = "description_test",
    srcs = ["description_test.py"],
    deps = [
        ":node",
        "//checker:stac",
    ],
)

py_test(
    name = "extensions_test",
    srcs = ["extensions_test.py"],
    deps = [
        ":node",
        "//checker:stac",
    ],
)

py_test(
    name = "extent_test",
    srcs = ["extent_test.py"],
    deps = [
        ":node",
        "//checker:stac",
    ],
)

py_test(
    name = "id_field_test",
    srcs = ["id_field_test.py"],
    deps = [
        ":node",
        "//checker:stac",
    ],
)

py_test(
    name = "interval_test",
    srcs = ["interval_test.py"],
    deps = [
        ":node",
        "//checker:stac",
    ],
)

py_test(
    name = "keywords_test",
    srcs = ["keywords_test.py"],
    deps = [
        ":node",
        "//checker:stac",
    ],
)

py_test(
    name = "required_test",
    srcs = ["required_test.py"],
    deps = [
        ":node",
        "//checker:stac",
    ],
)

py_test(
    name = "stac_version_test",
    srcs = ["stac_version_test.py"],
    deps = [
        ":node",
        "//checker:stac",
    ],
)

py_test(
    name = "title_test",
    srcs = ["title_test.py"],
    deps = [
        ":node",
        "//checker:stac",
    ],
)
