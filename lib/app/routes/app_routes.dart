// ignore_for_file: constant_identifier_names

part of './app_pages.dart';

abstract class AppRoutes {
  static const REGISTER = '/';
  static const HOME = '/home';
  static const CREATE_COMMUNITY = '/create_community';
  static const USER_DETAILS = '/user_details';
  static const JOIN_GROUP = '/join_group/:id';
  static const COMMUNITY_DETAILS = '/community_details';
  static const COMMUNITY_SETTINGS = '/community_settings';
  static const PROFILE = '/profile';
  static const JOIN_COMMUNITY_WITH_INVITE_LINK =
      '/join_community_with_invite_link';
}
