import 'package:get/get.dart';
import 'package:organizer_client/app/core/user/data/database/user_local_database.dart';
import 'package:organizer_client/app/core/user/data/database/user_remote_database.dart';
import 'package:organizer_client/app/core/user/data/repositories/user_repository_impl.dart';
import 'package:organizer_client/app/core/user/domain/usecases/authenticated_user.dart';
import 'package:organizer_client/app/features/chat/data/database/community_chat_remote_database.dart';
import 'package:organizer_client/app/features/chat/data/database/group_chat_remote_database.dart';
import 'package:organizer_client/app/features/chat/data/repositories/community_chat_repository_impl.dart';
import 'package:organizer_client/app/features/chat/data/repositories/group_chat_repository_impl.dart';
import 'package:organizer_client/app/features/chat/domain/repositories/community_chat_repository.dart';
import 'package:organizer_client/app/features/chat/domain/repositories/group_chat_repository.dart';
import 'package:organizer_client/app/features/chat/domain/usecases/delete_group_message.dart';
import 'package:organizer_client/app/features/chat/domain/usecases/edit_group_message.dart';
import 'package:organizer_client/app/features/chat/domain/usecases/send_group_message.dart';
import 'package:organizer_client/app/features/chat/presentation/widgets/controllers/chat_controller.dart';
import 'package:organizer_client/app/features/community/data/database/community_remote_database.dart';
import 'package:organizer_client/app/features/community/data/repositories/community_repository_impl.dart';
import 'package:organizer_client/app/features/community/domain/repositories/community_repository.dart';
import 'package:organizer_client/app/features/discover/presentation/controllers/discover_controller.dart';
import 'package:organizer_client/app/features/groups/data/database/group_remote_database.dart';
import 'package:organizer_client/app/features/groups/data/repositories/group_repository_impl.dart';
import 'package:organizer_client/app/features/groups/domain/repositories/group_repository.dart';
import 'package:organizer_client/shared/network/network.dart';

import 'app/features/community/domain/usecases/find_community.dart';
import 'app/features/groups/domain/usecases/find_group.dart';
import 'app/features/groups/domain/usecases/is_member.dart';

class InitialBinding {
  static void inject() {
    Get.put(NetworkInfoImpl(), permanent: true);
    Get.put(UserLocalDatabaseImpl(), permanent: true);
    Get.put(UserRemoteDatabaseImpl(), permanent: true);
    Get.put(CommunityRemoteDatabaseImpl(), permanent: true);
    Get.put(
        CommunityChatRemoteDatabaseImpl(
          userRemoteDatabase: Get.find<UserRemoteDatabaseImpl>(),
        ),
        permanent: true);
    Get.put(
        GroupChatRemoteDatabaseImpl(
            userRemoteDatabase: Get.find<UserRemoteDatabaseImpl>()),
        permanent: true);

    Get.put(
      GroupRemoteDatabaseImpl(
          userRemoteDatabase: Get.find<UserRemoteDatabaseImpl>(),
          communityRemoteDatabase: Get.find<CommunityRemoteDatabaseImpl>()),
      permanent: true,
    );

    Get.put(UserRepositoryImpl(
      networkInfo: Get.find<NetworkInfoImpl>(),
      userRemoteDatabase: Get.find<UserRemoteDatabaseImpl>(),
      userLocalDatabase: Get.find<UserLocalDatabaseImpl>(),
    ));
    Get.lazyPut<GroupRepository>(
      () => GroupRepositoryImpl(
        networkInfo: Get.find<NetworkInfoImpl>(),
        remoteDatabase: Get.find<GroupRemoteDatabaseImpl>(),
      ),
      fenix: true,
    );
    Get.lazyPut<GroupChatRepository>(
      () => GroupChatRepositoryImpl(
        networkInfo: Get.find<NetworkInfoImpl>(),
        remoteDatabase: Get.find<GroupChatRemoteDatabaseImpl>(),
      ),
      fenix: true,
    );
    Get.lazyPut<CommunityRepository>(
      () => CommunityRepositoryImpl(
        networkInfo: Get.find<NetworkInfoImpl>(),
        remoteDatabase: Get.find<CommunityRemoteDatabaseImpl>(),
      ),
      fenix: true,
    );
    Get.put(
      AuthenticatedUserUseCase(userRepository: Get.find<UserRepositoryImpl>()),
    );
    Get.lazyPut(
      () =>
          SendGroupMessageUseCase(repository: Get.find<GroupChatRepository>()),
    );
    Get.lazyPut<DeleteGroupMessageUseCase>(
      () => DeleteGroupMessageUseCase(repository: Get.find()),
    );
    Get.lazyPut<EditGroupMessageUseCase>(
      () => EditGroupMessageUseCase(repository: Get.find()),
    );
    Get.put(
      ChatController(
          sendMessageUseCase: Get.find(),
          deleteMessageUseCase: Get.find(),
          editMessageUseCase: Get.find()),
      permanent: true,
    );
    Get.lazyPut<CommunityChatRepository>(
      () => CommunityChatRepositoryImpl(
        remoteDatabase: Get.find<CommunityChatRemoteDatabaseImpl>(),
        networkInfo: Get.find<NetworkInfoImpl>(),
      ),
      fenix: true,
    );
    Get.lazyPut<FindCommunityUseCase>(
        () => FindCommunityUseCase(repository: Get.find()));
    Get.lazyPut<FindGroupUseCase>(
      () => FindGroupUseCase(repository: Get.find()),
      fenix: true,
    );
    Get.lazyPut<IsMemberUseCase>(() => IsMemberUseCase(repository: Get.find()));
    Get.put(
      DiscoverController(
        findCommunityUseCase: Get.find(),
        findGroupUseCase: Get.find(),
        isMemberUseCase: Get.find(),
      ),
      permanent: true,
    );
  }
}
