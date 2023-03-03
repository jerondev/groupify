// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:external_path/external_path.dart';
import 'package:get/get.dart';
import 'package:organizer_client/app/features/groups/domain/entities/group_entity.dart';
import 'package:organizer_client/shared/ui/snackbars.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:permission_handler/permission_handler.dart';

class GroupPreviewController extends GetxController {
  final GroupEntity groupEntity = Get.arguments['group'];

  Future<String?> _getDownloadsDirectory() async {
    final granted = await requestStoragePermission();
    if (granted) {
      final path = await ExternalPath.getExternalStoragePublicDirectory(
          ExternalPath.DIRECTORY_DOWNLOADS);
      final groupifyDirectory = Directory('$path/groupify');
      if (!await groupifyDirectory.exists()) {
        await groupifyDirectory.create();
      }
      return groupifyDirectory.path;
    } else {
      // get the documents directory
      final path = await ExternalPath.getExternalStoragePublicDirectory(
          ExternalPath.DIRECTORY_DOCUMENTS);
      final groupifyDirectory = Directory('$path/groupify');
      if (!await groupifyDirectory.exists()) {
        await groupifyDirectory.create();
      }
      return groupifyDirectory.path;
    }
  }

  Future<bool> requestStoragePermission() async {
    final status = await Permission.storage.request();
    return (status == PermissionStatus.granted);
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
    if (path == null) {
      showErrorSnackbar(message: "Unable to export group data");
      return;
    }
    final file =
        File('$path/${groupEntity.communityName}-${groupEntity.name}.pdf');
    await file.writeAsBytes(await pdf.save());
    showSuccessSnackbar(message: "Group data exported to ${file.path}");
  }
}
