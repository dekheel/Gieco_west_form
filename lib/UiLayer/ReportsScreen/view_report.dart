import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gieco_west/DataLayer/Model/my_report.dart';
import 'package:gieco_west/UiLayer/ReportsScreen/widgets/report_tables.dart';
import 'package:gieco_west/Utils/colors.dart';
import 'package:gieco_west/Utils/const.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart ' as pw;
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

class ViewReport extends StatelessWidget {
  ViewReport({super.key});

  static String routeName = 'ViewReport';
  ScreenshotController screenshotController = ScreenshotController();

  @override
  Widget build(BuildContext context) {
    var arguments = ModalRoute.of(context)?.settings.arguments;
    return Scaffold(
      appBar: AppBar(
          title: const Text('التقارير'),
          backgroundColor: MyColors.whiteColor,
          elevation: 0,
          toolbarHeight: 35.h,
          actions: [
            IconButton(
                icon: const Icon(Icons.share_outlined),
                onPressed: () async {
                  await shareFile();
                })
          ]),
      body: Screenshot(
        controller: screenshotController,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 17.0),
          child: Stack(children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(Const.scaffoldImage),
                  fit: BoxFit.fill,
                  colorFilter: ColorFilter.mode(
                    Colors.white.withOpacity(0.05),
                    BlendMode.dstATop,
                  ),
                ),
              ),
            ),
            ReportTables(
                shiftReport: arguments is ShiftReport ? arguments : null,
                tripReport: arguments is TripReport ? arguments : null)
          ]),
        ),
      ),
    );
  }

  Future<void> shareFile() async {
    await screenshotController
        .capture(
      delay: const Duration(milliseconds: 10),
    )
        .then((capturedImage) async {
      if (capturedImage != null) {
        pw.Document pdf = pw.Document(title: "تقرير");
        final pdfImage = pw.MemoryImage(capturedImage);

        pdf.addPage(pw.Page(
            pageFormat: PdfPageFormat.a4,
            build: (pw.Context context) {
              return pw.Expanded(
                  child: pw.Image(pdfImage, fit: pw.BoxFit.fill));
            }));

        final directory = await getApplicationDocumentsDirectory();
        File pdfFile = await File("${directory.path}/report.pdf").create();

        await pdfFile.writeAsBytes(await pdf.save());
        await Share.shareXFiles([XFile(pdfFile.path)], text: 'تقرير ');
      }
    });
  }
}
