local Fence = class("Fence")

local function fenceGenerator(node, bound, callback)

	for i = -bound,bound do
		local sp = cc.Sprite:create("za.png")
		local posx,posy = callback(i)
		sp:setPosition(posx, posy)
		node:addChild(sp)
	end

end

function Fence:ctor(bound, node)
	
	self.bound = bound
	-- self.increment = 1
	-- self.cMoveSpeed = 0.3

	if bound then

		--up
		fenceGenerator(node, bound, function(i)
			return Grid2Pos(i, bound)
		end)

		fenceGenerator(node, bound, function(i)
			return Grid2Pos(i, -bound)
		end)

		--left
		fenceGenerator(node, bound, function(i)
			return Grid2Pos(bound, i)
		end)

		fenceGenerator(node, bound, function(i)
			return Grid2Pos(-bound, i)
		end)

	end

end

-- function Fence:gameSet(i, s)

-- 	self.increment = i;
-- 	self.cMoveSpeed = s;
	
-- end

-- function Fence:gameGet()

-- 	local increment = self.increment or 1
-- 	local cMoveSpeed = self.cMoveSpeed or 0.3

-- 	return increment, cMoveSpeed

-- end

function Fence:CheckCollide(x, y)

	return x == self.bound or x == - self.bound or y == self.bound or y == -self.bound

end

return Fence