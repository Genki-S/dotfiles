lua << EOF
  require("treesitter-context").setup({
    enable = false, -- false so that initial plugin load with :TSContextToggle would enable it
  })

  vim.keymap.set("n", "<Leader>ck", function()
    require("treesitter-context").go_to_context(vim.v.count1)
    -- context is not shown when cursor is on the top, so move the cursor on the center of the window
    vim.cmd("normal! z.")
  end, { silent = false })
EOF
