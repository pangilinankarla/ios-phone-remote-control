var express = require('express');
var app = express();
var server = require('http').createServer(app);
var io = require('socket.io')(server);

connections = [];

server.listen(process.env.PORT || 3000);
console.log('Server is running...');

io.sockets.on('connection', function(socket) {
    connections.push(socket); // add socket to the array of connections
    console.log('Connect: %s socket/s are connected', connections.length);

    // Disconnect
    socket.on('disconnect', function(data) {
        connections.splice(connections.indexOf(socket), 1); // remove the socket
        console.log('%s socket/s are connected', connections.length);
    });

    // Custom event #1 (handshake)
    socket.on('NodeJS Server Port', function(data) {
        console.log(data);
        io.sockets.emit('iOS Client Port', {msg: 'Hi, iOS client!'});
    });

    // Custom event #2
    socket.on('Send move', function(data) { 
        console.log('Move received: %s', data);
        io.sockets.emit('Move received', data);
    });
});