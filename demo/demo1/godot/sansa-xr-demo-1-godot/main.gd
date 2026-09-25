extends Node3D

# SansaXR Demo 1 の OpenXR 初期化を行う。
# OpenXR interface が利用できない場合や初期化に失敗した場合は、
# XR を開始せずエラーを出力する。
func _ready() -> void:
	var xr_interface := XRServer.find_interface("OpenXR")

	if xr_interface == null:
		push_error("OpenXR interface was not found.")
		return

	if not xr_interface.is_initialized():
		if not xr_interface.initialize():
			push_error("OpenXR initialization failed.")
			return

	get_viewport().use_xr = true

	print("OpenXR initialized.")
	print("XR interface: ", xr_interface.get_name())
	
