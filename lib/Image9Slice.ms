import "qa"

Image9Slice = {}
Image9Slice.src = null
Image9Slice.left = 0
Image9Slice.bottom = 0
Image9Slice.right = 0
Image9Slice.top = 0

create = function(src, left, bottom, right, top)
	noob = new Image9Slice
	noob.src = src
	noob.left = left
	noob.bottom = bottom
	noob.right = right
	noob.top = top
	return noob
end function

draw = function(image, left, bottom, width, height, pixelDisplay, scale=1)
	qa.assert(
	  image isa Image9Slice,
	  "image must be of type Image9Slice")
	qa.assert(
	  pixelDisplay isa Display and pixelDisplay.mode == 3,
	  "pixelDisplay must be a PixelDisplay")
	
	middleHeight = height - image.bottom * scale - image.top * scale
	srcHeight = image.src.height - image.bottom - image.top
	topStop = bottom + height - image.top * scale
	srcTopStop = image.src.height - image.top
	
	middleWidth = width - image.left * scale - image.right * scale
	srcWidth = image.src.width - image.left - image.right
	rightStop = left + width - image.right * scale
	srcRightStop = image.src.width - image.right
	
	pixelDisplay.drawImage image.src,
	  left, bottom, image.left * scale, image.bottom * scale,
	  0, 0, image.left, image.bottom
	pixelDisplay.drawImage image.src,
	  left, bottom + image.bottom * scale, image.left * scale, middleHeight,
	  0, image.bottom, image.left, srcHeight
	pixelDisplay.drawImage image.src,
	  left, topStop, image.left * scale, image.top * scale,
	  0, srcTopStop, image.left, image.top
	
	pixelDisplay.drawImage image.src,
	  left + image.left * scale, bottom, middleWidth, image.bottom * scale,
	  image.left, 0, srcWidth, image.bottom
	pixelDisplay.drawImage image.src,
	  left + image.left * scale, bottom + image.bottom * scale, middleWidth, middleHeight,
	  image.left, image.bottom, srcWidth, srcHeight
	pixelDisplay.drawImage image.src,
	  left + image.left * scale, topStop, middleWidth, image.top * scale,
	  image.left, srcTopStop, srcWidth, image.top
	
	pixelDisplay.drawImage image.src,
	  rightStop, bottom, image.right * scale, image.bottom * scale,
	  srcRightStop, 0, image.right, image.bottom
	pixelDisplay.drawImage image.src,
	  rightStop, bottom + image.bottom * scale, image.right * scale, middleHeight,
	  srcRightStop, image.bottom, image.right, srcHeight
	pixelDisplay.drawImage image.src,
	  rightStop, topStop, image.right * scale, image.top *scale,
	  srcRightStop, srcTopStop, image.right, image.top	
end function

if globals == locals then
	testImg = file.loadImage("orangeborder.png")
	test9Slice = create(testImg,5,5,5,5)
	draw test9Slice, 200, 200, 100, 100, display(5), 3
	draw test9Slice, 400, 200, 200, 100, display(5), 3
end if