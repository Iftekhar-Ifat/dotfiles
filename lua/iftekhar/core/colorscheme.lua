require('onedark').setup {
    style = 'deep',
    transparent = true 
}

local status, _ = pcall(vim.cmd, "colorscheme onedark")

if not status then 
  print("colorscheme not found!")
  return
end
