import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:page_transition/page_transition.dart';
import 'package:quick_parck/pages/MyBooking/my_booking.dart';
import 'package:quick_parck/pages/addVehicle/add_vehicle.dart';
import 'package:quick_parck/pages/arrived/arrived.dart';
import 'package:quick_parck/pages/auth/login.dart';
import 'package:quick_parck/pages/auth/otp.dart';
import 'package:quick_parck/pages/auth/register.dart';
import 'package:quick_parck/pages/bookParkingDetail/book_parking_detail.dart';
import 'package:quick_parck/pages/boomark/book_mark.dart';
import 'package:quick_parck/pages/bottomNavigationBar/bottom_navigation_bar.dart';
import 'package:quick_parck/pages/confirmation/confirmation.dart';
import 'package:quick_parck/pages/creditCard/credit_card.dart';
import 'package:quick_parck/pages/detail/detail.dart';
import 'package:quick_parck/pages/direction/direction.dart';
import 'package:quick_parck/pages/extendParkingTime/extend_parking_time.dart';
import 'package:quick_parck/pages/home/home.dart';
import 'package:quick_parck/pages/images/images.dart';
import 'package:quick_parck/pages/notification/notification.dart';
import 'package:quick_parck/pages/onboarding/onboarding.dart';
import 'package:quick_parck/pages/parkingTicket/parking_ticket.dart';
import 'package:quick_parck/pages/parkingTime/parking_time.dart';
import 'package:quick_parck/pages/paymentMethods/payment_methods.dart';
import 'package:quick_parck/pages/profile/app_settings.dart';
import 'package:quick_parck/pages/profile/edit_profile.dart';
import 'package:quick_parck/pages/profile/help_support.dart';
import 'package:quick_parck/pages/profile/languages.dart';
import 'package:quick_parck/pages/profile/my_vehicle.dart';
import 'package:quick_parck/pages/profile/privacy_policy.dart';
import 'package:quick_parck/pages/profile/profile.dart';
import 'package:quick_parck/pages/profile/terms_condition.dart';
import 'package:quick_parck/pages/profile/wallet.dart';
import 'package:quick_parck/pages/review/review.dart';
import 'package:quick_parck/pages/selectSlot/select_slot.dart';
import 'package:quick_parck/pages/selectVehicle/select_vehicle.dart';
import 'package:quick_parck/pages/splash.dart';
import 'package:quick_parck/theme/theme.dart';
import 'localization/localization.dart';
import 'localization/localization_const.dart';
import 'pages/screens.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  print(" fire base uid auth 454444444444444444444 ${FirebaseAuth.instance.currentUser?.uid}");
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  static void setLocale(BuildContext context, Locale locale) {
    _MyAppState state = context.findAncestorStateOfType<_MyAppState>()!;
    state.setLocale(locale);
  }

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale? _locale;

  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  void didChangeDependencies() {
    getLocale().then((locale) {
      setState(() {
        _locale = locale;
      });
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FL QuickPark',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: primaryColor,
        fontFamily: 'Mulish',
        scaffoldBackgroundColor: scaffoldBgColor,
      ),
      home: const SplashScreen(),
      onGenerateRoute: routes,
      locale: _locale,
      supportedLocales: const [
        Locale('en'),
        Locale('hi'),
        Locale('id'),
        Locale('zh'),
        Locale('ar'),
      ],
      localizationsDelegates: [
        DemoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      localeResolutionCallback: (deviceLocale, supportedLocales) {
        for (var locale in supportedLocales) {
          if (locale.languageCode == deviceLocale?.languageCode) {
            return deviceLocale;
          }
        }
        return supportedLocales.first;
      },
    );
  }

  Route<dynamic>? routes(settings) {
    switch (settings.name) {
      case '/':
        return PageTransition(
            child: const SplashScreen(),
            type: PageTransitionType.fade,
            settings: settings);
      case '/onboarding':
        return PageTransition(
            child: const OnboardingScreen(),
            type: PageTransitionType.fade,
            settings: settings);
      case '/login':
        return PageTransition(
            child: const LoginScreen(),
            type: PageTransitionType.rightToLeft,
            settings: settings);
      case '/register':
        return PageTransition(
            child: const RegisterScreen(),
            type: PageTransitionType.rightToLeft,
            settings: settings);
      case '/otp':
        return PageTransition(
            child: const OTPScreen(),
            type: PageTransitionType.rightToLeft,
            settings: settings);
      case '/bottomBar':
        return PageTransition(
            child: const BottomBar(),
            type: PageTransitionType.fade,
            settings: settings);
      case '/home':
        return PageTransition(
            child: const HomeScreen(),
            type: PageTransitionType.rightToLeft,
            settings: settings);
      case '/notification':
        return PageTransition(
            child: const NotificationScreen(),
            type: PageTransitionType.rightToLeft,
            settings: settings);
      case '/detail':
        return PageTransition(
            child: const DetailScreen(),
            type: PageTransitionType.rightToLeft,
            settings: settings);
      case '/review':
        return PageTransition(
            child: const ReviewScreen(),
            type: PageTransitionType.rightToLeft,
            settings: settings);
      case '/images':
        return PageTransition(
            child: const ImageScreen(),
            type: PageTransitionType.rightToLeft,
            settings: settings);
      case '/direction':
        return PageTransition(
            child: const DirectionScreen(),
            type: PageTransitionType.rightToLeft,
            settings: settings);
      case '/arrived':
        return PageTransition(
            child: const ArrivedScreen(),
            type: PageTransitionType.rightToLeft,
            settings: settings);
      case '/parkingTime':
        return PageTransition(
            child: const ParkingTimeScreen(),
            type: PageTransitionType.rightToLeft,
            settings: settings);
      case '/extendParkingTime':
        return PageTransition(
            child: const ExtendParkingTimeScreen(),
            type: PageTransitionType.rightToLeft,
            settings: settings);
      case '/paymentMethods':
        return PageTransition(
            child: const PaymentMethodsScreen(),
            type: PageTransitionType.rightToLeft,
            settings: settings);
      case '/creditCard':
        return PageTransition(
            child: const CreditCardScreen(),
            type: PageTransitionType.rightToLeft,
            settings: settings);
      case '/bookingConfirm':
        return PageTransition(
            child: const BookingConfirmationScreen(),
            type: PageTransitionType.rightToLeft,
            settings: settings);
      case '/parkingTicket':
        return PageTransition(
            child: const ParkingTicketScreen(),
            type: PageTransitionType.rightToLeft,
            settings: settings);
      case '/selectVehical':
        return PageTransition(
            child: const SelectVehicalScreen(),
            type: PageTransitionType.rightToLeft,
            settings: settings);
      case '/addVehical':
        return PageTransition(
            child: const AddVehicalScreen(),
            type: PageTransitionType.rightToLeft,
            settings: settings);
      case '/bookParkingDetail':
        return PageTransition(
            child: const BookParkingDetailScreen(),
            type: PageTransitionType.rightToLeft,
            settings: settings);
      case '/selectSlot':
        return PageTransition(
            child: const SelectSlotScreen(),
            type: PageTransitionType.rightToLeft,
            settings: settings);
      case '/myBooking':
        return PageTransition(
            child: const MyBookingScreen(),
            type: PageTransitionType.rightToLeft,
            settings: settings);
      case '/bookMark':
        return PageTransition(
            child: const BookMarkScreen(),
            type: PageTransitionType.rightToLeft,
            settings: settings);
      case '/profile':
        return PageTransition(
            child: const ProfileScreen(),
            type: PageTransitionType.rightToLeft,
            settings: settings);
      case '/editProfile':
        return PageTransition(
            child: const EditProfileScreen(),
            type: PageTransitionType.rightToLeft,
            settings: settings);
      case '/wallet':
        return PageTransition(
            child: const WalletScreen(),
            type: PageTransitionType.rightToLeft,
            settings: settings);
      case '/myVehicle':
        return PageTransition(
            child: const MyVehicleScreen(),
            type: PageTransitionType.rightToLeft,
            settings: settings);
      case '/helpAndSupport':
        return PageTransition(
            child: const HelpSupportScreen(),
            type: PageTransitionType.rightToLeft,
            settings: settings);
      case '/privacyPolicy':
        return PageTransition(
            child: const PrivacyPolicyScreen(),
            type: PageTransitionType.rightToLeft,
            settings: settings);
      case '/termsCondition':
        return PageTransition(
            child: const TermsAndConditionScreen(),
            type: PageTransitionType.rightToLeft,
            settings: settings);
      case '/languages':
        return PageTransition(
            child: const LanguagesScreen(),
            type: PageTransitionType.rightToLeft,
            settings: settings);
      case '/appSettings':
        return PageTransition(
            child: const AppSettingsScreen(),
            type: PageTransitionType.rightToLeft,
            settings: settings);
      default:
        return null;
    }
  }
}
