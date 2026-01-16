/// 使用方法：AppPages.routes;
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../pages/pages.dart';
import 'routes.dart';

class AppPages {
  static final RouteObserver<Route> observer = RouteObservers();
  static List<String> history = [];

  static final List<GetPage> routes = [
    GetPage(
      name: AppRoutes.welcome,
      page: () => const WelcomePage(),
      transition: Transition.native,
      middlewares: [
        RouteWelcomeMiddleware(priority: 1),
      ],
    ),
    GetPage(
      name: AppRoutes.application,
      page: () => const ApplicationPage(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: AppRoutes.login,
      page: () => const LoginPage(),
      transition: Transition.downToUp,
    ),
    GetPage(
      name: AppRoutes.setting,
      page: () => const SettingPage(),
    ),
    GetPage(
      name: AppRoutes.aboutApp,
      page: () => const AboutPage(),
    ),
    GetPage(
      name: AppRoutes.search,
      page: () => const SearchPage(),
    ),
    GetPage(
      name: AppRoutes.profile,
      page: () => const ProfilePage(),
    ),
    GetPage(
      name: AppRoutes.listDemo,
      page: () => const ListPage(),
    ),
    GetPage(
      name: AppRoutes.feedback,
      page: () => const FeedbackPage(),
    ),
    GetPage(
      name: AppRoutes.profileDetail,
      page: () => const ProfileDetailPage(),
    ),
    GetPage(
      name: AppRoutes.appRecommend,
      page: () => const AppRecommendPage(),
    ),
    GetPage(
      name: AppRoutes.register,
      page: () => const RegisterPage(),
      transition: Transition.downToUp,
    ),
    GetPage(
      name: AppRoutes.articleDetail,
      page: () => const ArticleDetailPage(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.notification,
      page: () => const NotificationPage(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.componentShowcase,
      page: () => const ComponentShowcasePage(),
      transition: Transition.rightToLeft,
    ),
  ];

  static final GetPage unknownRoute = GetPage(
    name: AppRoutes.notFound,
    page: () => const NotFoundPage(),
  );
}
