const std = @import("std");
const SDL = @cImport(@cInclude("SDL.h"));
const fractals = @import("fractal_stuff.zig");

const window_size_x = 1000;
const window_size_y = 1000;
inline fn normalizeValToColor(x:anytype) u8 {
    return @intCast(@max(@rem(x,255),0));
}
fn colors(x:i64,y:i64) fractals.RGBA{

    return fractals.RGBA{
        .red = 0,
        .green = normalizeValToColor(x*y),
        .blue = 0,
        .alpha = 255
    };
}
fn colors2(x:i64,y:i64) fractals.RGBA{

    return fractals.RGBA{
        .red = 0,
        .green = 0,
        .blue = normalizeValToColor(x*y),
        .alpha = 255
    };
}

pub fn main() !void{
        std.debug.print("init first", .{});
    try fractals.initFractalWindow(colors,window_size_x,window_size_y);

    std.time.sleep(1000);
    try fractals.initFractalWindow(colors2,window_size_x,window_size_y);
    std.debug.print("init second", .{});
}
