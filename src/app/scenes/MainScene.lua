local Snake = require("app.Snake")
local Apple = require("app.Apple")
local Fence = require("app.Fence")

local MainScene = class("MainScene", function()
    return display.newScene("MainScene")
end)

local cGridSize = 33
local scaleRate = 1/display.contentScaleFactor

function Grid2Pos(x, y)

	local visibleSize = cc.Director:getInstance():getVisibleSize()
	local origin = cc.Director:getInstance():getVisibleOrigin()

	local finalX = origin.x + visibleSize.width/2 + x*cGridSize*scaleRate
	local finalY = origin.y + visibleSize.height/2 + y*cGridSize*scaleRate

	return finalX,finalY

end

local function addcB(node, x, y, r, callback)

    cc.ui.UIPushButton.new({normal="CloseNormal.png", pressed="CloseSelected.png"})
        :onButtonClicked(callback)
        :setRotation(r)
        :pos(x, y)
        :addTo(node)

end

-- function MainScene:ctor()
--     cc.ui.UILabel.new({
--             UILabelType = 2, text = "Hello Lua", size = 64})
--         :align(display.CENTER, display.cx, display.cy)
--         :addTo(self)
-- end

--local cMoveSpeed = 0.3
local cBound = 7

function MainScene:onEnter()

	display.newSprite("HelloWorld.png")
        :pos(display.cx, display.cy)
        :addTo(self)

    self:CreateScoreBoard()
    self.fence = Fence.new(cBound, self)
	--self.fence:gameSet(10, 0.3)
	
    self:Reset()
    -- self.snake = Snake.new(self)
    -- self.apple = Apple.new(cBound, self)

    addcB(self, 150, 200, 0, function ()
            local s =require("app.scenes.MainScene").new()
            self.snake:setDir("down")
        end)

    addcB(self, 150, 100, 180, function ()
            local s =require("app.scenes.MainScene").new()
            self.snake:setDir("up")
        end)

    addcB(self, 100, 150, -90, function ()
            local s =require("app.scenes.MainScene").new()
            self.snake:setDir("left")
        end)

    addcB(self, 200, 150, 90, function ()
            local s =require("app.scenes.MainScene").new()
            self.snake:setDir("right")
        end)

    local tick = function()

    	if self.stage == "running" then

			self.snake:Update()

			local headX,headY = self.snake:GetHeadGrid()

			if self.apple:CheckCollide(headX, headY) then
				self.apple:Generate()
				self.snake:Grow()
				self.score = self.score + self.fence.increment
				self:setScore(self.score)
			end

			if self.snake:CheckSelfCollide() or self.fence:CheckCollide(headX, headY) then
				self.stage = "dead"
				self.snake:Blink(function()
					self:Reset()
				end)
				
			end

		end
	end

    --self:ProcessInput()

    cc.Director:getInstance():getScheduler():scheduleScriptFunc(tick, self.fence.cMoveSpeed, false)

end

function MainScene:CreateScoreBoard()

	display.newSprite("g.png")
		:pos(display.right - 200, display.cy + 150)
		:addTo(self)

	local ttfConfig = {}
	ttfConfig.fontFilePath = "arial.ttf"
	ttfConfig.fontSize = 30

	local score = cc.Label:createWithTTF(ttfConfig, "0")
	self:addChild(score)

	score:setPosition(display.right - 200, display.cy + 80)
	self.scoreLabel = score

end

function MainScene:setScore(s)

	self.scoreLabel:setString(string.format("%d", s))

end

function MainScene:Reset()

	if self.snake ~= nil then
		self.snake:kill()
	end

	if self.apple ~= nil then
		self.apple:Reset()
	end

	self.snake = Snake.new(self)
    self.apple = Apple.new(cBound, self)
    self.stage = "running"
    self.score = 0
    self:setScore(self.score)

end

local function vector2Dir(x, y)

	if math.abs(x) > math.abs(y) then
		if x < 0 then
			return "left"
		else
			return "right"
		end
	else
		if y < 0 then
			return "up"
		else
			return "down"
		end
	end

end

function MainScene:ProcessInput()

	local function onTouchBegan(touch, event)

		local location = touch:getLocation()

		local visibleSize = cc.Director:getInstance():getVisibleSize()
		local origin = cc.Director:getInstance():getVisibleOrigin()


		local finalX = location.x - (origin.x + visibleSize.width/2)
		local finalY = location.y - (origin.y + visibleSize.height/2)

		local dir = vector2Dir(finalX, finalY)

		self.snake:setDir(dir)

	end

	local listener = cc.EventListenerTouchOneByOne:create()
	listener:registerScriptHandler(onTouchBegan, cc.Handler.EVENT_TOUCH_BEGAN)
	local eventDispatcher = self:getEventDispatcher()
	eventDispatcher:addEventListenerWithSceneGraphPriority(listener, self)

end

function MainScene:onExit()
end

return MainScene