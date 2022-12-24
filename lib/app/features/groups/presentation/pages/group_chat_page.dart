import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/bubble_type.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_9.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:ionicons/ionicons.dart';
import 'package:organizer_client/app/features/groups/presentation/controllers/group_chat_controller.dart';
import 'package:swipe_to/swipe_to.dart';

class GroupChatPage extends GetView<GroupChatController> {
  const GroupChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    const otherColor = Color.fromRGBO(225, 255, 199, 1.0);
    const userColor = Color.fromRGBO(212, 234, 244, 1.0);
    // use whatsapp colors
    return Scaffold(
      appBar: AppBar(
        title: const Text('Group Chat'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Flexible(
              child: ListView.separated(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.all(12),
                separatorBuilder: (context, index) => const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                ),
                itemCount: 10,
                itemBuilder: (context, index) {
                  return SwipeTo(
                    onRightSwipe: () {},
                    child: ChatBubble(
                      margin: const EdgeInsets.only(top: 5),
                      clipper: ChatBubbleClipper9(
                          type: index.isEven
                              ? BubbleType.sendBubble
                              : BubbleType.receiverBubble),
                      alignment:
                          index.isEven ? Alignment.topLeft : Alignment.topRight,
                      backGroundColor: index.isEven ? userColor : otherColor,
                      child: SizedBox(
                        width: Get.width * 0.7,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            if (index.isEven)
                              const Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  'Estelle Underwood',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            const Flexible(
                              child: Text(
                                "Okay I'll be there in 5 minutes and I'll bring the cake",
                                style: TextStyle(
                                    fontSize: 14, color: Colors.black),
                              ),
                            ),
                            const SizedBox(width: 5),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Text(
                                  '12:00 pm',
                                  style: TextStyle(
                                      fontSize: 10, color: Colors.black54),
                                ),
                                const SizedBox(width: 5),
                                if (index.isOdd)
                                  const Icon(
                                    Icons.done_all,
                                    size: 15,
                                    color: Colors.black54,
                                  ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            TextFormField(
              decoration: InputDecoration(
                // add send icon
                suffixIcon: IconButton(
                  onPressed: () {},
                  tooltip: "Send a message",
                  splashRadius: 20,
                  icon: const Icon(IconlyBroken.send),
                ),
                // add record icon
                prefixIcon: IconButton(
                  onPressed: () {},
                  tooltip: "Record a voice message",
                  splashRadius: 20,
                  icon: const Icon(Ionicons.mic_outline),
                ),
                hintText: 'Type a message',
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
