import 'package:finflow_iot/features/auth/screens/otp_page.dart';
import 'package:finflow_iot/features/auth/screens/signup_page.dart';
import 'package:finflow_iot/features/home/screens/home_page.dart';

// route is not used in fixed route, used for dynamic route
final allRoutes = {
  // '/': (ctx) => const SplashScreen(),
  SignUpPage.routeName: (ctx) => SignUpPage(),
  OTPPage.routeName: (ctx) => const OTPPage(),
  HomePage.routeName: (ctx) => const HomePage(),
};
