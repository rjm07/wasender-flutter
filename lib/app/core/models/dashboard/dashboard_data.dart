class DashboardDataResponse {
  const DashboardDataResponse({
    required this.messageAction,
    required this.messageCode,
    required this.messageData,
    required this.messageDesc,
    required this.messageId,
  });

  final String messageAction;
  final int messageCode;
  final dynamic messageData;
  final String messageDesc;
  final String messageId;

  factory DashboardDataResponse.fromJson(Map<String, dynamic> json) {
    return DashboardDataResponse(
      messageAction: json["message_action"] as String,
      messageCode: json["message_code"] as int,
      messageData: json["message_data"],
      messageDesc: json["message_desc"] as String,
      messageId: json["message_id"] as String,
    );
  }
}

class DashboardMessageData {
  const DashboardMessageData({
    required this.message,
    required this.success,
  });

  final String? message;
  final bool? success;

  factory DashboardMessageData.fromJson(Map<String, dynamic> json) {
    return DashboardMessageData(
      message: json["message"] as String?,
      success: json["success"] as bool?,
    );
  }
}

class DashboardData {
  const DashboardData({
    required this.perangkatAktif,
    required this.perangkatNonAktif,
    required this.perangkatTerhubung,
  });

  final int? perangkatAktif;
  final int? perangkatNonAktif;
  final dynamic perangkatTerhubung;

  factory DashboardData.fromJson(Map<String, dynamic> json) {
    return DashboardData(
      perangkatAktif: json["perangkat_aktif"] as int?,
      perangkatNonAktif: json["perangkat_non_aktif"] as int?,
      perangkatTerhubung: json["perangkat_terhubung"] as dynamic,
    );
  }
}
