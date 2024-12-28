return {
    require('lazy').setup({
        {
            'boganworld/crackboard.nvim',
            dependencies = { 'nvim-lua/plenary.nvim' },
            config = function()
                require('crackboard').setup({
                    session_key = '89b25402e5f9293d32b846df392efd3435cb8bbd606a81497ecb74e91bea3e29',
                })
            end,
        }
    })
}
