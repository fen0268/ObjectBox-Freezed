import 'package:flutter/material.dart';
import 'package:flutter_objectbox_riverpod_sample_app/features/user_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../main.dart';
import '../models/user.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    /// state を監視
    final data = ref.watch(userStateNotifierProvider);

    /// controller を監視
    final notifier = ref.watch(userStateNotifierProvider.notifier);
    final userBox = store.box<User>();

    /// 保存されている ID の中で一番大きな値を取得
    /// 何も保存されてない場合は 0
    final fetchUserBoxId =
        userBox.getAll().isEmpty ? 0 : userBox.getAll().last.id;

    void addUser() {
      final newUser = User(
        /// 9223372036854775807 2^63 max値
        /// 一番大きな ID + 1 で常に ID が被らないように実装
        id: fetchUserBoxId + 1,

        /// controller の TextEditingController のテキスト
        name: notifier.controller.text,
      );
      
      notifier.putUser(newUser);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('ObjectBox'),
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
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: userBox
                  .getAll()
                  .map(
                    (e) => ListTile(
                      title: Text('ID: ${e.id}, name: ${e.name}'),
                      trailing: IconButton(
                        onPressed: () {
                          notifier.removeUser(e.id);
                        },
                        icon: const Icon(Icons.delete),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
