import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:objectbox/objectbox.dart';

part 'user.freezed.dart';

/// idをインクリメントできるようにしたい => 上限2^32
/// またはidを使わずにuuidを代わりに使いたい => 上限2^122

@freezed
class User with _$User {
  @Entity(realClass: User)
  factory User({
    /// id に@Index() は使用できない?
    @Id(assignable: true) required int id,
    @Default('') String name,
  }) = _User;
}
