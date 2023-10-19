/*
 * Copyright (C) 2017, David PHAM-VAN <dev.nfet.net@gmail.com>
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import 'dart:async';
import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/services.dart' show rootBundle;
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import '../data.dart';

const PdfColor green = PdfColor.fromInt(0xff9ce5d0);
const PdfColor lightGreen = PdfColor.fromInt(0xffcdf1e7);
const sep = 120.0;

Future<Uint8List> generateResume(PdfPageFormat format, CustomData data) async {
  final doc = pw.Document(title: 'My Résumé', author: 'David PHAM-VAN');

  final profileImage = pw.MemoryImage(
    (await rootBundle.load('assets/profile.jpg')).buffer.asUint8List(),
  );

  final pageTheme = await _myPageTheme(format);

  doc.addPage(
    pw.MultiPage(
      pageTheme: pageTheme,
      build: (pw.Context context) => [
        pw.Partitions(
          children: [
            pw.Partition(
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: <pw.Widget>[
                  pw.Container(
                    padding: const pw.EdgeInsets.only(left: 30, bottom: 20),
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: <pw.Widget>[
                        pw.Text('Delhi',
                            textScaleFactor: 2,
                            style: pw.Theme.of(context)
                                .defaultTextStyle
                                .copyWith(fontWeight: pw.FontWeight.bold)),
                        // pw.Padding(padding: const pw.EdgeInsets.only(top: 10)),
                        pw.Text('India',
                            textScaleFactor: 1.2,
                            style: pw.Theme.of(context)
                                .defaultTextStyle
                                .copyWith(
                                    fontWeight: pw.FontWeight.bold,
                                    color: green)),
                        pw.Padding(padding: const pw.EdgeInsets.only(top: 20)),
                        pw.Row(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                          children: <pw.Widget>[
                            pw.Column(
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              children: <pw.Widget>[
                                pw.Text('Travleogue.in'),
                                // pw.Text('Nordegg, AB T0M 2H0'),
                                // pw.Text('Canada, ON'),
                              ],
                            ),
                            pw.Column(
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              children: <pw.Widget>[
                                pw.Text('+91 9004137508'),
                                _UrlText(
                                    'travelogue.in', 'mailto:travelogue.in'),
                                // _UrlText(
                                //     'wholeprices.ca', 'https://wholeprices.ca'),
                              ],
                            ),
                            pw.Padding(padding: pw.EdgeInsets.zero)
                          ],
                        ),
                      ],
                    ),
                  ),
                  _Category(title: 'Travel Itinerary'),
                  _Block(
                      title: 'Day 1: Mumbai to Delhi (flight)',
                      icon: const pw.IconData(0xe530),
                      detail:
                          "Arrive in Delhi in the morning\nCheck-in at your hotel and freshen up\nVisit the Lotus Temple in the afternoon\nTime Stamps\n • Flight from Mumbai to Delhi (Morning)\n • Check-in at hotel (Afternoon)\n • Visit Lotus Temple (Late Afternoon/Evening)"),
                  _Block(
                      title: 'Day 2: Old Delhi Tour',
                      icon: const pw.IconData(0xe30d),
                      detail:
                          "Visit the Red Fort and Jama Masjid\nTake a rickshaw ride in the Chandni Chowk area\nExplore the spice market and enjoy street food\nTake a rickshaw ride in the Chandni Chowk area in the evening\nTime stamps:\n • Red Fort and Jama Masjid (Morning)\n • Spice Market and Street Food (Afternoon)\n • Chandni Chowk Rickshaw Ride (Evening)"),
                  _Block(
                      title: 'Day 3: Delhi Sightseeing',
                      icon: const pw.IconData(0xe30d),
                      detail:
                          "Visit Humayun's Tomb and Qutub Minar in the morning\nGo shopping in the nearby markets in the afternoon\nTime stamps:\n • Humayun's Tomb and Qutub Minar (Morning)\n • Market Visit (Afternoon)"),
                  _Block(
                      title: 'Day 4: Delhi City Tour',
                      icon: const pw.IconData(0xe30d),
                      detail:
                          "Visit the India Gate and Rajpath in the morning\nExplore the Rashtrapati Bhavan and Parliament House\n Visit the National Museum in the afternoon\nTime stamps:\n • India Gate and Rajpath (Morning)\n • Rashtrapati Bhavan and Parliament House (Afternoon)\n • National Museum (Late Afternoon)"),
                  _Block(
                      title: 'Day 5: Akshardham and Light Show',
                      icon: const pw.IconData(0xe30d),
                      detail:
                          "Visit the Akshardham Temple in the morning\nWatch a light and sound show in the evening\nTime stamps:\n • Akshardham Temple (Morning)\n • Light and Sound Show (Evening)"),
                  pw.SizedBox(height: 20),
                  _Category(title: 'Hotels'),
                  _Block(
                      title: 'Day 1: Mumbai - Delhi',
                      detail: "Hotel in Delhi: The Imperial New Delhi"),
                  _Block(
                      title: 'Day 2: Delhi',
                      detail: "Hotel in Delhi: The Imperial New Delhi"),
                  _Block(
                      title: 'Day 3: Delhi - Agra',
                      detail: "Hotel in Agra: The Oberoi Amarvilas, Agra"),
                  _Block(
                      title: 'Day 4: Agra - Jaipur',
                      detail: "Hotel in Jaipur: Rambagh Palace, Jaipur"),
                  _Block(
                      title: 'Day 5: Jaipur',
                      detail: "Hotel in Jaipur: Rambagh Palace, Jaipur"),
                  pw.Padding(padding: const pw.EdgeInsets.only(top: 20)),
                  pw.Text(
                      "These are just a few options, and there are many other hotels and guesthouses available in these cities to suit different budgets and preferences. Make sure to do some research and book in advance to ensure availability and the best rates.")
                ],
              ),
            ),
            pw.Partition(
              width: sep,
              child: pw.Column(
                children: [
                  pw.Container(
                    height: pageTheme.pageFormat.availableHeight,
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.center,
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: <pw.Widget>[
                        pw.ClipRRect(
                          child: pw.Container(
                            width: 100,
                            height: 100,
                            decoration: pw.BoxDecoration(
                              shape: pw.BoxShape.circle,
                              color: lightGreen,
                            ),
                            child: pw.Image(profileImage),
                          ),
                        ),
                        // pw.Column(children: <pw.Widget>[
                        //   _Percent(size: 60, value: .7, title: pw.Text('Word')),
                        //   _Percent(
                        //       size: 60, value: .4, title: pw.Text('Excel')),
                        // ]),
                        // pw.BarcodeWidget(
                        //   data: 'Parnella Charlesbois',
                        //   width: 60,
                        //   height: 60,
                        //   barcode: pw.Barcode.qrCode(),
                        //   drawText: false,
                        // ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ],
    ),
  );
  return doc.save();
}

Future<pw.PageTheme> _myPageTheme(PdfPageFormat format) async {
  final bgShape = await rootBundle.loadString('assets/resume.svg');

  format = format.applyMargin(
      left: 2.0 * PdfPageFormat.cm,
      top: 4.0 * PdfPageFormat.cm,
      right: 2.0 * PdfPageFormat.cm,
      bottom: 2.0 * PdfPageFormat.cm);
  return pw.PageTheme(
    pageFormat: format,
    theme: pw.ThemeData.withFont(
      base: await PdfGoogleFonts.openSansRegular(),
      bold: await PdfGoogleFonts.openSansBold(),
      icons: await PdfGoogleFonts.materialIcons(),
    ),
    buildBackground: (pw.Context context) {
      return pw.FullPage(
        ignoreMargins: true,
        child: pw.Stack(
          children: [
            pw.Positioned(
              child: pw.SvgImage(svg: bgShape),
              left: 0,
              top: 0,
            ),
            pw.Positioned(
              child: pw.Transform.rotate(
                  angle: pi, child: pw.SvgImage(svg: bgShape)),
              right: 0,
              bottom: 0,
            ),
          ],
        ),
      );
    },
  );
}

class _Block extends pw.StatelessWidget {
  _Block({required this.title, this.icon, this.detail});

  final String title;
  final String? detail;

  final pw.IconData? icon;

  @override
  pw.Widget build(pw.Context context) {
    return pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: <pw.Widget>[
          pw.Row(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: <pw.Widget>[
                pw.Container(
                  width: 6,
                  height: 6,
                  margin: const pw.EdgeInsets.only(top: 5.5, left: 2, right: 5),
                  decoration: const pw.BoxDecoration(
                    color: green,
                    shape: pw.BoxShape.circle,
                  ),
                ),
                pw.Text(title,
                    style: pw.Theme.of(context)
                        .defaultTextStyle
                        .copyWith(fontWeight: pw.FontWeight.bold)),
                pw.Spacer(),
                if (icon != null) pw.Icon(icon!, color: lightGreen, size: 18),
              ]),
          pw.Container(
            decoration: const pw.BoxDecoration(
                border: pw.Border(left: pw.BorderSide(color: green, width: 2))),
            padding: const pw.EdgeInsets.only(left: 10, top: 5, bottom: 5),
            margin: const pw.EdgeInsets.only(left: 5),
            child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: <pw.Widget>[
                  pw.Text(detail!)
                  // pw.Lorem(length: 20),
                ]),
          ),
        ]);
  }
}

class _Category extends pw.StatelessWidget {
  _Category({required this.title});

  final String title;

  @override
  pw.Widget build(pw.Context context) {
    return pw.Container(
      decoration: const pw.BoxDecoration(
        color: lightGreen,
        borderRadius: pw.BorderRadius.all(pw.Radius.circular(6)),
      ),
      margin: const pw.EdgeInsets.only(bottom: 10, top: 20),
      padding: const pw.EdgeInsets.fromLTRB(10, 4, 10, 4),
      child: pw.Text(
        title,
        textScaleFactor: 1.5,
      ),
    );
  }
}

class _Percent extends pw.StatelessWidget {
  _Percent({
    required this.size,
    required this.value,
    required this.title,
  });

  final double size;

  final double value;

  final pw.Widget title;

  static const fontSize = 1.2;

  PdfColor get color => green;

  static const backgroundColor = PdfColors.grey300;

  static const strokeWidth = 5.0;

  @override
  pw.Widget build(pw.Context context) {
    final widgets = <pw.Widget>[
      pw.Container(
        width: size,
        height: size,
        child: pw.Stack(
          alignment: pw.Alignment.center,
          fit: pw.StackFit.expand,
          children: <pw.Widget>[
            pw.Center(
              child: pw.Text(
                '${(value * 100).round().toInt()}%',
                textScaleFactor: fontSize,
              ),
            ),
            pw.CircularProgressIndicator(
              value: value,
              backgroundColor: backgroundColor,
              color: color,
              strokeWidth: strokeWidth,
            ),
          ],
        ),
      )
    ];

    widgets.add(title);

    return pw.Column(children: widgets);
  }
}

class _UrlText extends pw.StatelessWidget {
  _UrlText(this.text, this.url);

  final String text;
  final String url;

  @override
  pw.Widget build(pw.Context context) {
    return pw.UrlLink(
      destination: url,
      child: pw.Text(text,
          style: const pw.TextStyle(
            decoration: pw.TextDecoration.underline,
            color: PdfColors.blue,
          )),
    );
  }
}
