local C = require("clock")

--vim.keymap.set("n", "<space><space>t", '<cmd>lua require("clock").get_time()<CR>')
vim.keymap.set("n", "<space><space>t", C.get_time)
