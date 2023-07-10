"""Creating venv based on rules_pyvenv and some things on top"""

PYTHON_TOOLCHAIN_TYPE = "@bazel_tools//tools/python:toolchain_type"

def _run_py_venv_impl(ctx):
    toolchain_depset = ctx.toolchains[PYTHON_TOOLCHAIN_TYPE].py3_runtime.files or depset()
    toolchain_files = {f: None for f in toolchain_depset.to_list()}

    venv_binary = ctx.attr.venv_binary
    print(venv_binary)
    print(RunEnvironmentInfo in venv_binary)

    # for dep in ctx.attr.venv_binary:
    #     if PyInfo not in dep:
    #         continue
    #     imports.extend([i for i in dep[PyInfo].imports.to_list() if i not in imports])
    #
    # deps = depset(transitive = [dep[DefaultInfo].default_runfiles.files for dep in ctx.attr.deps])
    out = ctx.outputs.output_env_json
    #
    # files = []
    # for dep in deps.to_list():
    #     # Skip files that are provided by the python toolchain.
    #     # They don't need to be in the venv.
    #     if dep in toolchain_files:
    #         continue
    #
    #     typ = "S" if dep.is_source else "G"
    #     files.append({"t": typ, "p": dep.short_path})
    #
    # doc = {
    #     "workspace": ctx.workspace_name,
    #     "imports": imports,
    #     "files": files,
    #     "commands": ctx.attr.commands,
    #     "always_link": ctx.attr.always_link,
    # }
    # ctx.actions.write(out, json.encode(doc))

    return [DefaultInfo(files = depset(direct = [out]))]

_run_py_venv = rule(
    implementation = _run_py_venv_impl,
    attrs = {
        "venv_binary": attr.label(),
        "output_env_json": attr.output(),
    },
    toolchains = [PYTHON_TOOLCHAIN_TYPE],
)

def mock_rule(name, venv_binary = None, **kwargs):
    mock_name = "_" + name + "_env"
    out_name = mock_name + ".json"
    _run_py_venv(
        name = mock_name,
        venv_binary = venv_binary,
        output_env_json = out_name,
        **kwargs
    )
    #
    # env = {
    #     "BUILD_ENV_INPUT": "$(location " + out_label + ")",
    # }
    #
    # if venv_location:
    #     env.update({"VENV_LOCATION": venv_location})
    #
    # py_binary(
    #     name = name,
    #     srcs = ["@rules_pyvenv//:build_env.py"],
    #     deps = ["@rules_pyvenv//vendor/importlib_metadata"],
    #     data = [out_label] + deps,
    #     main = "@rules_pyvenv//:build_env.py",
    #     env = env,
    #     **kwargs
    # )
