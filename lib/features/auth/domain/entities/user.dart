import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

part 'user.freezed.dart';
part 'user.g.dart';

/// User entity
@freezed
abstract class User with _$User {
  // User constructor private
  const User._();

  // User factory constructor
  const factory User({
    @JsonKey(name: 'id')
    required String id,
    @JsonKey(name: 'email')
    required String email,
    @JsonKey(name: 'first_name')
    String? firstName,
    @JsonKey(name: 'last_name')
    String? lastName,
    @JsonKey(name: 'avatar_url')
    String? avatarUrl,
    @JsonKey(name: 'phone_number')
    String? phoneNumber,
    @JsonKey(name: 'email_verified')
    @Default(false) bool emailVerified,
    @JsonKey(name: 'phone_verified')
    @Default(false) bool phoneVerified,
    @JsonKey(name: 'roles')
    @Default([]) List<String> roles,
    @JsonKey(name: 'created_at')
    DateTime? createdAt,
    @JsonKey(name: 'updated_at')
    DateTime? updatedAt,
    @JsonKey(name: 'logged_in_at')
    DateTime? loggedInAt,
    @JsonKey(name: 'is_profile_completed')
    @Default(false) bool isProfileCompleted,
    @JsonKey(name: 'is_active')
    @Default(true) bool isActive,
  }) = _User;

  factory User.empty() => const User(
        id: '',
        email: '',
        firstName: null,
        lastName: null,
        avatarUrl: null,
        phoneNumber: null,
        emailVerified: false,
        phoneVerified: false,
        roles: [],
        createdAt: null,
        updatedAt: null,
        loggedInAt: null,
        isProfileCompleted: false,
        isActive: true,
      );

  /// Factory method for creating a User from a JSON object
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  /// Convenience getter to check if user has a specific role
  bool hasRole(String role) => roles.contains(role);

/// Convenience getter to check if user is an admin
  bool get isAdmin => hasRole('admin');

  /// Convenience getter to get user's full name
  String get fullName => '$firstName $lastName';
}