-- Install Lazy if it's not installed
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

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Setup lazy.nvim
require("lazy").setup({
	spec = {
		"nvim-treesitter/nvim-treesitter",
		{
			"folke/which-key.nvim",
			event = "VeryLazy",
  			opts = {
    		-- your configuration comes here
    		-- or leave it empty to use the default settings
    		-- refer to the configuration section below
  			},
  			keys = {
    			{
      				"<leader>?",
      				function()
        				require("which-key").show({ global = false })
      				end,
      			desc = "Buffer Local Keymaps (which-key)",
    			},
  			},
		},
	  	{
  			'ribru17/bamboo.nvim',
  			lazy = false,
  			priority = 1000,
  			config = function()
    			require('bamboo').setup {
      				-- optional configuration here
    			}
    			require('bamboo').load()
  			end,
		},
	},
  	-- Configure any other settings here. See the documentation for more details.
  	-- colorscheme that will be used when installing plugins.
  	install = { colorscheme = { "bamboo" } },
  	-- automatically check for plugin updates
  	checker = { enabled = true },
})

-- Sets

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.tabstop = 4
vim.opt.shiftwidth=4
vim.opt.showbreak="..."
vim.g.zig_fmt_parse_errors = 0
vim.g.zig_fmt_autosave = 0

if jit.os == 'Windows' then 
	vim.opt.shell = "powershell"
	vim.o.shellcmdflag = "-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;"
	vim.o.shellredir = "2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode"
	vim.o.shellpipe = "2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode"
	vim.o.shellquote = ""
	vim.o.shellxquote = ""
end

-- Keymaps
vim.g.mapleader = ' '
vim.g.maplocalleader = '\\'
vim.keymap.set('n','<leader><F1>','<cmd>!odin run .<CR>')
vim.keymap.set('n','.',"<nop>")
vim.keymap.set("n", "Q", "<nop>")

-- End
print("Running with init.lua")
