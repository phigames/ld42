part of ld42;

class Drive extends Sprite {

  static const num WIDTH = 330, HEIGHT = 250, BAR_HEIGHT = 30;

  String name;
  num size;
  num used;
  List<File> files;
  List<String> targetFileNames;
  Sprite area;
  Sprite bar;
  TextField nameText;
  TextField sizeText;
  bool dragging;

  Drive(this.name, num x, num y, this.size, this.files, this.targetFileNames) {
    this.x = x;
    this.y = y;
    area = new Sprite();
    area.graphics.beginPath();
    area.graphics.rect(0, 0, WIDTH, HEIGHT);
    area.graphics.fillColor(0xFFCCCCCC);
    area.graphics.strokeColor(0xFF000000, 2);
    addChild(area);
    bar = new Sprite();
    bar.y = -BAR_HEIGHT;
    nameText = new TextField(name, new TextFormat(FONT, 20, 0xFFFFFFFF))
        ..x = 5
        ..width = WIDTH - 10
        ..height = BAR_HEIGHT
        ..mouseEnabled = false;
    bar.addChild(nameText);
    sizeText = new TextField('', new TextFormat(FONT, 20, 0xFFFFFFFF, align: 'right'))
        ..x = 5
        ..width = WIDTH - 10
        ..height = BAR_HEIGHT
        ..mouseEnabled = false;
    bar.addChild(sizeText);
    update(sort: true);
    bar.mouseCursor = MouseCursor.POINTER;
    addChild(bar);
    dragging = false;
  }

  bool moveHere(File file) {
    if (file.size > size - used) {
      return false;
    }
    file.drive.files.remove(file);
    file.drive.update();
    files.add(file);
    update(sort: true);
    return true;
  }

  bool containsTargetFiles() {
    for (String fn in targetFileNames) {
      bool contained = false;
      for (File f in files) {
        if (f.name == fn) {
          contained = true;
          break;
        }
      }
      if (!contained) {
        return false;
      }
    }
    return true;
  }

  void update({bool sort = false, bool redraw = true}) {
    if (sort) {
      //files.sort((f1, f2) => f1.name.compareTo(f2.name));
    }
    int fileX = 10;
    int fileY = 10;
    used = 0;
    for (File f in files) {
      f.drive = this;
      f.x = x + fileX;
      f.y = y + fileY;
      fileX += 160;
      if (fileX > WIDTH - 160) {
        fileX = 10;
        fileY += 60;
      }
      used += f.size;
    }
    sizeText.text = '${sizeString(used)}/${sizeString(size)}';
    if (redraw) {
      bar.graphics.beginPath();
      bar.graphics.rect(0, 0, WIDTH, BAR_HEIGHT);
      bar.graphics.fillColor(0xFF4444FF);
      bar.graphics.beginPath();
      bar.graphics.rect(0, BAR_HEIGHT, WIDTH * used / size, -BAR_HEIGHT);//-10);
      bar.graphics.fillColor(0xFFAA4444);
      bar.graphics.beginPath();
      bar.graphics.rect(0, 0, WIDTH, BAR_HEIGHT);
      bar.graphics.strokeColor(0xFF000000, 2);
    }
  }

}
