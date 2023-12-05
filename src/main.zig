const std = @import("std");
const SDL = @cImport(@cInclude("SDL.h"));
const fractals = @import("fractal_stuff.zig");

const window_size_x = 1000;
const window_size_y = 1000;
fn colors(x:i64,y:i64) fractals.RGBA{
    _ = x;
    _ = y;

    return fractals.RGBA{
        .red = @intCast(@max(@rem(std.time.microTimestamp(),255),0)),
        .green = @intCast(@max(@rem(std.time.microTimestamp(),255),0)),
        .blue = @intCast(@max(@rem(std.time.microTimestamp(),255),0)),
        .alpha = 255
    };
}

pub fn main() !void{
    try fractals.initFractalWindow(colors,window_size_x,window_size_y);
    try fractals.initFractalWindow(colors,window_size_x,window_size_y);
}
