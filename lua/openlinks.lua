local M = {}

local function get_link_under_cursor()
	local row, col = unpack(vim.api.nvim_win_get_cursor(0))
	local line = vim.api.nvim_get_current_line()

	-- simple URL regex (http, https, ftp, file)
	local pattern = "https?://[%w-_%.%?%.:/%+=&]+"

	for start_idx, end_idx in line:gmatch("()(" .. pattern .. ")()") do
		-- check if cursor column is inside the match
		if col + 1 >= start_idx and col < end_idx then
			return line:sub(start_idx, end_idx - 1)
		end
	end
	return nil
end

M.setup = function()
	print ("made it here") 
	vim.api.nvim_create_user_command("Openlink", function()
		local link = get_link_under_cursor()
		if link == nil then
			print("No links under cursor")
		end

		os.execute(string.format("xdg-open %s", link))
		print("Successfully opened link")
	end)
end

return M
