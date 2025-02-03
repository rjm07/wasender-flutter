class DashboardAllDeviceResponse {
  const DashboardAllDeviceResponse({
    required this.messageAction,
    required this.messageCode,
    required this.messageData,
    required this.messageDesc,
    required this.messageId,
  });

  final String? messageAction;
  final int? messageCode;
  final dynamic messageData;
  final String? messageDesc;
  final String? messageId;

  factory DashboardAllDeviceResponse.fromJson(Map<String, dynamic> json) {
    return DashboardAllDeviceResponse(
      messageAction: json["message_action"] as String?,
      messageCode: json["message_code"] as int?,
      messageData: json["message_data"],
      messageDesc: json["message_desc"] as String?,
      messageId: json["message_id"] as String?,
    );
  }
}

class DashboardAllDeviceMessageData {
  const DashboardAllDeviceMessageData({
    required this.data,
    required this.message,
    required this.success,
  });
  final DashboardAllDeviceData data;
  final String message;
  final bool success;

  factory DashboardAllDeviceMessageData.fromJson(Map<String, dynamic> json) {
    return DashboardAllDeviceMessageData(
      data: json["data"],
      message: json["message"] as String,
      success: json["success"] as bool,
    );
  }
}

class DashboardAllDeviceData {
  const DashboardAllDeviceData({
    required this.perangkatAktif,
    required this.perangkatNonAktif,
    required this.perangkatTerhubungList,
    required this.totalPerangkat,
  });
  final int? perangkatAktif;
  final int? perangkatNonAktif;
  final List<PerangkatTerhubungData> perangkatTerhubungList;
  final int? totalPerangkat;

  factory DashboardAllDeviceData.fromJson(Map<String, dynamic> json) {
    return DashboardAllDeviceData(
      perangkatAktif: json["perangkat_aktif"],
      perangkatNonAktif: json["perangkat_non_aktif"] as int?,
      perangkatTerhubungList:
          (json['perangkat_terhubung'] as List).map((item) => PerangkatTerhubungData.fromJson(item)).toList(),
      totalPerangkat: json["total_perangkat"] as int?,
    );
  }
}

class PerangkatTerhubungData {
  const PerangkatTerhubungData({
    required this.id,
    required this.inboxType,
    required this.isActive,
    required this.pkey,
    required this.sessionID,
    required this.whatsappNumber,
  });
  final String? id;
  final String? inboxType;
  final bool? isActive;
  final String? pkey;
  final String? sessionID;
  final String? whatsappNumber;

  factory PerangkatTerhubungData.fromJson(Map<String, dynamic> json) {
    return PerangkatTerhubungData(
      id: json["id"] as String?,
      inboxType: json["inbox_type"] as String?,
      isActive: json["is_active"] as bool?,
      pkey: json["pkey"] as String?,
      sessionID: json["session_id"] as String?,
      whatsappNumber: json["whatsapp_number"] as String?,
    );
  }
}
