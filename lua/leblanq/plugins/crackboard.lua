return {
    require('lazy').setup({
        {
            'boganworld/crackboard.nvim',
            dependencies = { 'nvim-lua/plenary.nvim' },
            config = function()
                require('crackboard').setup({
                    session_key = 'xx',
                })
            end,
        }
    })
}
