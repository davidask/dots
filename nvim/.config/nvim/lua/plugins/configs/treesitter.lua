local present, treesitter = pcall(require, "nvim-treesitter.configs")

if not present then
   return
end

local options = {
   ensure_installed = {
      "lua",
      "vim",
      "yaml",
      "rust",
      "typescript",
      "tsx",
      "json",
      "css",
      "html",
      "javascript",
      "swift",
      "c_sharp",
      "bash",
      "toml"

   },
   highlight = {
      enable = true,
      use_languagetree = true,
   },
   matchup = {
     enable = true
   }
}

treesitter.setup(options)
