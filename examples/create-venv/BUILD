"""Creating working environment with up-to-date .pth files

## Usage
    ```
    bazel run -c opt //examples/create-venv:devenv
    ```
this will put `.venv/devenv` ready for pointing the IDE to it.
"""

load(":defs.bzl", "export_devenv")
load("@python_deps//:requirements.bzl", _python_all_requirements = "all_requirements")

# Use this target as follows:
# bazel run //tools/python:export_all_requirements
export_devenv(
    name = "devenv",
    tags = ["manual"],
    venv_location = ".venv/devenv",
    deps = _python_all_requirements,
)
