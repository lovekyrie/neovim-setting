local M = {}

local html_script_type_languages = {
  importmap = "json",
  module = "javascript",
  ["application/ecmascript"] = "javascript",
  ["text/ecmascript"] = "javascript",
}

local non_filetype_match_injection_language_aliases = {
  ex = "elixir",
  pl = "perl",
  sh = "bash",
  ts = "typescript",
  uxn = "uxntal",
}

local function first_node(match, capture)
  local captured = match[capture]
  if type(captured) == "table" then
    return captured[1]
  end
  return captured
end

local function get_parser_from_markdown_info_string(injection_alias)
  local match = vim.filetype.match({ filename = "a." .. injection_alias })
  return match or non_filetype_match_injection_language_aliases[injection_alias] or injection_alias
end

local function valid_args(name, pred, count, strict_count)
  local arg_count = #pred - 1
  if strict_count then
    return arg_count == count
  end
  return arg_count >= count
end

function M.apply()
  if vim.fn.has("nvim-0.12") == 0 then
    return
  end

  local ok, query = pcall(require, "vim.treesitter.query")
  if not ok then
    return
  end

  local opts = { force = true }

  query.add_predicate("nth?", function(match, _pattern, _bufnr, pred)
    if not valid_args("nth?", pred, 2, true) then
      return false
    end

    local node = first_node(match, pred[2])
    local n = tonumber(pred[3])
    return node ~= nil
      and n ~= nil
      and node:parent()
      and node:parent():named_child_count() > n
      and node:parent():named_child(n) == node
  end, opts)

  query.add_predicate("is?", function(match, _pattern, bufnr, pred)
    if not valid_args("is?", pred, 2) then
      return false
    end

    local node = first_node(match, pred[2])
    if not node then
      return true
    end

    local locals_ok, locals = pcall(require, "nvim-treesitter.locals")
    if not locals_ok then
      return false
    end

    local _, _, kind = locals.find_definition(node, bufnr)
    return vim.tbl_contains({ unpack(pred, 3) }, kind)
  end, opts)

  query.add_predicate("kind-eq?", function(match, _pattern, _bufnr, pred)
    if not valid_args(pred[1], pred, 2) then
      return false
    end

    local node = first_node(match, pred[2])
    if not node then
      return true
    end

    return vim.tbl_contains({ unpack(pred, 3) }, node:type())
  end, opts)

  query.add_directive("set-lang-from-mimetype!", function(match, _, bufnr, pred, metadata)
    local node = first_node(match, pred[2])
    if not node then
      return
    end

    local type_attr_value = vim.treesitter.get_node_text(node, bufnr)
    local configured = html_script_type_languages[type_attr_value]
    if configured then
      metadata["injection.language"] = configured
      return
    end

    local parts = vim.split(type_attr_value, "/", {})
    metadata["injection.language"] = parts[#parts]
  end, opts)

  query.add_directive("set-lang-from-info-string!", function(match, _, bufnr, pred, metadata)
    local node = first_node(match, pred[2])
    if not node then
      return
    end

    local injection_alias = vim.treesitter.get_node_text(node, bufnr):lower()
    metadata["injection.language"] = get_parser_from_markdown_info_string(injection_alias)
  end, opts)

  query.add_directive("make-range!", function() end, opts)

  query.add_directive("downcase!", function(match, _, bufnr, pred, metadata)
    local id = pred[2]
    local node = first_node(match, id)
    if not node then
      return
    end

    local text = vim.treesitter.get_node_text(node, bufnr, { metadata = metadata[id] }) or ""
    metadata[id] = metadata[id] or {}
    metadata[id].text = string.lower(text)
  end, opts)
end

return M
