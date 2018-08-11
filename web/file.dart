part of ld42;

enum FileType {
  TEXT,
  IMAGE,
  ZIP
}

class File extends Sprite {
  
  String name;
  FileType type;
  num size;
  Drive drive;
  bool selected;

  File(this.name, this.type, this.size) {
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
    selected = false;
    drawIcon();
  }

  void drawIcon() {
    graphics.clear();
    graphics.beginPath();
    graphics.rect(0, 0, 50, 50);
    if (type == FileType.TEXT) {
      graphics.fillColor(selected ? 0xFF880000 : 0xFFFF0000);
    } else {
      graphics.fillColor(selected ? 0xFF008800 : 0xFF00FF00);
    }
  }

  void select() {
    selected = true;
    drawIcon();
  }

  void deselect() {
    selected = false;
    drawIcon();
  }

  @override
  String toString() {
    return 'FILE: ' + name;
  }

}

class ZipFile extends File {

  List<File> files;
  num originalSize;

  ZipFile(int number, this.files) : super('zip' + number.toString(), FileType.ZIP, calculateSize(files)) {
    originalSize = 0;
    for (File f in files) {
      originalSize += f.size;
    }
  }

  static num calculateSize(List<File> files) {
    num size = 0;
    for (File f in files) {
      size += f.size;
    }
    return size;
  }

  @override
  String toString() {
    return 'ZIPFILE: ' + name + ' (' + files.toString() + ')';
  }

}