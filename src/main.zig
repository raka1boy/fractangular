const std = @import("std");
const SDL = @cImport(@cInclude("SDL.h"));

const window_size_x = 600;
const window_size_y = 600;
pub fn main() !void {
    if (SDL.SDL_Init(SDL.SDL_INIT_VIDEO) < 0) @panic("SDL Not initialized!\n");

    var window:*SDL.SDL_Window = undefined;
    var renderer:*SDL.SDL_Renderer = undefined;

    SDL.SDL_CreateWindowAndRenderer(1000,1000,0,&window,&renderer);

    x:f64 = 0.0;
    y:f64 = 0.0;
    while(x < 1.0){
        while(y < 1.0){

            
            y = y + 0.1;
        }
        x = x + 0.1;
    }
    SDL.SDL_RenderPresent(renderer);
}
