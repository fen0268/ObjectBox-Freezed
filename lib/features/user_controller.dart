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
    state = state.copyWith(id: user.id, name: user.name);
    userBox.put(user);
  }

  ///削除メソッド
  void removeUser(int id) {
    state = state.copyWith(id: id, name: '');
    userBox.remove(state.id);
  }
}
