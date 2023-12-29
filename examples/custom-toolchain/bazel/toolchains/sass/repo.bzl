_SASS_ROOT_BUILD_FILE = """
package(default_visibility = ["//visibility:public"])
exports_files( ["dart-sass/sass"] )
"""

_SASS_RELEASE_URL = "https://github.com/sass/dart-sass/releases/download/{sass_version}/dart-sass-{sass_version}-{sass_os}-{sass_arch}.{ext}"
_SASS_RELEASE_OS_TO_OS = {
    "darwin": "macos",
    "linux": "linux",
    "windows": "windows",
}
_SASS_RELEASE_ARCH_TO_ARCH = {
    "amd64": "x64",
    "arm64": "arm64",
}
_SASS_RELEASE_OS_TO_EXT = {
    "darwin": "tar.gz",
    "linux": "tar.gz",
    "windows": "zip",
}

SASS_EXPORTED_REPOS = [
    ("darwin", "amd64", "7a7e13df875d027580b47c1c0a3189641ce3af9396bfc7b35d743aee52b698f1"),
    ("darwin", "arm64", "bf86a62fa1765029c7dfca36176f6bb604f237c568b5e23d3a42ac4232e2110b"),
    ("linux", "amd64", "8c7c03dc768282bbf03026a4945d52983dfc90cdd2541c15ae5bda62bc514de6"),
    ("linux", "arm64", "596d740d80c100deb28524291fe8193f8612c08a26576b277947afb65c520108"),
    ("windows", "amd64", "d00942a244eb88d2bab194ce699843a6ef34a5b854c373c2de96fa2dc99cb251"),
]

def _sass_repo_impl(repo_ctx):
    version, sha256, os, arch = [
        repo_ctx.attr.version,
        repo_ctx.attr.sha256,
        repo_ctx.attr.os,
        repo_ctx.attr.arch,
    ]
    url = _SASS_RELEASE_URL.format(
        sass_version = version,
        sass_os = _SASS_RELEASE_OS_TO_OS[os],
        sass_arch = _SASS_RELEASE_ARCH_TO_ARCH[arch],
        ext = _SASS_RELEASE_OS_TO_EXT[os],
    )

    repo_ctx.download_and_extract(
        url = url,
        sha256 = sha256,
    )

    repo_ctx.file("BUILD", _SASS_ROOT_BUILD_FILE)

sass_repo = repository_rule(
    implementation = _sass_repo_impl,
    attrs = {
        "version": attr.string(
            default = "1.69.6",
            doc = "Version of Sass to download",
        ),
        "sha256": attr.string(
            mandatory = True,
            doc = "Expected SHA-256 sum of the downloaded archive",
        ),
        "os": attr.string(
            mandatory = True,
            values = ["darwin", "linux", "windows"],
            doc = "Host OS",
        ),
        "arch": attr.string(
            mandatory = True,
            values = ["amd64", "arm64"],
            doc = "Host architecture",
        ),
    },
)

def declare_all_repos(name = "sass_toolchain_repo"):
    """Declares all repos for all architectures"""
    for os, arch, sha in SASS_EXPORTED_REPOS:
        sass_repo(
            name = "{name}_{os}_{arch}".format(name = name, os = os, arch = arch),
            sha256 = sha,
            os = os,
            arch = arch,
        )
