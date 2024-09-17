# The EarthEngine Catalog STAC catalog from Jsonnet.

load("@rules_jsonnet//jsonnet:jsonnet.bzl", "jsonnet_library")
load("@//dev:jsonnets_to_json.bzl", "jsonnets_to_json")

jsonnets_to_json(
    name = "catalog",
    srcs = glob(["**/*.jsonnet"]),
    data = glob(["**/*.md"]),
    imports = [
        ".",
    ],
    deps = [":lib"],
)

jsonnet_library(
    name = "lib",
    srcs = glob([
        "*.libsonnet",
        "**/*.libsonnet",
    ]),
)
