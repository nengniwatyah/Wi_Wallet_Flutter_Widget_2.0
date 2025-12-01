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

  /// Greeting headline on the home screen
  ///
  /// In en, this message translates to:
  /// **'Welcome'**
  String get welcome_message;

  /// Short greeting text
  ///
  /// In en, this message translates to:
  /// **'Hello'**
  String get greeting;

  /// Farewell text
  ///
  /// In en, this message translates to:
  /// **'Goodbye'**
  String get farewell;

  /// Application name shown in titles
  ///
  /// In en, this message translates to:
  /// **'Test App'**
  String get app_name;

  /// Label for light theme option
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get light_theme;

  /// Label for dark theme option
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get dark_theme;

  /// Navigation label for Home tab
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get navigatorHome;

  /// Navigation label for Deposit tab
  ///
  /// In en, this message translates to:
  /// **'Deposit'**
  String get navigatorHomeDeposit;

  /// Navigation label for Convert tab
  ///
  /// In en, this message translates to:
  /// **'Convert'**
  String get navigatorHomeConvert;

  /// Navigation label for Setting tab
  ///
  /// In en, this message translates to:
  /// **'Setting'**
  String get navigatorHomeSetting;

  /// Action label for transferring funds
  ///
  /// In en, this message translates to:
  /// **'Transfer'**
  String get transfer;

  /// Action label for topping up balance
  ///
  /// In en, this message translates to:
  /// **'Top Up'**
  String get top_up;

  /// Action label for paying bills
  ///
  /// In en, this message translates to:
  /// **'Bill'**
  String get bill;

  /// Section title for announcements
  ///
  /// In en, this message translates to:
  /// **'Announcement'**
  String get announcement;

  /// Button text to view all items
  ///
  /// In en, this message translates to:
  /// **'View all'**
  String get viewAll;

  /// Label for available balance section
  ///
  /// In en, this message translates to:
  /// **'Available Balance'**
  String get availableBalance;

  /// Label for available balance section
  ///
  /// In en, this message translates to:
  /// **'Available Balance'**
  String get labelHomeTotalBalance;

  /// Label for total balance section
  ///
  /// In en, this message translates to:
  /// **'Available Balance'**
  String get homeDrawerDetailTotalBalance;

  /// Label for primary button examples
  ///
  /// In en, this message translates to:
  /// **'Primary Button'**
  String get primaryButton;

  /// Label for secondary button examples
  ///
  /// In en, this message translates to:
  /// **'Secondary Button'**
  String get secondaryButton;

  /// Label for enabled primary button
  ///
  /// In en, this message translates to:
  /// **'Primary Enabled'**
  String get primaryEnabled;

  /// Label for enabled secondary button
  ///
  /// In en, this message translates to:
  /// **'Secondary Enabled'**
  String get secondaryEnabled;

  /// Label for disabled secondary button
  ///
  /// In en, this message translates to:
  /// **'Secondary Disabled'**
  String get secondaryDisabled;

  /// Label for amount entry enabled state
  ///
  /// In en, this message translates to:
  /// **'Amount Enabled'**
  String get amountEnabled;

  /// Title for card review transaction preview
  ///
  /// In en, this message translates to:
  /// **'Card Review Transaction'**
  String get cardReviewPreviewTitle;

  /// Label for total amount
  ///
  /// In en, this message translates to:
  /// **'Total'**
  String get cardReviewTotalLabel;

  /// Mock total amount value
  ///
  /// In en, this message translates to:
  /// **'5,000.00'**
  String get cardReviewTotalAmountMock;

  /// Mock currency code
  ///
  /// In en, this message translates to:
  /// **'THB'**
  String get cardReviewCurrencyMock;

  /// Label for fee amount
  ///
  /// In en, this message translates to:
  /// **'Fee'**
  String get cardReviewFeeLabel;

  /// Mock fee amount value
  ///
  /// In en, this message translates to:
  /// **'0.00'**
  String get cardReviewFeeAmountMock;

  /// Label for source account
  ///
  /// In en, this message translates to:
  /// **'From'**
  String get cardReviewFromLabel;

  /// Mock source account value
  ///
  /// In en, this message translates to:
  /// **'Your Wi Wallet'**
  String get cardReviewFromValueMock;

  /// Label for mobile number
  ///
  /// In en, this message translates to:
  /// **'Mobile Number'**
  String get cardReviewMobileLabel;

  /// Mock mobile number value
  ///
  /// In en, this message translates to:
  /// **'081-141-1234'**
  String get cardReviewMobileValueMock;

  /// Label for destination account
  ///
  /// In en, this message translates to:
  /// **'To'**
  String get cardReviewToLabel;

  /// Mock destination account value
  ///
  /// In en, this message translates to:
  /// **'Siam Commercial Bank'**
  String get cardReviewToValueMock;

  /// Label for account name
  ///
  /// In en, this message translates to:
  /// **'Account Name'**
  String get cardReviewAccountNameLabel;

  /// Mock account name value
  ///
  /// In en, this message translates to:
  /// **'Victor Von Doom'**
  String get cardReviewAccountNameValueMock;

  /// Label for account number
  ///
  /// In en, this message translates to:
  /// **'Account Number'**
  String get cardReviewAccountNumberLabel;

  /// Mock account number value
  ///
  /// In en, this message translates to:
  /// **'1234567890'**
  String get cardReviewAccountNumberValueMock;

  /// Placeholder for mobile number input
  ///
  /// In en, this message translates to:
  /// **'Mobile Number'**
  String get mobileNumberPlaceholder;

  /// Empty state text when no results are found
  ///
  /// In en, this message translates to:
  /// **'No results found'**
  String get noResultsFound;

  /// Prompt to retry after a failure
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
