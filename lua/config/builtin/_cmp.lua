-- [[ Configure nvim-cmp ]]--
-- See `:help cmp`
-- gpt
-- TEMP FIX for cmp-nvim-lsp on Neovim < 0.11
if not vim.lsp._with_bufnr_fix then
  local old_request = vim.lsp.buf_request
  vim.lsp.buf_request = function(bufnr, method, params, handler)
    if type(bufnr) == "function" then
      -- backward compatibility fix
      bufnr = vim.api.nvim_get_current_buf()
    end
    return old_request(bufnr, method, params, handler)
  end
  vim.lsp._with_bufnr_fix = true
end
-- end gpt
local cmp = require 'cmp'
local luasnip = require 'luasnip'
require('luasnip.loaders.from_vscode').lazy_load()
luasnip.config.setup {}

cmp.setup {
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	mapping = cmp.mapping.preset.insert {
		['<C-n>'] = cmp.mapping.select_next_item(),
		['<C-p>'] = cmp.mapping.select_prev_item(),
		['<C-d>'] = cmp.mapping.scroll_docs(-4),
		['<C-f>'] = cmp.mapping.scroll_docs(4),
		['<C-Space>'] = cmp.mapping.complete {},
		['<CR>'] = cmp.mapping.confirm {
			behavior = cmp.ConfirmBehavior.insert,
			select = false,
		},
		['<S-Tab>'] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif luasnip.expand_or_locally_jumpable() then
				luasnip.expand_or_jump()
			else
				fallback()
			end
		end, { 'i', 's' }),
		-- ['<S-Tab>'] = cmp.mapping(function(fallback)
		-- 	if cmp.visible() then
		-- 		cmp.select_prev_item()
		-- 	elseif luasnip.locally_jumpable(-1) then
		-- 		luasnip.jump(-1)
		-- 	else
		-- 		fallback()
		-- 	end
		-- end, { 'i', 's' }),
	},
	sources = {
		{ name = 'nvim_lsp' },
		{ name = 'luasnip' },
	},
}
