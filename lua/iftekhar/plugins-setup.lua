-- auto install packer if not installed
local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
    vim.cmd([[packadd packer.nvim]])
    return true
  end
  return false
end
local packer_bootstrap = ensure_packer() -- true if packer was just installed

-- autocommand that reloads neovim and installs/updates/removes plugins
-- when file is saved
vim.cmd([[ 
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins-setup.lua source <afile> | PackerSync
  augroup end
]])

-- import packer safely
local status, packer = pcall(require, "packer")
if not status then
  return
end

return packer.startup(function(use)
    use("wbthomason/packer.nvim")

    -- theme
    use ('navarasu/onedark.nvim')

    -- statusline
    use('nvim-lualine/lualine.nvim')

    -- icons
    use ('nvim-tree/nvim-web-devicons')

    -- file explorer
    use ('nvim-tree/nvim-tree.lua')

    -- fuzzy finding w/ telescope
    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.0', module='telescope', cmd='Telescope',
        requires = { {'nvim-lua/plenary.nvim'}, {'nvim-telescope/telescope-fzf-native.nvim'} }
    }

    -- other packages
    use ('ThePrimeagen/vim-be-good')

    -- treesitter configuration
    use({
        "nvim-treesitter/nvim-treesitter",
        run = function()
        local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
        ts_update()
        end,
    })

    -- auto closing
    use("windwp/nvim-autopairs") -- autoclose parens, brackets, quotes, etc...
    use({ "windwp/nvim-ts-autotag", after = "nvim-treesitter" }) -- autoclose tags

    if packer_bootstrap then
        require("packer").sync()
    end
end)

