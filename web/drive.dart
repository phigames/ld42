part of ld42;

class Drive extends Sprite {

  static const num BAR_HEIGHT = 30;

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
    area.graphics.rect(0, 0, 300, 300);
    area.graphics.fillColor(0xFFDDDDDD);
    addChild(area);
    bar = new Sprite();
    bar.y = -BAR_HEIGHT;
    nameText = new TextField(name, new TextFormat('sans-serif', 20, 0xFFFFFFFF))
        ..x = 5
        ..width = area.width - 10
        ..height = BAR_HEIGHT
        ..mouseEnabled = false;
    bar.addChild(nameText);
    sizeText = new TextField('', new TextFormat('sans-serif', 20, 0xFFFFFFFF, align: 'right'))
        ..x = 5
        ..width = area.width - 10
        ..height = BAR_HEIGHT
        ..mouseEnabled = false;
    bar.addChild(sizeText);
    update(true);
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
    update(true);
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

  void update([bool sort = false]) {
    if (sort) {
      files.sort((f1, f2) => f1.name.compareTo(f2.name));
    }
    int fileX = 10;
    int fileY = 10;
    used = 0;
    for (File f in files) {
      f.drive = this;
      f.x = x + fileX;
      f.y = y + fileY;
      fileX += 60;
      if (fileX > area.width - 60) {
        fileX = 10;
        fileY += 90;
      }
      used += f.size;
    }
    sizeText.text = used.toString() + '/' + size.toString() + 'kB';
    bar.graphics.beginPath();
    bar.graphics.rect(0, 0, area.width, BAR_HEIGHT);
    bar.graphics.fillColor(0xFF4444FF);
    bar.graphics.beginPath();
    bar.graphics.rect(0, BAR_HEIGHT, area.width * used / size, -10);
    bar.graphics.fillColor(0xFFAA4444);
    print('DRIVE UPDATED:');
    print(files);
  }

}
