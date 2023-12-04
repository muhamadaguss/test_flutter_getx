class ApiPagination<T> {
  final int? currentPage;
  final List<T>? data;
  final String? firstPageUrl;
  final int? from;
  final String? nextPageUrl;
  final String? path;
  final int? perPage;
  final String? prevPageUrl;
  final int? to;

  ApiPagination({
    this.currentPage = 1,
    this.data = const [],
    this.firstPageUrl = '',
    this.from,
    this.nextPageUrl,
    this.path = '',
    this.perPage = 15,
    this.prevPageUrl,
    this.to,
  });

  factory ApiPagination.fromJson(Map<String, dynamic> json, Function(Map<String, dynamic> json)? fromJson) {
    final data = json['data'] != null
        ? (json['data'] as List<dynamic>).map<T>((e) {
            return fromJson?.call(e);
          }).toList()
        : <T>[];

    return ApiPagination(
      currentPage: json['current_page'],
      data: data,
      firstPageUrl: json['first_page_url'],
      from: json['from'],
      nextPageUrl: json['next_page_url'],
      path: json['path'],
      perPage: json['per_page'],
      prevPageUrl: json['prev_page_url'],
      to: json['to'],
    );
  }
}
