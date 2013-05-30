library squad_server;

import "dart:io";
import "package:start/start.dart";

main() {
  print("Starting RubySquad server");
  
  int port = 3000;
  if (Platform.environment.containsKey("PORT")) {
    port = int.parse(Platform.environment["PORT"]);
  }
  print("Running on port = ${port}");
  start(public: "deploy", port: port).then((Server app) {
    app.get('/', (req, Response res) {
      print("Getting '/'");
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