library ruby_squad;

import 'dart:html';
import 'dart:async';
import 'dart:json';
import 'package:game_loop/game_loop_html.dart';

class RubySquad {
  CanvasElement canvas;
  GameLoopHtml gameLoop;
  
  WebSocket _socket;
  int _port;
  String _hostname;
  
  RubySquad() {
    _initSettings();
    _initGameLoop();
    _initWebSocket();
  }

  void _initGameLoop() {
    canvas = query(".game-canvas");
    CanvasRenderingContext2D context = canvas.context2D;
    
    // Construct a game loop.
    gameLoop = new GameLoopHtml(canvas);
    gameLoop.onUpdate = (GameLoopHtml gameLoop) {
    };
    gameLoop.onRender = ((GameLoopHtml loop) {
    });
  }
  
  void _initWebSocket() {
    _socket = new WebSocket("ws://$_hostname:$_port/ws");
  }
  
  void _initSettings() {
    _port = int.parse(window.location.port);
    if (_port == 3030) {
      // If we're serving from Dartium, then connect from 3000 instead
      _port = 3000;
    }
    _hostname = window.location.hostname;
  }

  void start() {
    gameLoop.start();
    _socket.onMessage.listen((MessageEvent e) {
      String msg = e.data;
      String msg_name = msg.split(":").first;
      
      switch (msg_name) {
        case 'pong':
          query(".msg").text = "Received pong!";
          break;
        case 'reply':
          var data = parse(msg.substring(msg.indexOf(":") + 1));
          query(".msg").text = "Received reply! data = ${data}";
          break;
      }
    });
    _socket.onOpen.listen((_) {
      _socket.send("echo:${stringify({"name":"Bob Barker","power_level":1000})}");  
    });
  }
}