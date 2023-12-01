const std = @import("std");
const SDL = @cImport(@cInclude("SDL.h"));
const fractals = @import("fractal_stuff.zig");

fn colors(x:i64,y:i64) fractals.RGBA{
    return fractals.RGBA{
        .red = @intCast(@rem(x,255)),
        .green = @intCast(@rem((x-y ),255)),
        .blue = 0,
        .alpha = 255
    };
}

pub fn main() !void{
    try fractals.initFractalWindow(colors);
}
