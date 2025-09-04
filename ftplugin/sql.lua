vim.keymap.set("n", "<leader>x", function()
    vim.cmd('w')
    local dbt_project_root = vim.fn.findfile('dbt_project.yml', '.;')
    if dbt_project_root ~= '' then
        dbt_project_root = vim.fn.fnamemodify(dbt_project_root, ':h')
    else
        dbt_project_root = vim.loop.cwd()
    end
    local model_name = vim.fn.expand('%:t:r')  -- Get filename without extension
    vim.cmd('cd ' .. dbt_project_root)
    vim.cmd('term dbt run --select ' .. model_name)
end, { silent = false })
