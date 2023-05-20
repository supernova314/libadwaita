library libadwaita_core;

import 'package:flutter/material.dart';
import 'package:yaru_window/yaru_window.dart';

typedef AdwControlsWidget = Widget? Function(
  void Function(BuildContext context)?,
);

class AdwControls {
  AdwControls({
    this.closeBtn,
    this.maximizeBtn,
    this.minimizeBtn,
  });

  final AdwControlsWidget? closeBtn;
  final AdwControlsWidget? maximizeBtn;
  final AdwControlsWidget? minimizeBtn;

  AdwControls copyWith({
    AdwControlsWidget? closeBtn,
    AdwControlsWidget? maximizeBtn,
    AdwControlsWidget? minimizeBtn,
  }) =>
      AdwControls(
        closeBtn: closeBtn ?? this.closeBtn,
        maximizeBtn: maximizeBtn ?? this.maximizeBtn,
        minimizeBtn: minimizeBtn ?? this.minimizeBtn,
      );
}

class AdwActions {
  AdwActions({
    this.onClose,
    this.onMaximize,
    this.onMinimize,
    this.onDoubleTap,
    this.onHeaderDrag,
    this.onRightClick,
  });

  final void Function(BuildContext context)? onClose;
  final void Function(BuildContext context)? onMaximize;
  final void Function(BuildContext context)? onMinimize;
  final VoidCallback? onDoubleTap;
  final void Function(BuildContext context)? onHeaderDrag;
  final VoidCallback? onRightClick;

  AdwActions copyWith({
    final void Function(BuildContext context)? onClose,
    final void Function(BuildContext context)? onMaximize,
    final void Function(BuildContext context)? onMinimize,
    VoidCallback? onDoubleTap,
    final void Function(BuildContext context)? onHeaderDrag,
    VoidCallback? onRightClick,
  }) =>
      AdwActions(
        onClose: onClose ?? this.onClose,
        onMaximize: onMaximize ?? this.onMaximize,
        onMinimize: onMinimize ?? this.onMinimize,
        onDoubleTap: onDoubleTap ?? this.onDoubleTap,
        onHeaderDrag: onHeaderDrag ?? this.onHeaderDrag,
        onRightClick: onRightClick ?? this.onRightClick,
      );
}

extension Default on AdwActions {
  AdwActions get adwDefault => AdwActions(
        onClose: (context) {
          YaruWindow.of(context).close();
        },
        onMaximize: (context) {
          YaruWindow.of(context).close();
        },
        onMinimize: (context) {
          YaruWindow.of(context).close();
        },
        onHeaderDrag: (context) {
          YaruWindow.of(context).drag();
        },
      );
}
