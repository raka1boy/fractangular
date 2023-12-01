const std = @import("std");
const SDL = @cImport(@cInclude("SDL.h"));
const fractals = @import("fractal_stuff.zig");

const window_size_x = 600;
const window_size_y = 600;
pub fn main() !void {
    if (SDL.SDL_Init(SDL.SDL_INIT_VIDEO) < 0) @panic("SDL Not initialized!\n");

    var window: ?*SDL.SDL_Window = undefined;
    var renderer: ?*SDL.SDL_Renderer = undefined;

    _ = SDL.SDL_CreateWindowAndRenderer(1920, 1080, 0, &window, &renderer);
    _ =SDL.SDL_RenderSetScale(renderer,2,2);

    var x: f32 = 0.0;
    var y: f32 = 0.0;
    
    while (x < 1.0) {
        while (y < 1.0) {
            const iters = fractals.is_in_set(std.math.complex.Complex(f32).init(x, y), 25, 10);
            if (iters == 0) {
                _ = SDL.SDL_SetRenderDrawColor(renderer, 0, 0, 0, 255);
                _ = SDL.SDL_RenderDrawPointF(renderer, x, y);
            } else {
                _ = SDL.SDL_SetRenderDrawColor(renderer, 255 - iters, 255 - iters, 255 - iters, 255);
                _ = SDL.SDL_RenderDrawPointF(renderer, x, y);
            }
            y = y + 0.001;
        }
        x = x + 0.001;
    }
    SDL.SDL_RenderPresent(renderer);
    while(true){
        std.time.sleep(1);
    }
}
