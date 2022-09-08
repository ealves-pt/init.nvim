local function map(modes, lhs, rhs, opts)
  local options = { silent = true, remap = false }
  if opts then
    options = vim.tbl_extend('force', options, opts)
  end
  vim.keymap.set(modes, lhs, rhs, options)
end

return map
