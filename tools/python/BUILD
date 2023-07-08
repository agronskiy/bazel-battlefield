load("@rules_python//python:pip.bzl", "compile_pip_requirements")
load("@bazel_tools//tools/python:toolchain.bzl", "py_runtime_pair")

compile_pip_requirements(
    name = "compile_python_requirements",
    extra_args = [
        "--resolver=backtracking",
        "--allow-unsafe",  # Usually is needed for `sertuptools`
    ],
    requirements_in = "requirements.txt",
    requirements_txt = "requirements_lock.txt",
    tags = ["manual"],
)

exports_files([
    "requirements.txt",
    "requirements_lock.txt",
])

# Non-hermetic toolchain

py_runtime(
    name = "python3_runtime",
    interpreter_path = "/usr/bin/python3",
    python_version = "PY3",
    visibility = ["//visibility:public"],
)

py_runtime_pair(
    name = "python_runtime_pair",
    py2_runtime = None,
    py3_runtime = ":python3_runtime",
)

toolchain(
    name = "python_toolchain",
    toolchain = ":python_runtime_pair",
    toolchain_type = "@bazel_tools//tools/python:toolchain_type",
)
