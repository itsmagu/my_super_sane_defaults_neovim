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
-- TREESITTER
		"nvim-treesitter/nvim-treesitter",
-- WHICH-KEY
		{
			"folke/which-key.nvim",
			event = "VeryLazy",
  			opts = {
				preset = "helix",
				spec = {
					{"<leader>p",group="project workdir"},
				},
				plugins = {
					spelling = {
						enabled = false,
						suggestions = 0,
					},
				},
				win = {
					no_overlap = true,
					padding = {0,0},
					title = true,
					title_pos = "left",
				},
				sort = {"group","local","case"},
				expand = 1,
				icons = {
					breadcrumb = '..',
					separator = '=>',
					group = '++',
					ellipsis = '....',
					mappings = true,
					colors = true,
					keys = {
						Up = '/\\',
						Down = '\\/',
						Left = '<-',
						Right = '->',
						C = 'C ',
						M = 'M ',
						D = 'D ',
						S = 'S ',
						CR = 'CR',
						Esc = 'ESC',
						ScrollWheelDown = 'SWD',
						ScrollWheelUp = 'SWU',
						NL = 'NL',
						BS = 'BS',
						Space = 'SPC',
						Tab = 'TAB',
						F1 = 'F1',
						F2 = 'F2',
						F3 = 'F3',
						F4 = 'F4',
						F5 = 'F5',
						F6 = 'F6',
						F7 = 'F7',
						F8 = 'F8',
						F9 = 'F9',
						F10 = 'F10',
						F11 = 'F11',
						F12 = 'F12',
					},
				},
				show_help = true,
				show_keys = true,
      			disable = {
        			ft = {},
        			bt = {},
      			},
      			debug = false, -- enable wk.log in the current directory
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
--BAMBOO THEME
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
vim.opt.scrolloff=6
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


vim.keymap.set('n','<leader>pe',vim.cmd.Ex, {desc = "Explore in work dir"})
vim.keymap.set('n','<leader>pO','<cmd>!odin run .<CR>', {desc = "Odin run in work dir"})
vim.keymap.set('n','<leader>pZ','<cmd>!zig build .<CR>', {desc = "Zig run in work dir"})
vim.keymap.set('n','<leader>pD','<cmd>!dotnet run .<CR>', {desc = "Dotnet run in work dir"})
--vim.keymap.set('n','<leader><leader>','<cmd>so<CR>',{desc = "source"})
--vim.keymap.set('v','<leader><leader>',"<cmd>'<,'>so<CR>",{desc = "source selection"})

vim.keymap.set('n','.',"<nop>")
vim.keymap.set('n','Q', "<nop>")

-- End
print("Running with init.lua")
