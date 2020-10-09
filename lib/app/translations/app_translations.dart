import 'en_US/en_us_translation.dart';
import 'pt_BR/pt_br_translation.dart';
  abstract class AppTranslation {
  static Map<String, Map<String, String>> translations = {
    'pt_BR': ptBR,
    'en_US': enUs,
  };
}
  