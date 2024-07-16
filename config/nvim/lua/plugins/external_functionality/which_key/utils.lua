local M = {}

---@param keymaps table The list of keymaps
---@param properties table? The properties which is need to inject into every keymap from keymaps
function M.apply_props(keymaps, properties)
  if not properties then
    return keymaps
  end

  for _, keymap in ipairs(keymaps) do
    for prop_name, prop_val in pairs(properties) do
      if not keymap[prop_name] then
          keymap[prop_name] = prop_val
      end
    end
  end

  return keymaps
end

---@param dest table The destination table, in which will be copied values from source
---@param source table The source table. Must be a list!
local function insert_all_into(dest, source)
  for _, val in ipairs(source) do
    table.insert(dest, val)
  end
end

local function tbl_flatmap(callback, tbl)
  local mapped_tbl = {}
  for key, value in pairs(tbl) do
    local result = callback(key, value)
    if result then
      insert_all_into(mapped_tbl, result)
    end
  end

  return mapped_tbl
end

---@param keymaps table The keymaps which have groups will be expanded for which-key.
function M.expand(keymaps)
  local expanded_keymaps = {}

  for key, subkeymaps in pairs(keymaps) do
    if subkeymaps.name ~= nil then
      local group_name = subkeymaps.name
      subkeymaps.name = nil

      subkeymaps = tbl_flatmap(function(inner_key, inner_value)
          return M.expand({ [inner_key] = inner_value })
        end,
        subkeymaps
      )
      -- INFO: group definition
      table.insert(subkeymaps, { key, group = group_name })

      insert_all_into(expanded_keymaps, vim.tbl_map(function(submapping)
          if type(submapping[1]) == "function" then
            return { key, table.unpack(submapping) }
          elseif type(submapping[1]) == "string" then
            if submapping[2] ~= nil or submapping[1] ~= key then
              submapping[1] = key .. submapping[1]
            end
            return submapping
          else
            vim.notify("Invalid type in keymapping. Skipped.", vim.log.levels.WARN)
            return nil
          end
        end,
        subkeymaps
      ))
    elseif subkeymaps.desc ~= nil then
      local expanded_keymap = { key, subkeymaps[1] }
      subkeymaps[1] = nil

      table.insert(expanded_keymaps, M.apply_props({ expanded_keymap }, subkeymaps)[1])
    else
      vim.notify("Invalid type in keymapping. Skipped.", vim.log.levels.WARN)
    end
  end

  return expanded_keymaps
end

---@param keymaps table The keymappings for which will be applied the given prefix
---@param prefix string? The prefix
function M.with_prefix(keymaps, prefix)
  if not prefix then
    return keymaps
  end

  return vim.tbl_map(function(keymap)
      keymap[1] = prefix .. keymap[1]
      return keymap
    end,
    keymaps
  )
end

--- The general function which can apply 'expand', 'with_prefix' and 'apply_props'
--- in one time. Instead of providing 'prefix' as argument, pass into props table
--- for readability.
---
---@param keymaps table The keymaps in old which-key variant
---@param props table? the keymapping properties
function M.keymaps(keymaps, props)
  local prefix = props and props.prefix or nil
  if props then
    props.prefix = nil
  end

  return M.apply_props(M.with_prefix(M.expand(keymaps), prefix), props)
end

return M
