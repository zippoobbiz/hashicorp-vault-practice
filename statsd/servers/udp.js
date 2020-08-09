const dgram  = require('dgram');

exports.start = function(config, callback) {
  const udp_version = config.address_ipv6 ? 'udp6' : 'udp4';
  const server = dgram.createSocket(udp_version, callback);

  server.bind(config.port || 8125, config.address || undefined);
  // this.server = server;

  // server.on('message',function(msg,info){
  //   console.log('Data received from client : ' + msg.toString());
  //   console.log('Received %d bytes from %s:%d\n',msg.length, info.address, info.port);
  
  //   //sending msg
  //   server.send(msg,info.port,'localhost',function(error){
  //     if(error){
  //       client.close();
  //     }else{
  //       console.log('Data sent !!!');
  //     }
    
  //   });
  // });

  return true;
};
