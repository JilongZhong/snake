local gameSetting = class("gameSetting")

function gameSetting:gameSet(i, s)

	increment = i;
	cMoveSpeed = s;
	
end

function gameSetting:gameGet()

	-- local increment = increment or 1
	-- local cMoveSpeed = cMoveSpeed or 0.3

	return increment or 1, cMoveSpeed or 0.3

end

return gameSetting