library ld42;

import 'dart:async';
import 'dart:html' as html;
import 'package:stagexl/stagexl.dart';

part 'level.dart';
part 'drive.dart';
part 'file.dart';

Future<Null> main() async {
  StageOptions options = new StageOptions()
    ..backgroundColor = Color.White
    ..renderEngine = RenderEngine.Canvas2D;

  var canvas = html.querySelector('#stage');
  var stage = new Stage(canvas, width: 800, height: 600, options: options);

  var renderLoop = new RenderLoop();
  renderLoop.addStage(stage);

  var resourceManager = new ResourceManager();
  //resourceManager.addBitmapData("dart", "images/dart@1x.png");

  await resourceManager.load();

  Level level = Level.LEVEL_TEST;
  stage.addChild(level);
}
