part of ld42;

class Level extends Sprite {

  static final Level LEVEL_TEST = new Level(
    <Drive>[
      new Drive(
        'test_drive',
        50, 50,
        100,
        <File>[
          new File('test.txt', FileType.TEXT, 10)
        ],
        <String>[

        ]
      ),
      new Drive(
        'asdf',
        400, 200,
        50,
        <File>[
          new File('asdf.jpg', FileType.IMAGE, 10)
        ],
        <String>[
          'test.txt'
        ]
      )
    ]
  );

  List<Drive> drives;

  Level(this.drives) {
    for (Drive d in drives) {
      addChild(d);
      for (File f in d.files) {
        f.onTouchBegin.listen((e) => _startFileDrag(f, e.localX, e.localY));
        f.onTouchEnd.listen((_) => _stopFileDrag(f));
        f.onTouchOut.listen((_) => _stopFileDrag(f));
        f.onMouseDown.listen((e) => _startFileDrag(f, e.localX, e.localY));
        f.onMouseUp.listen((_) => _stopFileDrag(f));
        f.onMouseOut.listen((_) => _stopFileDrag(f));
        addChild(f);
      }
    }
  }

  void _startFileDrag(File file, num offsetX, num offsetY) {
    file.startDrag(false, /*Rectangle<num>(offsetX, offsetY, area.width - file.width, area.height - file.height)*/);
    file.alpha = 0.5;
    setChildIndex(file, children.length - 1);
  }

  void _stopFileDrag(File file) {
    bool moved = false;
    for (Drive d in drives) {
      if (file.hitTestObject(d)) {
        file.drive.files.remove(file);
        file.drive.update();
        d.files.add(file);
        d.update();
        moved = true;
      }
    }
    if (!moved) {
      file.drive.update();
    }
    file.stopDrag();
    file.alpha = 1;
  }

}