local uv = vim.loop

local M = {}

local has_value = function(tbl, target)
  for _, value in ipairs(tbl) do
    if value == target then
      return true
    end
  end
  return false
end

local has_value_in_table = function(tbl, target_key)
  for k, _ in pairs(tbl) do
    if (k == target_key) then
      return true
    end
  end
  return false
end

local reference_files = { "gradlew", "pom.xml", "mvnw" }
local function find_app_root_path()
  local cur_dir = vim.fn.expand("%:h")
  local prev_path = nil
  repeat
    local found = false
    if cur_dir == "/" then
      vim.api.nvim_err_write("Not found the java project!")
      return
    end

    local dir_content = uv.fs_scandir(cur_dir)
    if not dir_content then
      vim.api.nvim_err_write("Invalid directory and path!")
      return
    end

    repeat
      local name = uv.fs_scandir_next(dir_content)
      if has_value(reference_files, name) then
        found = true
      end
    until not name

    if not found then
      prev_path = cur_dir
    end

    local next_dir = uv.fs_realpath(cur_dir .. "/..")
    if not next_dir then
      vim.api.nvim_err_write("Invalid directory and path!")
      return
    end
    cur_dir = next_dir
  until found

  return prev_path
end

--- @param name string
--- @return string | nil
local function find_path_to_prefs(name)
  local settings_path = find_app_root_path() .. "/.settings"
  local settings_folder = uv.fs_opendir(settings_path)
  if not settings_folder then
    local result = uv.fs_mkdir(settings_path, tonumber("755", 8))
    if not result then
      vim.api.nvim_err_write("Error of creating the dir! No permissions!")
      return
    end
  end

  return settings_path .. name
end

local needed_properties = {
  ["org.eclipse.jdt.core.compiler.problem.enablePreviewFeatures"] = "enabled",
  ["org.eclipse.jdt.core.compiler.problem.reportPreviewFeatures"] = "ignore",
}
local function append_or_change_preview_prefs(content)
  if content then
    local updated_content = ""
    local properties = {}
    for k, v in string.gmatch(content, "([^\n]+)=([^\n]+)") do
      properties[k] = v
    end
    for pref, value in pairs(needed_properties) do
      properties[pref] = value
    end
    for pref, value in pairs(properties) do
      updated_content = updated_content .. pref .. "=" .. value .. "\n"
    end
    content = updated_content
  else
    content = ""
    for pref, value in pairs(needed_properties) do
      content = content .. pref .. "=" .. value .. "\n"
    end
  end
  return content
end

local function remove_preview_prefs(content)
  if content then
    local updated_content = ""
    for pref, value in string.gmatch(content, "([^\n]+)=([^\n]+)") do
      if not has_value_in_table(needed_properties, pref) then
        updated_content = updated_content .. pref .. "=" .. value .. "\n"
      end
    end
    content = updated_content
  else
    content = ""
  end
  return content
end

local function write_to_file(fd, filename, content)
  local result = uv.fs_ftruncate(fd, 0)
  if result then
    uv.fs_fsync(fd)
    uv.fs_close(fd)
    fd = uv.fs_open(filename, "w+", tonumber("755", 8))
    if not fd then
      vim.api.nvim_err_write("Current user don't have permissions to create file!")
      return
    end
    uv.fs_write(fd, content)
  else
    vim.api.nvim_err_write("Cannot truncate the file!")
  end
  uv.fs_close(fd)
end

M.enable = function()
  local settings_path = find_app_root_path() .. "/.settings"
  local settings_folder = uv.fs_opendir(settings_path)
  if not settings_folder then
    return
  end

  local eclipse_jdt_ls_core_prefs = settings_path .. "/org.eclipse.jdt.core.prefs"

  local prefs_file = uv.fs_open(eclipse_jdt_ls_core_prefs, "r+", tonumber("755", 8))
  if not prefs_file then
    return
  end

  local content = uv.fs_read(prefs_file, uv.fs_stat(eclipse_jdt_ls_core_prefs).size, -1)
  content = append_or_change_preview_prefs(content)

  write_to_file(prefs_file, eclipse_jdt_ls_core_prefs, content)
end

M.disable = function()
  local eclipse_jdt_ls_core_prefs = find_path_to_prefs("/org.eclipse.jdt.core.prefs")
  if not eclipse_jdt_ls_core_prefs then
    return
  end

  local prefs_file = uv.fs_open(eclipse_jdt_ls_core_prefs, "r+", tonumber("755", 8))
  if not prefs_file then
    prefs_file = uv.fs_open(eclipse_jdt_ls_core_prefs, "w+", tonumber("755", 8))
  end
  if not prefs_file then
    vim.api.nvim_err_write("Current user don't have permissions to create file!")
    return
  end

  local content = uv.fs_read(prefs_file, uv.fs_stat(eclipse_jdt_ls_core_prefs).size, -1)
  content = remove_preview_prefs(content)

  write_to_file(prefs_file, eclipse_jdt_ls_core_prefs, content)
end

return M
