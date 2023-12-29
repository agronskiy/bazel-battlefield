def _compile_sass_impl(ctx):
    output_css = ctx.actions.declare_file(ctx.file.out_css.basename)
    output_css_map = ctx.actions.declare_file("{path}.map".format(path = ctx.file.out_css.basename))
    outputs = [
        output_css,
        output_css_map,
    ]

    sass_compiler = ctx.toolchains["//bazel/toolchains/sass:toolchain_type"].sass_info.compiler
    sass_arguments = [
        ctx.file.main.path,
        output_css.path,
    ]

    ctx.actions.run(
        mnemonic = "CompileSassStage",
        progress_message = "Compile Sass",
        executable = sass_compiler,
        arguments = sass_arguments,
        inputs = [ctx.file.main] + ctx.files.srcs,
        outputs = outputs,
        tools = [sass_compiler],
    )

    return [DefaultInfo(
        files = depset(outputs),
    )]

compile_sass = rule(
    implementation = _compile_sass_impl,
    attrs = {
        "srcs": attr.label_list(
            allow_files = [".scss"],
            mandatory = True,
        ),
        "main": attr.label(
            allow_single_file = [".scss"],
            mandatory = True,
        ),
        "out_css": attr.label(
            allow_single_file = [".css"],
            default = "main.css",
        ),
    },
    toolchains = [
        "//bazel/toolchains/sass:toolchain_type",
    ],
)
