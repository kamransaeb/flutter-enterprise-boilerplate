import 'package:flutter_enterprise_boilerplate/features/auth/domain/entities/user.dart';
import 'package:freezed_annotation/freezed_annotation.dart';


part 'user_model.freezed.dart';
part 'user_model.g.dart';

// With freezed 3 the public class must be abstract.
@freezed
abstract class UserModel with _$UserModel {
  const UserModel._();  // ← enables custom methods on generated class UserModel.toEntity()

  const factory UserModel({
    required String id,
    required String email,
    @JsonKey(name: 'first_name') String? firstName,
    @JsonKey(name: 'last_name') String? lastName,
    @JsonKey(name: 'avatar_url') String? avatarUrl,
    @JsonKey(name: 'phone_number') String? phoneNumber,
    @JsonKey(name: 'email_verified') bool? emailVerified,
    @JsonKey(name: 'phone_verified') @Default(false) bool phoneVerified,
    @JsonKey(name: 'roles') List<String>? roles,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
    @JsonKey(name: 'logged_in_at') DateTime? loggedInAt,
    @JsonKey(name: 'is_profile_completed') bool? isProfileCompleted,
    @JsonKey(name: 'is_active') @Default(true) bool isActive,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  User toEntity() {
    return User(
      id: id,
      email: email,
      firstName: firstName,
      lastName: lastName,
      phoneNumber: phoneNumber,
      avatarUrl: avatarUrl,
      emailVerified: emailVerified ?? false,
      phoneVerified: phoneVerified,
      roles: roles ?? [],
      createdAt: createdAt,
      updatedAt: updatedAt,
      loggedInAt: loggedInAt,
      isProfileCompleted: isProfileCompleted ?? false,  
      isActive: isActive,
    );
  }
}

extension UserExtension on User {
  UserModel toModel() {
    return UserModel(
      id: id,
      email: email,
      firstName: firstName,
      lastName: lastName, 
      avatarUrl: avatarUrl,
      phoneNumber: phoneNumber,
      emailVerified: emailVerified,
      phoneVerified: phoneVerified,
      roles: roles,
      createdAt: createdAt,
      updatedAt: updatedAt,
      loggedInAt: loggedInAt,
      isProfileCompleted: isProfileCompleted,
      isActive: isActive,
    );
  }
}