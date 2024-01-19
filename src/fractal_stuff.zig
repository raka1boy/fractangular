const std = @import("std");
const SDL = @cImport(@cInclude("SDL.h"));

pub const RGBA = @Vector(4, u8);
pub var mousePos: SDL.SDL_Point = 0;
pub var realMousePos: SDL.SDL_Point = 0;

const windowInstance = struct {
    event: SDL.SDL_Event = undefined,
    window: ?*SDL.SDL_Window = undefined,
    renderer: ?*SDL.SDL_Renderer = undefined,
    height: usize,
    width: usize,
    colorsFunction: ?fn (x: usize, y: usize) RGBA,
    pixelsFunction: ?fn (x: usize, y: usize) @Vector(2, usize), //TODO: Better naming
    pub fn renderWithColorsFunction(Self: *windowInstance) !void {
        if (Self.pixelsFunction == undefined) @panic("Error: You have not provided function for RenderWithColorsFunction!");
        for (0..Self.width) |x| {
            for (0..Self.height) |y| {
                const colors = Self.colorsFunction(x, y);
                _ = SDL.SDL_SetRenderDrawColor(Self.renderer, colors[0], colors[1], colors[2], colors[3]);
                _ = SDL.SDL_RenderDrawPoint(Self.renderer, @intCast(x), @intCast(y));
            }
        }
        SDL.SDL_RenderPresent(Self.renderer);
        // _ = SDL.SDL_PollEvent(&Self.event); Mayhaps you should not get event and just handle that extermally kappa
    }

    pub fn renderWithPixelsFunction(Self: *windowInstance) !void {
        if (Self.pixelsFunction == undefined) @panic("Error: You have not provided function for RenderWithPixelsFunction!");
        for (0..Self.width) |x| {
            for (0..Self.height) |y| {
                const coords = Self.pixelsFunction(x, y);
                _ = SDL.SDL_SetRenderDrawColor(Self.renderer, 0, 255, 0, 0);
                _ = SDL.SDL_RenderDrawPoint(Self.renderer, @intCast(coords[0]), @intCast(coords[1]));
            }
        }
        SDL.SDL_RenderPresent(Self.renderer);
        // _ = SDL.SDL_PollEvent(&Self.event);
    }
};
// pub fn initFractalWindow(comptime , window_size_x: i64, window_size_y: i64) windowInstance {
//     var event: SDL.SDL_Event = undefined;
//     var window: ?*SDL.SDL_Window = undefined;
//     var renderer: ?*SDL.SDL_Renderer = undefined;

//     if (SDL.SDL_Init(SDL.SDL_INIT_VIDEO) < 0) @panic("SDL Not initialized!\n");
//     _ = SDL.SDL_PollEvent(&event);
//     _ = SDL.SDL_CreateWindowAndRenderer(@intCast(window_size_x), @intCast(window_size_y), 0, &window, &renderer);
//     //
//     while (event.type != SDL.SDL_QUIT) {
//         std.debug.print("SDL Event = {any} \n", .{event.type});

//     }

//     //
//     // SDL.SDL_DestroyRenderer(renderer);
//     return .{ .event = event, .window = window, .renderer = renderer };
// }

pub fn cleanup(things: windowInstance) void {
    SDL.SDL_DestroyWindow(things.window);
    SDL.SDL_DestroyRenderer(things.renderer);
}
