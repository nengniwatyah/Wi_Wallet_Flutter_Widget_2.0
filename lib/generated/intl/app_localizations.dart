import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_my.dart';
import 'app_localizations_ru.dart';
import 'app_localizations_th.dart';
import 'app_localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'intl/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('my'),
    Locale('ru'),
    Locale('th'),
    Locale('zh'),
  ];

  /// No description provided for @welcome_message.
  ///
  /// In en, this message translates to:
  /// **'Welcome'**
  String get welcome_message;

  /// No description provided for @greeting.
  ///
  /// In en, this message translates to:
  /// **'Hello'**
  String get greeting;

  /// No description provided for @farewell.
  ///
  /// In en, this message translates to:
  /// **'Goodbye'**
  String get farewell;

  /// No description provided for @app_name.
  ///
  /// In en, this message translates to:
  /// **'Test App'**
  String get app_name;

  /// No description provided for @light_theme.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get light_theme;

  /// No description provided for @dark_theme.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get dark_theme;

  /// No description provided for @navigatorHome.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get navigatorHome;

  /// No description provided for @navigatorHomeDeposit.
  ///
  /// In en, this message translates to:
  /// **'Deposit'**
  String get navigatorHomeDeposit;

  /// No description provided for @navigatorHomeConvert.
  ///
  /// In en, this message translates to:
  /// **'Convert'**
  String get navigatorHomeConvert;

  /// No description provided for @navigatorHomeSetting.
  ///
  /// In en, this message translates to:
  /// **'Setting'**
  String get navigatorHomeSetting;

  /// No description provided for @transfer.
  ///
  /// In en, this message translates to:
  /// **'Transfer'**
  String get transfer;

  /// No description provided for @top_up.
  ///
  /// In en, this message translates to:
  /// **'Top Up'**
  String get top_up;

  /// No description provided for @bill.
  ///
  /// In en, this message translates to:
  /// **'Bill'**
  String get bill;

  /// No description provided for @announcement.
  ///
  /// In en, this message translates to:
  /// **'Announcement'**
  String get announcement;

  /// No description provided for @viewAll.
  ///
  /// In en, this message translates to:
  /// **'View all'**
  String get viewAll;

  /// No description provided for @availableBalance.
  ///
  /// In en, this message translates to:
  /// **'Available Balance'**
  String get availableBalance;

  /// No description provided for @primaryButton.
  ///
  /// In en, this message translates to:
  /// **'Primary Button'**
  String get primaryButton;

  /// No description provided for @secondaryButton.
  ///
  /// In en, this message translates to:
  /// **'Secondary Button'**
  String get secondaryButton;

  /// No description provided for @primaryEnabled.
  ///
  /// In en, this message translates to:
  /// **'Primary Enabled'**
  String get primaryEnabled;

  /// No description provided for @secondaryEnabled.
  ///
  /// In en, this message translates to:
  /// **'Secondary Enabled'**
  String get secondaryEnabled;

  /// No description provided for @secondaryDisabled.
  ///
  /// In en, this message translates to:
  /// **'Secondary Disabled'**
  String get secondaryDisabled;

  /// No description provided for @amountEnabled.
  ///
  /// In en, this message translates to:
  /// **'Amount Enabled'**
  String get amountEnabled;

  /// No description provided for @cardReviewPreviewTitle.
  ///
  /// In en, this message translates to:
  /// **'Card Review Transaction'**
  String get cardReviewPreviewTitle;

  /// No description provided for @cardReviewTotalLabel.
  ///
  /// In en, this message translates to:
  /// **'Total'**
  String get cardReviewTotalLabel;

  /// No description provided for @cardReviewTotalAmountMock.
  ///
  /// In en, this message translates to:
  /// **'5,000.00'**
  String get cardReviewTotalAmountMock;

  /// No description provided for @cardReviewCurrencyMock.
  ///
  /// In en, this message translates to:
  /// **'THB'**
  String get cardReviewCurrencyMock;

  /// No description provided for @cardReviewFeeLabel.
  ///
  /// In en, this message translates to:
  /// **'Fee'**
  String get cardReviewFeeLabel;

  /// No description provided for @cardReviewFeeAmountMock.
  ///
  /// In en, this message translates to:
  /// **'0.00'**
  String get cardReviewFeeAmountMock;

  /// No description provided for @cardReviewFromLabel.
  ///
  /// In en, this message translates to:
  /// **'From'**
  String get cardReviewFromLabel;

  /// No description provided for @cardReviewFromValueMock.
  ///
  /// In en, this message translates to:
  /// **'Your Wi Wallet'**
  String get cardReviewFromValueMock;

  /// No description provided for @cardReviewMobileLabel.
  ///
  /// In en, this message translates to:
  /// **'Mobile Number'**
  String get cardReviewMobileLabel;

  /// No description provided for @cardReviewMobileValueMock.
  ///
  /// In en, this message translates to:
  /// **'081-141-1234'**
  String get cardReviewMobileValueMock;

  /// No description provided for @cardReviewToLabel.
  ///
  /// In en, this message translates to:
  /// **'To'**
  String get cardReviewToLabel;

  /// No description provided for @cardReviewToValueMock.
  ///
  /// In en, this message translates to:
  /// **'Siam Commercial Bank'**
  String get cardReviewToValueMock;

  /// No description provided for @cardReviewAccountNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Account Name'**
  String get cardReviewAccountNameLabel;

  /// No description provided for @cardReviewAccountNameValueMock.
  ///
  /// In en, this message translates to:
  /// **'Victor Von Doom'**
  String get cardReviewAccountNameValueMock;

  /// No description provided for @cardReviewAccountNumberLabel.
  ///
  /// In en, this message translates to:
  /// **'Account Number'**
  String get cardReviewAccountNumberLabel;

  /// No description provided for @cardReviewAccountNumberValueMock.
  ///
  /// In en, this message translates to:
  /// **'1234567890'**
  String get cardReviewAccountNumberValueMock;

  /// No description provided for @mobileNumberPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Mobile Number'**
  String get mobileNumberPlaceholder;

  /// No description provided for @noResultsFound.
  ///
  /// In en, this message translates to:
  /// **'No results found'**
  String get noResultsFound;

  /// No description provided for @pleaseTryAgain.
  ///
  /// In en, this message translates to:
  /// **'Please try again'**
  String get pleaseTryAgain;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'my', 'ru', 'th', 'zh'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'my':
      return AppLocalizationsMy();
    case 'ru':
      return AppLocalizationsRu();
    case 'th':
      return AppLocalizationsTh();
    case 'zh':
      return AppLocalizationsZh();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
