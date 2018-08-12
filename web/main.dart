library ld42;

import 'dart:async';
import 'dart:html' as html;
import 'package:stagexl/stagexl.dart';

part 'level.dart';
part 'levels.dart';
part 'drive.dart';
part 'file.dart';
part 'tutorial.dart';

const String FONT = 'Share Tech Mono';

Stage stage;
ResourceManager resourceManager;
List<Level> levels;
int currentLevel;
TextField levelText;

Future<Null> main() async {
  StageOptions options = new StageOptions()
    ..backgroundColor = 0xFF7788AA
    ..renderEngine = RenderEngine.Canvas2D;

  html.CanvasElement canvas = html.querySelector('#stage');
  stage = new Stage(canvas, width: 800, height: 600, options: options);

  RenderLoop renderLoop = new RenderLoop();
  renderLoop.addStage(stage);

  resourceManager = new ResourceManager();
  resourceManager.addBitmapData('text', 'res/text.png');
  resourceManager.addBitmapData('image', 'res/image.png');
  resourceManager.addBitmapData('zip', 'res/zip.png');
  resourceManager.addBitmapData('stapler1', 'res/stapler1.png');
  resourceManager.addBitmapData('stapler2', 'res/stapler2.png');

  await resourceManager.load();

  levels = <Level>[
    Levels.TUTORIAL1,
    Levels.TUTORIAL2,
    Levels.TUTORIAL3,
    Levels.ZIP1,
    Levels.ZIP2,
    Levels.ZIP3,
    Levels.ZIP4,
    Levels.BOMB,
  ];
  currentLevel = 0;
  levelText = new TextField('Level ${currentLevel.toString()}', new TextFormat(FONT, 30, 0xFF222222))
    ..x = 20
    ..y = 20
    ..width = 200
    ..height = 50;
  stage.addChild(levelText);
  stage.addChild(levels[currentLevel]);
  html.document.onKeyUp.listen(_onKeyPressed);
}

void nextLevel() {
  stage.removeChildren();
  currentLevel++;
  if (currentLevel >= levels.length) {
    gameOver();
  } else {
    levelText.text = 'Level ${currentLevel.toString()}';
    stage.addChild(levelText);
    stage.addChild(levels[currentLevel]);
  }
}

void _onKeyPressed(html.KeyboardEvent event) {
  levels[currentLevel]._onKeyPressed(event.keyCode);
}

void gameOver() {
  html.window.location.assign('https://redditp.com/r/kittengifs/');
}