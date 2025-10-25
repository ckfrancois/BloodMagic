extends TextureRect

@export var emptyTexture: Texture

func setItem(data: Dictionary):
	print("setItem called with:", data)
	if data.is_empty():
		texture = emptyTexture
		return
	if data.has("icon"):
		texture = data["icon"]
		return
	texture = emptyTexture
