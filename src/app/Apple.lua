local Apple = class("Apple")

function Apple:ctor(bound, node)

	self.bound = bound
	self.node = node 

	math.randomseed(os.time())

	self:Generate()

end

local function getPos(bound)
	return math.random(-bound, bound)
end

function Apple:Generate()

	if self.appleSprite ~= nil then
		self.node:removeChild(self.appleSprite)
	end

	local sp = cc.Sprite:create("g.png")

	local genBoundLimit = self.bound - 1

	local x,y = getPos(genBoundLimit),getPos(genBoundLimit)
	local finalX,finalY = Grid2Pos(x, y)

	sp:setPosition(finalX, finalY)
	self.node:addChild(sp)

	self.appleX = x
	self.appleY = y

	self.appleSprite = sp

end

function Apple:CheckCollide(x, y)

	if x == self.appleX and y == self.appleY then
		return true
	else
		return false
	end

end

function Apple:Reset()

	self.node:removeChild(self.appleSprite)

end

return Apple