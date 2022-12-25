import 'package:get/get.dart';
import 'package:organizer_client/app/core/user/data/database/user_local_database.dart';
import 'package:organizer_client/app/core/user/data/database/user_remote_database.dart';
import 'package:organizer_client/app/core/user/data/repositories/user_repository_impl.dart';
import 'package:organizer_client/app/core/user/domain/usecases/authenticated_user.dart';
import 'package:organizer_client/app/features/chat/data/database/chat_remote_database.dart';
import 'package:organizer_client/app/features/chat/data/repositories/chat_repository_impl.dart';
import 'package:organizer_client/app/features/chat/domain/repositories/chat_repository.dart';
import 'package:organizer_client/app/features/chat/domain/usecases/send_message.dart';
import 'package:organizer_client/app/features/chat/presentation/widgets/controllers/chat_controller.dart';
import 'package:organizer_client/app/features/community/data/database/community_remote_database.dart';
import 'package:organizer_client/app/features/community/data/repositories/community_repository_impl.dart';
import 'package:organizer_client/app/features/community/domain/repositories/community_repository.dart';
import 'package:organizer_client/app/features/community/domain/usecases/delete_community.dart';
import 'package:organizer_client/app/features/groups/data/database/group_remote_database.dart';
import 'package:organizer_client/app/features/groups/data/repositories/group_repository_impl.dart';
import 'package:organizer_client/app/features/groups/domain/repositories/group_repository.dart';
import 'package:organizer_client/shared/network/network.dart';

class InitialBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(NetworkInfoImpl(), permanent: true);
    Get.put(UserLocalDatabaseImpl(), permanent: true);
    Get.put(UserRemoteDatabaseImpl(), permanent: true);
    Get.put(CommunityRemoteDatabaseImpl(), permanent: true);
    Get.put(
        ChatRemoteDatabaseImpl(
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
    Get.lazyPut<ChatRepository>(
      () => ChatRepositoryImpl(
        networkInfo: Get.find<NetworkInfoImpl>(),
        remoteDatabase: Get.find<ChatRemoteDatabaseImpl>(),
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
      () => SendMessageUseCase(repository: Get.find<ChatRepository>()),
    );
    Get.lazyPut<DeleteCommunityUseCase>(
        () => DeleteCommunityUseCase(repository: Get.find()));
    Get.put(
      ChatController(
        sendMessageUseCase: Get.find(),
        deleteMessageUseCase: Get.find(),
      ),
      permanent: true,
    );
  }
}
