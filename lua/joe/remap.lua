vim.g.mapleader = " "

vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- enable VSCode-like alt-arrow-key navigation using the J and K keys
-- when in visual mode
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- joins two lines together, but keeps the cursor at its initial position when
-- in normal mode
vim.keymap.set("n", "J", "mzJ`z")

-- move up or down the page, keeping the cursor in the center of the screen
-- when in normal mode
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- after performing a search and jumping to next/previous instances, keep the
-- cursor in the center of the screen when in normal mode
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- dump the replaced contents to the void register and paste over it
-- greatest remap ever
vim.keymap.set("x", "<leader>p", [["_dP]])

-- next greatest remap ever : asbjornHaland
-- shortcut to add yanked text to system clipboard when in normal mode
vim.keymap.set({"n", "v"}, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

-- dump the cut contents to the void register when in normal or visual mode
vim.keymap.set({"n", "v"}, "<leader>d", [["_d]])

-- don't ever press Q
vim.keymap.set("n", "Q", "<nop>")

-- tmux-sessionizer in vim!
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")

-- format the current buffer
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)

vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

-- quickly replace all instances of the word the cursor is in. For more
-- granular symbol renaming, use `<leader>rn`, provided in /after/plugin/lsp.lua
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- make this stuff executable
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

-- quickly shoutout a file
vim.keymap.set("n", "<leader><leader>", function()
    vim.cmd("so")
end)
