library squad_server;

import "package:start/start.dart";

main() {
  print("Starting RubySquad server");
  
  start(public: "../deploy", port: 3000).then((Server app) {
    app.get('/', (req, Response res) {
      print("Getting");
      res.send("Hi there!");
    });
    
    app.ws("/ws", (Socket socket) {
      socket.on("ping", () {
        print("Received a message");
        socket.send("pong");
      });
    });
  });
}