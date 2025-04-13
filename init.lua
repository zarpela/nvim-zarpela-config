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
  if vim.fn.expand("%:e") ~= "py" then
    vim.notify("⚠️ Not a Python file.")
    return
  end

  vim.cmd('w') -- save current file
  local file = vim.fn.shellescape(vim.fn.expand("%:p"))

  local terminal_win = nil

  for _, win in ipairs(vim.api.nvim_list_wins()) do
    local buf = vim.api.nvim_win_get_buf(win)
    if vim.bo[buf].buftype == "terminal" then
      terminal_win = win
      break
    end
  end

  if terminal_win then
    -- If terminal is already open, just go to it
    vim.api.nvim_set_current_win(terminal_win)
  else
    -- Otherwise, open a new one
    vim.cmd('belowright split | terminal')
    vim.cmd('wincmd j')
  end

  -- Run the command
  local term_job_id = vim.b.terminal_job_id
  vim.fn.chansend(term_job_id, "clear && python3 " .. file .. "\n")
  vim.cmd('startinsert')
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



