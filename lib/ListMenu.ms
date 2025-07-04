import "coreUtils"
ensureImport "ListPanel"
cursorImage = file.loadImage("images/cursor_point_right.png")

ListMenu = {}
ListMenu.panel = null
ListMenu.currentSelected = 0
ListMenu.options = []
ListMenu.menuCursor = null

ListMenu.show = function(pixelDisplay, spriteDisplay)
    qa.assert(pixelDisplay isa Display and pixelDisplay.mode == 3,
    	"pixelDisplay must be a PixelDisplay")
    qa.assert(spriteDisplay isa SpriteDisplay,
        "spriteDisplay must be a SpriteDisplay")
    self.panel.draw pixelDisplay
    self.menuCursor = new Sprite
    self.menuCursor.image = cursorImage
    self.menuCursor.scale = 3
    spriteDisplay.sprites.push self.menuCursor
    self.updateCursorPosition
end function

ListMenu.updateCursorPosition = function
    self.menuCursor.y = self.panel.position.y + self.panel.extent.height -
    46 - self.currentSelected * 40
    self.menuCursor.x = self.panel.position.x + 16
end function

ListMenu.cursorBackward = function
    self.currentSelected = self.currentSelected - 1 + menuItems.len
    self.currentSelected %= self.options.len
    self.updateCursorPosition
end function

ListMenu.cursorForward = function
    self.currentSelected = self.currentSelected + 1 + menuItems.len
    self.currentSelected %= self.options.len
    self.updateCursorPosition
end function

create = function(left, bottom, width, height, entries)
    noob = new ListMenu
    noob.options = entries
    noob.panel = ListPanel.create(left, bottom, width, height, entries)
    return noob
end function

if globals == locals then
    clear
    testMenu = create(652, 0, 300, 200, ["One", "Two", "Three", "Four"])
    testMenu.show display(5), display(4)
end if