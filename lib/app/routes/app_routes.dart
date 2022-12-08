// ignore_for_file: constant_identifier_names

part of './app_pages.dart';

abstract class AppRoutes {
  static const REGISTER = '/';
  static const HOME = '/home';
  static const NEW_COMMUNITY = '/new_community';
  static const USER_DETAILS = '/user_details';
  static const GROUP_DETAILS = '/group_details';
  static const JOIN_GROUP = '/join_group/:id';
  static const CREATED_COMMUNITIES = '/created_communities';
  static const COMMUNITY_DETAILS = '/community_details';
  static const COMMUNITY_SETTINGS = '/community_settings';
  static const JOIN_COMMUNITY = '/join_community/:id';
}
