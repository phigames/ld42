library ld42;

import 'dart:async';
import 'dart:html' as html;
import 'package:stagexl/stagexl.dart';

part 'level.dart';
part 'levels.dart';
part 'drive.dart';
part 'file.dart';
part 'tutorial.dart';

Stage stage;
List<Level> levels;
int currentLevel;

Future<Null> main() async {
  StageOptions options = new StageOptions()
    ..backgroundColor = Color.White
    ..renderEngine = RenderEngine.Canvas2D;

  html.CanvasElement canvas = html.querySelector('#stage');
  stage = new Stage(canvas, width: 800, height: 600, options: options);

  RenderLoop renderLoop = new RenderLoop();
  renderLoop.addStage(stage);

  ResourceManager resourceManager = new ResourceManager();
  //resourceManager.addBitmapData("dart", "images/dart@1x.png");

  await resourceManager.load();

  levels = <Level>[
    Levels.TUTORIAL1,
    Levels.TUTORIAL2,
  ];
  currentLevel = 0;
  stage.addChild(levels[currentLevel]);
}

void nextLevel() {
  print('next');
  currentLevel++;
  if (currentLevel >= levels.length) {
    gameOver();
  } else {
    stage.addChild(levels[currentLevel]);
  }
}

void gameOver() {
  print('game over');
}