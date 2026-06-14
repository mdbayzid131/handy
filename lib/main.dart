import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:handy/core/services/storage_service.dart';
import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Disable screen rotation (Portrait only)
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // Initialize services here
  await StorageService.init();

  runApp(const MyApp());
}
