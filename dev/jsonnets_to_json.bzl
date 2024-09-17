"""Build with many jsonnet files."""

load("@rules_jsonnet//jsonnet:jsonnet.bzl", "jsonnet_to_json")

def jsonnets_to_json(
        name,
        srcs,
        jsonnet_vars = {},
        deps = [],
        imports = [],
        data = []):
    """Converts multiple input files from jsonnet to json.

    Args:
      name: name for the filegroup containing the generated json files
      srcs: list of input jsonnet files
      jsonnet_vars: Optional, dictionary of variable names and values passed to
                    the jsonnet_to_json generation.
      deps: Optional, list of jsonnet libraries that will be used as
            dependencies during jsonnet to json conversion.
      imports: Optional, list of import `-J` flags to be passed to the `jsonnet` compiler.
      data: Optional, list of files that will be used during jsonnet to json
            conversion, typically via importstr.
    """
    json_srcs = []
    for src in srcs:
        label_suffix = src.replace("/", "_").replace(":", "_")
        out = src.rsplit(".", 1)[0] + ".json"
        json_srcs.append(out)
        jsonnet_to_json(
            name = "jsonnet_to_json_%s" % label_suffix,
            src = src,
            outs = [out],
            data = data,
            imports = imports,
            vars = jsonnet_vars,
            deps = deps,
        )
    native.filegroup(
        name = name,
        srcs = json_srcs,
        visibility = ["//visibility:public"],
    )

