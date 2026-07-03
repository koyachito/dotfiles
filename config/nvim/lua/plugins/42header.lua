return {
  "Diogo-ss/42-header.nvim",
  cmd = { "Stdheader" },
  config = function()
    require("42header").setup({
      default_map = true, -- <F1>でHeader挿入
      auto_update = true, -- 保存時にUpdatedを更新
      user = "koyachito",
      mail = "koyachito@student.42tokyo.jp",
    })
  end,
}
