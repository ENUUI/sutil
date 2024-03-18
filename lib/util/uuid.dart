import 'package:uuid/uuid.dart';

String uuid() {
  final u = Uuid();
  return u.v4();
}
