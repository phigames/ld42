part of ld42;

class File extends Sprite {
  
  String name;
  FileType type;
  num size;
  Drive drive;

  File(this.name, this.type, this.size) {
    graphics.beginPath();
    graphics.rect(0, 0, 50, 50);
    if (type == FileType.TEXT) {
      graphics.fillColor(0xFFFF0000);
    } else {
      graphics.fillColor(0xFF00FF00);
    }
    addChild(
      new TextField(name, new TextFormat('sans-serif', 15, 0xFF000000, align: 'center'))
        ..y = 50
        ..width = 50
        ..height = 20
        ..mouseEnabled = false
    );
    addChild(
      new TextField(size.toString() + 'kB', new TextFormat('sans-serif', 15, 0xFF000000, align: 'center'))
        ..y = 65
        ..width = 50
        ..height = 20
        ..mouseEnabled = false
    );
    mouseCursor = MouseCursor.POINTER;
  }

}

enum FileType {
  TEXT,
  IMAGE
}