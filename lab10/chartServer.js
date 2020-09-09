var net = require('net');
var eol = require('os').EOL;

var srvr = net.createServer();
var clientList = [];

var list = "\\list";
var rename = "\\rename";
var private = "\\private";

srvr.on('connection', function(client) {
  client.name = client.remoteAddress + ':' + client.remotePort;
  client.write('Welcome, ' + client.name + eol);
  clientList.push(client);

  client.on('data', function(data) {
    input(data, client);
  });
});

function input(data, client) {
  data += '';
  if (data == eol) return; //check whether data is null
  
  var command = data.split(' ');
  if (command.length > 0) { 
    if(command[0].trim() === list.trim()){
        for (var k in clientList)
          if (clientList[k] !== client) client.write(clientList[k].name + eol);
    }
    else if(command[0].trim() === rename.trim()){
        if (command.length > 1) {
          client.name = command[1].trim();
          client.write("The new name is: " + client.name + eol);
        } 
        else
          client.write("Please enter a new name" + eol)
    }
    else if(command[0].trim() === private.trim()){
        if (command.length > 2){
          for (var i in clientList)
            if (clientList[i].name === command[1].trim())
              clientList[i].write(command[2]);
   //           client.write(command[2] + eol);
            } 
        else
          client.write("Please enter a message" + eol);
    }
    else{

    }
  }
}

function broadcast(data, client) {
  for (var i in clientList) {
    if (client !== clientList[i]) {
      clientList[i].write(client.name + eol);
    }
  }
}

srvr.listen(9000);

