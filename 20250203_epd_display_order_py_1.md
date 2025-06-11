clear_display()
	display.clear()


1. display_image_8bpp(display, image_buffer)
	2. draw_full(mode)
		frame = get_frame_buff() -> rotated or not
		3. update(frame, xy, dims, mode, pixel_format)
			wait_display_ready()
			4. load_image_area(data, xy, dims, pixel_format)
				if xy is None:
					load_image_start(endian_type, pixel_format, rotate_mode)
			 			spi.write_cmd(commands.ld_img, area)
				else:
			 		load_image_area_start(endian_type, pixel_format, rotate_mode, xy, dims)
			 			spi.write_cmd(commands.ld_img_area, arg0, xy[0], xy[1], dims[0], dims[1])
			 	spi.pack_and_write_pixels(buff, bpp)
			 	load_image_end()
			 		spi.write_cmd(commands.ld_img_end)
				5.  display_area(xy, dims, mode)
				 		spi.write_cmd(commands.display_area, xy[0], xy[1], dims[0], dims[1], display_modea)
