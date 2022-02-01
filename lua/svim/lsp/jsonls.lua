local M = {}

function M.setup(opts)
    local schemastore_status_ok, schemastore = pcall(require, "schemastore")
    if schemastore_status_ok then
        opts["settings"] = {
            json = {
                schemas = schemastore.json.schemas(),
            },
        }
        -- require("svim.utils").print_table(opts.settings.json)
    end
    return opts
end

return M
