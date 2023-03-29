local null = require("null-ls")
return {
  sources = {
    null.builtins.code_actions.cspell,
    null.builtins.code_actions.eslint,

    null.builtins.code_actions.gitsigns.with({
      config = {
        filter_actions = function(title)
          return title:lower():match("blame") == nil
        end
      }
    }),

    null.builtins.code_actions.refactoring,
    null.builtins.code_actions.shellcheck,
    null.builtins.code_actions.statix,

    null.builtins.diagnostics.actionlint,
    null.builtins.diagnostics.buf,
    null.builtins.diagnostics.cpplint,
    null.builtins.diagnostics.cmake_lint,
    null.builtins.diagnostics.deadnix,
    null.builtins.diagnostics.hadolint,
    null.builtins.diagnostics.jsonlint,
    null.builtins.diagnostics.ktlint,
    null.builtins.diagnostics.markdownlint,
    null.builtins.diagnostics.ruff,
    null.builtins.diagnostics.stylelint,
    null.builtins.diagnostics.swiftlint,
    null.builtins.diagnostics.yamllint,
    null.builtins.diagnostics.zsh,


    null.builtins.formatting.buf,
    null.builtins.formatting.clang_format.with({
      extra_args = {
        '--style="{ BasedOnStyle: Google, AccessModifierOffset: -1 }"'
      }
    }),
    null.builtins.formatting.cmake_format,
    null.builtins.formatting.jq,
    null.builtins.formatting.ktlint.with({
      extra_args = { "--relative", "--format" }
    }),
    null.builtins.formatting.markdownlint,
    null.builtins.formatting.nixpkgs_fmt,
    null.builtins.formatting.prettier,
    null.builtins.formatting.ruff,
    null.builtins.formatting.rustfmt,
    null.builtins.formatting.shfmt.with({
      extra_args = { "-i", 2, "-s", "-w" }
    }),
    null.builtins.formatting.stylua,
    null.builtins.formatting.swiftlint,
    null.builtins.formatting.yamlfmt,

    null.builtins.hover.dictionary,
    null.builtins.hover.printenv
  }
}
