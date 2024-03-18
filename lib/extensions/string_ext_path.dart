import 'package:path/path.dart' as p;

extension StringPath on String {
  String joinPath(String part) {
    return p.join(this, part);
  }

  String joinAllPaths(List<String> parts) {
    return p.joinAll([this, ...parts]);
  }

  List<String> splitPath() {
    return p.split(this);
  }
}
