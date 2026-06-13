import 'package:flutter/material.dart';
import 'package:handy/core/services/storage_service.dart';
import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize services here
  await StorageService.init();

  runApp(const MyApp());
}
