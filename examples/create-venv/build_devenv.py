""" Adds necessary `.pth` (see below) to the venv's `site-packages` directory.

Necessary `.pth`s serve the purpose of finding our root repo to make the IDE/Language Servers
aware of fully-qualified first-party imports. For examples:
```py
    from pantscode.ml_infra.common import something
```

"""
import os
import pathlib
import subprocess


def run_deps():
    """Runs the dependency of this rule, see `:defs.bzl`"""
    subprocess.check_output([os.environ["PY_VENV_BINARY"]])


def main():
    if "VENV_LOCATION" not in os.environ:
        raise Exception("Uses VENV_LOCATION")

    root_path = pathlib.Path(os.environ["BUILD_WORKSPACE_DIRECTORY"])

    env_path = root_path / os.environ["VENV_LOCATION"]
    pth_path = (
        pathlib.Path(
            subprocess.check_output(
                [
                    env_path / "bin/python",
                    "-c",
                    "import site; print(site.getsitepackages()[0], end='')",
                ],
            ).decode()
        )
        / "deepcode-devenv.pth"
    )

    # Add `.pth` file to point to the workspace directory, this allwos python IDEs to
    # put it to the pythonpath
    with pth_path.open("w") as f:
        f.write(str(root_path) + "\n")
        f.write(str(root_path / "bazel-bin" / "dist" / "codegen") + "\n")


if __name__ == "__main__":
    run_deps()
    main()

