///sendCoords(oject, buffer, socket)
var o = argument[0];
var buffer = argument[1];
var socket = argument[2];

buffer_seek(buffer, buffer_seek_start, 0);
switch(o){
    case oPlayerOne:
        buffer_write(buffer, buffer_u8, 1);
        buffer_write(buffer, buffer_u32, o.x);
        buffer_write(buffer, buffer_u32, o.y);
        break;
    case oPlayerTwo:
        buffer_write(buffer, buffer_u8, 2);
        buffer_write(buffer, buffer_u32, o.x);
        buffer_write(buffer, buffer_u32, o.y);
        break;
}

network_send_packet(socket, buffer, buffer_tell(buffer));
