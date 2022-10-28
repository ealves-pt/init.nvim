-- Plugin: nvim-autopairs
-- url: https://github.com/windwp/nvim-autopairs

require("nvim-autopairs").setup()

local cmp_status_ok, cmp = pcall(require, "cmp")
if not cmp_status_ok then
  return
end

-- Integration w/ nvim-cmp
local cmp_autopairs_ok, cmp_autopairs = pcall(require, "nvim-autopairs.completion.cmp")
if not cmp_autopairs_ok then
  return
end

cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
