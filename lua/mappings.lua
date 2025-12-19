require "nvchad.mappings"

local setMap = vim.keymap.set
local delMap = vim.keymap.del

setMap("n", ";", ":", { desc = "CMD enter command mode" })
setMap("i", "jk", "<ESC>")
setMap("n", "m", ":make<cr>", { desc = "run makefile" })
setMap({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
setMap({ "n", "i", "v" }, "<C-a>", "gg0vG$")
--===== Terminal mode

-- ovveride nvcahd
delMap("t", "<C-x>") --delete previus map ( conflict key, e.g. Nano editor when using git)
setMap("t", "<ESC>", "<C-\\><C-N>")
