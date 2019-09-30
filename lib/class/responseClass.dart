class ResponseClass{
  ResponseClass(this.success, this.message);
  bool success;
  String message;

  factory ResponseClass.fromJson(Map<String, dynamic> json) {
    return ResponseClass(json['success'] as bool,json['message'] as String);
  }
}