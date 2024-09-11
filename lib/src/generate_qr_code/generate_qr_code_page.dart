import 'package:app/data/models/qr_data_model.dart';
import 'package:app/data/providers/qr_data_provider.dart';
import 'package:app/src/generate_qr_code/email_qr_code.dart';
import 'package:app/src/generate_qr_code/generate_form_types/business_qr_code.dart';
import 'package:app/src/generate_qr_code/generate_form_types/event_qr_code.dart';
import 'package:app/src/generate_qr_code/generate_form_types/instgram-qr-code.dart';
import 'package:app/src/generate_qr_code/generate_form_types/location-qr-code.dart';
import 'package:app/src/generate_qr_code/generate_form_types/phone-number-qr-code.dart';
import 'package:app/src/generate_qr_code/generate_form_types/twitter_x_qr_code.dart';
import 'package:app/src/generate_qr_code/generate_form_types/whatsapp_qr_code.dart';
import 'package:app/src/generate_qr_code/generate_form_types/wifi_qr_code.dart';
import 'package:app/common_lib.dart';
import 'package:app/utils/components/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:uuid/uuid.dart';

import '../../data/models/qr_type_enum.dart';
import '../../utils/components/custom_scaffold.dart';
import 'generate_form_types/generate_contact_qr_code.dart';
import 'generate_form_types/text_and_internet_qr_code.dart';

//This is keept here not inside cuz when it's inside the build it keeps rebuild and thus keeping it empty
String qrData = '';

class GenerateQrCodePage extends HookConsumerWidget {
  const GenerateQrCodePage({super.key, required this.type});
  final QRType type;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    FocusNode focusNode = FocusNode();
    final formKey = useMemoized(() => GlobalKey<FormState>());
    Widget getForm() {
      switch (type) {
        case QRType.text:
          return GenerateTextQRCode(
            onChange: (value) => qrData = value,
          );
        case QRType.website:
          return GenerateInternetQRCode(
            onChange: (value) => qrData = value,
          );
        case QRType.network:
          return GenerateWifiQRCode(
            onChange: (value) => qrData = value,
          );
        case QRType.event:
          return GenerateEventQRCode(
            onChange: (value) => qrData = value,
          );
        case QRType.contact:
          return GenerateContactQRCode(
            type: type,
            onChange: (value) => qrData = value,
          );
        case QRType.business:
          return GenerateBusinessQRCode(
            type: type,
            onChange: (value) => qrData = value,
          );
        case QRType.whatsApp:
          return GenerateWhatsAppQRCode(
            type: type,
            onChange: (value) => qrData = value,
          );
        case QRType.twitter:
          return GenerateTwitterORXQRCode(
            type: type,
            onChange: (value) => qrData = value,
          );
        case QRType.email:
          return GenerateEmailORXQRCode(
            type: type,
            onChange: (value) => qrData = value,
          );
        case QRType.instagram:
          return GenerateInstagramQRCode(
            type: type,
            onChange: (value) => qrData = value,
          );
        case QRType.phoneNumber:
          return GeneratePhoneNumberQRCode(
            type: type,
            onChange: (value) => qrData = value,
          );

        case QRType.location:
          return GenerateLocationQRCode(
            type: type,
            onChange: (value) => qrData = value,
          );
        default:
          return Container();
      }
    }

    return CustomScaffold(
      body: FormBody(formKey: formKey, children: [
        CustomAppBar(title: type.toTitleString()),
        const Gap(Insets.extraLarge),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: 350,
            padding: const EdgeInsets.symmetric(
              vertical: 2,
            ),
            decoration: const BoxDecoration(
              color: Color(0xFFFDB623),
              borderRadius: BorderSize.extraSmallRadius,
            ),
            child: Container(
              padding: Insets.extraSmallAll,
              decoration: const BoxDecoration(
                color: Color(0xFF3B3B3B),
                borderRadius: BorderSize.extraSmallRadius,
              ),
              child: Column(
                children: [
                  const Gap(Insets.extraLarge),
                  type == QRType.location
                      ? Image.asset(
                          type.iconPath,
                          height: 100,
                        )
                      : SvgPicture.asset(type.iconPath),
                  const Gap(Insets.extraLarge),
                  getForm(),
                  const Gap(Insets.extraLarge),
                  Container(
                    decoration: const BoxDecoration(boxShadow: [
                      BoxShadow(color: Colors.black, blurRadius: 10, spreadRadius: -2)
                    ]),
                    child: ElevatedButton(
                      onPressed: () async {
                        focusNode.unfocus();
                        if (formKey.currentState?.validate() ?? false) {
                          final qrImage = PrettyQrView.data(
                            data: qrData,
                            decoration: const PrettyQrDecoration(),
                          );
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              backgroundColor: Colors.white,
                              content: qrImage,
                              actions: [
                                IconButton(
                                    onPressed: () {}, icon: const Icon(Icons.save)),
                                IconButton(onPressed: () {}, icon: const Icon(Icons.save))
                              ],
                            ),
                          );
                        }
                        print(type.name);

                        ref.read(addQRDataProvider.notifier).addQRdata(QrDataModel(
                            id: const Uuid().v4(),
                            data: qrData,
                            date: DateTime.now(),
                            type: type.name));
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFDB623),
                        foregroundColor: const Color(0xFF333333),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderSize.extraSmallRadius,
                        ),
                      ),
                      child: const Text('Generate QR Code'),
                    ),
                  ),
                  const Gap(Insets.large),
                ],
              ),
            ),
          ),
        ),
        const Gap(Insets.extraLarge * 4),
      ]),
    );
  }
}
