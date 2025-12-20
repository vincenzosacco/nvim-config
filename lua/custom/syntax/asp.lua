-- lua/custom/syntax/asp.lua
local M = {}

local function set_asp_highlights()
  local set_hl = vim.api.nvim_set_hl
  -- Linking to standard groups ensures colors update with your theme
  set_hl(0, "ASPComment", { link = "Comment" })
  set_hl(0, "ASPKeyword", { link = "PreProc" }) -- #const, #sum
  set_hl(0, "ASPArrow", { link = "Operator" }) -- :-
  set_hl(0, "ASPVariable", { link = "Type" }) -- Capitalized words
  set_hl(0, "ASPPredicate", { link = "Function" }) -- lowercase(
  set_hl(0, "ASPNumber", { link = "Number" })
  set_hl(0, "ASPOperator", { link = "Special" }) -- +, -, *, =, etc
end

local function define_asp_syntax()
  vim.cmd "syntax clear"

  local function match(group, pattern)
    vim.cmd("syntax match " .. group .. ' "' .. pattern .. '"')
  end

  -- 1. COMMENTS (Must be first)
  match("ASPComment", [[%.*]]) -- Standard % comment

  -- 2. AGGREGATES & DIRECTIVES (#keyword)
  match("ASPKeyword", [[#[a-z]\+]])

  -- 3. THE RULE ARROW (:-)
  -- We match it simply as a symbol. No complex lookbehind needed.
  match("ASPArrow", [[:-\s*]])
  match("ASPArrow", [[:\~]]) -- Weak constraint arrow

  -- 4. VARIABLES (Start with Uppercase or Underscore)
  match("ASPVariable", [[\<[A-Z_][a-zA-Z0-9_]*\>]])

  -- 5. PREDICATES (Start with lowercase, strictly followed by '(' )
  -- \ze sets the "end of match" so we highlight the word but not the '('
  match("ASPPredicate", [[\<[a-z][a-zA-Z0-9_]*\ze(]])

  -- 6. NUMBERS
  match("ASPNumber", [[\<[0-9]\+\>]])

  -- 7. BASIC OPERATORS
  match("ASPOperator", [[=]])
  match("ASPOperator", [[!=]])
  match("ASPOperator", [[<]])
  match("ASPOperator", [[>]])
  match("ASPOperator", [[+]])
  match("ASPOperator", [[-]])
  match("ASPOperator", [[\.\.]]) -- Range dots (1..4)
  match("ASPOperator", [[\.$]]) -- End of rule dot

  -- 8. LOGICAL KEYWORDS
  match("ASPOperator", [[\<not\>]])
end

M.apply_syntax = function()
  set_asp_highlights()
  define_asp_syntax()
  -- This tells Neovim: "When commenting, put a '%' followed by a space (%s is the code)"
  vim.bo.commentstring = "% %s"
  vim.cmd "let b:current_syntax = 'azsp'"
end

return M
