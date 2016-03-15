local Snake = class("Snake")
local Body = require("app.Body")

local  cInitLen = 3

function Snake:ctor(node)

	self.BodyArr = {}
	self.node = node

	for i = 1,cInitLen do
		self:Grow(i == 1)
	end

	self:setDir("left")

end

function Snake:GetTailGrid()

	if #self.BodyArr == 0 then
		return 0,0
	end

	local tail = self.BodyArr[#self.BodyArr]

	return tail.X,tail.Y

end

function Snake:GetHeadGrid()

	if #self.BodyArr == 0 then
		return nil
	end

	local head = self.BodyArr[1]

	return head.X,head.Y

end

function Snake:Grow(isHead)

	local tailX,tailY = self:GetTailGrid()
	local body = Body.new(self, tailX, tailY, self.node, isHead)

	table.insert(self.BodyArr, body)

end

local function OffsetGridByDir(x, y, dir)

	if dir == 'left' then
		return x-1,y
	elseif dir == 'right' then
		return x+1,y
	elseif dir == 'up' then
		return x,y-1
	elseif dir == 'down' then
		return x,y+1
	end

	print("unknow Snake MoveDir")
	return x,y

end

local hvTable = {
	["left"] = "h",
	["right"] = "h",
	["up"] = "v",
	["down"] = "v"
}

local rotTable = {
	["left"] = -90,
	["right"] = 90,
	["up"] = 180,
	["down"] = 0
}

function Snake:setDir(dir)

	if hvTable[dir] == hvTable[self.MoveDir] then
		return
	end

	self.MoveDir = dir

	local head = self.BodyArr[1]
	head.sp:setRotation(rotTable[self.MoveDir])

end

function Snake:Update()

	if #self.BodyArr == 0 then
		return
	end

	for i = #self.BodyArr,1,-1 do

		local body = self.BodyArr[i]

		if i == 1 then
			body.X,body.Y = OffsetGridByDir(body.X, body.Y, self.MoveDir)
		else
			local front = self.BodyArr[i-1]
			body.X,body.Y = front.X, front.Y
		end

		body:Update()

	end

end

function Snake:CheckSelfCollide()

	if #self.BodyArr < 2 then
		return false
	end

	local headX,headY = self:GetHeadGrid()

	for i = 2,#self.BodyArr do

		local  body = self.BodyArr[i]
		if body.X == headX and body.Y == headY then
			return true
		end

	end

	return false

end

function Snake:kill()
	
	for _,body in ipairs(self.BodyArr) do

		self.node:removeChild(body.sp)

	end

end

function Snake:Blink(callback)

	for index,body in ipairs(self.BodyArr) do

		local blink = cc.Blink:create(3, 5)

		if index == 1 then
			local a = cc.Sequence:create(blink, cc.CallFunc:create(callback))
			body.sp:runAction(a)
		else
			body.sp:runAction(blink)
		end

	end

end

return Snake