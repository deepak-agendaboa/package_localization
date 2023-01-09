import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:package_localization/l10n/messages_all.dart';

/// A class for localizations/internationalization of the app.
class PackageLocalizations {
  PackageLocalizations(this.localeName);

  static Future<PackageLocalizations> load(Locale locale) {
    final String name = locale.countryCode?.isEmpty ?? true
        ? locale.languageCode
        : locale.toString();
    final String localeName = Intl.canonicalizedLocale(name);

    // DateFormat class uses the locale from the defaultLocale of system.
    // ISSUE: The date was formatting to default i.e en_US
    // We tried to use the initializeDateFormatting method but faced error.
    // See: https://github.com/flutter/flutter/issues/70040 and this https://github.com/dart-lang/intl/issues/292
    // SOLUTION: we now set the defaultLocale with the localeName provided by this load method
    Intl.defaultLocale = localeName;

    // ISSUE:
    // The issue we faced was when we were changing the string of an already
    // localized string and performed hot reload/restart we were not seeing the
    // updated string. eg: for the "login" string which was already translated
    // for different locales and then we updated to "log in" and perform hot
    // reload/restart the text was still displaying as "login" and not "log in".

    // REASON:
    // This was happening because the app_localizations load method calls the
    // initializeMessages method that returns the translated strings from the
    // files "messages_[locale].dart" present in L10n. The Intl.message() string
    // is not returned and instead we get the translated messages from the
    // "messages_[locale].dart" files.

    // SOLUTION:
    // When we are in debug mode we will avoid returning the translated strings.
    // Also we check for only the english (en_US) strings. This allows us then
    // to see the updated localization strings after a hot reload/restart.
    //
    // If we change the language to say pt,pt_PT or en_UK then we can return
    // the translated strings.
    if (kDebugMode && localeName == 'en') {
      return Future.value(PackageLocalizations(localeName));
    }

    return initializeMessages(localeName).then((_) {
      return PackageLocalizations(localeName);
    });
  }

  static PackageLocalizations of(BuildContext context) {
    return Localizations.of<PackageLocalizations>(
        context, PackageLocalizations)!;
  }

  static const LocalizationsDelegate<PackageLocalizations> delegate =
      _PackageLocalizationsDelegate();

  final String localeName;

  // Common strings
  String get email {
    return Intl.message(
      'E-mail',
      name: 'email',
      desc: 'email label',
      locale: localeName,
    );
  }

  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: 'password label',
      locale: localeName,
    );
  }

  String get cancel {
    return Intl.message(
      'cancel',
      name: 'cancel',
      desc: 'cancel popup text',
      locale: localeName,
    );
  }

  String get ok {
    return Intl.message(
      'ok',
      name: 'ok',
      desc: 'ok popup text',
      locale: localeName,
    );
  }

  String get clear {
    return Intl.message(
      'clear',
      name: 'clear',
      desc: 'clear popup text',
      locale: localeName,
    );
  }
}

class _PackageLocalizationsDelegate
    extends LocalizationsDelegate<PackageLocalizations> {
  const _PackageLocalizationsDelegate();

  // supported locales by the app
  static final locales = {
    const Locale('en', ''): 'English',
    const Locale('pt', ''): 'Portuguese (BR)',
    const Locale('pt', 'PT'): 'Portuguese (PT)'
  };

  @override
  bool isSupported(Locale locale) => isLocaleSupported(locale);

  @override
  Future<PackageLocalizations> load(Locale locale) =>
      PackageLocalizations.load(locale);

  @override
  bool shouldReload(_PackageLocalizationsDelegate old) => false;

  /// returns if locale is supported or not
  bool isLocaleSupported(Locale locale) {
    bool isSupported = false;

    for (var l in locales.keys) {
      if (l.languageCode == locale.languageCode) {
        isSupported = true;
      }
    }

    return isSupported;
  }
}
