lua << EOF
  require("diffview").setup({
    use_icons = false,
    file_panel = {
      win_config = {
        position = "top",
        height = 5,
      },
      listing_style = "list",
    },
  })
EOF

