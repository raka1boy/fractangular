const std = @import("std");
const SDL = @cImport(@cInclude("SDL.h"));

var pallete:*SDL.SDL_Colors = undefined;
var pixels:*u32 = undefined;
var format:*SDL.SDL_PixelFormat = undefined;
const window_size_x = 800;
const window_size_y = 600;
const zoom_val = 0.1;
var title:u8[128] = 0;

var v_up:f64 = 1.12;
var v_down:f64 = -1.12;
var v_left:f64 = -2.0;
var v_right:f64 = 0.47;
pub fn main() !void {
    if (SDL.SDL_Init(SDL.SDL_INIT_VIDEO) < 0) @panic("SDL Not initialized!\n");

    const window = SDL.SDL_CreateWindow(
        "SDL2 Window",
        SDL.SDL_WINDOWPOS_CENTERED,
        SDL.SDL_WINDOWPOS_CENTERED,
        window_size_x,
        window_size_y,
        0,
    );
    
    if (window == null) @panic("No window!\n");
    var renderer:SDL.SDL_Renderer  = SDL.SDL_CreateRenderer(window, -1, 0); 
    var texture:SDL.SDL_Texture = SDL.SDL_CreateTexture(renderer,SDL.SDL_PIXELFORMAT_ARGB8888, SDL.SDL_TEXTUREACCESS_STATIC, window_size_x, window_size_y);
    _ = texture;
    format = SDL.SDL_AllocFormat(SDL.SDL_PIXELFORMAT_ARGB8888);
    pixels = std.mem.zeroes(u32[window_size_x * window_size_y]);
    const window_surface = SDL.SDL_GetWindowSurface(window);

    if (window_surface == null) @panic("No window surf!\n");

    var keep_window_open: bool = true;
    while (keep_window_open) {
        var event: SDL.SDL_Event = undefined;

        while (SDL.SDL_PollEvent(&event) > 0) {
            if (event.type == SDL.SDL_QUIT) keep_window_open = false;

            _ = SDL.SDL_UpdateWindowSurface(window);
        }
    }
}
