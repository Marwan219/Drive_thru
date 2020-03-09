import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import './messages_all.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';



class AppLocalizations {
  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);

  }

  static Future<AppLocalizations> load(Locale locale) {
    final String name =
        locale.countryCode == null ? locale.languageCode : locale.toString();
    final String localeName = Intl.canonicalizedLocale(name);

    return initializeMessages(localeName).then((bool _) {
      Intl.defaultLocale = localeName;
      return new AppLocalizations();
    });
  }
  
/// this for Dashboard Localization 

  String get allCategory => Intl.message(
        'All Categories',
        name: 'allCategory',
        desc: 'All Cateogries option',
  );

  
  String get frieds => Intl.message(
        'Freids',
        name: 'frieds',
        desc: 'Freids Menu',
  );
 String get fastFood => Intl.message(
        'Fast Food',
        name: 'fastFood',
        desc: 'Fast Food Menu',
  );
  String get creamery => Intl.message(
        'Creamery',
        name: 'creamery',
        desc: 'Creamery Menu',
  );
  String get hotDrinks => Intl.message(
        'Hot Drinks',
        name: 'hotDrinks',
        desc: 'Hot Drinks Menu',
  );
  String get vegetables => Intl.message(
        'Vegetables ',
        name: 'vegetables',
        desc: 'Vegetables  Menu',
  );

  String get resturants  => Intl.message(
        'Resturants',
        name: 'resturants',
        desc: 'Resturants  Menu',
  );


// this for slide bar 
 String get homePage => Intl.message(
        'Home Page',
        name: 'homePage',
        desc: 'Home Page ',
  );
 String get myProfile => Intl.message(
        'My Profile',
        name: 'myProfile',
        desc: 'My Profile',
  );
  String get myCart => Intl.message(
        'My Cart',
        name: 'myCart',
        desc: 'My Cart',
  );
  String get store => Intl.message(
        'Store',
        name: 'store',
        desc: 'Store',
  );
  String get addResturant => Intl.message(
        'Add Resturant',
        name: 'addResturant',
        desc: 'Add Resturant',
  );

  String get setting  => Intl.message(
        'Setting',
        name: 'setting',
        desc: 'Setting',
  );
  String get timerPage  => Intl.message(
        'Timer Page',
        name: 'timerPage',
        desc: 'Timer Page',
  );

String get  language => Intl.message(
        'Language',
        name: 'language',
        desc: 'Language',
  );

String get signOut  => Intl.message(
        'Sing Out',
        name: 'signOut',
        desc: 'Sing Out',
  );
  String get signIn  => Intl.message(
        'Sing In',
        name: 'signIn',
        desc: 'Sing In Button',
  );
    String get signUp  => Intl.message(
        'Sing Up',
        name: 'signUp',
        desc: 'Sing Up Button',
  );
  // end of Slide bar  


  /// this for Menu 
  String get menutxt  => Intl.message(
        'Menu',
        name: 'menutxt',
        desc: 'Menu cnotainer txt',
  );
  /// end of menu 
  
    // Product Page start
      String get quantity  => Intl.message(
        "Quantity",
        name: 'quantity',
        desc: 'Quantity btn txt',
  );
      String get buyNowbtn  => Intl.message(
        "Buy Now",
        name: 'buyNowbtn',
        desc: 'Buy Now btn txt',
  );
     String get addToCartbtn  => Intl.message(
        "Add To Cart",
        name: 'addToCartbtn',
        desc: 'Add To Cart btn txt',
  );
    // Product Page end 
  




  // Buy Page start

       String get bill  => Intl.message(
        "Bill",
        name: 'bill',
        desc: 'Bill txt',
  );
       String get items  => Intl.message(
        "Items",
        name: 'items',
        desc: 'items txt',
  );
       String get  price => Intl.message(
        "Price",
        name: 'price',
        desc: 'price txt',
  );
       String get totalPrice  => Intl.message(
        "Totoal Price",
        name: 'totalPrice',
        desc: 'total price txt',
  );
       String get chooseAvailableCoins  => Intl.message(
        "Choose Available Coins",
        name: 'chooseAvailableCoins',
        desc: ' Choose Available Coins txt',
  );
       String get deliveryOption  => Intl.message(
        "Delivery Option",
        name: 'deliveryOption',
        desc: ' Delivery Option btn txt',
  );
       String get  car => Intl.message(
        "Car",
        name: 'car',
        desc: ' Carbtn txt',
  );
       String get  carSpec => Intl.message(
        "Car Specs",
        name: 'carSpec',
        desc: 'Car Specs btn txt',
  );
       String get carNumber  => Intl.message(
        "Car Number",
        name: 'carNumber',
        desc: 'Car Number btn txt',
  );
       String get  carModel => Intl.message(
        "Car Model",
        name: 'carModel',
        desc: 'Car Model btn txt',
  );
       String get  carColor => Intl.message(
        "Car Color",
        name: 'carColor',
        desc: 'Car Color btn txt',
  );
       String get walk  => Intl.message(
        "Walk",
        name: 'walk',
        desc: 'Walk btn txt',
  );
       String get personalInfo  => Intl.message(
        "Personal Information",
        name: 'personalInfo',
        desc: 'Personal Information btn txt',
  );
       String get phoneNumber => Intl.message(
        "Phone Number",
        name: 'phoneNumber',
        desc: ' Phone Numberbtn txt',
  );
       String get name  => Intl.message(
        "Name",
        name: 'name',
        desc: 'Name btn txt',
  );
// Buy page end     


}

class SpecificLocalizationDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  final Locale overriddenLocale;

  SpecificLocalizationDelegate(this.overriddenLocale);
  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale('ar', ''), Locale('en', ''),
    ];}
  @override
  // bool isSupported(Locale locale) => overriddenLocale != null;
  bool isSupported(Locale locale) => _isSupported(locale);
  
  bool _isSupported(Locale locale) {
    if (locale != null) {
      for (Locale supportedLocale in supportedLocales) {
        if (supportedLocale.languageCode == locale.languageCode) {
          return true;
        }
      }
    }
    return false;
  }
  @override
  Future<AppLocalizations> load(Locale locale) =>
      AppLocalizations.load(overriddenLocale);

  @override
  bool shouldReload(LocalizationsDelegate<AppLocalizations> old) => true;
  
  
}

class FallbackCupertinoLocalisationsDelegate extends LocalizationsDelegate<CupertinoLocalizations> {
  const FallbackCupertinoLocalisationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'ar'].contains(locale.languageCode);

  @override
  Future<CupertinoLocalizations> load(Locale locale) => SynchronousFuture<_DefaultCupertinoLocalizations>(_DefaultCupertinoLocalizations(locale));

  @override
  bool shouldReload(FallbackCupertinoLocalisationsDelegate old) => false;
}

class _DefaultCupertinoLocalizations extends DefaultCupertinoLocalizations {
  final Locale locale;
  
  _DefaultCupertinoLocalizations(this.locale);

 
}
String language  = "en";
// two main funcitons needed to update message fiels 
// first is tow update message_ arb fiels 
  // flutter pub pub run intl_translation:extract_to_arb --output-dir=lib/l10n lib/src/lang/sit_localizations.dart
// second is to update .dart fiels 
  // flutter pub pub run intl_translation:generate_from_arb lib\generated\intl\l10n.dart  lib/l10n/intl_en.arb  --output-dir=lib\generated\intl --no-use-deferred-loading
