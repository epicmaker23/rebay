import 'package:intl/intl.dart';

class DateUtilsX {
  static String formatRelativeTime(DateTime dt) {
    final diff = DateTime.now().difference(dt);
    if (diff.inMinutes < 1) return 'ahora';
    if (diff.inMinutes < 60) return '${diff.inMinutes} min';
    if (diff.inHours < 24) return '${diff.inHours} h';
    return DateFormat('dd/MM/yyyy').format(dt);
  }

  static String formatDateHeader(DateTime dt) {
    return DateFormat('EEE d MMM, HH:mm', 'es_ES').format(dt);
  }

  static String formatTime(DateTime dt) {
    return DateFormat('HH:mm').format(dt);
  }
}
