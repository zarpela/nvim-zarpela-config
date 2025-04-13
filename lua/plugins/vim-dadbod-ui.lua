return {
  { "tpope/vim-dadbod", lazy = false, cmd = "DB" },
  { "kristijanhusak/vim-dadbod-ui", dependencies = { "tpope/vim-dadbod" }, cmd = { "DBUI", "DBUIToggle", "DBUIAddConnection", "DBUIFindBuffer" }, keys = { { "<leader>D", "<cmd>DBUIToggle<CR>", desc = "Toggle DBUI" } } },
}
