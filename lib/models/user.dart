import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:objectbox/objectbox.dart';

part 'user.freezed.dart';

@freezed
class User with _$User {
  @Entity(realClass: User)
  factory User({
    /// @Id() アノテーションで ID であることを明示する
    /// assignable 自分で ID を割り当てる場合は true にしなければならない
    /// Freezed の場合は自動インクリメントされないので true にしないと自動生成されない
    @Id(assignable: true) required int id,
    @Default('') String name,
  }) = _User;
}
