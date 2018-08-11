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
  Bitmap icon;
  TextField text;

  File(this.name, this.type, this.size) {
    mouseCursor = MouseCursor.POINTER;
    selected = false;
    icon = new Bitmap();
    addChild(icon);
    text = new TextField('${name}\n${sizeString(size)}', new TextFormat(FONT, 15, 0xFF000000, align: 'left'))
      ..x = 55
      ..y = 5
      ..width = 95
      ..height = 40
      ..mouseEnabled = false;
    addChild(text);
    updateIcon();
  }

  void updateIcon() {
    if (type == FileType.TEXT) {
      icon.bitmapData = resourceManager.getBitmapData('text');
    } else if (type == FileType.IMAGE) {
      icon.bitmapData = resourceManager.getBitmapData('image');
    } else if (type == FileType.ZIP) {
      icon.bitmapData = resourceManager.getBitmapData('zip');
    }
    if (!selected) {
      text.defaultTextFormat = new TextFormat(FONT, 15, 0xFF000000, align: 'left');
    } else {
      text.defaultTextFormat = new TextFormat(FONT, 15, 0xFF000000, align: 'left', bold: true, underline: true);
    }
    icon.width = 50;
    icon.height = 50;
  }

  void select() {
    selected = true;
    updateIcon();
  }

  void deselect() {
    selected = false;
    updateIcon();
  }

  @override
  String toString() {
    return 'FILE: ' + name;
  }

}

class ZipFile extends File {

  static const Map<FileType, num> COMPRESSION = <FileType, num>{
    FileType.TEXT: 0.3,
    FileType.IMAGE: 0.9,
    FileType.ZIP: 0,
  };

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
      size += f.size * COMPRESSION[f.type];
    }
    return size;
  }

  @override
  String toString() {
    return 'ZIPFILE: ' + name + ' (' + files.toString() + ')';
  }

}