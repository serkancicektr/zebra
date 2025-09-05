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
    await tscCommand.text(content: "莫听穿林打叶声，何妨吟啸且徐行。", x: 10, y: 10);
    await tscCommand.text(
      content: "竹杖芒鞋轻胜马，谁怕？",
      x: 10,
      y: 60,
      xMulti: 2,
      yMulti: 2,
    );
    await tscCommand.text(
      content: "一蓑烟雨任平生。",
      x: 10,
      y: 170,
      xMulti: 3,
      yMulti: 3,
    );
    await tscCommand.qrCode(
      // content: "料峭春风吹酒醒，微冷，山头斜照却相迎。",
      content: "28938928",
      x: 50,
      y: 350,
      cellWidth: 3,
    );
    await tscCommand.qrCode(
      // content: "回首向来萧瑟处，归去，也无风雨也无晴。",
      content: "28938928",
      x: 50,
      y: 500,
    );
    await tscCommand.barCode(content: "123456789", x: 200, y: 350);
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

  static yaziBolme({
    required String gondericiAdres,
    required String aliciAdres,
  }) {
    String gondericiAdres1 = gondericiAdres.substring(0, 51);
    String gondericiAdres2 = gondericiAdres.substring(51, 102);
    String gondericiAdres3 = gondericiAdres.substring(102);

    String aliciAdres1 = aliciAdres.substring(0, 51);
    String aliciAdres2 = aliciAdres.substring(51, 102);
    String aliciAdres3 = aliciAdres.substring(102);

    print("Part 1 (ilk 50 karakter): $gondericiAdres1");
    print("Part 2 (geri kalan): $gondericiAdres2");
    print("Part 3 (geri kalan): $gondericiAdres3");
  }

  static String kabul = "GENEL MÜDÜRLÜĞÜ/ANKARA";
  static String kabulZamani = "30/10/2024 - 09:00:00";
  static String posetAparatNo = "W00280185060";
  static String gonderici = "PTT AS GENEL MUDURLUGU";
  static String musteriNo = "902735802";
  static String gondericiAdres1 =
      "HACI BAYRAM MAH. SEHIT TEGMEN KALMAZ CAD. NO:2 ULUS";
  static String gondericiAdres2 = "MAHALLESI";
  static String gondericiAdres3 = "MAHALLESI";
  static String gondericiTel = "0599 911 12 21";
  static String agirilik = "5000GR";
  static String desi = "15 DS";
  static String il = "ANKARA";
  static String ilce = "ALTINDAG";
  static String ua = "165 TL";
  static String dk = "1000 TL";
  static String os = "";
  static String ucret = "1000 TL";
  static String barkod = "KP70007335412";
  static String barkod2 = "70007335412";
  static String alici = "Hasim Ahmet Abdulbaki";
  static String firma = "Bugra Bahadir Nebiogullari";
  static String aliciAdres1 = "AYDINLIKEVLER MAH. EVRELI CAD. NO:52";
  static String aliciAdres2 = "AYDINLIKEVLER MAH. EVRELI CAD. NO:52";
  static String aliciAdres3 = "AYDINLIKEVLER MAH. EVRELI CAD. NO:52";
  static String aliciTel = "0312 509 61 80";
  static String aliciIl = "ANKARA";
  static String aliciIlce = "ALTINDAG";
  static String guzergah = "ANKARA";
  static String mahalle = "AYDINLIKEVLER MAHALLESI";
  static String dagitimYeri = "BASKENT ANKARA KDM";
  static String ozelHizmetler = "DK/OS/UA/KT/1-3";

  static Future<Uint8List> cpclTemplateCmd() async {
    // Zebra ZQ220 CPCL formatı
    yaziBolme(aliciAdres: "kkkkkkk", gondericiAdres: "kkkkkkk");
    String cpcl =
        """
! 0 200 200 639 1
PW 575
TONE 0
SPEED 2
ON-FEED IGNORE
NO-PACE
BAR-SENSE
BOX 1 5 575 596 4
L 1 39 568 39 2
L 1 544 570 544 2
L 3 479 570 479 2
L 3 401 574 401 2
L 482 5 482 403 2
L 3 309 482 309 2
L 3 174 483 174 2
L 23 41 23 151 2
L 22 175 22 310 2
T 0 0 8 14 Kabul: $kabul
T 0 0 309 14 $kabulZamani
T 0 0 225 27 Poset Aparat No  : $posetAparatNo
T 0 2 494 14 PTT A.S
T90 0 0 8 134 GONDERICI
T 0 0 9 156 UA: $ua DK: $dk OS: $os Ucret : $ucret / UA
T 0 0 25 46 GONDERICI : $gonderici (Musteri No: $musteriNo)
T 0 0 27 63 $gondericiAdres1
T 0 0 16 116  $agirilik, $desi
T 0 1 23 134 $ilce/$il   
T 0 0 309 134 TEL: $gondericiTel
T 0 0 27 182 ALICI: $alici
T 0 0 27 201 $firma
T 0 0 284 286 TEL : $aliciTel
T 0 0 27 220 $aliciAdres1
T 7 0 1 280   $aliciIlce/$aliciIl      
T90 0 0 8 260 ALICI
T 0 0 11 411 GUZERGAH: $guzergah
T 0 0 11 427 MAHALLE: $mahalle
T 7 0 11 444 DAGITIM YERI : $dagitimYeri
T 7 0 35 485 Ozel Hizmetler:
T 7 0 35 515 $ozelHizmetler
T 0 0 11 555 Kisisel verileriniz KVKK kapsaminda islenmekte olup 
L 255 479 255 545 2
BT 7 0 0
B 128 1 30 65 73 317 $barkod
BT 7 0 0
B 128 1 30 40 263 491 $barkod2
BT 7 0 0
VB 128 1 30 63 490 357 $barkod
L 2 150 482 150 2
T 0 0 1 568  aydinlatma metni için: PTT is yerleri veya www.ptt.gov.tr
T 0 0 27 82 $gondericiAdres2
T 0 0 27 238 $aliciAdres2
T 0 0 27 256 $aliciAdres3
T 0 0 25 99 $gondericiAdres3
PRINT
""";

    String cpclNew = convertTurkishCharacters(cpcl);

    Uint8List bytes = Uint8List.fromList(latin1.encode(cpclNew));
    return bytes;
  }

  static String convertTurkishCharacters(String input) {
    // Türkçe karakterler ile ASCII/Latin-1 karşılıkları
    Map<String, String> turkishToAscii = {
      'ç': 'c',
      'ı': 'i',
      'ğ': 'g',
      'ş': 's',
      'ü': 'u',
      'ö': 'o',
      'İ': 'I',
      'Ş': 'S',
      'Ç': 'C',
      'Ğ': 'G',
      'Ü': 'U',
      'Ö': 'O',
    };

    // Her Türkçe karakteri karşılıkları ile değiştir
    return input
        .split('')
        .map((char) {
          return turkishToAscii[char] ??
              char; // Eğer karakter harita da varsa, onu al, yoksa olduğu gibi bırak
        })
        .join('');
  }

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
      fontSize: EscFontSize.size3,
    );
    await escCommand.newline();
    await escCommand.code128(content: "123456");
    await escCommand.newline();
    await escCommand.qrCode(content: "this is qrcode");
    await escCommand.print(feedLines: 5);
    final cmd = await escCommand.getCommand();
    return cmd;
  }
}
