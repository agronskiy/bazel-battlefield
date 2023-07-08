"""Macros to load external repositories"""

load("@bazel_tools//tools/build_defs/repo:git.bzl", "git_repository", "new_git_repository")
load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

def load_repositories():
    """Main macro to load them"""

    git_repository(
        name = "com_github_gflags_gflags",
        commit = "addd749114fab4f24b7ea1e0f2f837584389e52c",
        remote = "https://github.com/gflags/gflags",
    )

    git_repository(
        name = "com_google_glog",
        commit = "142c451e6b1bddd2892f3d66f625f81ca962ee5d",
        remote = "https://github.com/vraychev/glog.git",
    )

    git_repository(
        name = "com_googlesource_code_re2",
        commit = "0dade9ff39bb6276f18dd6d4bc12d3c20479ee24",
        remote = "https://github.com/google/re2.git",
    )

    git_repository(
        name = "com_google_absl",
        commit = "c96db73c09dbb528eca6d19a50bd258b37e9fd5e",
        remote = "https://github.com/abseil/abseil-cpp",
    )

    git_repository(
        name = "com_github_grpc_grpc",
        remote = "https://github.com/grpc/grpc",
        tag = "v1.51.1",
    )

    git_repository(
        name = "rules_proto_grpc",
        remote = "https://github.com/rules-proto-grpc/rules_proto_grpc",
        tag = "4.2.0",
    )

    git_repository(
        name = "com_google_googletest",
        build_file = "@//tools/deps:gtest.BUILD",
        remote = "https://github.com/google/googletest",
        tag = "release-1.11.0",
    )

    http_archive(
        name = "rules_python",
        sha256 = "84aec9e21cc56fbc7f1335035a71c850d1b9b5cc6ff497306f84cced9a769841",
        strip_prefix = "rules_python-0.23.1",
        url = "https://github.com/bazelbuild/rules_python/releases/download/0.23.1/rules_python-0.23.1.tar.gz",
    )

    git_repository(
        name = "rules_pyvenv",
        commit = "115dcaf7f02c620d1649e681ab9c9476d2e51cd1",
        remote = "https://github.com/cedarai/rules_pyvenv",
    )
