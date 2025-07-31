require("notify").setup({
  background_colour = "#000000",
  stages = "fade_in_slide_out",
  timeout = 2000,
  render = "compact",
  max_width = 60,
  max_height = 10,
  level = vim.log.levels.ERROR,
}) 
