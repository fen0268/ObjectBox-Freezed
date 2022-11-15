import 'package:flutter/material.dart';
import 'package:flutter_objectbox_riverpod_sample_app/features/user_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../main.dart';
import '../models/user.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(userStateNotifierProvider);
    final notifier = ref.watch(userStateNotifierProvider.notifier);
    final userBox = store.box<User>();
    final fetchUserBoxId =
        userBox.getAll().isEmpty ? 0 : userBox.getAll().last.id;

    void addUser() {
      final newUser = User(
        // 9223372036854775807 2^63 max値
        id: fetchUserBoxId + 1,
        name: notifier.controller.text,
      );
      notifier.putUser(newUser);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('ObjectBox'),
        actions: [
          IconButton(
            onPressed: () {
              notifier.removeUser();
            },
            icon: const Icon(Icons.delete),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(32),
              child: TextFormField(
                controller: notifier.controller,
                decoration: const InputDecoration(hintText: 'ユーザー名'),
              ),
            ),
            ElevatedButton(
              onPressed: addUser,
              child: const Text('ユーザーを追加する'),
            ),
            const SizedBox(height: 16),
            const Text('データ全体'),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: userBox
                  .getAll()
                  .map(
                    (e) => Text('ID: ${e.id}, name: ${e.name}'),
                  )
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
