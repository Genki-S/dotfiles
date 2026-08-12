lua << EOF
  local expanded_file_panel_height = 10

  require("diffview").setup({
    use_icons = false,
    file_panel = {
      win_config = {
        position = "top",
        height = expanded_file_panel_height,
      },
      listing_style = "list",
    },
    hooks = {
      view_opened = function(view)
        if view.class:name() ~= "DiffView" then
          return
        end

        local panel = view.panel

        panel:on_autocmd("WinEnter", {
          callback = function()
            vim.api.nvim_win_set_height(panel.winid, expanded_file_panel_height)
          end,
        })
        panel:on_autocmd("WinLeave", {
          callback = function()
            panel:highlight_cur_file()
            vim.api.nvim_win_set_height(panel.winid, 1)
          end,
        })
      end,
    },
  })
EOF
