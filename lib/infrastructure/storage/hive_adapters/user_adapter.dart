import 'package:flutter_enterprise_boilerplate/features/auth/data/models/user_model.dart';
import 'package:hive/hive.dart';
import 'package:flutter_enterprise_boilerplate/features/auth/domain/entities/user.dart';

class UserAdapter extends TypeAdapter<UserModel> {
  @override
  final int typeId = 1;

  @override
  UserModel read(BinaryReader reader) {

    final id = reader.readString();
    final email = reader.readString();
    final firstName = reader.readString();
    final lastName = reader.readString();
    final avatarUrl = reader.readString();
    final phoneNumber = reader.readString();
    final emailVerified = reader.readBool();
    final roles = reader.readList().cast<String>();
    
    final hasCreatedAt = reader.readBool();
    final createdAt = hasCreatedAt ? DateTime.fromMillisecondsSinceEpoch(reader.readInt()) : null;
    
    final hasUpdatedAt = reader.readBool();
    final updatedAt = hasUpdatedAt ? DateTime.fromMillisecondsSinceEpoch(reader.readInt()) : null;

    final hasLoggedInAt = reader.readBool();
    final loggedInAt = hasLoggedInAt ? DateTime.fromMillisecondsSinceEpoch(reader.readInt()) : null;

    final isProfileCompleted = reader.readBool();
     
    return UserModel(
      id: id,
      email: email,
      firstName: firstName,
      lastName: lastName,
      avatarUrl: avatarUrl.isEmpty ? null : avatarUrl,
      phoneNumber: phoneNumber.isEmpty ? null : phoneNumber,
      emailVerified: emailVerified,
      roles: roles,
      createdAt: createdAt,
      updatedAt: updatedAt,
      loggedInAt: loggedInAt,
      isProfileCompleted: isProfileCompleted,
    );
  }

  @override
  void write(BinaryWriter writer, UserModel obj) {
    writer
      ..writeString(obj.id)
      ..writeString(obj.email)
      ..writeString(obj.firstName )
      ..writeString(obj.lastName  )
      ..writeString(obj.avatarUrl ?? '')
      ..writeString(obj.phoneNumber ?? '')
      ..writeBool(obj.emailVerified)
      ..writeList(obj.roles)
      ..writeBool(obj.createdAt != null);

      if (obj.createdAt != null) {
        writer.writeInt(obj.createdAt!.millisecondsSinceEpoch);
      }

      writer.writeBool(obj.updatedAt != null);
      if (obj.updatedAt != null) {
        writer.writeInt(obj.updatedAt!.millisecondsSinceEpoch);
      }

      writer.writeBool(obj.loggedInAt != null);
      if (obj.loggedInAt != null) {
        writer.writeInt(obj.loggedInAt!.millisecondsSinceEpoch);
      }

      writer.writeBool(obj.isProfileCompleted);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
