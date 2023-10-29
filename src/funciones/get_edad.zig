const std = @import("std");
const edadErrores = @import("../errors/errorsEdad.zig").edadErrores;

pub fn getEdad(edad: u8) !?u8 {
    if (edad < 18) {
        return edadErrores.MenorDeEdad;
    } else if (edad > 50 and edad <= 100) {
        return edadErrores.EresMuyViejo;
    } else if (edad > 100) {
        return null;
    }
    return edad;
}

test "los error set son u16" {
    try std.testing.expect(@TypeOf(@intFromError(edadErrores.MenorDeEdad)) == u16);
}

test "asegurate que el usuario es mayor de edad" {
    for (0..18) |edad| {
        const fn_edad = getEdad(@as(u8, @intCast(edad)));
        try std.testing.expectError(edadErrores.MenorDeEdad, fn_edad);
    }
}

test "asegurate funcione para mayores de edad" {
    for (18..51) |edad| {
        const get_edad = try getEdad(@as(u8, @intCast(edad)));
        try std.testing.expect(get_edad.? == edad);
    }
}

test "asegurate funcione para cuando ya eres viejo :)" {
    for (51..100) |edad| {
        const fn_edad = getEdad(@as(u8, @intCast(edad)));
        try std.testing.expectError(edadErrores.EresMuyViejo, fn_edad);
    }
}

test "asegurate sea null" {
    for (101..255) |edad| {
        const get_edad = try getEdad(@as(u8, @intCast(edad)));
        try std.testing.expect(get_edad == null);
    }
}
