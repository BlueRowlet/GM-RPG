#define client_connect
///client_connect(ip_address, port)
var ip = argument0;
var port = argument1;

socket = network_create_socket(network_socket_tcp);
var connect = network_connect_raw(socket, ip, port);

send_buffer = buffer_create(256, buffer_fixed, 1);
clientmap = ds_map_create();

if(connect < 0)
    show_error("Couln't connect to server", true);

#define client_disconnect
///client_disconnect()
ds_map_destroy(clientmap);
network_destroy(socket);

#define client_handle_message
///client_handle_message(buffer)
var buffer = argument0;

while(true){
    var message_id = buffer_read(buffer, buffer_u8);
    
    switch(message_id){
        case MESSAGE_MOVE:
            var client = buffer_read(buffer, buffer_u16);
            var xx = buffer_read(buffer, buffer_u16);
            var yy = buffer_read(buffer, buffer_u16);
            
            if(ds_map_exists(clientmap, string(client))){
                var clientObject = clientmap[? string(client)];
                
                clientObject.x = xx;
                clientObject.y = yy;
            } else {
                var l = instance_create(xx, yy, oOtherClient);
                clientmap[? string(client)] = l;
            }
            
            with(oServerClient){
                if(client_id != client_id_current){
                    network_send_raw(self.socket_id, other.send_buffer, buffer_tell(other.send_buffer));
                }
            }
        break;
    }
    
    if(buffer_tell(buffer) == buffer_get_size(buffer)){
        break;
    }
}

#define client_send_movement
///client_send_movement()
buffer_seek(send_buffer, buffer_seek_start, 0);

buffer_write(send_buffer, buffer_u8, MESSAGE_MOVE);
buffer_write(send_buffer, buffer_u16, round(oPlayerOne.x));
buffer_write(send_buffer, buffer_u16, round(oPlayerOne.y));

network_send_raw(socket, send_buffer, buffer_tell(send_buffer));