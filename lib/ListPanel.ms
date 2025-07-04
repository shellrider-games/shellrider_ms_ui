import "coreUtils"
ensureImport "qa"
ensureImport "Image9Slice"

panelImage = file.loadImage("images/orangeborder.png")
panel9Slice = Image9Slice.create(panelImage, 5, 5, 5, 5)

ListPanel = {}
ListPanel.background = null
ListPanel.backgroundScale = 1
ListPanel.position = {"x": 0, "y" : 0}
ListPanel.extent = {"width" : 0, "height" : 0}
ListPanel.entries = []

ListPanel.draw = function(pixelDisplay)
    qa.assert(
	  pixelDisplay isa Display and pixelDisplay.mode == 3,
	  "pixelDisplay must be a PixelDisplay")
    Image9Slice.draw(
        self.background,
        self.position.x, self.position.y, self.extent.width, self.extent.height,
        pixelDisplay,
        self.backgroundScale)
    listItemX = self.position.x + 46
    listItemY = self.position.y + self.extent.height - 56

    for item in self.entries
        pixelDisplay.print item, listItemX, listItemY, color.orange, "large"
        listItemY -= 40
    end for
end function

create = function(left, bottom, width, height, entries)
    noob = new ListPanel
    noob.background = panel9Slice
    noob.backgroundScale = 3
    noob.position = {"x": left, "y": bottom}
    noob.extent = {"width": width, "height": height}
    noob.entries = entries
    return noob
end function

if locals == globals then
    clear
    testPanel = create(652, 0, 300, 200, ["One", "Two", "Three", "Four"])
    testPanel.draw display(5)
end if