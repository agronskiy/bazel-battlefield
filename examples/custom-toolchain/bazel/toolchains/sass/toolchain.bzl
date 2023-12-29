"""Toolchain implementation is kept in a separate file"""

load("repo.bzl", "SASS_EXPORTED_REPOS")

SassToolchainInfo = provider(
    doc = "Contains information about a Sass toolchain, it's beneficial to keep the API here",
    fields = {
        "compiler": "Compiler binary",
        "args": "Arguments to the compiler",
    },
)

def _sass_toolchain_impl(ctx):
    toolchain_info = platform_common.ToolchainInfo(
        sass_info = SassToolchainInfo(
            compiler = ctx.file.compiler,  # Type File
            args = ctx.attr.args,
        ),
    )
    return [toolchain_info]

sass_toolchain = rule(
    implementation = _sass_toolchain_impl,
    attrs = {
        # This can be any type, not necessarily a string. If e.g. it's `label`, we
        # can later access it via `ctx.files`, etc.
        "compiler": attr.label(
            allow_single_file = True,
            mandatory = True,
            executable = True,
            cfg = "exec",  # WIPP
            doc = "Compiler executable",
        ),
        "args": attr.string_list(),
    },
)

_ARCH_TO_CPU = {
    "amd64": "x86_64",
    "arm64": "arm64",
}

_OS_TO_PLATFORM_OS = {
    "darwin": "macos",
    "linux": "linux",
    "windows": "windows",
}
_GENERIC_NAME = "sass_toolchain"

def define_all_toolchains(name = _GENERIC_NAME):
    for os, arch, _ in SASS_EXPORTED_REPOS:
        sass_toolchain(
            name = "{name}_{os}_{arch}_impl".format(name = name, arch = arch, os = os),
            compiler = "@sass_toolchain_repo_{os}_{arch}//:dart-sass/sass".format(arch = arch, os = os),
        )

        native.toolchain(
            name = "{name}_{os}_{arch}".format(name = name, arch = arch, os = os),
            exec_compatible_with = [
                "@platforms//os:{os}".format(os = _OS_TO_PLATFORM_OS[os]),
                "@platforms//cpu:{cpu}".format(cpu = _ARCH_TO_CPU[arch]),
            ],
            toolchain = ":{name}_{os}_{arch}_impl".format(name = name, arch = arch, os = os),
            toolchain_type = "//bazel/toolchains/sass:toolchain_type",
        )

def register_all_toolchains(name = _GENERIC_NAME):
    all_toolchains = []
    for os, arch, _ in SASS_EXPORTED_REPOS:
        all_toolchains.append("//bazel/toolchains/sass:{name}_{os}_{arch}".format(name = _GENERIC_NAME, arch = arch, os = os))
    native.register_toolchains(*all_toolchains)
