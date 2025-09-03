import 'dart:convert';
import 'dart:typed_data';

import 'package:bluetooth_print_plus/bluetooth_print_plus.dart';

/// CommandTool
class CommandTool {
  static final tscCommand = TscCommand();
  static final cpclCommand = CpclCommand();
  static final escCommand = EscCommand();

  /// tscSelfTestCmd
  static Future<Uint8List?> tscSelfTestCmd() async {
    await tscCommand.cleanCommand();
    await tscCommand.selfTest();
    final cmd = await tscCommand.getCommand();
    return cmd;
  }

  /// tscImageCmd
  static Future<Uint8List?> tscImageCmd(Uint8List image) async {
    await tscCommand.cleanCommand();
    await tscCommand.size(width: 72, height: 72);
    await tscCommand.cls(); // most after size
    await tscCommand.image(image: image, x: 0, y: 0);
    await tscCommand.print(1);
    final cmd = await tscCommand.getCommand();
    return cmd;
  }

  /// tscTemplateCmd
  static Future<Uint8List?> tscTemplateCmd() async {
    await tscCommand.cleanCommand();
    await tscCommand.size(width: 76, height: 130);
    await tscCommand.cls(); // most after size
    await tscCommand.speed(8);
    await tscCommand.density(8);
    await tscCommand.text(
      content: "莫听穿林打叶声，何妨吟啸且徐行。",
      x: 10,
      y: 10,
    );
    await tscCommand.text(
        content: "竹杖芒鞋轻胜马，谁怕？", x: 10, y: 60, xMulti: 2, yMulti: 2);
    await tscCommand.text(
        content: "一蓑烟雨任平生。", x: 10, y: 170, xMulti: 3, yMulti: 3);
    await tscCommand.qrCode(
      // content: "料峭春风吹酒醒，微冷，山头斜照却相迎。",
        content: "28938928",
        x: 50,
        y: 350,
        cellWidth: 3);
    await tscCommand.qrCode(
      // content: "回首向来萧瑟处，归去，也无风雨也无晴。",
      content: "28938928",
      x: 50,
      y: 500,
    );
    await tscCommand.barCode(
      content: "123456789",
      x: 200,
      y: 350,
    );
    await tscCommand.print(1);
    final cmd = await tscCommand.getCommand();
    return cmd;
  }

  /// cpclImageCmd
  static Future<Uint8List?> cpclImageCmd(Uint8List image) async {
    await cpclCommand.cleanCommand();
    await cpclCommand.size(width: 72 * 8, height: 72 * 8);
    await cpclCommand.image(image: image, x: 0, y: 0);
    await cpclCommand
        .form(); // After printing is complete, locate it at the top of the next page.
    await cpclCommand.print();
    final cmd = await cpclCommand.getCommand();
    return cmd;
  }

  /// cpclTemplateCmd
  // static Future<Uint8List?> cpclTemplateCmd() async {
  //   await cpclCommand.cleanCommand();
  //   await cpclCommand.size(width: 72 * 8, height: 72 * 8);
  //   await cpclCommand.barCode(content: "KP0000000000", x: 10, y: 100, codeType: BarCodeType.c_128);
  //   await cpclCommand.text(content: "KP0000000000", x: 10, y: 300);
  //   await cpclCommand.text(
  //       content: "Serkan", x: 10, y: 330, bold: true, xMulti: 2, yMulti: 2);
  //   await cpclCommand.line(x: 300, y: 100, endX: 360, endY: 500);
  //   await cpclCommand
  //       .form(); // After printing is complete, locate it at the top of the next page.
  //   await cpclCommand.print();
  //   final cmd = await cpclCommand.getCommand();
  //   return cmd;
  // }
  /// escImageCmd
  static Future<Uint8List?> escImageCmd(Uint8List image) async {
    await escCommand.cleanCommand();
    await escCommand.print();
    await escCommand.image(image: image);
    await escCommand.print();
    final cmd = await escCommand.getCommand();
    return cmd;
  }


  static Future<Uint8List> cpclTemplateCmd() async {
  // Zebra ZQ220 CPCL formatı
  String cpcl = """
! 0 200 200 80 1
PAGE-WIDTH 576
BARCODE 128 1 1 50 50 50 KP0000000000
TEXT 4 0 50 150 KP0000000000
TEXT 7 0 50 200 Serkan
LINE 300 100 360 500 2
FORM
PRINT
""";

  // CPCL string → byte array (latin1 daha güvenli)
  Uint8List bytes = Uint8List.fromList(latin1.encode(cpcl));
  return bytes;
  }

  // static Future<Uint8List> cpclTemplateCmd() async {
  // String cpcl = """
  // ! 0 200 200 600 1
  // PAGE-WIDTH 576
  // BARCODE 128 1 1 50 50 50 KP0000000000
  // TEXT 4 0 50 150 KP0000000000
  // TEXT 7 0 50 200 Serkan
  // LINE 300 100 360 500 2
  // FORM
  // PRINT
  // """;
  //   Uint8List bytes = Uint8List.fromList(ascii.encode(cpcl));
  //   return bytes;
  // }



  static Future<Uint8List?> escTemplateCmd() async {
    await escCommand.cleanCommand();
    await escCommand.print(feedLines: 5);
    await escCommand.newline();
    await escCommand.text(content: "hello world");
    await escCommand.newline();
    await escCommand.text(
        content: "hello flutter",
        alignment: Alignment.center,
        style: EscTextStyle.underline,
        fontSize: EscFontSize.size3);
    await escCommand.newline();
    await escCommand.code128(content: "123456");
    await escCommand.newline();
    await escCommand.qrCode(content: "this is qrcode");
    await escCommand.print(feedLines: 5);
    final cmd = await escCommand.getCommand();
    return cmd;
  }
}