abstract class SafeJson {}

class SafeJsonData implements SafeJson {
  static int intSafe(dynamic value) => switch (value) {
    null => 0,
    int() => value,
    String() => int.tryParse(value) ?? 0,
    double() => value.toInt(),
    _ => 0,
  };

  static double doubleSafe(dynamic value) => switch (value) {
    null => 0,
    int() => value.toDouble(),
    String() => double.tryParse(value) ?? 0,
    double() => value,
    _ => 0,
  };
}
