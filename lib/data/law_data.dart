import 'package:equalis/data/profile.dart';

class LawData {
  int lawId = 0;
  String title = "";
  String description = "";
  String lawBody = "";
  String proposedBy = "";
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();
  LawStatus status = LawStatus.pending;
  int votesFor = 0;
  int votesAgainst = 0;
  int totalVotes = 0;
  Duration duration = const Duration(days: 0);
  bool hasUserVoted = false;

  LawData();

  LawData.fromJson(json) {
    lawId = json['id'];
    title = json['title'];
    description = json['description'];
    lawBody = json['law_body'];
    proposedBy = json['proposed_by'];
    startDate = DateTime.parse(json['start_date']);
    endDate = DateTime.parse(json['end_date']);
    status = LawStatus.values[json['status']];
    votesFor = json['votes_for'];
    votesAgainst = json['votes_against'];
    totalVotes = json['total_votes'];
  }

  vote(bool approve) {
    if (approve) {
      votesFor++;
    } else {
      votesAgainst++;
    }

    hasUserVoted = true;
    Profile.vote(lawId, approve ? 1 : 0);
  }
}

enum LawStatus {
  inactive,
  pending,
  active,
  rejected,
  expired,
}