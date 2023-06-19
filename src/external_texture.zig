const ChainedStruct = @import("gpu.zig").ChainedStruct;
const TextureView = @import("texture_view.zig").TextureView;
const Origin2D = @import("gpu.zig").Origin2D;
const Extent2D = @import("gpu.zig").Extent2D;
const Impl = @import("interface.zig").Impl;

pub const ExternalTexture = opaque {
    pub const BindingEntry = extern struct {
        chain: ChainedStruct = .{ .next = null, .s_type = .external_texture_binding_entry },
        external_texture: *ExternalTexture,
    };

    pub const BindingLayout = extern struct {
        chain: ChainedStruct = .{ .next = null, .s_type = .external_texture_binding_layout },
    };

    const Rotation = enum(u32) {
        rotate_0_degrees = 0x00000000,
        rotate_90_degrees = 0x00000001,
        rotate_180_degrees = 0x00000002,
        rotate_270_degrees = 0x00000003,
    };

    pub const Descriptor = extern struct {
        next_in_chain: ?*const ChainedStruct = null,
        label: ?[*:0]const u8 = null,
        plane0: *TextureView,
        plane1: ?*TextureView = null,
        visible_origin: Origin2D,
        visible_size: Extent2D,
        do_yuv_to_rgb_conversion_only: bool = false,
        yuv_to_rgb_conversion_matrix: ?*const [12]f32 = null,
        src_transform_function_parameters: *const [7]f32,
        dst_transform_function_parameters: *const [7]f32,
        gamut_conversion_matrix: *const [9]f32,
        flip_y: bool,
        rotation: Rotation,
    };
};