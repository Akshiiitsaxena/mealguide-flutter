import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class BrightnessNotifier extends StatefulWidget {
  final Widget child;
  final VoidCallback? onBrightnessChanged;

  const BrightnessNotifier({
    Key? key,
    required this.child,
    this.onBrightnessChanged,
  }) : super(key: key);

  @override
  _BrightnessNotifierState createState() => _BrightnessNotifierState();
}

class _BrightnessNotifierState extends State<BrightnessNotifier>
    with WidgetsBindingObserver {
  late Brightness _currentBrightness;

  @override
  void initState() {
    _currentBrightness = SchedulerBinding
        .instance.window.platformBrightness; // Save initial system brightness
    WidgetsBinding.instance
        .addObserver(this); // Bind to app system state events
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance
        .removeObserver(this); // Don't forget to remove the observer
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      // App went back to foreground
      final systemBrightness = SchedulerBinding.instance.window
          .platformBrightness; // Check if current system brightness did change
      if (_currentBrightness != systemBrightness) {
        _currentBrightness = systemBrightness;
        // Notify if it did
        widget.onBrightnessChanged?.call();
      }
    }
  }

  @override
  void didChangePlatformBrightness() {
    widget.onBrightnessChanged?.call();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
