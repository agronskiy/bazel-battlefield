load("@rules_python//python:pip.bzl", "compile_pip_requirements")

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
