# Top level BUILD for the Earth Engine Catalog

package(default_visibility = ["//visibility:public"])

load("@//dev:jsonnets_to_json.bzl", "jsonnets_to_json")

jsonnets_to_json(
    name = "non_commercial_datasets",
    srcs = glob(["non_commercial_datasets.jsonnet"]),
)

