if vim.g.neovide then
  -- neovide font setup
  -- vim.opt.guifont = "PragmataPro Nerd Font Mono:h16"
  vim.opt.guifont = "Pragmasevka Nerd Font:h16"

  -- Helper function for transparency formatting
  local alpha = function() return string.format("%x", math.floor(255 * (vim.g.transparency or 0.8))) end
  -- g:neovide_transparency should be 0 if you want to unify transparency of content and title bar.
  vim.g.neovide_transparency = 0.9
  vim.g.transparency = 0.9
  vim.g.neovide_background_color = "#1E1E2F" .. alpha()

  -- floating blur
  vim.g.neovide_floating_blur_amount_x = 2.0
  vim.g.neovide_floating_blur_amount_y = 2.0

  -- floating shadow
  vim.g.neovide_floating_shadow = true
  vim.g.neovide_floating_z_height = 10
  vim.g.neovide_light_angle_degrees = 45
  vim.g.neovide_light_radius = 5
end
