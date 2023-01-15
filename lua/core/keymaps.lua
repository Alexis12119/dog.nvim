-- Remap for dealing with word wrap
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

vim.keymap.set("n", "<leader>w", ":wa<cr>:make<up><cr>")
vim.keymap.set("n", "<leader>b", ":wa<cr>:make<up><cr>")
vim.keymap.set("n", "<leader>c", "<cmd>bd!<cr>")
vim.keymap.set("n", "<leader>/", "<cmd>noh<cr>")
vim.keymap.set("i", "jk", "<esc>")
vim.keymap.set("n", "<leader>n", "<cmd>next<cr>")

