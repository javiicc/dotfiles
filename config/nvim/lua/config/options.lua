-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

local opt = vim.opt

opt.ignorecase = true -- ignore case in search patterns
opt.number = false -- print the line number in front of each line
opt.relativenumber = false -- show relative line number in front of each line
opt.textwidth = 80 -- maximum width of text that is being inserted
opt.colorcolumn = "80" -- columns to highlight
opt.linebreak = true -- wrap long lines at a blank
