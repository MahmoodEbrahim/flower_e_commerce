import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'translations/app_localizations.dart';
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
    Locale('ar'),
    Locale('en'),
  ];

  /// No description provided for @occasion.
  ///
  /// In en, this message translates to:
  /// **'Occasion'**
  String get occasion;

  /// No description provided for @bloomWithOurExquisitebestSellers.
  ///
  /// In en, this message translates to:
  /// **'Bloom with our exquisite best sellers'**
  String get bloomWithOurExquisitebestSellers;

  /// No description provided for @allCategory.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get allCategory;

  /// No description provided for @noProducts.
  ///
  /// In en, this message translates to:
  /// **'No Products Found'**
  String get noProducts;

  /// No description provided for @loading.
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get loading;

  /// No description provided for @errorMessage.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong'**
  String get errorMessage;

  /// No description provided for @search.
  ///
  /// In en, this message translates to:
  /// **'search'**
  String get search;

  /// No description provided for @addToCart.
  ///
  /// In en, this message translates to:
  /// **'Add to cart'**
  String get addToCart;

  /// No description provided for @egp.
  ///
  /// In en, this message translates to:
  /// **'EGP'**
  String get egp;

  /// No description provided for @status.
  ///
  /// In en, this message translates to:
  /// **'Status: '**
  String get status;

  /// No description provided for @inStock.
  ///
  /// In en, this message translates to:
  /// **'In stock'**
  String get inStock;

  /// No description provided for @outOfStock.
  ///
  /// In en, this message translates to:
  /// **'Out of stock'**
  String get outOfStock;

  /// No description provided for @includeTax.
  ///
  /// In en, this message translates to:
  /// **'All prices include tax'**
  String get includeTax;

  /// No description provided for @description.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get description;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @enterYourEmail.
  ///
  /// In en, this message translates to:
  /// **'Enter your email'**
  String get enterYourEmail;

  /// No description provided for @enterYourPassword.
  ///
  /// In en, this message translates to:
  /// **'Enter your password'**
  String get enterYourPassword;

  /// No description provided for @rememberMe.
  ///
  /// In en, this message translates to:
  /// **'Remember me'**
  String get rememberMe;

  /// No description provided for @forgetPassword.
  ///
  /// In en, this message translates to:
  /// **'Forget password?'**
  String get forgetPassword;

  /// No description provided for @loginSuccess.
  ///
  /// In en, this message translates to:
  /// **'Login Success ✅'**
  String get loginSuccess;

  /// No description provided for @serverError.
  ///
  /// In en, this message translates to:
  /// **'server error , try again'**
  String get serverError;

  /// No description provided for @continueAsGuest.
  ///
  /// In en, this message translates to:
  /// **'Continue as guest'**
  String get continueAsGuest;

  /// No description provided for @donotHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account? '**
  String get donotHaveAccount;

  /// No description provided for @signUp.
  ///
  /// In en, this message translates to:
  /// **'Sign up'**
  String get signUp;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @pleaseenteryouremailassociatedtoyouraccount.
  ///
  /// In en, this message translates to:
  /// **'Please enter your email associated to \nyour account'**
  String get pleaseenteryouremailassociatedtoyouraccount;

  /// No description provided for @thisEmailisnotvalid.
  ///
  /// In en, this message translates to:
  /// **'This Email is not valid'**
  String get thisEmailisnotvalid;

  /// No description provided for @enteryouremail.
  ///
  /// In en, this message translates to:
  /// **'Enter your email'**
  String get enteryouremail;

  /// No description provided for @confirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirm;

  /// No description provided for @emailverification.
  ///
  /// In en, this message translates to:
  /// **'Email verification'**
  String get emailverification;

  /// No description provided for @pleaseEnterYourCodeThatSentToYourEmailAddress.
  ///
  /// In en, this message translates to:
  /// **'Please enter your code that was sent to your\n email address'**
  String get pleaseEnterYourCodeThatSentToYourEmailAddress;

  /// No description provided for @didntReceiveCode.
  ///
  /// In en, this message translates to:
  /// **'Didn\'t receive code?'**
  String get didntReceiveCode;

  /// No description provided for @passwordValidationMessage.
  ///
  /// In en, this message translates to:
  /// **'Password must not be empty and must contain\n 6 characters with upper case letter and one\n number at least'**
  String get passwordValidationMessage;

  /// No description provided for @resend.
  ///
  /// In en, this message translates to:
  /// **'Resend'**
  String get resend;

  /// No description provided for @resetpassword.
  ///
  /// In en, this message translates to:
  /// **'Reset password'**
  String get resetpassword;

  /// No description provided for @enteryoupassword.
  ///
  /// In en, this message translates to:
  /// **'Enter your password'**
  String get enteryoupassword;

  /// No description provided for @confirmpassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm password'**
  String get confirmpassword;

  /// No description provided for @newpassword.
  ///
  /// In en, this message translates to:
  /// **'New password'**
  String get newpassword;

  /// No description provided for @passwordresetlinksentsuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Password reset link sent successfully'**
  String get passwordresetlinksentsuccessfully;

  /// No description provided for @gender.
  ///
  /// In en, this message translates to:
  /// **'Gender'**
  String get gender;

  /// No description provided for @female.
  ///
  /// In en, this message translates to:
  /// **'Female'**
  String get female;

  /// No description provided for @male.
  ///
  /// In en, this message translates to:
  /// **'Male'**
  String get male;

  /// No description provided for @pleaseSelectGender.
  ///
  /// In en, this message translates to:
  /// **'Please select the gender'**
  String get pleaseSelectGender;

  /// No description provided for @firstName.
  ///
  /// In en, this message translates to:
  /// **'First Name'**
  String get firstName;

  /// No description provided for @enterFirstName.
  ///
  /// In en, this message translates to:
  /// **'Enter first name'**
  String get enterFirstName;

  /// No description provided for @lastName.
  ///
  /// In en, this message translates to:
  /// **'Last Name'**
  String get lastName;

  /// No description provided for @enterLastName.
  ///
  /// In en, this message translates to:
  /// **'Enter last name'**
  String get enterLastName;

  /// No description provided for @enterEmail.
  ///
  /// In en, this message translates to:
  /// **'Enter your email'**
  String get enterEmail;

  /// No description provided for @phone.
  ///
  /// In en, this message translates to:
  /// **'Phone'**
  String get phone;

  /// No description provided for @enterPassword.
  ///
  /// In en, this message translates to:
  /// **'Enter password'**
  String get enterPassword;

  /// No description provided for @confirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get confirmPassword;

  /// No description provided for @enterConfirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm password'**
  String get enterConfirmPassword;

  /// No description provided for @phoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get phoneNumber;

  /// No description provided for @enterPhoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Enter phone number'**
  String get enterPhoneNumber;

  /// No description provided for @creatingAccountAgreement.
  ///
  /// In en, this message translates to:
  /// **'Creating an account, you agree to our '**
  String get creatingAccountAgreement;

  /// No description provided for @termsAndConditions.
  ///
  /// In en, this message translates to:
  /// **'Terms & Conditions'**
  String get termsAndConditions;

  /// No description provided for @alreadyHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Already have an account? '**
  String get alreadyHaveAccount;

  /// No description provided for @allProducts.
  ///
  /// In en, this message translates to:
  /// **'All Products'**
  String get allProducts;

  /// No description provided for @bloomWithOurExquisiteAllProducts.
  ///
  /// In en, this message translates to:
  /// **'Bloom with our exquisite all Products'**
  String get bloomWithOurExquisiteAllProducts;

  /// No description provided for @bestSeller.
  ///
  /// In en, this message translates to:
  /// **'Best Seller'**
  String get bestSeller;

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'🌸 Flowery'**
  String get appTitle;

  /// No description provided for @deliveryLocation.
  ///
  /// In en, this message translates to:
  /// **'Deliver to 2XVP+XC - Sheikh Zayed'**
  String get deliveryLocation;

  /// No description provided for @categories.
  ///
  /// In en, this message translates to:
  /// **'Categories'**
  String get categories;

  /// No description provided for @occasions.
  ///
  /// In en, this message translates to:
  /// **'Occasions'**
  String get occasions;

  /// No description provided for @products.
  ///
  /// In en, this message translates to:
  /// **'Products'**
  String get products;

  /// No description provided for @error.
  ///
  /// In en, this message translates to:
  /// **'error'**
  String get error;

  /// No description provided for @address.
  ///
  /// In en, this message translates to:
  /// **'Deliver to 2XVP+XC - Sheikh Zayed '**
  String get address;

  /// No description provided for @noProductsFound.
  ///
  /// In en, this message translates to:
  /// **'No Products found.'**
  String get noProductsFound;

  /// No description provided for @seeAll.
  ///
  /// In en, this message translates to:
  /// **'see all'**
  String get seeAll;

  /// No description provided for @cart.
  ///
  /// In en, this message translates to:
  /// **'cart'**
  String get cart;

  /// No description provided for @checkout.
  ///
  /// In en, this message translates to:
  /// **'CheckOut'**
  String get checkout;

  /// No description provided for @deliver_to.
  ///
  /// In en, this message translates to:
  /// **'deliver to'**
  String get deliver_to;

  /// No description provided for @bigAddress.
  ///
  /// In en, this message translates to:
  /// **'2XVP+XC - Sheikh Zayed 2XVP+XC - Sheikh Zayed 2XVP+XC - Sheikh Zayed 2XVP+XC - Sheikh Zayed'**
  String get bigAddress;

  /// No description provided for @subTotal.
  ///
  /// In en, this message translates to:
  /// **'Sub total'**
  String get subTotal;

  /// No description provided for @deliveryFee.
  ///
  /// In en, this message translates to:
  /// **'Delivery fee'**
  String get deliveryFee;

  /// No description provided for @total.
  ///
  /// In en, this message translates to:
  /// **'Total'**
  String get total;

  /// No description provided for @flowery.
  ///
  /// In en, this message translates to:
  /// **'Flowery'**
  String get flowery;

  /// No description provided for @guest.
  ///
  /// In en, this message translates to:
  /// **'Guest'**
  String get guest;

  /// No description provided for @myOrders.
  ///
  /// In en, this message translates to:
  /// **'My orders'**
  String get myOrders;

  /// No description provided for @savedAddress.
  ///
  /// In en, this message translates to:
  /// **'Saved address'**
  String get savedAddress;

  /// No description provided for @notification.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notification;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @english.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// No description provided for @arabic.
  ///
  /// In en, this message translates to:
  /// **'Arabic'**
  String get arabic;

  /// No description provided for @aboutUs.
  ///
  /// In en, this message translates to:
  /// **'About us'**
  String get aboutUs;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @errorLoadingData.
  ///
  /// In en, this message translates to:
  /// **'Error loading data'**
  String get errorLoadingData;

  /// No description provided for @noDataFound.
  ///
  /// In en, this message translates to:
  /// **'No data found'**
  String get noDataFound;

  /// No description provided for @noSectionsFound.
  ///
  /// In en, this message translates to:
  /// **'No sections found'**
  String get noSectionsFound;

  /// No description provided for @version.
  ///
  /// In en, this message translates to:
  /// **'V '**
  String get version;

  /// No description provided for @confirmLogout.
  ///
  /// In en, this message translates to:
  /// **'Confirm logout!!'**
  String get confirmLogout;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @editProfile.
  ///
  /// In en, this message translates to:
  /// **'Edit profile'**
  String get editProfile;

  /// No description provided for @profileUpdatedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Profile updated successfully'**
  String get profileUpdatedSuccessfully;

  /// No description provided for @update.
  ///
  /// In en, this message translates to:
  /// **'Update'**
  String get update;

  /// No description provided for @currentPassword.
  ///
  /// In en, this message translates to:
  /// **'Current password'**
  String get currentPassword;

  /// No description provided for @newPassword.
  ///
  /// In en, this message translates to:
  /// **'New password'**
  String get newPassword;

  /// No description provided for @passwordChangeSuccessfuly.
  ///
  /// In en, this message translates to:
  /// **'✅ Password Change Successfuly'**
  String get passwordChangeSuccessfuly;

  /// No description provided for @changelanguage.
  ///
  /// In en, this message translates to:
  /// **'Change Language'**
  String get changelanguage;

  /// No description provided for @homeTab.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get homeTab;

  /// No description provided for @categoriesTab.
  ///
  /// In en, this message translates to:
  /// **'Categories'**
  String get categoriesTab;

  /// No description provided for @cartTab.
  ///
  /// In en, this message translates to:
  /// **'Cart'**
  String get cartTab;

  /// No description provided for @profileTab.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profileTab;

  /// No description provided for @orderPage.
  ///
  /// In en, this message translates to:
  /// **'My Order'**
  String get orderPage;

  /// No description provided for @active.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get active;

  /// No description provided for @completed.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get completed;

  /// No description provided for @reorder.
  ///
  /// In en, this message translates to:
  /// **'Reorder'**
  String get reorder;

  /// No description provided for @trackorder.
  ///
  /// In en, this message translates to:
  /// **'Track order'**
  String get trackorder;

  /// No description provided for @lowerPrice.
  ///
  /// In en, this message translates to:
  /// **'Lower Price'**
  String get lowerPrice;

  /// No description provided for @highestPrice.
  ///
  /// In en, this message translates to:
  /// **'Highest Price'**
  String get highestPrice;

  /// No description provided for @newFilter.
  ///
  /// In en, this message translates to:
  /// **'New'**
  String get newFilter;

  /// No description provided for @old.
  ///
  /// In en, this message translates to:
  /// **'Old'**
  String get old;

  /// No description provided for @discount.
  ///
  /// In en, this message translates to:
  /// **'Discount'**
  String get discount;

  /// No description provided for @filter.
  ///
  /// In en, this message translates to:
  /// **'Filter'**
  String get filter;

  /// No description provided for @startShopping.
  ///
  /// In en, this message translates to:
  /// **'Start Shopping'**
  String get startShopping;

  /// No description provided for @emptyMessage.
  ///
  /// In en, this message translates to:
  /// **'Your cart is blooming… \n but still empty! 🌸 '**
  String get emptyMessage;

  /// No description provided for @loginToEnjoyShopping.
  ///
  /// In en, this message translates to:
  /// **'Please Login to enjoy shopping'**
  String get loginToEnjoyShopping;

  /// No description provided for @sortBy.
  ///
  /// In en, this message translates to:
  /// **'sortBy'**
  String get sortBy;

  /// No description provided for @commonError.
  ///
  /// In en, this message translates to:
  /// **'oops somthing went wrong please try again '**
  String get commonError;

  /// No description provided for @typeSomething.
  ///
  /// In en, this message translates to:
  /// **'Type something to search...'**
  String get typeSomething;

  /// No description provided for @noProductsFor.
  ///
  /// In en, this message translates to:
  /// **'No products found for '**
  String get noProductsFor;

  /// No description provided for @noLocationFound.
  ///
  /// In en, this message translates to:
  /// **'No Address Found !   😐'**
  String get noLocationFound;
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
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
