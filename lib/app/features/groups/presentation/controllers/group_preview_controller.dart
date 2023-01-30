// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:get/get.dart';
import 'package:organizer_client/app/features/groups/domain/entities/group_entity.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;

class GroupPreviewController extends GetxController {
  final GroupEntity groupEntity = Get.arguments['group'];

  Future<String> _getDownloadsDirectory() async {
    final directory = await getApplicationDocumentsDirectory();
    final path = directory.path;
    final groupifyDirectory = Directory('$path/groupify');
    if (!await groupifyDirectory.exists()) {
      await groupifyDirectory.create();
    }
    return groupifyDirectory.path;
  }

  Future<void> exportPdf() async {
    final pdf = pw.Document();
    pdf.addPage(
      pw.Page(
        build: (context) {
          return pw.Container(
            child: pw.Column(
              children: [
                pw.Text("${groupEntity.name} Members"),
                pw.SizedBox(height: 20),
                pw.Table.fromTextArray(data: [
                  ['Full Name', 'Phone Number'],
                  ...groupEntity.members
                      .map((member) => [member.fullName, member.phoneNumber])
                      .toList(),
                ]),
              ],
            ),
          );
        },
      ),
    );
    final path = await _getDownloadsDirectory();
    final file =
        File('$path/${groupEntity.communityName}-${groupEntity.name}.pdf');
    await file.writeAsBytes(await pdf.save());
    Get.snackbar("Exported", "Group data exported to ${file.path}");
  }
}
