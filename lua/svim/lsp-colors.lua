local status_ok, lsp_colors = pcall(require, "lsp-colors")
if not status_ok then
	return
end

lsp_colors.setup()
