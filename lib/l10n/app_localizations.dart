import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:async';

class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  static final Map<String, Map<String, String>> _localizedValues = {
    'en': {
      'appTitle': 'George Amir Portfolio',
      'home': 'Home',
      'about': 'About',
      'skills': 'Skills',
      'experience': 'Experience',
      'projects': 'Projects',
      'contact': 'Contact',
      'education': 'Education',
      'profile': 'Profile',
      'languages': 'Languages',
      'downloadCV': 'Download CV',
      'switchToArabic': 'العربية',
      'switchToEnglish': 'English',
      'lightTheme': 'Light Theme',
      'darkTheme': 'Dark Theme',
      'profileDescription':
          'Highly versatile software engineer with a bachelor\'s degree in computer science. Expertise in Flutter development and UI/UX design.',
    },
    'ar': {
      'appTitle': 'بورتفوليو جورج أمير',
      'home': 'الرئيسية',
      'about': 'عنّي',
      'skills': 'المهارات',
      'experience': 'الخبرات',
      'projects': 'المشاريع',
      'contact': 'تواصل',
      'education': 'التعليم',
      'profile': 'الملف الشخصي',
      'languages': 'اللغات',
      'downloadCV': 'تحميل السيرة الذاتية',
      'switchToArabic': 'العربية',
      'switchToEnglish': 'English',
      'lightTheme': 'الوضع الفاتح',
      'darkTheme': 'الوضع الداكن',
      'profileDescription':
          'مهندس برمجيات متعدد المهارات حاصل على بكالوريوس في علوم الحاسب. خبرة في تطوير تطبيقات Flutter وتصميم واجهات المستخدم.',
    },
  };

  String translate(String key) {
    return _localizedValues[locale.languageCode]?[key] ?? key;
  }
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'ar'].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) async {
    return AppLocalizations(locale);
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}
