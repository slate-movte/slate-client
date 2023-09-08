import 'dart:async';

import 'package:slate/domain/entities/user.dart';

class SlateAuth {
  final StreamController<User?> _auth = StreamController.broadcast();

  Stream<User?> authStateChanges() => _auth.stream;

  void update(User user) => _auth.add(user);

  Future<void> delete() async => await _auth.close();

  void checkState() {}
}
