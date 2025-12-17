import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:custom_mapper_annotation/custom_mapper_annotation.dart';

part 'user.freezed.dart';
part 'user.map.dart';

@freezed
sealed class User with _$User {
  const factory User({
    required String name,
    required int age,
    required String email,
  }) = _User;
}

@freezed
@Mapper(domain: User)
sealed class UserData with _$UserData {
  const factory UserData({
    required String name,
    required int age,
    required String email,
  }) = _UserData;
}
