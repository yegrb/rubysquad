library ruby_squad;

import 'dart:html';
import 'package:game_loop/game_loop_html.dart';

class RubySquad {
  CanvasElement canvas;
  GameLoopHtml gameLoop;
  
  RubySquad() {
    canvas = query(".game-canvas");
    CanvasRenderingContext2D context = canvas.context2D;

    // Construct a game loop.
    gameLoop = new GameLoopHtml(canvas);
    gameLoop.onUpdate = (GameLoopHtml gameLoop) {
      // Handle keyboard events

      print("keys = ${gameLoop.keyboard.isDown(Keyboard.SPACE)}");
    };
    gameLoop.onRender = ((gameLoop) {
      
    });
  }
  
  start() {
    gameLoop.start();
  }
}