import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:organizer_client/app/features/groups/presentation/controllers/new_group.controller.dart';

class NewGroupPage extends GetView<NewGroupController> {
  const NewGroupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Group'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: ListView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(14),
          children: [
            Form(
              child: Column(
                children: [
                  TextFormField(
                    maxLength: 8,
                    autofocus: true,
                    validator: (value) {
                      return null;
                    },
                    decoration: const InputDecoration(
                      labelText: "Group Code",
                      helperText: "CSM 257",
                    ),
                  ),
                  const SizedBox(height: 25),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: "Group Name",
                      helperText: "Structured Program Design",
                    ),
                  ),
                  const SizedBox(height: 25),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    maxLength: 4,
                    decoration: const InputDecoration(
                      labelText: "Total People",
                      helperText: "520",
                      counter: SizedBox.shrink(),
                    ),
                  ),
                  const SizedBox(height: 25),
                  // ask the user which grouping criteria they want
                  // Eg. I want to divide the people into groups of 4
                  // Or I want 10 groups and we will take care of the rest
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Grouping Criteria"),
                      ToggleButtons(
                        isSelected: const [false, true],
                        children: const [
                          Text("Group Number"),
                          Text("People Number"),
                        ],
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
