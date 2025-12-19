local M = {}

-- 1. HELPER FUNCTION
local function darken(hex, amount)
  hex = hex:gsub("#", "")
  local r = tonumber(hex:sub(1, 2), 16)
  local g = tonumber(hex:sub(3, 4), 16)
  local b = tonumber(hex:sub(5, 6), 16)

  r = math.max(0, r - amount)
  g = math.max(0, g - amount)
  b = math.max(0, b - amount)
  return string.format("#%02x%02x%02x", r, g, b)
end

-- 2. Base Colors (Palette Dark Mode)
local dark = {
  green = "#a6da95",
  cyan = "#75a9b4",
  yellow = "#e5c890",
  text = "#f0f0f0",
  red = "#ed8796",
}
dark.comment = darken(dark.text, 100)
dark.dark_green = darken(dark.green, 100)

--Function (not global scope) for dynamic change theme
-- Dynamic get highligh colors ( dark or light)
M.get_highlights = function()
  local is_light = vim.o.background == "light"

  local light = {
    cyan = darken(dark.cyan, 50),
    dark_green = dark.dark_green,
    green = darken(dark.green, 100),
    yellow = darken(dark.yellow, 50),
    text = "#444444",
    red = darken(dark.red, 50),
  }
  light.comment = darken(light.text, -100)

  -- Seleziona la palette attiva
  local c = is_light and light or dark

  -- Restituisce la tabella completa
  return {
    --====================== C/C++
    ["Macro"] = { fg = c.cyan, bold = true },
    ["@constant.macro"] = { fg = c.cyan, bold = true },
    ["PreProc"] = { fg = c.cyan, bold = true },
    ["cBlock"] = { fg = c.cyan, bold = false },

    --======================= Python
    ["pythonBuiltin"] = { fg = c.cyan, italic = true },
    ["@function.builtin.python"] = { fg = c.cyan, italic = true },
    --====================== Global

    -- GREEN
    ["Include"] = { fg = c.dark_green, bold = true },
    ["Statement"] = { fg = c.green },
    ["Repeat"] = { fg = c.green },
    ["Type"] = { fg = c.green },
    ["Structure"] = { fg = c.green },
    ["Conditional"] = { fg = c.green },
    ["Boolean"] = { fg = c.green },
    ["@keyword.conditional"] = { fg = c.green },
    ["@keyword.function"] = { fg = c.green },
    ["@keyword.operator"] = { fg = c.green },
    ["Operator"] = { fg = c.green },
    ["@keyword"] = { fg = c.green },
    ["@keyword.return"] = { fg = c.green },

    -- DARK GREEN

    -- Text Color
    ["Function"] = { fg = c.text },
    ["@function"] = { fg = c.text },
    ["@function.call"] = { fg = c.text },
    ["@function.method.call"] = { fg = c.text },
    ["@function.builtin"] = { fg = c.text },
    ["@variable"] = { fg = c.text },
    ["@variable.member"] = { fg = c.text },
    ["@constant"] = { fg = c.text },
    ["@variable.parameter"] = { fg = c.text },
    ["@property"] = { fg = c.text, italic = true },
    ["Special"] = { fg = c.text },

    -- Cyan
    ["SpecialChar"] = { fg = c.cyan, bold = true },
    ["@character"] = { fg = c.cyan },
    ["@string"] = { fg = c.cyan },
    ["String"] = { fg = c.cyan },
    ["Number"] = { fg = c.cyan },
    ["@number"] = { fg = c.cyan },
    -- No color (Based on theme)
    ["Comment"] = { fg = c.comment, italic = true },
    ["@comment"] = { fg = c.comment, italic = true },

    -- Yellow (Gold)
    ["Todo"] = { fg = c.yellow, bold = true },
    ["@text.todo"] = { fg = c.yellow, bold = true },
    ["WarningMsg"] = { fg = c.yellow, bold = true },

    -- Red
    ["Exception"] = { fg = c.red },
  }
end

return M
