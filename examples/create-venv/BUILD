load(":defs.bzl", "mock_rule")
load("@rules_pyvenv//:venv.bzl", "py_venv")
load("@python_deps//:requirements.bzl", _python_all_requirements = "all_requirements")

# Use this target as follows:
# bazel run //tools/python:export_all_requirements
py_venv(
    name = "venv_binary",
    always_link = True,
    tags = ["manual"],
    venv_location = ".venv/devenv",
    deps = _python_all_requirements,
)

mock_rule(
    name = "mock_venv_rule",
    venv_binary = ":venv_binary",
)
