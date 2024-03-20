import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _kLocaleStorageKey = '__locale_key__';

class FFLocalizations {
  FFLocalizations(this.locale);

  final Locale locale;

  static FFLocalizations of(BuildContext context) =>
      Localizations.of<FFLocalizations>(context, FFLocalizations)!;

  static List<String> languages() => ['en', 'hi', 'ta', 'ur'];

  static late SharedPreferences _prefs;
  static Future initialize() async =>
      _prefs = await SharedPreferences.getInstance();
  static Future storeLocale(String locale) =>
      _prefs.setString(_kLocaleStorageKey, locale);
  static Locale? getStoredLocale() {
    final locale = _prefs.getString(_kLocaleStorageKey);
    return locale != null && locale.isNotEmpty ? createLocale(locale) : null;
  }

  String get languageCode => locale.toString();
  String? get languageShortCode =>
      _languagesWithShortCode.contains(locale.toString())
          ? '${locale.toString()}_short'
          : null;
  int get languageIndex => languages().contains(languageCode)
      ? languages().indexOf(languageCode)
      : 0;

  String getText(String key) =>
      (kTranslationsMap[key] ?? {})[locale.toString()] ?? '';

  String getVariableText({
    String? enText = '',
    String? hiText = '',
    String? taText = '',
    String? urText = '',
  }) =>
      [enText, hiText, taText, urText][languageIndex] ?? '';

  static const Set<String> _languagesWithShortCode = {
    'ar',
    'az',
    'ca',
    'cs',
    'da',
    'de',
    'dv',
    'en',
    'es',
    'et',
    'fi',
    'fr',
    'gr',
    'he',
    'hi',
    'hu',
    'it',
    'km',
    'ku',
    'mn',
    'ms',
    'no',
    'pt',
    'ro',
    'ru',
    'rw',
    'sv',
    'th',
    'uk',
    'vi',
  };
}

class FFLocalizationsDelegate extends LocalizationsDelegate<FFLocalizations> {
  const FFLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    final language = locale.toString();
    return FFLocalizations.languages().contains(
      language.endsWith('_')
          ? language.substring(0, language.length - 1)
          : language,
    );
  }

  @override
  Future<FFLocalizations> load(Locale locale) =>
      SynchronousFuture<FFLocalizations>(FFLocalizations(locale));

  @override
  bool shouldReload(FFLocalizationsDelegate old) => false;
}

Locale createLocale(String language) => language.contains('_')
    ? Locale.fromSubtags(
        languageCode: language.split('_').first,
        scriptCode: language.split('_').last,
      )
    : Locale(language);

final kTranslationsMap = <Map<String, Map<String, String>>>[
  // LoginPage
  {
    'e4y46hdi': {
      'en': 'Sign In',
      'hi': '',
      'ta': '',
      'ur': '',
    },
    '74ewmz87': {
      'en': 'Email Address',
      'hi': '',
      'ta': '',
      'ur': '',
    },
    'jhz4vq85': {
      'en': 'Enter your email...',
      'hi': '',
      'ta': '',
      'ur': '',
    },
    'tt2zzhio': {
      'en': 'Password',
      'hi': '',
      'ta': '',
      'ur': '',
    },
    'c6e1ose8': {
      'en': 'Enter your password...',
      'hi': '',
      'ta': '',
      'ur': '',
    },
    'uxsas9ba': {
      'en': 'Forgot Password?',
      'hi': '',
      'ta': '',
      'ur': '',
    },
    '1nqinczd': {
      'en': 'Sign In',
      'hi': '',
      'ta': '',
      'ur': '',
    },
    '5ufk9are': {
      'en': 'Login with google:',
      'hi': '',
      'ta': '',
      'ur': '',
    },
    'ad2biyfw': {
      'en': 'Sign Up',
      'hi': '',
      'ta': '',
      'ur': '',
    },
    'x8n9oakh': {
      'en': 'Email Address',
      'hi': '',
      'ta': '',
      'ur': '',
    },
    'ndbp7iw4': {
      'en': 'Enter your email...',
      'hi': '',
      'ta': '',
      'ur': '',
    },
    '8atdoddc': {
      'en': 'Username',
      'hi': '',
      'ta': '',
      'ur': '',
    },
    'weju04x7': {
      'en': 'Enter your Username...',
      'hi': '',
      'ta': '',
      'ur': '',
    },
    'j7qaytho': {
      'en': 'Field is required',
      'hi': '',
      'ta': '',
      'ur': '',
    },
    'j0jqe3ow': {
      'en': 'Error: Password must be at least 5 characters',
      'hi': '',
      'ta': '',
      'ur': '',
    },
    'k0phfe5t': {
      'en': 'Please choose an option from the dropdown',
      'hi': '',
      'ta': '',
      'ur': '',
    },
    'm6mw3kmi': {
      'en': 'Password',
      'hi': '',
      'ta': '',
      'ur': '',
    },
    'pnvy3zyj': {
      'en': 'Enter your password...',
      'hi': '',
      'ta': '',
      'ur': '',
    },
    'ho6xibl3': {
      'en': 'Error: Password must be at least 8 characters',
      'hi': '',
      'ta': '',
      'ur': '',
    },
    'inxh8oxc': {
      'en': 'Password needs at least 1 number and uppercase letter',
      'hi': '',
      'ta': '',
      'ur': '',
    },
    'qhzwc6ff': {
      'en': 'Please choose an option from the dropdown',
      'hi': '',
      'ta': '',
      'ur': '',
    },
    '42tizffb': {
      'en': 'Confirm Password',
      'hi': '',
      'ta': '',
      'ur': '',
    },
    'a29igl5p': {
      'en': 'Re-enter your password...',
      'hi': '',
      'ta': '',
      'ur': '',
    },
    'zyl2k2ck': {
      'en': 'Please choose an option from the dropdown',
      'hi': '',
      'ta': '',
      'ur': '',
    },
    'jnnbgrhv': {
      'en': 'Create Account',
      'hi': '',
      'ta': '',
      'ur': '',
    },
    't8to1ov5': {
      'en': 'Sign up with your Google account:',
      'hi': '',
      'ta': '',
      'ur': '',
    },
    'bsr34egz': {
      'en': 'Home',
      'hi': '',
      'ta': '',
      'ur': '',
    },
  },
  // ProfilePage
  {
    'cqmqqa8t': {
      'en': 'My Account',
      'hi': '',
      'ta': '',
      'ur': '',
    },
    'oq9f1id0': {
      'en': 'Logout',
      'hi': '',
      'ta': '',
      'ur': '',
    },
    'embyo4wh': {
      'en': '',
      'hi': '',
      'ta': '',
      'ur': '',
    },
  },
  // CalendarPage
  {
    'dxksjiui': {
      'en': 'My Calendar',
      'hi': '',
      'ta': '',
      'ur': '',
    },
    'aoy2coot': {
      'en': '',
      'hi': '',
      'ta': '',
      'ur': '',
    },
  },
  // HomePage
  {
    '05ejm1ds': {
      'en': 'My Projects',
      'hi': '',
      'ta': '',
      'ur': '',
    },
    'r6ph4rke': {
      'en': '1',
      'hi': '',
      'ta': '',
      'ur': '',
    },
    'da4eiq11': {
      'en': 'Project Name',
      'hi': '',
      'ta': '',
      'ur': '',
    },
    'uyrtxe9w': {
      'en': 'Due:',
      'hi': '',
      'ta': '',
      'ur': '',
    },
    '50x8isv9': {
      'en': '12/30/2024',
      'hi': '',
      'ta': '',
      'ur': '',
    },
    'msrxr7ql': {
      'en': 'Owner:',
      'hi': '',
      'ta': '',
      'ur': '',
    },
    'fsymek5v': {
      'en': 'Group Members: ',
      'hi': '',
      'ta': '',
      'ur': '',
    },
    'h45glb7m': {
      'en': '50%',
      'hi': '',
      'ta': '',
      'ur': '',
    },
    '5kgeolel': {
      'en': '',
      'hi': '',
      'ta': '',
      'ur': '',
    },
  },
  // Settings
  {
    '18mfdv1n': {
      'en': 'Settings',
      'hi': '',
      'ta': '',
      'ur': '',
    },
    'tgrgyzd3': {
      'en': 'Change Password',
      'hi': '',
      'ta': '',
      'ur': '',
    },
    'b90i71h0': {
      'en': 'Change Profile Photo',
      'hi': '',
      'ta': '',
      'ur': '',
    },
    '73t1epel': {
      'en': 'Home',
      'hi': '',
      'ta': '',
      'ur': '',
    },
  },
  // GroupChatPage
  {
    'i2yspim2': {
      'en': 'Group Chat',
      'hi': '',
      'ta': '',
      'ur': '',
    },
    'qwh9ktio': {
      'en': 'Home',
      'hi': '',
      'ta': '',
      'ur': '',
    },
  },
  // ProjectPage
  {
    's2l5yd7h': {
      'en': 'Project Name',
      'hi': '',
      'ta': '',
      'ur': '',
    },
    'hos8rg9o': {
      'en': '1',
      'hi': '',
      'ta': '',
      'ur': '',
    },
    'r0y5lwb6': {
      'en': 'Members: ',
      'hi': '',
      'ta': '',
      'ur': '',
    },
    '6ssxwsdu': {
      'en': 'Task Name',
      'hi': '',
      'ta': '',
      'ur': '',
    },
    'y58t59f4': {
      'en': 'Due:',
      'hi': '',
      'ta': '',
      'ur': '',
    },
    'apd6y9kd': {
      'en': '12/30/2024',
      'hi': '',
      'ta': '',
      'ur': '',
    },
    'xlgpir3u': {
      'en': 'Assigned: ',
      'hi': '',
      'ta': '',
      'ur': '',
    },
    'opmi8fkl': {
      'en': '4/5',
      'hi': '',
      'ta': '',
      'ur': '',
    },
    'zfzgua40': {
      'en': '50%',
      'hi': '',
      'ta': '',
      'ur': '',
    },
    'h0riw7oh': {
      'en': 'Subtask Name',
      'hi': '',
      'ta': '',
      'ur': '',
    },
    '611wb6zh': {
      'en': 'Due:',
      'hi': '',
      'ta': '',
      'ur': '',
    },
    '9s13yr85': {
      'en': '12/30/2024',
      'hi': '',
      'ta': '',
      'ur': '',
    },
    'zemnchb3': {
      'en': 'Assigned: ',
      'hi': '',
      'ta': '',
      'ur': '',
    },
    'iz2u2gk4': {
      'en': '5/5',
      'hi': '',
      'ta': '',
      'ur': '',
    },
    'qhisv69k': {
      'en': '50%',
      'hi': '',
      'ta': '',
      'ur': '',
    },
    'pkboi0a7': {
      'en': 'Home',
      'hi': '',
      'ta': '',
      'ur': '',
    },
  },
  // CreateProjectPage
  {
    'mj6ztqcc': {
      'en': 'Create Project',
      'hi': '',
      'ta': '',
      'ur': '',
    },
    'q5re9w8p': {
      'en': 'Project Name',
      'hi': '',
      'ta': '',
      'ur': '',
    },
    'hd0epbsa': {
      'en': '',
      'hi': '',
      'ta': '',
      'ur': '',
    },
    'v0qyv2ak': {
      'en': 'Enter project name...',
      'hi': '',
      'ta': '',
      'ur': '',
    },
    'jvn4olit': {
      'en': 'Project Description',
      'hi': '',
      'ta': '',
      'ur': '',
    },
    'a5ehd179': {
      'en': '',
      'hi': '',
      'ta': '',
      'ur': '',
    },
    'k7o9qywf': {
      'en': 'Enter project description...',
      'hi': '',
      'ta': '',
      'ur': '',
    },
    'd102u3jx': {
      'en': 'Due Date',
      'hi': '',
      'ta': '',
      'ur': '',
    },
    'rtrwsvel': {
      'en': 'Create Project',
      'hi': '',
      'ta': '',
      'ur': '',
    },
    'aza0er4i': {
      'en': 'Home',
      'hi': '',
      'ta': '',
      'ur': '',
    },
  },
  // InvitationsPage
  {
    '4sz614g6': {
      'en': 'Invitations',
      'hi': '',
      'ta': '',
      'ur': '',
    },
    'vxinv1ta': {
      'en': 'Username',
      'hi': '',
      'ta': '',
      'ur': '',
    },
    'jzjxgbcf': {
      'en': 'Project: ',
      'hi': '',
      'ta': '',
      'ur': '',
    },
    'cak4nrx9': {
      'en': 'Project Name',
      'hi': '',
      'ta': '',
      'ur': '',
    },
    'r1lh1cce': {
      'en': 'Accept',
      'hi': '',
      'ta': '',
      'ur': '',
    },
    '28ab5ai4': {
      'en': 'Decline',
      'hi': '',
      'ta': '',
      'ur': '',
    },
    'gie8070c': {
      'en': 'Home',
      'hi': '',
      'ta': '',
      'ur': '',
    },
  },
  // TaskCreationPage
  {
    'zceeaj00': {
      'en': 'Create Task',
      'hi': '',
      'ta': '',
      'ur': '',
    },
    'yslwomjz': {
      'en': 'Task Name',
      'hi': '',
      'ta': '',
      'ur': '',
    },
    'v2tad378': {
      'en': '',
      'hi': '',
      'ta': '',
      'ur': '',
    },
    'tjnwuzj6': {
      'en': 'Enter task name...',
      'hi': '',
      'ta': '',
      'ur': '',
    },
    '7ntnpm78': {
      'en': 'Task Description',
      'hi': '',
      'ta': '',
      'ur': '',
    },
    's1ee9evl': {
      'en': '',
      'hi': '',
      'ta': '',
      'ur': '',
    },
    'jz3m0ogv': {
      'en': 'Enter task description...',
      'hi': '',
      'ta': '',
      'ur': '',
    },
    'ap83tmea': {
      'en': 'Due Date',
      'hi': '',
      'ta': '',
      'ur': '',
    },
    '4jw39ag9': {
      'en': 'Difficulty: ',
      'hi': '',
      'ta': '',
      'ur': '',
    },
    'g9coxb0l': {
      'en': 'Assign: ',
      'hi': '',
      'ta': '',
      'ur': '',
    },
    's6zbmlri': {
      'en': '3',
      'hi': '',
      'ta': '',
      'ur': '',
    },
    'j3ii2nur': {
      'en': '4',
      'hi': '',
      'ta': '',
      'ur': '',
    },
    'vmk9oplj': {
      'en': '5',
      'hi': '',
      'ta': '',
      'ur': '',
    },
    '3zfhzx8y': {
      'en': '6',
      'hi': '',
      'ta': '',
      'ur': '',
    },
    'gyvywh4h': {
      'en': 'Please select...',
      'hi': '',
      'ta': '',
      'ur': '',
    },
    'r0ibd4mv': {
      'en': 'Search for an item...',
      'hi': '',
      'ta': '',
      'ur': '',
    },
    'plcf02yu': {
      'en': 'Create Task',
      'hi': '',
      'ta': '',
      'ur': '',
    },
    'a4kfe3y1': {
      'en': 'Home',
      'hi': '',
      'ta': '',
      'ur': '',
    },
  },
  // EdtiProjectPage
  {
    'lvji7nfx': {
      'en': 'Edit Project',
      'hi': '',
      'ta': '',
      'ur': '',
    },
    'c7a7l00k': {
      'en': 'Project Name',
      'hi': '',
      'ta': '',
      'ur': '',
    },
    'zvkgh9dm': {
      'en': '',
      'hi': '',
      'ta': '',
      'ur': '',
    },
    '0rzkyar6': {
      'en': 'Enter project name...',
      'hi': '',
      'ta': '',
      'ur': '',
    },
    'bkz5cnkc': {
      'en': 'Project Description',
      'hi': '',
      'ta': '',
      'ur': '',
    },
    '6oe9gyfk': {
      'en': '',
      'hi': '',
      'ta': '',
      'ur': '',
    },
    'hpxgbpn2': {
      'en': 'Enter project description...',
      'hi': '',
      'ta': '',
      'ur': '',
    },
    'ntwq82l4': {
      'en': 'Due Date',
      'hi': '',
      'ta': '',
      'ur': '',
    },
    'sd8hwamc': {
      'en': 'Edit Project',
      'hi': '',
      'ta': '',
      'ur': '',
    },
    'rdru07l9': {
      'en': 'Home',
      'hi': '',
      'ta': '',
      'ur': '',
    },
  },
  // EditTaskPage
  {
    'hqfyykk1': {
      'en': 'Edit Task',
      'hi': '',
      'ta': '',
      'ur': '',
    },
    '855fnml8': {
      'en': 'Task Name',
      'hi': '',
      'ta': '',
      'ur': '',
    },
    'ollnvd7i': {
      'en': '',
      'hi': '',
      'ta': '',
      'ur': '',
    },
    '4hkp363v': {
      'en': 'Enter task name...',
      'hi': '',
      'ta': '',
      'ur': '',
    },
    'fbv2isin': {
      'en': 'Task Description',
      'hi': '',
      'ta': '',
      'ur': '',
    },
    '7rirszll': {
      'en': '',
      'hi': '',
      'ta': '',
      'ur': '',
    },
    'u24vfkf7': {
      'en': 'Enter task description...',
      'hi': '',
      'ta': '',
      'ur': '',
    },
    'z6vwpeg6': {
      'en': 'Due Date',
      'hi': '',
      'ta': '',
      'ur': '',
    },
    'jvkwgxp7': {
      'en': 'Difficulty: ',
      'hi': '',
      'ta': '',
      'ur': '',
    },
    'ggov34qu': {
      'en': 'Assign: ',
      'hi': '',
      'ta': '',
      'ur': '',
    },
    'mlxsxz9s': {
      'en': '3',
      'hi': '',
      'ta': '',
      'ur': '',
    },
    'nge5va5h': {
      'en': '4',
      'hi': '',
      'ta': '',
      'ur': '',
    },
    'cks5f0f7': {
      'en': '5',
      'hi': '',
      'ta': '',
      'ur': '',
    },
    '4dylwsq9': {
      'en': '6',
      'hi': '',
      'ta': '',
      'ur': '',
    },
    'l1zshjhu': {
      'en': 'Please select...',
      'hi': '',
      'ta': '',
      'ur': '',
    },
    '49dsyvnb': {
      'en': 'Search for an item...',
      'hi': '',
      'ta': '',
      'ur': '',
    },
    'u3accrhc': {
      'en': 'Edit Task',
      'hi': '',
      'ta': '',
      'ur': '',
    },
    'd9ok70x0': {
      'en': 'Home',
      'hi': '',
      'ta': '',
      'ur': '',
    },
  },
  // EditSubtaskPage
  {
    'ij81r6kv': {
      'en': 'Edit Subtask',
      'hi': '',
      'ta': '',
      'ur': '',
    },
    '85zns82k': {
      'en': 'Subtask Name',
      'hi': '',
      'ta': '',
      'ur': '',
    },
    'lqm885kf': {
      'en': '',
      'hi': '',
      'ta': '',
      'ur': '',
    },
    'gev50m9s': {
      'en': 'Enter subtask name...',
      'hi': '',
      'ta': '',
      'ur': '',
    },
    'ssi8go7o': {
      'en': 'Subtask Description',
      'hi': '',
      'ta': '',
      'ur': '',
    },
    'atioz2mc': {
      'en': '',
      'hi': '',
      'ta': '',
      'ur': '',
    },
    'so0slm2d': {
      'en': 'Enter subtask description...',
      'hi': '',
      'ta': '',
      'ur': '',
    },
    'zpnsqh3k': {
      'en': 'Due Date',
      'hi': '',
      'ta': '',
      'ur': '',
    },
    '5vuxcz6s': {
      'en': 'Assign: ',
      'hi': '',
      'ta': '',
      'ur': '',
    },
    '84nddnrp': {
      'en': '3',
      'hi': '',
      'ta': '',
      'ur': '',
    },
    '8epd72zv': {
      'en': '4',
      'hi': '',
      'ta': '',
      'ur': '',
    },
    '6jnson3u': {
      'en': '5',
      'hi': '',
      'ta': '',
      'ur': '',
    },
    'oo8za3tg': {
      'en': '6',
      'hi': '',
      'ta': '',
      'ur': '',
    },
    '8g5l1hm9': {
      'en': 'Please select...',
      'hi': '',
      'ta': '',
      'ur': '',
    },
    'pjrwlagm': {
      'en': 'Search for an item...',
      'hi': '',
      'ta': '',
      'ur': '',
    },
    'r4rscmbk': {
      'en': 'Difficulty: ',
      'hi': '',
      'ta': '',
      'ur': '',
    },
    '27hchqvw': {
      'en': 'Progress: ',
      'hi': '',
      'ta': '',
      'ur': '',
    },
    'qdrb7g0u': {
      'en': '50%',
      'hi': '',
      'ta': '',
      'ur': '',
    },
    '4te14s09': {
      'en': 'Edit Subtask',
      'hi': '',
      'ta': '',
      'ur': '',
    },
    '1fdu342m': {
      'en': 'Home',
      'hi': '',
      'ta': '',
      'ur': '',
    },
  },
  // SubtaskCreationPage
  {
    'ts80gdlj': {
      'en': 'Create Subtask',
      'hi': '',
      'ta': '',
      'ur': '',
    },
    '5ylgtkyy': {
      'en': 'Subtask Name',
      'hi': '',
      'ta': '',
      'ur': '',
    },
    '6gmjs4v1': {
      'en': '',
      'hi': '',
      'ta': '',
      'ur': '',
    },
    'o5xb10iy': {
      'en': 'Enter subtask name...',
      'hi': '',
      'ta': '',
      'ur': '',
    },
    'ij3v49wm': {
      'en': 'Subtask Description',
      'hi': '',
      'ta': '',
      'ur': '',
    },
    'o3bu5yg5': {
      'en': '',
      'hi': '',
      'ta': '',
      'ur': '',
    },
    'nrohy2yv': {
      'en': 'Enter subtask description...',
      'hi': '',
      'ta': '',
      'ur': '',
    },
    'l98sv6cp': {
      'en': 'Due Date',
      'hi': '',
      'ta': '',
      'ur': '',
    },
    '45l0krru': {
      'en': 'Difficulty: ',
      'hi': '',
      'ta': '',
      'ur': '',
    },
    '78bkkcx6': {
      'en': 'Assign: ',
      'hi': '',
      'ta': '',
      'ur': '',
    },
    'b51pongy': {
      'en': '3',
      'hi': '',
      'ta': '',
      'ur': '',
    },
    'jg4k9rt2': {
      'en': '4',
      'hi': '',
      'ta': '',
      'ur': '',
    },
    '5pb1mnqa': {
      'en': '5',
      'hi': '',
      'ta': '',
      'ur': '',
    },
    '0df262s3': {
      'en': '6',
      'hi': '',
      'ta': '',
      'ur': '',
    },
    '6ft73sr9': {
      'en': 'Please select...',
      'hi': '',
      'ta': '',
      'ur': '',
    },
    'o14g7yhr': {
      'en': 'Search for an item...',
      'hi': '',
      'ta': '',
      'ur': '',
    },
    's4r75cqr': {
      'en': 'Create Subtask',
      'hi': '',
      'ta': '',
      'ur': '',
    },
    'vud4cvtn': {
      'en': 'Home',
      'hi': '',
      'ta': '',
      'ur': '',
    },
  },
  // RatingPage
  {
    '37qjb5e9': {
      'en': 'Rate Members',
      'hi': '',
      'ta': '',
      'ur': '',
    },
    '676mvfty': {
      'en':
          'Please rate your fellow group memebrs based on their perfomance in the project. Try to be as honest as possible.',
      'hi': '',
      'ta': '',
      'ur': '',
    },
    '8wpejko5': {
      'en': 'Username',
      'hi': '',
      'ta': '',
      'ur': '',
    },
    '8vssdylo': {
      'en': 'Rating: ',
      'hi': '',
      'ta': '',
      'ur': '',
    },
    'if5jqr4o': {
      'en': 'Username',
      'hi': '',
      'ta': '',
      'ur': '',
    },
    'h2j71jhl': {
      'en': 'Rating: ',
      'hi': '',
      'ta': '',
      'ur': '',
    },
    'lykhybrz': {
      'en': 'Confirm',
      'hi': '',
      'ta': '',
      'ur': '',
    },
    'b40pty0b': {
      'en': 'Home',
      'hi': '',
      'ta': '',
      'ur': '',
    },
  },
  // PasswordResetPage
  {
    'wd1i268l': {
      'en': 'Change Password',
      'hi': '',
      'ta': '',
      'ur': '',
    },
    '8sqt9vni': {
      'en': 'Reset ',
      'hi': '',
      'ta': '',
      'ur': '',
    },
    'rg6vkp0k': {
      'en': 'Enter Current Email ',
      'hi': '',
      'ta': '',
      'ur': '',
    },
    'ucq36msc': {
      'en': 'Home',
      'hi': '',
      'ta': '',
      'ur': '',
    },
  },
  // BrowsePage
  {
    '22oz6z76': {
      'en': 'Browse Members',
      'hi': '',
      'ta': '',
      'ur': '',
    },
    'jouk0pud': {
      'en': 'Search',
      'hi': '',
      'ta': '',
      'ur': '',
    },
    '7rbk6xqm': {
      'en': 'Username',
      'hi': '',
      'ta': '',
      'ur': '',
    },
    'vm1jncpr': {
      'en': 'Classes: ',
      'hi': '',
      'ta': '',
      'ur': '',
    },
    'o6xs9phq': {
      'en': 'Class Names',
      'hi': '',
      'ta': '',
      'ur': '',
    },
    'uqzih04t': {
      'en': 'Invite',
      'hi': '',
      'ta': '',
      'ur': '',
    },
    'vzyan3yw': {
      'en': 'Home',
      'hi': '',
      'ta': '',
      'ur': '',
    },
  },
  // ChangeProfilePhoto
  {
    'bkgucj98': {
      'en': 'Change \nProfile Photo',
      'hi': '',
      'ta': '',
      'ur': '',
    },
    'g6y2xxs6': {
      'en': 'Change Profile Photo',
      'hi': '',
      'ta': '',
      'ur': '',
    },
    'jxt3fjea': {
      'en': 'Home',
      'hi': '',
      'ta': '',
      'ur': '',
    },
  },
  // OptionsProject
  {
    'tymhcmg1': {
      'en': 'Project Options',
      'hi': '',
      'ta': '',
      'ur': '',
    },
    '4ijjngxt': {
      'en': 'Edit project information',
      'hi': '',
      'ta': '',
      'ur': '',
    },
    'u5m4q2s5': {
      'en': 'Delete project',
      'hi': '',
      'ta': '',
      'ur': '',
    },
  },
  // OptionsTask
  {
    '7op0tu0f': {
      'en': 'Task Options',
      'hi': '',
      'ta': '',
      'ur': '',
    },
    'xkbtgzak': {
      'en': 'Edit task information',
      'hi': '',
      'ta': '',
      'ur': '',
    },
    'h5svic5p': {
      'en': 'Delete task',
      'hi': '',
      'ta': '',
      'ur': '',
    },
  },
  // ProjectDescription
  {
    'dxl7j30a': {
      'en': 'Description:',
      'hi': '',
      'ta': '',
      'ur': '',
    },
    'ra7sb24o': {
      'en': 'Description...',
      'hi': '',
      'ta': '',
      'ur': '',
    },
  },
  // Task_SubtaskDescription
  {
    'ktpu0i5d': {
      'en': 'Description:',
      'hi': '',
      'ta': '',
      'ur': '',
    },
    'bojmxsff': {
      'en': 'Description...',
      'hi': '',
      'ta': '',
      'ur': '',
    },
  },
  // ShowcaseProfile
  {
    'i3iawjsr': {
      'en': 'Username',
      'hi': '',
      'ta': '',
      'ur': '',
    },
  },
  // AreYouSureProject
  {
    'nktukkcp': {
      'en': 'Are you sure you wish to delete this project?',
      'hi': '',
      'ta': '',
      'ur': '',
    },
    'aqswhyc8': {
      'en': 'Yes',
      'hi': '',
      'ta': '',
      'ur': '',
    },
    'wl40gcpc': {
      'en': 'No',
      'hi': '',
      'ta': '',
      'ur': '',
    },
  },
  // AreYouSureTask
  {
    'mphor1oe': {
      'en': 'Are you sure you wish to delete this task?',
      'hi': '',
      'ta': '',
      'ur': '',
    },
    'p79ycexh': {
      'en': 'Yes',
      'hi': '',
      'ta': '',
      'ur': '',
    },
    'ozo0ft3c': {
      'en': 'No',
      'hi': '',
      'ta': '',
      'ur': '',
    },
  },
  // AreYouSureSubtask
  {
    'itz2851z': {
      'en': 'Are you sure you wish to delete this subtask?',
      'hi': '',
      'ta': '',
      'ur': '',
    },
    'jaw66i4j': {
      'en': 'Yes',
      'hi': '',
      'ta': '',
      'ur': '',
    },
    'zriq2ufz': {
      'en': 'No',
      'hi': '',
      'ta': '',
      'ur': '',
    },
  },
  // OptionsSubtask
  {
    '44yc46am': {
      'en': 'Subtask Options',
      'hi': '',
      'ta': '',
      'ur': '',
    },
    'lr3vbmqn': {
      'en': 'Edit subtask information',
      'hi': '',
      'ta': '',
      'ur': '',
    },
    'rp02udxi': {
      'en': 'Delete subtask',
      'hi': '',
      'ta': '',
      'ur': '',
    },
  },
  // Miscellaneous
  {
    'tuf7ywhd': {
      'en': 'Label',
      'hi': 'लेबल',
      'ta': 'லேபிள்',
      'ur': 'لیبل',
    },
    'z2zi1qq5': {
      'en': 'Button',
      'hi': 'बटन',
      'ta': 'பொத்தானை',
      'ur': 'بٹن',
    },
    'qm71wpil': {
      'en': 'Button',
      'hi': 'बटन',
      'ta': 'பொத்தானை',
      'ur': 'بٹن',
    },
    'fi5o91qd': {
      'en': '',
      'hi': '',
      'ta': '',
      'ur': '',
    },
    'skzc79wn': {
      'en': '',
      'hi': '',
      'ta': '',
      'ur': '',
    },
    '0rnqst8h': {
      'en': '',
      'hi': '',
      'ta': '',
      'ur': '',
    },
    'nh43oztv': {
      'en': '',
      'hi': '',
      'ta': '',
      'ur': '',
    },
    'i4m03gv7': {
      'en': '',
      'hi': '',
      'ta': '',
      'ur': '',
    },
    '9h5b120r': {
      'en': '',
      'hi': '',
      'ta': '',
      'ur': '',
    },
    '2xxt8j1o': {
      'en': '',
      'hi': '',
      'ta': '',
      'ur': '',
    },
    't7udujpl': {
      'en': '',
      'hi': '',
      'ta': '',
      'ur': '',
    },
    'zbbv93d3': {
      'en': '',
      'hi': '',
      'ta': '',
      'ur': '',
    },
    '8tpeh8vp': {
      'en': '',
      'hi': '',
      'ta': '',
      'ur': '',
    },
    'ojtaf5os': {
      'en': '',
      'hi': '',
      'ta': '',
      'ur': '',
    },
    'zgfa37gt': {
      'en': '',
      'hi': '',
      'ta': '',
      'ur': '',
    },
    'mwcq8wyv': {
      'en': '',
      'hi': '',
      'ta': '',
      'ur': '',
    },
    'cql4rcil': {
      'en': '',
      'hi': '',
      'ta': '',
      'ur': '',
    },
    't9vh67yu': {
      'en': '',
      'hi': '',
      'ta': '',
      'ur': '',
    },
    'ac2c7a8c': {
      'en': '',
      'hi': '',
      'ta': '',
      'ur': '',
    },
    '43t0g3v5': {
      'en': '',
      'hi': '',
      'ta': '',
      'ur': '',
    },
    'hxsgfsan': {
      'en': '',
      'hi': '',
      'ta': '',
      'ur': '',
    },
    'zuih46g4': {
      'en': '',
      'hi': '',
      'ta': '',
      'ur': '',
    },
    '8oo00kio': {
      'en': '',
      'hi': '',
      'ta': '',
      'ur': '',
    },
    'f4h7j5e1': {
      'en': '',
      'hi': '',
      'ta': '',
      'ur': '',
    },
    'dka0mr3o': {
      'en': '',
      'hi': '',
      'ta': '',
      'ur': '',
    },
    'a9x09f52': {
      'en': '',
      'hi': '',
      'ta': '',
      'ur': '',
    },
    'gn6bmhck': {
      'en': '',
      'hi': '',
      'ta': '',
      'ur': '',
    },
    'b9gx9zp0': {
      'en': '',
      'hi': '',
      'ta': '',
      'ur': '',
    },
    '3ogdlxsd': {
      'en': '',
      'hi': '',
      'ta': '',
      'ur': '',
    },
    'uxmsgxy2': {
      'en': '',
      'hi': '',
      'ta': '',
      'ur': '',
    },
  },
].reduce((a, b) => a..addAll(b));
