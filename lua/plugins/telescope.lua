return {
  {
    "jvgrootveld/telescope-zoxide",
    dependencies = { "nvim-telescope/telescope.nvim" },
    keys = {
      {
        "<leader>cd",
        function()
          require("telescope").extensions.zoxide.list()
        end,
      },
    },
  },
}
