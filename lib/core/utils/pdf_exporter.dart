import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:permission_handler/permission_handler.dart';
import 'package:printing/printing.dart';

class PdfExporter {
  static Future<void> exportScoreDetailPdf(
      BuildContext context, String type) async {
    // Request storage permission if necessary
    if (await Permission.storage.request().isDenied) {
      // show message
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Storage permission required')));
      return;
    }

    final doc = pw.Document();
    doc.addPage(
      pw.Page(
        build: (pw.Context ctx) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text('Score detail: $type',
                  style: pw.TextStyle(
                      fontSize: 18, fontWeight: pw.FontWeight.bold)),
              pw.SizedBox(height: 12),
              pw.Text('This is a simple export of the current view.'),
            ],
          );
        },
      ),
    );

    // preview/print/save
    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => doc.save(),
    );
  }
}
