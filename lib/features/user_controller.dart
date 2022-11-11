import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../main.dart';
import '../models/user.dart';

final userStateNotifierProvider =
    StateNotifierProvider.autoDispose<UserStateNotifier, User>(
  ((ref) => UserStateNotifier()),
);

class UserStateNotifier extends StateNotifier<User> {
  UserStateNotifier() : super(User(id: store.box<User>().getAll().length + 1));
  final controller = TextEditingController(); //
  final userBox = store.box<User>();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void fetchUserBoxId() {
    userBox.getAll().length;
  }

  ///追加メソッド
  void putUser(User user) {
    state = User(id: user.id, name: user.name);
    userBox.put(state);
  }

  ///全部削除メソッド
  void removeUser() {
    userBox.removeAll();
  }
}
