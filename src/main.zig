const std = @import("std");
const getEdad = @import("./funciones/get_edad.zig").getEdad;

pub fn main() !void {
    std.debug.print("Ingresa una edad: ", .{});

    var stdin = std.io.getStdIn();

    var buff: [3]u8 = undefined;

    const edad_result = while (true) {
        const result = try stdin.reader().readUntilDelimiter(&buff, '\n');

        if (std.fmt.parseInt(u8, result, 10)) |edad| {
            break edad;
        } else |_| {
            std.debug.print("No es una edad validad intentalo de nuevo: ", .{});
            continue;
        }
    };

    const mi_edad = getEdad(edad_result);
    if (mi_edad) |edad| {
        std.debug.print("{any} \n", .{edad});
    } else |err| {
        std.log.err("{any} \n", .{err});
    }
}

test {
    std.testing.refAllDecls(@This());
}
