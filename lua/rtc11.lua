local api = vim.api;

local M = {};

M.colors = {
    orange    = '#FFb436',
    green     = '#46830c',
    limegreen = '#98f842',
    red       = '#f92672',
    lightblue = '#3a8998',
    rose      = '#fA3592',
    gray      = '#7f7f7f',
    darkgray  = '#444444',
    lightgray = '#606060',
    yellow    = '#ffbf80',
    black     = '#222222',
    white     = '#f0f0e0',
    none      = 'NONE',
    dark      = '#060407'
}

M.stylings = {
    i = 'italic',
    italic = 'italic',
    b = 'bold',
    bold = 'bold',
    bi = 'bold,italic',
    bold_italic = 'bold,italic',
    underline = 'underline',
    u = 'underline',
    reverse = 'reverse',
    r = 'reverse',
    rb = 'reverse,bold',
}

function M.highlight(group, style)
    local gui = style.gui and 'gui=' .. style.gui or 'gui=NONE'
    local fg  = style.fg and 'guifg=' .. style.fg or 'guifg=NONE'
    local bg  = style.bg and 'guibg=' .. style.bg or 'guibg=NONE'
    local sp  = style.sp and 'guisp=' .. style.sp or ''
    api.nvim_command('hi ' .. group .. ' ' .. gui .. ' ' .. fg .. ' ' .. bg .. ' ' .. sp)
end

function M.load_colors()
    local colors                          = M.colors
    local styles                          = M.stylings
    local syntax                          = {

        -- naming conventions
        Comment                    = { fg = colors.gray, bg = colors.none, gui = colors.none },

        Constant                   = { fg = colors.rose, bg = colors.none, gui = styles.i },
        String                     = { fg = colors.yellow, bg = colors.none, gui = colors.none }, -- "hello"
        Character                  = { fg = colors.yellow, bg = colors.none, gui = colors.none }, -- 'c', '\n'
        Number                     = { fg = colors.yellow, bg = colors.none, gui = colors.none }, -- 234, 0xff
        Boolean                    = { fg = colors.yellow, bg = colors.none, gui = colors.none }, -- TRUE, false
        Float                      = { fg = colors.yellow, bg = colors.none, gui = colors.none }, -- 2.3e10

        -- Identifier                 = { fg = colors.rose, bg = colors.none, gui = styles.none }, -- variable name
        Function                   = { fg = colors.white, bg = colors.none, gui = colors.none }, -- function name, methods for classes

        Statement                  = { fg = colors.white, bg = colors.none, gui = colors.none },
        Conditional                = { fg = colors.red, bg = colors.none, gui = styles.i },          -- if, then, else, endif, switch, etc
        Repeat                     = { fg = colors.rose, bg = colors.none, gui = styles.i },         -- for, do, while, etc
        Label                      = { fg = colors.yellow, bg = colors.none, gui = colors.none },    -- case, default, etc
        Operator                   = { fg = colors.yellow, bg = colors.none, gui = colors.none },    -- sizeof, +, *, etc
        Keyword                    = { fg = colors.orange, bg = colors.none, gui = styles.bold },
        Exception                  = { fg = colors.orange, bg = colors.none, gui = styles.bold },    -- try, catch, throw

        PreProc                    = { fg = colors.white, bg = colors.none, gui = colors.none },     -- generic preprocessor
        Include                    = { fg = colors.white, bg = colors.none, gui = colors.none },     -- preprocessor #include
        Define                     = { fg = colors.red, bg = colors.none, gui = colors.none },       -- preprocessor #define
        Macro                      = { fg = colors.red, bg = colors.none, gui = colors.none },       -- same as Define
        PreCondit                  = { fg = colors.red, bg = colors.none, gui = colors.none },       -- preprocessor #if, #else, #endif, etc

        Type                       = { fg = colors.white, bg = colors.none, gui = styles.b },        -- int, long, char, etc
        StorageClass               = { fg = colors.yellow, bg = colors.none, gui = styles.none },    -- static, register, volatile, etc
        Structure                  = { fg = colors.lightblue, bg = colors.none, gui = styles.none }, -- struct, union, enum, etc
        TypeDef                    = { fg = colors.white, bg = colors.none, gui = styles.none },

        Special                    = { fg = colors.gray, bg = colors.none, gui = colors.none },      -- any special symbol
        SpecialChar                = { fg = colors.gray, bg = colors.none, gui = colors.none },      -- special char in a constant
        Tag                        = { fg = colors.rose, bg = colors.none, gui = colors.none },      -- you can use CTRL-] on this (vim)
        Deliminiter                = { fg = colors.rose, bg = colors.none, gui = colors.none },
        SpecialComment             = { fg = colors.white, bg = colors.none, gui = colors.none },     -- special things inside comments
        Debug                      = { fg = colors.white, bg = colors.none, gui = colors.none },     -- debugging statements

        Underlined                 = { fg = colors.none, bg = colors.none, gui = styles.underline }, -- text that stands out, HTML links

        -- :highlight
        ColorColumn                = { fg = colors.none, bg = colors.black, gui = colors.none }, -- vim.opt.colorcolumn
        Cursor                     = { fg = colors.rose, bg = colors.white, gui = colors.none },
        CursorColumn               = { fg = colors.none, bg = colors.dark, gui = colors.none },  -- vim.opt.cursorcolumn
        CursorLine                 = { bg = colors.dark },                                       -- vim.opt.cursorline
        CursorLineNr               = { fg = colors.orange, gui = styles.bold },                  -- vim.opt.cursorline

        Directory                  = { fg = colors.lightblue, bg = colors.none, gui = colors.none },

        DiffAdd                    = { fg = colors.limegreen, bg = colors.green, gui = styles.bold },   -- line added
        DiffChange                 = { fg = colors.yellow, bg = colors.cobalt, gui = colors.none },     -- line changed
        DiffDelete                 = { fg = colors.red, bg = colors.none, gui = colors.none },          -- line deleted
        DiffText                   = { fg = colors.yellow, bg = colors.darkblue, gui = styles.bold },   -- text in line changed

        ErrorMsg                   = { fg = colors.white, bg = colors.red, gui = colors.none },         -- error msg on the command line
        WinSeparator               = { fg = colors.lightblue, bg = colors.none, gui = colors.none },    -- separators between window splits
        Folded                     = { fg = colors.gray, bg = colors.black, gui = colors.none },        -- line used for closed folds
        SignColumn                 = {},                                                                -- column where signs are displayed
        IncSearch                  = { fg = colors.rose, bg = colors.black, gui = styles.r },           -- incsearch and search-replace :s/search/replace/gc
        LineNr                     = { fg = colors.gray, },                                             -- line number for :number and :#
        MatchParen                 = { fg = colors.red, bg = colors.none, gui = styles.underline },     -- char under cursor if it is paired with bracket

        NonText                    = { fg = colors.none, bg = colors.none, gui = colors.none },         -- '@' at the end of the window (line overflow)
        Normal                     = { fg = colors.lightgray, bg = colors.none, gui = colors.none },
        Pmenu                      = { fg = colors.lightblue, bg = colors.none, gui = colors.none },    -- popup menu: normal item
        PmenuSel                   = { fg = colors.none, bg = colors.black, gui = colors.none },        -- popup menu: selected item
        PmenuKind                  = { fg = colors.orange, bg = colors.black, gui = colors.none },      -- popup menu: item kind
        PmenuKindSel               = { fg = colors.none, bg = colors.black, gui = colors.none },        -- popup menu: selected item kind
        PmenuExtra                 = { fg = colors.lightgray, bg = colors.black, gui = colors.none },   -- popup menu: normal item extra text

        Search                     = { fg = colors.rose, bg = colors.darkblue, gui = colors.none },     -- last search pattern highlight :hlsearch
        SpecialKey                 = { fg = colors.darkgray, bg = colors.offblack, gui = colors.none }, -- unprintable chars
        StatusLine                 = { fg = colors.yellow, bg = colors.gray, gui = styles.bold },       -- status line of current window
        StatusLineNC               = { fg = colors.orange, bg = colors.none, gui = colors.none },       -- status line non-current windows
        TabLine                    = {},                                                                -- tab pages line, not active tab page label
        Title                      = { fg = colors.white, bg = colors.none, gui = styles.bold },        -- titles for output from :set all, :autocmd, etc
        Visual                     = { fg = colors.black, bg = colors.lightblue, gui = colors.none },   -- visual mode selection
        WarningMsg                 = { fg = colors.white, bg = colors.brown, gui = colors.none },       -- warning messages

        Whitespace                 = { fg = colors.darkgray },                                          -- nbsp, space, tab, multispace, lead, trail

        -- Diagnostics
        DiagnosticError            = { fg = colors.red, bg = colors.offblack },
        DiagnosticHint             = { fg = colors.lightblue, bg = colors.offblack },
        DiagnosticInfo             = { fg = colors.limegreen, bg = colors.offblack },
        DiagnosticWarn             = { fg = colors.orange, bg = colors.offblack },
        DiagnosticUnnecessary      = { fg = colors.darkgray, gui = styles.u },

        DiagnosticSignError        = { fg = colors.red, bg = colors.none },
        DiagnosticSignHint         = { fg = colors.lightblue, bg = colors.none },
        DiagnosticSignInfo         = { fg = colors.limegreen, bg = colors.none },
        DiagnosticSignWarn         = { fg = colors.orange, bg = colors.none },

        DiagnosticVirtualTextError = { fg = colors.red, bg = colors.none },
        DiagnosticVirtualTextHint  = { fg = colors.lightblue, bg = colors.none },
        DiagnosticVirtualTextInfo  = { fg = colors.limegreen, bg = colors.none },
        DiagnosticVirtualTextWarn  = { fg = colors.orange, bg = colors.none },

        -- PLUGIN COLORS

        -- GitGutter
        GitGutterAdd               = { fg = colors.green },
        GitGutterChange            = { fg = colors.lightblue },
        GitGutterDelete            = { fg = colors.red },

        -- Fugitive
        diffOldFile                = { fg = colors.red },
        diffNewFile                = { fg = colors.green },
        diffAdded                  = { fg = colors.limegreen },
        diffRemoved                = { fg = colors.red },
        gitDiff                    = { fg = colors.gray },

        -- Rust
        RustInlay                  = { fg = colors.gray },

    }

    -- TRESITTER
    syntax["@constructor.kotlin"]         = { fg = colors.orange };
    syntax["@punctuation.bracket.kotlin"] = { fg = colors.lightblue };
    syntax["@punctuation.special.kotlin"] = { fg = colors.lightblue };
    syntax["@variable.kotlin"]            = { fg = colors.white, gui = styles.none };
    syntax["@boolean.kotlin"]             = { fg = colors.white, gui = styles.none };
    syntax["@variable.builtin.kotlin"]    = { fg = colors.white, gui = styles.none };
    syntax["@type.builtin.kotlin"]        = { fg = colors.white, gui = styles.b };
    syntax["@function.builtin.kotlin"]    = { fg = colors.white, gui = styles.none };
    syntax["@type.builtin.c"]             = { fg = colors.white, gui = styles.none };
    -- syntax["@attribute.zig"]                     = { fg = colors.};
    -- syntax["@variable"]                          = { fg = colors.lightblue, gui = styles.none };
    -- syntax["@type.qualifier"]                    = { fg = colors.seablue };
    -- syntax["@keyword.return"]                    = { fg = colors.orange };
    -- syntax["@keyword.repeat"]                    = { fg = colors.rose };
    -- syntax["@keyword.conditional"]               = { fg = colors.rose };

    -- LSP SEMANTIC HIGHLIGHTS
    syntax["@lsp.type.property.kotlin"]   = { fg = colors.white };
    -- syntax["@lsp.type.enumMember.kotlin"] = { fg = colors.rose };
    -- syntax["@lsp.type.enum.kotlin"]       = { fg = colors.white };
    -- syntax["@lsp.type.class.kotlin"]      = { fg = colors.white, gui = styles.none };

    -- syntax["@lsp.type.namespace"]             = { fg = colors.white };
    -- syntax["@lsp.type.property"]                 = { fg = colors.white };
    -- syntax["@lsp.type.parameter"]                = { fg = colors.white };
    syntax["@lsp.type.variable"]          = { fg = colors.white, gui = styles.none };
    -- syntax["@lsp.type.label"]                    = { fg = colors.red };
    -- syntax["@lsp.mod.declaration"]               = { gui = styles.i };
    -- syntax["@lsp.type.errorTag"]                 = { fg = colors.lightblue, bg = colors.none, gui = styles.b }
    -- syntax["@lsp.typemod.comment.documentation"] = { fg = colors.lightgray, gui = styles.b }

    syntax["@constant.kotlin"]            = { fg = colors.rose, gui = styles.i };
    return syntax
end

function M.colorscheme()
    if vim.fn.exists('syntax_on') then
        api.nvim_command('syntax reset')
    end
    vim.o.background = 'dark'
    vim.o.termguicolors = true
    vim.g.colors_name = 'rtc11'
    local syntax = M.load_colors()
    for group, style in pairs(syntax) do
        M.highlight(group, style)
    end
end

return M
