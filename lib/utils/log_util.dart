import 'dart:convert';
import 'dart:developer';

class Log {
  factory Log() => _instance!;

  Log._(this.production);

  static void init({bool production = false}) => _instance = Log._(production);

  static late Log? _instance;

  final bool production;

  void debug(String tag, [dynamic payload]) {
    String output;
    if (production) return log('');
    try {
      output = generator('=', tag, jsonPretty(json.decode(payload)));
    } catch (e) {
      output = generator('=', tag, payload);
    }

    return log(output);
  }

  String error(String tag, [dynamic payload]) {
    if (production) return '';
    final output = generator('*', tag, payload);
    return output;
  }

  String generator(String delime, String tag, [dynamic payload]) {
    if (production) return '';
    var _ = '';

    final d = delime.padRight(20, delime);
    _ += '\n$delime> $tag $d>\n';
    if (payload != null) {
      _ += '$payload \n$d\n';
    }

    return _;
  }
}

String jsonPretty(Object obj) {
  const encoder = JsonEncoder.withIndent('  ');
  final prettyprint = encoder.convert(obj);
  return prettyprint;
}
