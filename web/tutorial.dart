part of ld42;

class Tutorial extends Sprite {

  Map<Action, String> actionStrings;
  Sprite stapler;
  Sprite balloon;
  Sprite button;
  Function callback;

  Tutorial({String begin, String end}) {
    actionStrings = new Map<Action, String>();
    if (begin != null) actionStrings[Action.BEGIN] = begin;
    if (end != null) actionStrings[Action.END] = end;
    x = 500;
    y = 300;
    stapler = new Sprite();
    stapler.graphics.beginPath();
    stapler.graphics.rect(0, 230, 100, 50);
    stapler.graphics.fillColor(0xFFFF0000);
    addChild(stapler);
    balloon = new Sprite();
    balloon.graphics.beginPath();
    balloon.graphics.rectRound(0, 0, 300, 200, 10, 10);
    balloon.graphics.fillColor(0xFFFFFF88);
    balloon.graphics.strokeColor(0xFF000000);
    addChild(balloon);
    button = new Sprite();
    button.x = 200;
    button.y = 210;
    button.graphics.beginPath();
    button.graphics.rect(0, 0, 100, 30);
    button.graphics.fillColor(0xFFFFFFAA);
    button.graphics.strokeColor(0xFF000000);
    button.addChild(
      new TextField('OK', new TextFormat(FONT, 15, 0xFF000000, align: 'center'))
        ..x = 5
        ..y = 5
        ..width = 90
        ..height = 20
        ..mouseEnabled = false
    );
    button.onTouchTap.listen((_) => hide());
    button.onMouseClick.listen((_) => hide());
    button.mouseCursor = MouseCursor.POINTER;
    addChild(button);
    visible = false;
  }

  void handleAction(Action action, [Function callback]) {
    if (actionStrings.containsKey(action)) {
      hide();
      balloon.addChild(
        new TextField(actionStrings[action], new TextFormat(FONT, 15, 0xFF000000))
          ..x = 10
          ..y = 10
          ..width = 280
          ..height = 180
          ..wordWrap = true
      );
      actionStrings.remove(action);
      visible = true;
      this.callback = callback;
    }
  }

  void hide() {
    balloon.removeChildren();
    visible = false;
    if (callback != null) {
      callback();
    }
  }

}

enum Action {
  BEGIN,
  END,
}