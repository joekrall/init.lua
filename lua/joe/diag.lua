if vim.g.vscode then
  vim.keymap.set("n", "[d", function() vim.fn.VSCodeNotify("editor.action.marker.next") end)
  vim.keymap.set("n", "]d", function() vim.fn.VSCodeNotify("editor.action.marker.prev") end)
  vim.keymap.set("n", "<leader>vd", function() vim.fn.VSCodeNotify("editor.action.showHover") end)
else
  vim.keymap.set("n", "[d", function() vim.diagnostic.jump({ count = 1, float = true }) end)
  vim.keymap.set("n", "]d", function() vim.diagnostic.jump({ count = -1, float = true }) end)
  vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end)
end
