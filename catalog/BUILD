# The EarthEngine Catalog STAC catalog from Jsonnet.

bazel_dep(name = "rules_jsonnet", version = "0.6.0"))
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
