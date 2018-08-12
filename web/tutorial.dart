part of ld42;

enum Action {
  BEGIN,
  ZIP,
  END,
}

class Tutorial extends Sprite {

  Map<Action, String> actionStrings;
  Sprite stapler;
  Sprite balloon;
  Sprite button;
  Function callback;

  Tutorial({String begin, String zip, String end}) {
    actionStrings = new Map<Action, String>();
    if (begin != null) actionStrings[Action.BEGIN] = begin;
    if (zip != null) actionStrings[Action.ZIP] = zip;
    if (end != null) actionStrings[Action.END] = end;
    x = 480;
    y = 300;
    stapler = new Sprite()
      ..x = 40
      ..y = 200
      ..mouseCursor = MouseCursor.POINTER;
    Bitmap image = new Bitmap(resourceManager.getBitmapData('stapler2'))
      ..width = 160
      ..height = 100;
    stapler.addChild(image);
    stapler.onMouseOver.listen((_) {
      image.bitmapData = resourceManager.getBitmapData('stapler1');
      image.width = 160;
      image.height = 100;
    });
    stapler.onMouseOut.listen((_) {
      image.bitmapData = resourceManager.getBitmapData('stapler2');
      image.width = 160;
      image.height = 100;
    });
    addChild(stapler);
    balloon = new Sprite();
    balloon.graphics.beginPath();
    balloon.graphics.rectRound(0, 0, 300, 200, 5, 5);
    balloon.graphics.fillColor(0xFFFFFF88);
    balloon.graphics.strokeColor(0xFF000000, 2);
    balloon.graphics.beginPath();
    balloon.graphics.moveTo(25, 195);
    balloon.graphics.lineTo(50, 220);
    balloon.graphics.lineTo(50, 195);
    balloon.graphics.fillColor(0xFFFFFF88);
    balloon.graphics.strokeColor(0xFF000000, 2);
    addChild(balloon);
    button = new Sprite();
    button.x = 200;
    button.y = 210;
    button.graphics.beginPath();
    button.graphics.rect(0, 0, 100, 30);
    button.graphics.fillColor(0xFFFFFFAA);
    button.graphics.strokeColor(0xFF000000, 2);
    button.addChild(
      new TextField('OK', new TextFormat(FONT, 15, 0xFF000000, align: 'center'))
        ..x = 5
        ..y = 5
        ..width = 90
        ..height = 20
        ..mouseEnabled = false
    );
    button.onTouchTap.listen((_) => ok());
    button.onMouseClick.listen((_) => ok());
    stapler.onTouchTap.listen((_) => toggle());
    stapler.onMouseClick.listen((_) => toggle());
    button.mouseCursor = MouseCursor.POINTER;
    addChild(button);
    balloon.visible = button.visible = false;
  }

  void handleAction(Action action, [Function callback]) {
    if (actionStrings.containsKey(action)) {
      balloon.removeChildren();
      //ok();
      balloon.addChild(
        new TextField(actionStrings[action], new TextFormat(FONT, 15, 0xFF000000))
          ..x = 10
          ..y = 10
          ..width = 280
          ..height = 180
          ..wordWrap = true
      );
      actionStrings.remove(action);
      balloon.visible = button.visible = true;
      this.callback = callback;
      resourceManager.getSound('staple').play();
    }
  }

  void ok() {
    balloon.visible = button.visible = false;
    if (callback != null) {
      callback();
    }
    resourceManager.getSound('click').play();
  }

  void toggle() {
    if (balloon.visible) {
      balloon.visible = button.visible = false;
      resourceManager.getSound('click').play();
    }
    else {
      balloon.visible = button.visible = true;
      resourceManager.getSound('staple').play();
    }
  }

}