class Loan {
  final int id;
  final int bookId;
  final String status;
  final DateTime borrowedAt;
  final DateTime? returnedAt;

  Loan({
    required this.id,
    required this.bookId,
    required this.status,
    required this.borrowedAt,
    this.returnedAt,
  });

  factory Loan.fromJson(Map<String, dynamic> json) {
    return Loan(
      id: json['id'],
      bookId: json['book_id'],
      status: json['status'],
      borrowedAt: DateTime.parse(json['borrowed_at']),
      returnedAt: json['returned_at'] != null
          ? DateTime.tryParse(json['returned_at'])
          : null,
    );
  }
}
