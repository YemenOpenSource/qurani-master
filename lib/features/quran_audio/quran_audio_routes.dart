import 'package:auto_route/auto_route.dart';

/// مسارات مشغّل المصحف الصوتي تحت البادئة `/quran-audio`.
///
/// القائمة فارغة عمدًا: الشاشة الوحيدة في هذه الميزة
/// (`presentation/view/pages/audio_quran_screen.dart`) معطّلة بالكامل —
/// الملفّ كلّه تعليق ولا يُدفع من أي مكان. تُضاف الوجهات هنا حين تُستأنف
/// الشاشة، والبادئة محجوزة لها حتى ذلك الحين.
abstract final class QuranAudioRoutes {
  static List<AutoRoute> get routes => const <AutoRoute>[];
}
