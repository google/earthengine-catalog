# Earth Engine Public Data Catalog STAC checker.
load("@pip//:requirements.bzl", "requirement")
package(default_visibility = ["//visibility:public"])

py_binary(
    name = "ee_stac_check",
    srcs = ["ee_stac_check.py"],
    data = ["//catalog"],
    deps = [
        ":stac",
        "//checker/node",
        "//checker/tree",
    ],
)

py_library(
    name = "ee_stac_check_lib",
    srcs = ["ee_stac_check.py"],
    deps = [
        ":stac",
        "//checker/node",
        "//checker/tree",
    ],
)

# This test does not work well in a github action.
# py_test(
#     name = "ee_stac_check_test",
#     srcs = ["ee_stac_check_test.py"],
#     deps = [
#         ":ee_stac_check_lib",
#         ":stac",
#         "//checker/node",
#         "//checker/tree",
#     ],
# )

py_library(
    name = "stac",
    srcs = [
        "stac.py",
        "units.py",
    ],
    data = [
        "//:non_commercial_datasets",
        "//catalog",
    ],
)

py_test(
    name = "stac_test",
    srcs = ["stac_test.py"],
    deps = [
        ":stac",
        requirement("absl-py")
    ],
)

py_library(
    name = "test_utils",
    testonly = True,
    srcs = ["test_utils.py"],
    deps = [":stac"],
)

py_test(
    name = "test_utils_test",
    size = "small",
    srcs = ["test_utils_test.py"],
    deps = [
        ":stac",
        ":test_utils",
        requirement("absl-py")
    ],
)
