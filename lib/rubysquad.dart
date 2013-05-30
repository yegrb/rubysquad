library ruby_squad;

import 'dart:html';
import 'dart:async';
import 'package:game_loop/game_loop_html.dart';

class RubySquad {
  CanvasElement canvas;
  GameLoopHtml gameLoop;
  WebSocket _socket;

  RubySquad() {
    _initGameLoop();
    _initWebSocket();
  }

  void _initGameLoop() {
    canvas = query(".game-canvas");
    CanvasRenderingContext2D context = canvas.context2D;
    
    // Construct a game loop.
    gameLoop = new GameLoopHtml(canvas);
    gameLoop.onUpdate = (GameLoopHtml gameLoop) {
      // Handle keyboard events
//      print("keys = ${gameLoop.keyboard.isDown(Keyboard.SPACE)}");
    };
    gameLoop.onRender = ((GameLoopHtml loop) {
      loop.dt;
    });
  }
  
  void _initWebSocket() {
    _socket = new WebSocket("ws://${window.location.hostname}:${window.location.port}/ws");
  }

  void start() {
    gameLoop.start();
    _socket.onMessage.listen((MessageEvent e) {
      query(".msg").text = "Received pong!";
    });
    _socket.onOpen.listen((_) {
      _socket.send("ping");  
    });
  }
}