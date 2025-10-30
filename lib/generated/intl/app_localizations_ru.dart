// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get welcome_message => 'Добро пожаловать';

  @override
  String get greeting => 'Привет';

  @override
  String get farewell => 'До свидания';

  @override
  String get app_name => 'Тестовое приложение';

  @override
  String get light_theme => 'Светлая';

  @override
  String get dark_theme => 'Темная';

  @override
  String get home => 'Главная';

  @override
  String get deposit => 'Депозит';

  @override
  String get convert => 'Конв';

  @override
  String get setting => 'Настройки';

  @override
  String get transfer => 'Перевод';

  @override
  String get top_up => 'Пополнение';

  @override
  String get bill => 'Счет';

  @override
  String get announcement => 'Объявление';

  @override
  String get viewAll => 'Посмотреть все';

  @override
  String get availableBalance => 'Доступный баланс';

  @override
  String get primaryButton => 'Основная кнопка';

  @override
  String get secondaryButton => 'Вторичная кнопка';

  @override
  String get primaryEnabled => 'Основная включена';

  @override
  String get secondaryEnabled => 'Вторичная включена';

  @override
  String get secondaryDisabled => 'Вторичная отключена';

  @override
  String get amountEnabled => 'Сумма включена';
}
