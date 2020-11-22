class SheetResponse {
  String spreadsheetId;
  String spreadsheetUrl;

  SheetResponse({this.spreadsheetId, this.spreadsheetUrl});

  SheetResponse.fromJson(Map<String, dynamic> json) {
    spreadsheetId = json['spreadsheetId'];

    spreadsheetUrl = json['spreadsheetUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['spreadsheetId'] = this.spreadsheetId;
    data['spreadsheetUrl'] = this.spreadsheetUrl;
    return data;
  }
}
