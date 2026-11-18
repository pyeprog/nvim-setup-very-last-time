-- Do the following to load zprofile automatically
local shell = vim.system({
  "/bin/zsh", "-lic", [[printf '\0%s\0' "$PATH"]],
}):wait()

if shell.code == 0 then
  local path = shell.stdout:match("%z([^%z]+)%z")
  if path then
    vim.env.PATH = path
  end
end


