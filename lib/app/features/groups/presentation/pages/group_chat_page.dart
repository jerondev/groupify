import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:organizer_client/app/features/chat/presentation/widgets/single_message.dart';
import 'package:organizer_client/app/features/groups/presentation/controllers/group_chat_controller.dart';
import 'package:organizer_client/shared/ui/error_page.dart';

class GroupChatPage extends GetView<GroupChatController> {
  const GroupChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    String previousSender = "";

    return Scaffold(
      appBar: AppBar(
          title: InkWell(
        onTap: controller.showGroupDetails,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            children: [
              const Text("Group Chat"),
              Text(
                "${controller.group.name} (${controller.group.members.length} members)",
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ),
      )),
      body: SafeArea(child: Obx(
        () {
          if (controller.errorOccurred.value) {
            return ErrorPage(
              message: "Couldn't fetch messages",
              subMessage: "Connect to the internet and try again",
              callback: () {
                controller.messages.bindStream(
                  controller.getMessages(),
                );
              },
            );
          }
          return Column(
            children: [
              Expanded(
                child: ListView.separated(
                  cacheExtent: 1000,
                  controller: controller.scrollController,
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.all(12),
                  separatorBuilder: (context, index) => const Padding(
                    padding: EdgeInsets.symmetric(vertical: 7),
                  ),
                  itemCount: controller.messages.length,
                  itemBuilder: (context, index) {
                    final message = controller.messages[index];
                    final bool isSameSender =
                        previousSender == message.sender.fullName;
                    previousSender = message.sender.fullName;
                    final bool showTime = index == 0 ||
                        controller.messages[index - 1].formattedTime !=
                            message.formattedTime;
                    return Column(
                      children: [
                        // show chat date, like today, yesterday, 3rd May
                        if (index == 0 ||
                            controller.messages[index - 1].formattedDate !=
                                message.formattedDate)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Chip(
                              label: Text(message.formattedDate),
                              avatar: const Icon(IconlyBroken.calendar),
                            ),
                          ),
                        SingleMessage(
                          message: message,
                          isSameSender: isSameSender,
                          showTime: showTime,
                        )
                      ],
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10, left: 5, right: 5),
                child: TextFormField(
                  controller: controller.textMessageController,
                  maxLines: 5,
                  minLines: 1,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      onPressed: controller.sendMessage,
                      icon: const Icon(IconlyBroken.send),
                      tooltip: "Send a message",
                      splashRadius: 20,
                    ),
                    hintText: 'Type a message',
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 20,
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      )),
    );
  }
}
