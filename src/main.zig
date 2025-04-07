//! By convention, main.zig is where your main function lives in the case that
//! you are building an executable. If you are making a library, the convention
//! is to delete this file and start with root.zig instead.

const out = std.io.getStdOut().writer();
var out_buffer = std.io.bufferedWriter(out);
var out_writer = out_buffer.writer();

/// Print to stdout, buffered, and unsupported multithreading.
pub fn log(comptime fmt: []const u8, args: anytype) void {
    nosuspend out_writer.print(fmt, args) catch return;
}

pub fn main() !void {
    // get arguments
    var args = std.process.args();
    _ = args.next(); // Skip the program name

    const arg = args.next() orelse {
        std.debug.print("Expected an argument\n", .{});
        std.process.exit(1);
        return;
    };

    log("  .globl main\n", .{});
    log("main:\n", .{});
    const value = try std.fmt.parseInt(i32, arg, 10);
    log("  mov ${d}, %rax\n", .{value});
    log("  ret\n", .{});

    try out_buffer.flush(); // Don't forget to flush!
}

const std = @import("std");

/// This imports the separate module containing `root.zig`. Take a look in `build.zig` for details.
const lib = @import("zig_learn_chibicc_lib");
