import 'dart:convert';

import '../../services/shared_preference.dart';
import 'base.dart';

/// The signed-in doctor, kept in memory as `UserModel.i` and persisted with
/// [CacheHelper] (`AppCached.user`).
class UserModel extends Model {
  UserModel._();

  static UserModel i = UserModel._();

  late String name, email, title, address, type, token;

  /// Shown on the profile screen, as before.
  late String password;

  bool get isAuth => token.isNotEmpty;

  void fromJson([Map<String, dynamic>? json]) {
    id = stringFromJson(json, 'id');
    name = stringFromJson(json, 'name');
    email = stringFromJson(json, 'email');
    title = stringFromJson(json, 'title');
    address = stringFromJson(json, 'address');
    type = stringFromJson(json, 'type');
    token = stringFromJson(json, 'token');
    password = stringFromJson(json, 'password');
  }

  @override
  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'email': email,
    'title': title,
    'address': address,
    'type': type,
    'token': token,
    'password': password,
  };

  Future<void> save() async {
    await CacheHelper.setValue(AppCached.user, jsonEncode(toJson()));
  }

  Future<void> clear() async {
    await CacheHelper.clear();
    fromJson();
  }

  void get() {
    final String user = CacheHelper.getValue(AppCached.user) ?? '{}';
    fromJson(jsonDecode(user));
    if (token.isNotEmpty) return;
    // Sessions saved by the old app used one key per field.
    String legacy(String key) => '${CacheHelper.getValue(key) ?? ''}';
    token = legacy(AppCached.legacyToken);
    name = legacy(AppCached.legacyName);
    password = legacy(AppCached.legacyPassword);
    type = legacy(AppCached.legacyType);
    title = legacy(AppCached.legacyTitle);
    address = legacy(AppCached.legacyAddress);
  }

  @override
  String toString() => 'UserModel{id: $id, name: $name, email: $email}';
}
