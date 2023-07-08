# First, load all the repos from `:repositories.bzl`

load(":repositories.bzl", "load_repositories")

load_repositories()

load("@com_github_grpc_grpc//bazel:grpc_deps.bzl", "grpc_deps")

grpc_deps()

load("@com_github_grpc_grpc//bazel:grpc_extra_deps.bzl", "grpc_extra_deps")

grpc_extra_deps()

# Proto & gRPC build rules

load("@rules_proto_grpc//:repositories.bzl", "rules_proto_grpc_repos", "rules_proto_grpc_toolchains")

rules_proto_grpc_toolchains()

rules_proto_grpc_repos()

# Python
load("@rules_python//python:repositories.bzl", "py_repositories", "python_register_toolchains")

py_repositories()

# Additional info
#   * rules_python on toolchains:
#       https://github.com/bazelbuild/rules_python/blob/main/proposals/2019-02-12-design-for-a-python-toolchain.md
#   * Available toolchains:
#       https://github.com/bazelbuild/rules_python/blob/main/python/versions.bzl
# CAVEAT: on darwin, this could require potentially updating `coreutils`, the reason
# explained here: https://github.com/bazelbuild/rules_python/issues/725#issuecomment-1156864845
#   Symptoms: you get bazel erro during making the fetched interperter repo read-only:
#   > Error in fail: Failed to make interpreter installation read-only. 'chmod' error msg
#
# For non-hermetic way, use
#
#   register_toolchains("//tools/python:python_toolchain")
#
python_register_toolchains(
    name = "python310",
    python_version = "3.10",
)

load("@rules_python//python/pip_install:repositories.bzl", "pip_install_dependencies")

pip_install_dependencies()

load("@rules_python//python:pip.bzl", "pip_parse")

pip_parse(
    name = "python_deps",
    requirements_lock = "//tools/python:requirements_lock.txt",
)

load("@python_deps//:requirements.bzl", _install_deps = "install_deps")

_install_deps()
