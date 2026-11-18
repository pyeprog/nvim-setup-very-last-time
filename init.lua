local shell = vim.system({
  "/bin/zsh", "-lic", [[printf '\0%s\0' "$PATH"]],
}):wait()

if shell.code == 0 then
  local path = shell.stdout:match("%z([^%z]+)%z")
  if path then
    vim.env.PATH = path
  end
end

require("config.options")
require("config.lazy")
require("config.keymaps")
