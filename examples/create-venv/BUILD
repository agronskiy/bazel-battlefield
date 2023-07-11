load(":defs.bzl", "export_devenv")
load("@python_deps//:requirements.bzl", _python_all_requirements = "all_requirements")

# Use this target as follows:
# bazel run //tools/python:export_all_requirements
export_devenv(
    name = "devenv",
    venv_location = ".venv/devenv",
    deps = _python_all_requirements,
)
