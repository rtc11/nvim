local colors = {
    orange = '#FFb436',
    green = '#46830c',
    lightpurple = '#ff80ff',
    red = '#f92672',
    rose = '#fA3592',
    gray = '#7d7d7d',
    yellow = '#ffbf80',
    black = '#222222',
    none = 'NONE',
}

return {
    normal = {
        a = { bg = colors.none, fg = colors.orange },
        b = { bg = colors.none, fg = colors.yellow },
        c = { bg = colors.black, fg = colors.gray }
    },
    insert = {
        a = { bg = colors.none, fg = colors.green },
        b = { bg = colors.none, fg = colors.yellow },
        c = { bg = colors.black, fg = colors.gray }
    },
    visual = {
        a = { bg = colors.none, fg = colors.lightpurple },
        b = { bg = colors.none, fg = colors.yellow },
        c = { bg = colors.black, fg = colors.gray }
    },
    replace = {
        a = { bg = colors.none, fg = colors.red },
        b = { bg = colors.none, fg = colors.yellow },
        c = { bg = colors.black, fg = colors.gray }
    },
    command = {
        a = { bg = colors.none, fg = colors.rose },
        b = { bg = colors.none, fg = colors.yellow },
        c = { bg = colors.black, fg = colors.gray }
    },
    inactive = {
        a = { bg = colors.none, fg = colors.gray },
        b = { bg = colors.none, fg = colors.gray },
        c = { bg = colors.black, fg = colors.gray }
    }
}
