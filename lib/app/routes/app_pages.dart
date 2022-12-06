import 'package:get/get.dart';
import 'package:organizer_client/app/features/account/presentation/bindings/account_binding.dart';
import 'package:organizer_client/app/features/community/presentation/bindings/create_communities_binding.dart';
import 'package:organizer_client/app/features/community/presentation/bindings/new_community_binding.dart';
import 'package:organizer_client/app/features/community/presentation/pages/created_communities_page.dart';
import 'package:organizer_client/app/features/community/presentation/pages/new_community_page.dart';
import 'package:organizer_client/app/features/discover/presentation/bindings/discover_binding.dart';
import 'package:organizer_client/app/features/discover/presentation/bindings/join_group_bindng.dart';
import 'package:organizer_client/app/features/discover/presentation/bindings/sub_group_binding.dart';
import 'package:organizer_client/app/features/discover/presentation/pages/join_group_page.dart';
import 'package:organizer_client/app/features/discover/presentation/pages/sub_group_page.dart';
import 'package:organizer_client/app/features/groups/presentation/bindings/groups_binding.dart';
import 'package:organizer_client/app/features/home/presentation/bindings/home_binding.dart';
import 'package:organizer_client/app/features/home/presentation/pages/home_page.dart';
import 'package:organizer_client/app/features/register/presentation/bindings/register_binding.dart';
import 'package:organizer_client/app/features/register/presentation/bindings/user_details_binding.dart';
import 'package:organizer_client/app/features/register/presentation/pages/register_page.dart';
import 'package:organizer_client/app/features/register/presentation/pages/user_details_page.dart';

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
        DiscoverBinding(),
        AccountBinding(),
      ],
    ),
    GetPage(
      name: AppRoutes.NEW_COMMUNITY,
      page: () => const NewCommunityPage(),
      binding: NewCommunityBinding(),
    ),
    GetPage(
      name: AppRoutes.SUB_GROUP,
      page: () => const SubGroupPage(),
      binding: SubGroupBinding(),
    ),
    GetPage(
      name: AppRoutes.JOIN_GROUP,
      page: () => const JoinGroupPage(),
      binding: JoinGroupBinding(),
    ),
    GetPage(
      name: AppRoutes.CREATED_COMMUNITIES,
      page: () => const CreatedCommunitiesPage(),
      binding: CreatedCommunitiesBinding(),
    ),
  ];
}
