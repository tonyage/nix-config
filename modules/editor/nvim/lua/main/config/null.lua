return {
  sources = {
    require("null-ls").builtins.formatting.black,
    require("null-ls").builtins.formatting.cmake_format,
    require("null-ls").builtins.formatting.ktlint,
    require("null-ls").builtins.formatting.shfmt,
    require("null-ls").builtins.formatting.stylua,

    require("null-ls").builtins.diagnostics.buf,
    require("null-ls").builtins.diagnostics.cmake_lint,
    require("null-ls").builtins.diagnostics.ruff,

    require("null-ls").builtins.code_actions.gitsigns,
    require("null-ls").builtins.code_actions.refactoring,
    require("null-ls").builtins.code_actions.shellcheck,
    require("null-ls").builtins.code_actions.statix
  }
}
