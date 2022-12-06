// ignore_for_file: constant_identifier_names

part of './app_pages.dart';

abstract class AppRoutes {
  static const REGISTER = '/';
  static const HOME = '/home';
  static const NEW_COMMUNITY = '/new_community';
  static const USER_DETAILS = '/user_details';
  static const SUB_GROUP = '/sub_group/:id';
  static const JOIN_GROUP = '/join_group/:id';
  static const CREATED_COMMUNITIES = '/created_communities';
}
