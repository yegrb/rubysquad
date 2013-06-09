library squad_server;

import "dart:io";
import "dart:json";
import "package:start/start.dart" as s;

main() {
  print("Starting RubySquad server");
  
  int port = 3000;
  String app_root = "http://localhost:3000/";
  
  if (Platform.environment.containsKey("PORT")) {
    port = int.parse(Platform.environment["PORT"]);
  }
  print("Running on port = ${port}");
  s.start(public: "deploy", port: port).then((s.Server app) {
    app.get('/', (s.Request req, s.Response res) {
      res.send("Hi there!");
    });
    
    app.get('/settings.json', (req, resp) {
      Map settings = {
        "port": port,
        "app_root": app_root
      };
      resp.send(stringify(settings));
    });
    
    app.ws("/ws", (s.Socket socket) {
      socket.on("ping", (_) {
        print("Received a message");
        socket.send("pong");
      });
      socket.on("echo", (data) {
        print("Echoing data = $data");
        socket.send("reply:${stringify(data)}");
      });
    });
  });
}