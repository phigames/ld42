library ld42;

import 'dart:async';
import 'dart:html' as html;
import 'package:stagexl/stagexl.dart';

part 'level.dart';
part 'levels.dart';
part 'drive.dart';
part 'file.dart';
part 'tutorial.dart';

const String FONT = 'Times New Roman';

Stage stage;
List<Level> levels;
int currentLevel;

Future<Null> main() async {
  StageOptions options = new StageOptions()
    ..backgroundColor = 0xFF000022
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
  html.document.onKeyUp.listen(_onKeyPressed);
}

void nextLevel() {
  stage.removeChildren();
  currentLevel++;
  if (currentLevel >= levels.length) {
    gameOver();
  } else {
    stage.addChild(levels[currentLevel]);
  }
}

void _onKeyPressed(html.KeyboardEvent event) {
  levels[currentLevel]._onKeyPressed(event.keyCode);
}

void gameOver() {
  print('game over');
}