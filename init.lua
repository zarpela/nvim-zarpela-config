vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")
vim.cmd("set number")
vim.g.mapleader = " ";

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

local opts = {}



require("lazy").setup("plugins")  
local builtin = require("telescope.builtin")

vim.keymap.set('n', '<C-p>', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<C-n>', ":Neotree filesystem reveal left<CR>", {})
vim.keymap.set('n', '<F5>', function()
  vim.cmd('w') -- Save the file
  local file = vim.fn.expand('%:p') -- Full path to the file

  -- Open a horizontal terminal split and run the Python file after a short delay
  vim.cmd('belowright split | terminal sleep 0.5 && python3 ' .. file)

  -- Move the cursor to the terminal split and enter insert mode
  vim.cmd('wincmd j')        -- Move to the new (below) split
  vim.cmd('startinsert')     -- Enter insert mode for input
end, {})
local config = require("nvim-treesitter.configs")
require("nvim-treesitter.configs").setup({
    ensure_installed = { "lua", "javascript", "python", "html", "c" },
    highlight = {
      enable = true,
        additional_vim_regex_highlighting = false,
    },
    indent = { enable = true },
})



