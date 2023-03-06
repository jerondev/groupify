import 'package:get/get.dart';
import 'package:groupify/app/features/account/presentation/bindings/account_binding.dart';
import 'package:groupify/app/features/account/presentation/bindings/profile_binding.dart';
import 'package:groupify/app/features/account/presentation/pages/profile_page.dart';
import 'package:groupify/app/features/community/presentation/pages/create_page.dart';
import 'package:groupify/app/features/community/presentation/pages/join_with_inivite_link_page.dart';
import 'package:groupify/app/features/groups/presentation/bindings/groups_binding.dart';
import 'package:groupify/app/features/home/presentation/bindings/home_binding.dart';
import 'package:groupify/app/features/home/presentation/pages/home_page.dart';
import 'package:groupify/app/features/register/presentation/bindings/register_binding.dart';
import 'package:groupify/app/features/register/presentation/bindings/user_details_binding.dart';
import 'package:groupify/app/features/register/presentation/pages/register_page.dart';
import 'package:groupify/app/features/register/presentation/pages/user_details_page.dart';

import '../features/community/presentation/bindings/create_community_binding.dart';
import '../features/community/presentation/bindings/join_with_invite_link_binding.dart';

part './app_routes.dart';

abstract class AppPages {
  static final pages = [
    GetPage(
      name: AppRoutes.REGISTER,
      page: () => const RegisterPage(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: AppRoutes.USER_DETAILS,
      page: () => const UserDetailsPage(),
      binding: UserDetailsBinding(),
    ),
    GetPage(
      name: AppRoutes.HOME,
      page: () => const HomePage(),
      bindings: [
        HomeBinding(),
        GroupsBinding(),
        AccountBinding(),
      ],
    ),
    GetPage(
      name: AppRoutes.JOIN_COMMUNITY_WITH_INVITE_LINK,
      page: () => const JoinWithInviteLinkPage(),
      binding: JoinWithInviteLinkBinding(),
    ),
    GetPage(
      name: AppRoutes.CREATE_COMMUNITY,
      page: () => const CreatePage(),
      binding: CreateCommunityBinding(),
    ),
    GetPage(
      name: AppRoutes.PROFILE,
      page: () => const ProfilePage(),
      binding: ProfileBinding(),
    ),
  ];
}
