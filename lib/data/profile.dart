import 'dart:convert';
import 'dart:io';
import 'package:crypto/crypto.dart';
import 'package:equalis/data/election_data.dart';
import 'package:equalis/data/law_data.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';


class Profile {
  static String firstName = "";
  static String lastName = "";
  static String walletId = "";
  static String address = "";
  static String qrCode = "00000";
  static String passportId = "aflinwaldnaf21";
  static String sin = "12930129";
  static DateTime dob = DateTime.now();
  static bool verified = false;

  static List<ElectionData> elections = [];

  static List<LawData> laws = [
    LawData()
      ..lawId = 1
      ..title = "Lower the voting age"
      ..description = "Lower the voting age to 16 for all elections in Canada"
      ..startDate = DateTime.now()
      ..endDate = DateTime.now().add(const Duration(days: 3))
      ..status = LawStatus.pending
      ..lawBody = 
      """
Canada Elections Act
1 The definition future elector in subsection 2(1) of the Canada Elections Act is replaced by the following:
future elector means a Canadian citizen who is 14 or 15 years of age. (futur électeur)
2 Section 3 of the Act is replaced by the following:
Persons qualified as electors
3 Every person who is a Canadian citizen and is 16 years of age or older on polling day is qualified as an elector.
3 Subsection 22(5) of the Act is repealed.
4 (1) Subparagraph 281.‍3(a)‍(ii) of the Act is replaced by the following:
(ii) is not or will not be 16 years of age or older on polling day; or
(2) Subparagraph 281.‍3(b)‍(ii) of the Act is replaced by the following:
(ii) is not or will not be 16 years of age or older on polling day.
5 Paragraph 384.‍3(3)‍(a) is replaced by the following:
(a) any person who was under 16 years of age on the day on which the event took place;
6 Paragraph 549.‍1(1)‍(b) is replaced by the following:
(b) the elector is or will be 16 years of age or older on polling day;
      """
      ..votesFor = 1000
      ..votesAgainst = 340
      ..totalVotes = 1500,

    LawData()
      ..lawId = 2
      ..title = "Ban School"
      ..description = "Shut down all of the schools in Canada"
      ..startDate = DateTime.now().subtract(const Duration(days: 3))
      ..endDate = DateTime.now().add(const Duration(days: 3))
      ..status = LawStatus.pending
      ..lawBody = 
      """
Canada Schooling Act
1 The definition future elector in subsection 2(1) of the Canada Elections Act is replaced by the following:
future elector means a Canadian citizen who is 14 or 15 years of age. (futur électeur)
2 Section 3 of the Act is replaced by the following:
Persons qualified as electors
3 Every person who is a Canadian citizen and is 16 years of age or older on polling day is qualified as an elector.
3 Subsection 22(5) of the Act is repealed.
4 (1) Subparagraph 281.‍3(a)‍(ii) of the Act is replaced by the following:
(ii) is not or will not be 16 years of age or older on polling day; or
(2) Subparagraph 281.‍3(b)‍(ii) of the Act is replaced by the following:
(ii) is not or will not be 16 years of age or older on polling day.
5 Paragraph 384.‍3(3)‍(a) is replaced by the following:
(a) any person who was under 16 years of age on the day on which the event took place;
6 Paragraph 549.‍1(1)‍(b) is replaced by the following:
(b) the elector is or will be 16 years of age or older on polling day;
      """
      ..votesFor = 100
      ..votesAgainst = 3400
      ..totalVotes = 4000,
    
    LawData()
      ..lawId = 3
      ..title = "Make University Free"
      ..description = "Make all universitiies publically funded"
      ..startDate = DateTime.now().subtract(const Duration(days: 3))
      ..endDate = DateTime.now().add(const Duration(days: 3))
      ..status = LawStatus.active
      ..lawBody = 
      """
Canada Schooling Act
1 The definition future elector in subsection 2(1) of the Canada Elections Act is replaced by the following:
future elector means a Canadian citizen who is 14 or 15 years of age. (futur électeur)
2 Section 3 of the Act is replaced by the following:
Persons qualified as electors
3 Every person who is a Canadian citizen and is 16 years of age or older on polling day is qualified as an elector.
3 Subsection 22(5) of the Act is repealed.
4 (1) Subparagraph 281.‍3(a)‍(ii) of the Act is replaced by the following:
(ii) is not or will not be 16 years of age or older on polling day; or
(2) Subparagraph 281.‍3(b)‍(ii) of the Act is replaced by the following:
(ii) is not or will not be 16 years of age or older on polling day.
5 Paragraph 384.‍3(3)‍(a) is replaced by the following:
(a) any person who was under 16 years of age on the day on which the event took place;
6 Paragraph 549.‍1(1)‍(b) is replaced by the following:
(b) the elector is or will be 16 years of age or older on polling day;
      """
      ..votesFor = 10000
      ..votesAgainst = 100
      ..totalVotes = 11111
  ];

  static String get identityHash
    => sha256.convert(utf8.encode(sin + qrCode + passportId)).toString();

  static List<String> timeHash() {
    DateTime now = DateTime.now();
    String utc = now.toUtc().millisecondsSinceEpoch.toString();
    String timehash = sha256.convert(utf8.encode(utc + qrCode + passportId + sin)).toString();
    return [utc, timehash];
  }
  
  static vote(int electionId, int candidateId) async {
    List<String> _timeHash = timeHash();

    await http.post(
      Uri.parse('https://Equalis-API-1.con266667.repl.co/vote'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'uuid': identityHash,
        'utcMSE': _timeHash[0],
        'hash': _timeHash[1],
        'electionId': electionId.toString(),
        'candidateId': candidateId.toString(),
      }),
    );
  }

  static Future<bool> hasVoted(int id) async {
    List<String> _timeHash = timeHash();

    final response = await http.post(
      Uri.parse('https://Equalis-API-1.con266667.repl.co/hasVoted'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'uuid': identityHash,
        'utcMSE': _timeHash[0],
        'hash': _timeHash[1],
        'electionId': id.toString(),
      }),
    );

    return bool.fromEnvironment(jsonDecode(response.body)['hasVoted']);
  }

  static init() async {
    await getLaws();
  }

  static storeInfo() async {
    final storage = new FlutterSecureStorage();
    await storage.write(key: 'passport_id', value: passportId);
    await storage.write(key: 'sin', value: sin);
    await storage.write(key: 'qr_code', value: qrCode);
  }

  static clear() {
    final storage = new FlutterSecureStorage();
    storage.deleteAll();
  }

  static Future<bool> checkAlreadyVerified() async {
    // clear();
    if (verified) return true;
    final storage = new FlutterSecureStorage();
    passportId = await storage.read(key: 'passport_id') ?? "";
    sin = await storage.read(key: 'sin') ?? "";
    qrCode = await storage.read(key: 'qr_code') ?? "";
    return getUserData();
  }

  static getLaws() async {
    final response = await http.get(Uri.parse('https://Equalis-API-1.con266667.repl.co/getLaws'));
    print(response.body);
    final json = jsonDecode(response.body);
    laws = json['laws'].map((law) => LawData.fromJson(law)).toList();
  }
  
  static Future<bool> getUserData() async {
    List<String> _timeHash = timeHash();

    final response = await http.post(
      Uri.parse('https://Equalis-API-1.con266667.repl.co/getUser'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'uuid': identityHash,
        'utcMSE': _timeHash[0],
        'hash': _timeHash[1],
      }),
    );

    Map<String, dynamic> data;
    try {
      data = jsonDecode(response.body);
    } catch (_) {
      return false;
    }

    if (data.containsKey('first')) {
      firstName = data['first'] ?? "";
      lastName = data['last'] ?? "";
      address = data['address'] ?? "";
      storeInfo();
      verified = true;
      return true;
    } else {
      return false;
    }
  }

  static getElectionStatus(id) async {
    final response = await http.post(
      Uri.parse('https://Equalis-API-1.con266667.repl.co/electionstatus'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'id': id,
      }),
    );
  }

  static getElections() async {
    final response = await http.get(
      Uri.parse('https://Equalis-API-1.con266667.repl.co/getElections'),
    );

    elections = jsonDecode(response.body).map((election) => ElectionData.fromJson(election)).toList();
  }
}

class IDVerification {
  List<String> methods = [
    "Passport",
    "SIN",
    "Birth Certificate",
    "Health Card",
    "Driver's License",
    "Ontario Photo Card"
  ];
}