class ApiEndpoints {
  static const baseUrl = 'http://127.0.0.1:8000/api';

  static const register = '$baseUrl/register';
  static const login = '$baseUrl/login';
  static const logout = '$baseUrl/logout';
  static const me = '$baseUrl/me';

  static const publicBooks = '$baseUrl/public-books';
  static const topBooks = '$baseUrl/books/top';
  static const bookByCategory = '$baseUrl/books/category';
  static const bookDetail = '$baseUrl/books'; // /{id}
  static const categories = '$baseUrl/categories';

  static const loans = '$baseUrl/loans';
  static const loanHistory = '$baseUrl/loans/history';
  static const returnLoan = '$baseUrl/loans'; // /{id}/return

  static const profile = '$baseUrl/profile';

  // Review endpoints
  static String reviewsByBook(int bookId) => '$baseUrl/books/$bookId/reviews';
  static String reviewById(int reviewId) => '$baseUrl/reviews/$reviewId';
}
