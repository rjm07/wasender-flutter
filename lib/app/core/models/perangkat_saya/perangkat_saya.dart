class PerangkatSayaData {
  const PerangkatSayaData({
    required this.data,
    required this.message,
    required this.success,
  });

  final List<PerangkatSayaDataList> data;
  final String message;
  final bool success;

  factory PerangkatSayaData.fromJson(Map<String, dynamic> json) {
    return PerangkatSayaData(
      data: (json["data"] as List).map((item) {
        return PerangkatSayaDataList.fromJson(item);
      }).toList(),
      message: json["message"] as String,
      success: json["success"] as bool,
    );
  }
}

class PerangkatSayaDataList {
  const PerangkatSayaDataList({
    required this.id,
    required this.inboxType,
    required this.isActive,
    required this.pKey,
    required this.sessionID,
    required this.whatsappNumber,
  });

  final String id;
  final String? inboxType;
  final bool isActive;
  final String pKey;
  final String sessionID;
  final String whatsappNumber;

  factory PerangkatSayaDataList.fromJson(Map<String, dynamic> json) {
    return PerangkatSayaDataList(
      id: json["id"] as String,
      inboxType: json["inbox_type"] as String?,
      isActive: json["is_active"] as bool,
      pKey: json["pkey"] as String,
      sessionID: json["session_id"] as String,
      whatsappNumber: json["whatsapp_number"] as String,
    );
  }
}
