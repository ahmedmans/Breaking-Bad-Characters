class Quotes {
  late String quotes;

  Quotes.fromJson(Map<String, dynamic> json) {
    quotes = json['quote'];
  }
}
