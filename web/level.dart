part of ld42;

String sizeString(num size) {
  if (size < 1024) {
    return '${size.toStringAsFixed(1)}kB';
  } else {
    return '${(size/1024).toStringAsFixed(1)}MB';
  }
}

class Level extends Sprite {

  List<Drive> drives;
  Drive selectionDrive;
  int zipNumber;
  Tutorial tutorial;

  Level(this.drives, this.tutorial) {
    for (Drive d in drives) {
      d.bar.onTouchBegin.listen((_) => _startDriveDrag(d));
      d.bar.onTouchEnd.listen((_) => _stopDriveDrag(d));
      d.bar.onTouchOut.listen((_) => _stopDriveDrag(d));
      d.bar.onMouseDown.listen((_) => _startDriveDrag(d));
      d.bar.onMouseUp.listen((_) => _stopDriveDrag(d));
      d.bar.onMouseOut.listen((_) => _stopDriveDrag(d));
      d.bar.onMouseMove.listen((_) {
        if (d.dragging) d.update(redraw: false);
      });
      addChild(d);
      for (File f in d.files) {
        f.onTouchBegin.listen((_) => _startFileDrag(f));
        f.onTouchEnd.listen((_) => _stopFileDrag(f));
        //f.onTouchOut.listen((_) => _stopFileDrag(f));
        f.onMouseDown.listen((_) => _startFileDrag(f));
        f.onMouseUp.listen((_) => _stopFileDrag(f));
        //f.onMouseOut.listen((_) => _stopFileDrag(f));
        f.onTouchTap.listen((_) => _toggleFileSelection(f));
        f.onMouseRightClick.listen((_) => _toggleFileSelection(f));
        addChild(f);
      }
    }
    zipNumber = 0;
    if (tutorial != null) {
      addChild(tutorial);
    }
  }

  void start() {
    tutorial.handleAction(Action.BEGIN);
  }

  void deselectAll() {
    if (selectionDrive != null) {
      for (File f in selectionDrive.files) {
        f.deselect();
      }
    }
  }

  void addFile(Drive drive, File file, bool brandnew) {
    drive.files.add(file);
    if (brandnew) {
      file.onTouchBegin.listen((_) => _startFileDrag(file));
      file.onTouchEnd.listen((_) => _stopFileDrag(file));
      //file.onTouchOut.listen((_) => _stopFileDrag(file));
      file.onMouseDown.listen((_) => _startFileDrag(file));
      file.onMouseUp.listen((_) => _stopFileDrag(file));
      //file.onMouseOut.listen((_) => _stopFileDrag(file));
      file.onTouchTap.listen((_) => _toggleFileSelection(file));
      file.onMouseRightClick.listen((_) => _toggleFileSelection(file));
    } else {
      //file.visible = true;
    }
      addChild(file);
    drive.update(sort: true);
  }

  void removeFile(File file) {
    file.drive.files.remove(file);
    removeChild(file);
    //file.visible = false;
    file.drive.update();
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
    deselectAll();
    //resourceManager.getSound('click').play();
  }

  void _stopFileDrag(File file) {
    bool moved = false;
    for (Drive d in drives) {
      if (file.hitTestObject(d)) {
        if (d == file.drive) {
          moved = true;
          file.drive.update();
          break;
        }
        moved = d.moveHere(file);
        if (moved) {
          break;
        }
      }
    }
    if (!moved) {
      file.drive.update();
      file.highlight(0xFFAA4444);
      resourceManager.getSound('error').play();
    } else {
      checkLevelOver();
    }
    file.stopDrag();
    file.alpha = 1;
    resourceManager.getSound('click').play();
  }

  void _startDriveDrag(Drive drive) {
    drive.dragging = true;
    drive.startDrag();
  }

  void _stopDriveDrag(Drive drive) {
    drive.dragging = false;
    drive.stopDrag();
    drive.update(redraw: false);
  }

  void _toggleFileSelection(File file) {
    if (selectionDrive != null && selectionDrive != file.drive) {
      deselectAll();
    }
    if (file.selected) {
      file.deselect();
      resourceManager.getSound('click').play();
    } else {
      file.select();
      selectionDrive = file.drive;
      resourceManager.getSound('click').play();
    }
  }

  void _onKeyPressed(int keyCode) {
    if (keyCode == html.KeyCode.Z) {
      List<File> selectedFiles = new List<File>();
      for (Drive d in drives) {
        for (File f in d.files) {
          if (f.selected) {
            selectedFiles.add(f);
          }
        }
      }
      // unzip single zip file
      if (selectedFiles.length == 1 && selectedFiles[0] is ZipFile) {
        ZipFile zip = selectedFiles[0];
        if (zip.drive.used - zip.size + zip.originalSize > zip.drive.size) {
          zip.highlight(0xFFAA4444);
          resourceManager.getSound('error').play();
        } else {
          removeFile(zip);
          for (File f in zip.files) {
            addFile(zip.drive, f, false);
            f.highlight(0xFF4444FF);
          }
          checkLevelOver();
          if (zip.bomb) {
            zip.drive.crack();
          }
          resourceManager.getSound('zip').play();
        }
      }
      // zip multiple or single regular files
      else if (selectedFiles.length > 0) {
        for (File f in selectedFiles) {
          removeFile(f);
        }
        ZipFile zip = new ZipFile(zipNumber++, selectedFiles);
        addFile(selectionDrive, zip, true);
        zip.highlight(0xFF4444FF);
        tutorial.handleAction(Action.ZIP);
        resourceManager.getSound('zip').play();
      }
      deselectAll();
    }
  }

}