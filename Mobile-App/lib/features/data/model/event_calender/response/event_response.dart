class PostEventResponse {
  final int? status;
  final String message;

  PostEventResponse({
    this.status,
    required this.message,
  });

  factory PostEventResponse.fromJson(Map<String, dynamic> json) => PostEventResponse(
        message: json['message'],
        status: json['status'],
      );
}

