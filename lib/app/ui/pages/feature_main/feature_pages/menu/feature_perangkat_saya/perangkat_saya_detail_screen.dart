import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../../core/services/perangkat_saya/perangkat_saya.dart';
import '../../../../../../core/services/preferences.dart';
import '../../../../../shared/widgets/custom_textfield.dart';

class PerangkatSayaDetailScreen extends StatefulWidget {
  const PerangkatSayaDetailScreen({super.key, required this.whatsappNumber});

  final String whatsappNumber;

  @override
  State<PerangkatSayaDetailScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<PerangkatSayaDetailScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  late TextEditingController idPerangkatController;
  late TextEditingController namaPerangkatController;
  late TextEditingController nomorWhatsappController;
  late TextEditingController ipTerpercayaController;
  late TextEditingController webHookURLInboundController;
  late TextEditingController apiKeysTokenController;
  late TextEditingController trackingURLController;
  late TextEditingController webHookPerangkatController;
  late TextEditingController tipeSambutanController;
  late TextEditingController teksPesanSambutanController;
  late TextEditingController teksPesanAkhirController;
  late TextEditingController kecepatanPengirimanPesanController;
  late TextEditingController batasPesanController;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getDeviceInfo();
    });

    idPerangkatController = TextEditingController();
    namaPerangkatController = TextEditingController();
    nomorWhatsappController = TextEditingController();
    ipTerpercayaController = TextEditingController();
    webHookURLInboundController = TextEditingController();
    apiKeysTokenController = TextEditingController();
    trackingURLController = TextEditingController();
    webHookPerangkatController = TextEditingController();
    tipeSambutanController = TextEditingController();
    teksPesanSambutanController = TextEditingController();
    teksPesanAkhirController = TextEditingController();
    kecepatanPengirimanPesanController = TextEditingController();
    batasPesanController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    idPerangkatController.dispose();
    namaPerangkatController.dispose();
    nomorWhatsappController.dispose();
    ipTerpercayaController.dispose();
    webHookURLInboundController.dispose();
    apiKeysTokenController.dispose();
    trackingURLController.dispose();
    webHookPerangkatController.dispose();
    tipeSambutanController.dispose();
    teksPesanSambutanController.dispose();
    teksPesanAkhirController.dispose();
    kecepatanPengirimanPesanController.dispose();
    batasPesanController.dispose();
  }

  Future<void> getDeviceInfo() async {
    final PerangkatSayaServices devices = Provider.of<PerangkatSayaServices>(context, listen: false);
    final String? tokenBearer = await LocalPrefs.getBearerToken();
    debugPrint("tokenBearer: $tokenBearer");
    if (tokenBearer != null) {
      try {
        final deviceInfoResponse = await devices.getDeviceInfo(
          tokenBearer,
          widget.whatsappNumber,
          (message) => ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(message),
              backgroundColor: Colors.red,
              duration: const Duration(seconds: 3),
            ),
          ),
        );

        // Change this when real data is available
        setState(() {
          idPerangkatController.text = deviceInfoResponse.messageData?.data?.sessionID ?? '';
          namaPerangkatController.text = deviceInfoResponse.messageData?.data?.routingKey ?? '';
          nomorWhatsappController.text = deviceInfoResponse.messageData?.data?.sessionInit ?? '';
          ipTerpercayaController.text = deviceInfoResponse.messageDesc;
          webHookURLInboundController.text = deviceInfoResponse.messageData?.message ?? '';
          apiKeysTokenController.text = deviceInfoResponse.messageData?.data?.sessionID ?? '';
          trackingURLController.text = deviceInfoResponse.messageId;
          webHookPerangkatController.text = deviceInfoResponse.messageData?.message ?? '';
          tipeSambutanController.text = deviceInfoResponse.messageData!.data!.data!.isOn.toString();
          teksPesanSambutanController.text = deviceInfoResponse.messageData?.message ?? '';
          teksPesanAkhirController.text = deviceInfoResponse.messageDesc;
          kecepatanPengirimanPesanController.text = deviceInfoResponse.messageData?.data?.data?.sessionId ?? '';
          batasPesanController.text = deviceInfoResponse.statusCode.toString();
        });
      } catch (error) {
        debugPrint("Error fetching device info: $error");
        // You can show an error message here if needed.
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(''), actions: const [
        Spacer(),
        Padding(
          padding: EdgeInsets.only(right: 44.0),
          child: Text(
            '',
            style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w200, color: Colors.black87),
          ),
        ),
      ]),
      body: Form(
        key: formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Container(
          width: double.infinity,
          alignment: Alignment.topCenter,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 24.0),
              child: SizedBox(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Form Detail Perangkat',
                            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'Informasi dan pengaturan perangkat',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 24.0, right: 24.0, top: 12.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          WidgetWithOutlineTextField(
                            label: 'ID Perangkat',
                            controller: idPerangkatController,
                            textAlign: TextAlign.left,
                            textInputType: TextInputType.text,
                            description: 'Informasi ID Perangkat.',
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          WidgetWithOutlineTextField(
                            label: 'Nama Perangkat',
                            controller: namaPerangkatController,
                            textAlign: TextAlign.left,
                            textInputType: TextInputType.text,
                            description: 'Informasi nama perangkat.',
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          WidgetWithOutlineTextField(
                            label: 'Nomor Whatsapp',
                            controller: nomorWhatsappController,
                            textAlign: TextAlign.left,
                            textInputType: TextInputType.text,
                            description: 'Informasi nama perangkat.',
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          WidgetWithOutlineTextField(
                            label: 'IP Terpercaya',
                            controller: ipTerpercayaController,
                            textAlign: TextAlign.left,
                            textInputType: TextInputType.text,
                            description: 'Informasi list ip yang terpercaya.',
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          WidgetWithOutlineTextField(
                            label: 'Webhook url Inbound',
                            controller: webHookURLInboundController,
                            textAlign: TextAlign.left,
                            textInputType: TextInputType.text,
                            description: 'Alamat url untuk pengiriman pesan masuk baru dari WhatsApp',
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          WidgetWithOutlineTextField(
                            label: 'API Keys / Token',
                            controller: apiKeysTokenController,
                            textAlign: TextAlign.left,
                            textInputType: TextInputType.text,
                            description: 'Informasi token untuk integrasi',
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          WidgetWithOutlineTextField(
                            label: 'Tracking URL',
                            controller: trackingURLController,
                            textAlign: TextAlign.left,
                            textInputType: TextInputType.text,
                            description: 'Alamat url untuk status pesan baru dari WhatsApp',
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          WidgetWithOutlineTextField(
                            label: 'Webhook Perangkat',
                            controller: webHookPerangkatController,
                            textAlign: TextAlign.left,
                            textInputType: TextInputType.text,
                            description: 'Untuk Menerima Status Perangkat, misalnya saat perangkat terputus',
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          WidgetWithOutlineTextField(
                            label: 'Tipe Sambutan',
                            controller: tipeSambutanController,
                            textAlign: TextAlign.left,
                            textInputType: TextInputType.text,
                            description: 'Pesan sambutan yang dikirim automatis ketika ada pesan masuk.',
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          WidgetWithOutlineTextField(
                            label: 'Teks Pesan Sambutan',
                            controller: teksPesanSambutanController,
                            textAlign: TextAlign.left,
                            textInputType: TextInputType.text,
                            description: 'Pesan sambutan (Pesan ini akan dikirim diawal)',
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          WidgetWithOutlineTextField(
                            label: 'Teks Pesan Akhir',
                            controller: teksPesanAkhirController,
                            textAlign: TextAlign.left,
                            textInputType: TextInputType.text,
                            description: 'Pesan akhir (Pesan ini akan dikirim diakhir)',
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          WidgetWithOutlineTextField(
                            label: 'Kecepatan Pengiriman Pesan',
                            controller: kecepatanPengirimanPesanController,
                            textAlign: TextAlign.left,
                            textInputType: TextInputType.text,
                            description:
                                'Tunda setiap pengiriman 5 Pesan per detik dengan min:\n 15 detik dan Maks: 120 detik',
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          WidgetWithOutlineTextField(
                            label: 'Batas Pesan',
                            controller: batasPesanController,
                            textAlign: TextAlign.left,
                            textInputType: TextInputType.text,
                            description: 'Batas pengiriman pesan dalam 1 waktu pengiriman. min 1 dan maks 5',
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
