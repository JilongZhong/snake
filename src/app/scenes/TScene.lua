local gameSetting = require("app.gameSetting")

local TScene = class("TScene", function()
    return display.newScene("TScene")
end)

-- function TScene:ctor()
    -- cc.ui.UILabel.new({
    --         UILabelType = 2, text = "Hello, Lua", size = 64})
    --     :align(display.CENTER, display.cx, display.cy)
    --     :addTo(self)

    

--end

local function addcB(node, x, y, callback)

    cc.ui.UIPushButton.new({normal="CloseNormal.png", pressed="CloseSelected.png"})
        :onButtonClicked(callback)
        :pos(x, y)
        :addTo(node)

end

function TScene:onEnter()

    self.fence = Fence.new()


    display.newSprite("HelloWorld.png")
        :pos(display.cx, display.cy)
        :addTo(self)

    -- cc.ui.UIPushButton.new({normal="CloseNormal.png", pressed="CloseSelected.png"})
    --     :onButtonClicked(function () 
    --         print("is click")
    --     end)
    --     :pos(display.cx, display.cy - 50)
    --     :addTo(self)

    addcB(self, display.cx, display.cy - 100, function ()
            local s =require("app.scenes.MainScene").new()
            display.replaceScene(s, "fade", 0.6, display.COLOR_BLACK)
        end)
    addcB(self, display.cx - 100, display.cy - 150, function () 
            --self.fence:gameSet(20, 0.1)
            gameSetting:gameSet(20, 0.1)
            print("set")
        end)
    addcB(self, display.cx, display.cy - 150, function () 
            print("end")
        end)
    addcB(self, display.cx + 100, display.cy - 150, function () 
            print("help")
        end)
end
return TScene