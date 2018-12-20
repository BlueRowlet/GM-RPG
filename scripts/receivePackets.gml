///receivePackets(buffer)
var buffer = argument[0];
var messageID = buffer_read(buffer, buffer_u8);

switch(messageID){
    case 1:
        oPlayerOne.x = buffer_read(buffer, buffer_u32);
        oPlayerOne.y = buffer_read(buffer, buffer_u32);
        break;
    case 2:
        oPlayerTwo.x = buffer_read(buffer, buffer_u32);
        oPlayerTwo.y = buffer_read(buffer, buffer_u32);
        
}
