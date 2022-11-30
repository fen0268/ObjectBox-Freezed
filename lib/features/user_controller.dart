import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../main.dart';
import '../models/user.dart';

final userStateNotifierProvider =
    StateNotifierProvider.autoDispose<UserStateNotifier, User>(
  ((ref) => UserStateNotifier()),
);

class UserStateNotifier extends StateNotifier<User> {
  UserStateNotifier() : super(User(id: 0));
  final nameController = TextEditingController();

  /// Box を取得
  final userBox = store.box<User>();

  @override
  void dispose() {
    /// キャッシュクリア
    nameController.dispose();
    super.dispose();
  }

  ///追加メソッド
  void putUser() {
    /// 保存されている ID の中で一番大きな値を取得
    /// 何も保存されてない場合は 0 を取得
    final fetchUserBoxId =
        userBox.getAll().isEmpty ? 0 : userBox.getAll().last.id;

    final newUser = User(
      /// max値 9223372036854775807 2^63
      /// 一番大きな id + 1 で常に id が被らないように実装
      id: fetchUserBoxId + 1,
      name: nameController.text,
    );

    state = state.copyWith(id: newUser.id, name: newUser.name);
    userBox.put(state);
  }

  ///削除メソッド
  void removeUser(int id) {
    state = state.copyWith(id: id);
    userBox.remove(state.id);
  }
}
