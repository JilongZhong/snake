local Body = class("Body")

function Body:ctor( snake, x, y, node, isHead )
	self.snake = snake
	self.X = x
	self.Y = y

	if isHead then
		self.sp = cc.Sprite:create("CloseSelected.png")
	else
		self.sp = cc.Sprite:create("g.png")
	end

	node:addChild(self.sp)

	self:Update()
end

function Body:Update()

	local posx,posy = Grid2Pos(self.X, self.Y)

	self.sp:setPosition(posx, posy)

end

return Body