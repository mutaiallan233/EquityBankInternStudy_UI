import 'package:flutter/material.dart';

import '../data/data.dart';

class CurrentTrackModel extends ChangeNotifier {
  Study? selected;

  void selectTrack(Study track) {
    selected = track;
    notifyListeners();
  }
}
