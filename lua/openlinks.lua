local M = {}

local function get_link_under_cursor()
	local line = tostring(vim.api.nvim_get_current_line())

	-- simple URL regex (http, https, ftp)
	local pattern = "https?://[%w-_%.%?%.:/%+=&]+"

	for w in string.gmatch(line, pattern) do
		return w
	end

	-- 	for start_idx, end_idx in line:gmatch("()(" .. pattern .. ")()") do
	-- 		-- check if cursor column is inside the match
	-- 		if col + 1 >= start_idx and col < end_idx then
	-- 			return line:sub(start_idx, end_idx - 1)
	-- 		end
	-- 	end
	return nil
end

M.openlink = function()
	local link = get_link_under_cursor()
	if not link then
		print("No link under cursor")
		return
	end

	-- escape URL properly
	os.execute(string.format("xdg-open '%s' &", link))
	print("Successfully opened link: " .. link)
end

print("made it here")

vim.api.nvim_create_user_command("Openlink", function()
	local link = get_link_under_cursor()
	if not link then
		print("No link under cursor")
		return
	end

	-- escape URL properly
	os.execute(string.format("xdg-open '%s' &> /dev/null 2>&1", link))
	print("Successfully opened link: " .. link)
end, {})

M.setup = function(opts)
end
return M
