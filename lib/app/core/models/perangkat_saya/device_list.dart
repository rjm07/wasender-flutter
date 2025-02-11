class DeviceResponse {
  final String messageAction;
  final AllMessageData messageData;
  final String messageDesc;
  final String messageId;
  final int statusCode;

  DeviceResponse({
    required this.messageAction,
    required this.messageData,
    required this.messageDesc,
    required this.messageId,
    required this.statusCode,
  });

  factory DeviceResponse.fromJson(Map<String, dynamic> json) {
    return DeviceResponse(
      messageAction: json['message_action'],
      messageData: AllMessageData.fromJson(json['message_data']),
      messageDesc: json['message_desc'],
      messageId: json['message_id'],
      statusCode: json['status_code'],
    );
  }
}

class AllMessageData {
  final AllDeviceData data;
  final String message;
  final bool success;

  AllMessageData({
    required this.data,
    required this.message,
    required this.success,
  });

  factory AllMessageData.fromJson(Map<String, dynamic> json) {
    return AllMessageData(
      data: AllDeviceData.fromJson(json['data']),
      message: json['message'],
      success: json['success'],
    );
  }
}

class AllDeviceData {
  final int perangkatAktif;
  final int perangkatNonAktif;
  final List<Device> perangkatTerhubung;
  final int totalPerangkat;

  AllDeviceData({
    required this.perangkatAktif,
    required this.perangkatNonAktif,
    required this.perangkatTerhubung,
    required this.totalPerangkat,
  });

  factory AllDeviceData.fromJson(Map<String, dynamic> json) {
    return AllDeviceData(
      perangkatAktif: json['perangkat_aktif'],
      perangkatNonAktif: json['perangkat_non_aktif'],
      perangkatTerhubung: (json['perangkat_terhubung'] as List).map((e) => Device.fromJson(e)).toList(),
      totalPerangkat: json['total_perangkat'],
    );
  }
}

class Device {
  final String id;
  final String inboxType;
  final bool isActive;
  final String pkey;
  final String sessionId;
  final String whatsappNumber;

  Device({
    required this.id,
    required this.inboxType,
    required this.isActive,
    required this.pkey,
    required this.sessionId,
    required this.whatsappNumber,
  });

  factory Device.fromJson(Map<String, dynamic> json) {
    return Device(
      id: json['id'],
      inboxType: json['inbox_type'],
      isActive: json['is_active'],
      pkey: json['pkey'],
      sessionId: json['session_id'],
      whatsappNumber: json['whatsapp_number'],
    );
  }
}
