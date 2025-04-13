--[[
--NOTE: This is where your plugins go! put them in brackets like the following. Lazy will automatically pick them up and install them
--If you feel like this plugin is useful, feel free to git add commit push and make a pull request from your fork on GitHub. If there is a good, general use-case, I will merge it into the main branch :)
]]--

return {
  -- The naming convention is "GitHub Profile/GitHub Repo"
  --example:
  -- 'elkowar/yuck.vim'
  'Ayoubkrif/42-nvim',

  -- Add GitHub Copilot plugin
  {
    'github/copilot.vim',
    event = 'InsertEnter', -- Load Copilot on insert mode
    config = function()
      -- Optional: Configure Copilot settings
      vim.g.copilot_no_tab_map = true
      vim.api.nvim_set_keymap('i', '<C-J>', 'copilot#Accept("<CR>")', { silent = true, expr = true })
    end,
  },

vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "*.c,*.h",
  callback = function()
    vim.cmd([[
      syntax match DebugMacro /\<DBG\s*\>/ containedin=ALL
      highlight DebugMacro guifg=#5c6370 ctermfg=8
    ]])
  end,
})

}
