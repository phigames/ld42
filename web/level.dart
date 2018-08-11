part of ld42;

class Level extends Sprite {

  List<Drive> drives;
  Tutorial tutorial;

  Level(this.drives, this.tutorial) {
    for (Drive d in drives) {
      d.onTouchBegin.listen((_) => _startDriveDrag(d));
      d.onTouchEnd.listen((_) => _stopDriveDrag(d));
      d.onTouchOut.listen((_) => _stopDriveDrag(d));
      d.onMouseDown.listen((_) => _startDriveDrag(d));
      d.onMouseUp.listen((_) => _stopDriveDrag(d));
      d.onMouseOut.listen((_) => _stopDriveDrag(d));
      d.onMouseMove.listen((_) {
        if (d.dragging) d.update();
      });
      addChild(d);
      for (File f in d.files) {
        f.onTouchBegin.listen((_) => _startFileDrag(f));
        f.onTouchEnd.listen((_) => _stopFileDrag(f));
        f.onTouchOut.listen((_) => _stopFileDrag(f));
        f.onMouseDown.listen((_) => _startFileDrag(f));
        f.onMouseUp.listen((_) => _stopFileDrag(f));
        f.onMouseOut.listen((_) => _stopFileDrag(f));
        addChild(f);
      }
    }
    if (tutorial != null) {
      addChild(tutorial);
    }
    tutorial.handleAction(Action.BEGIN);
  }

  void checkLevelOver() {
    for (Drive d in drives) {
      if (!d.containsTargetFiles()) {
        return;
      }
    }
    tutorial.handleAction(Action.END, nextLevel);
  }

  void _startFileDrag(File file) {
    file.startDrag(false);
    file.alpha = 0.5;
    setChildIndex(file, children.length - 1);
  }

  void _stopFileDrag(File file) {
    bool moved = false;
    for (Drive d in drives) {
      if (d != file.drive && file.hitTestObject(d)) {
        moved = d.moveHere(file);
      }
    }
    if (!moved) {
      file.drive.update();
    } else {
      checkLevelOver();
    }
    file.stopDrag();
    file.alpha = 1;
  }

  void _startDriveDrag(Drive drive) {
    drive.dragging = true;
    drive.startDrag();
  }

  void _stopDriveDrag(Drive drive) {
    drive.dragging = false;
    drive.stopDrag();
  }

}