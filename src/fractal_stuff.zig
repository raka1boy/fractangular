const std = @import("std");
const complex = std.math.complex;
pub fn is_in_set(c:complex.Complex(f32),iters:i32,escape_amount:i32) u8 {
    var i:u8 = 0;
    var z = complex.Complex(f32).init(0.0,0.0);
    while (i < iters) { 
        z = complex.pow(complex.Complex(f32),z,complex.Complex(f32).init(2,0)).add(c);
        if(std.math.pow(f32,z.magnitude(),2.0) > @as(f32, @floatFromInt(escape_amount))){
            return i;
        }
        i += 1;
    }
    return 0;
}