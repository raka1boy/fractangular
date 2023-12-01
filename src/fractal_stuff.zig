const std = @import("std");
const SDL = @cImport(@cInclude("SDL.h"));

pub const RGBA = struct{
    red: u8,
    green : u8,
    blue: u8,
    alpha: u8
};
const window_size_x = 1920;
const window_size_y = 1080;
pub var event:SDL.SDL_Event = undefined;
pub var window: ?*SDL.SDL_Window = undefined;
pub var renderer: ?*SDL.SDL_Renderer = undefined;
pub var mousePos:SDL.SDL_Point = 0;
pub var realMousePos:SDL.SDL_Point = 0;

pub fn initFractalWindow(comptime getColors:fn(x:i64,y:i64) RGBA) !void {
    if (SDL.SDL_Init(SDL.SDL_INIT_VIDEO) < 0) @panic("SDL Not initialized!\n");
    _ = SDL.SDL_PollEvent(&event);
    _ = SDL.SDL_CreateWindowAndRenderer(window_size_x, window_size_y, 0, &window, &renderer);
    //event.type != SDL.SDL_QUIT
    while(true){
        std.debug.print("SDL Event = {any} \n", .{event.type});
        for(0..window_size_x) |x|{
            for(0..window_size_y) |y| {
                const colors = getColors(@intCast(x),@intCast(y));
                _ = SDL.SDL_SetRenderDrawColor(renderer,colors.red, colors.green, colors.blue, colors.alpha);
                _ = SDL.SDL_RenderDrawPoint(renderer, @intCast(x), @intCast(y));
            }
        }
        SDL.SDL_RenderPresent(renderer);
        _ = SDL.SDL_PollEvent(&event);
    }
}
