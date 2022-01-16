class ElectionData {
  String name = "";
  int id = 0;
  int totalVotes = 0;
  Map<Candidate, int> votes = {};
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();

  ElectionData.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
    totalVotes = json['totalVotes'];
    votes = json['votes'];
    startDate = DateTime.parse(json['startDate']);
    endDate = DateTime.parse(json['endDate']);
  }

  Candidate get winner {
    Candidate winner = votes.keys.first;
    for (Candidate candidate in votes.keys) {
      if (votes[candidate]! > votes[winner]!) {
        winner = candidate;
      }
    }
    return winner;
  }
}

class Candidate {
  final String name = "";
  final String id = "";
}