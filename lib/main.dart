import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app.dart';
import 'objectbox.g.dart';

late Store store;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  store = await openStore();

  runApp(
    const ProviderScope(child: App()),
  );
}
