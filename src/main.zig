const std = @import("std");
const SDL = @cImport(@cInclude("SDL.h"));

pub fn main() !void {
    if (SDL.SDL_Init(SDL.SDL_INIT_VIDEO) < 0) @panic("SDL Not initialized!\n");

    const window = SDL.SDL_CreateWindow(
        "SDL2 Window",
        SDL.SDL_WINDOWPOS_CENTERED,
        SDL.SDL_WINDOWPOS_CENTERED,
        680,
        480,
        0,
    );

    if (window == null) @panic("No window!\n");
}
