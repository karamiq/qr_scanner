// ignore_for_file: empty_catches
import 'package:add_2_calendar/add_2_calendar.dart' as calender;
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wifi_iot/wifi_iot.dart';
import '../../common_lib.dart';

enum QRType {
  location('location'),
  text("text"),
  website("website"),
  network("network"),
  event("event"),
  contact("contact"),
  business("business"),
  whatsApp("whatsApp"),
  twitter("twitter"),
  email("email"),
  instagram("instagram"),
  phoneNumber("phoneNumber");

  final String name;
  const QRType(this.name);
  @override
  String toString() => name;
}

Future<void> launchApp(String data) async {
  final type = handleQRCode(data);
  final tt = type == QRType.contact ? 'contact' : 'business';

  switch (type) {
    case QRType.network:
      try {
        RegExp regExp = RegExp(r'S:([^;]+);P:([^;]+);');
        Match? match = regExp.firstMatch(data);
        String name = match?.group(1) ?? '';
        String password = match?.group(2) ?? '';

        bool isConnected = await WiFiForIoTPlugin.connect(
          name,
          password: password,
          security: NetworkSecurity.WPA,
          joinOnce: true,
          withInternet: true,
        );
        if (isConnected) {
          Utils.showNotificatonSnackBar("Connecting to $name");
        } else {
          Utils.showNotificatonSnackBar("Failed to connect");
        }
      } catch (e) {}
      break;
    case QRType.event:
      try {
        final vCardData = extractVCardData(data);

        final event = calender.Event(
          title: vCardData['SUMMARY'] ?? '',
          description: vCardData['DESCRIPTION'] ?? '',
          location: vCardData['LOCATION'] ?? '',
          startDate: DateTime.parse(vCardData['DTSTART'] ?? ''),
          endDate: DateTime.parse(vCardData['DTEND'] ?? ''),
          allDay: false,
        );
        final state = await calender.Add2Calendar.addEvent2Cal(event);
        if (!state) {
          Utils.showErrorSnackBar('Faild to add');
        }
      } catch (e) {}
    case QRType.website:
    case QRType.whatsApp:
    case QRType.twitter:
    case QRType.email:
    case QRType.instagram:
    case QRType.phoneNumber:
    case QRType.location:
      try {
        await launchUrl(Uri.parse(data));
      } catch (e) {}
      break;
    case QRType.contact:
      try {
        final vCardData = extractVCardData(data);
        final state = await Permission.contacts.request();
        if (state.isGranted) {
          final contact = Contact(
            name: Name(
              first: vCardData['FN']?.split(' ').first ?? '',
              last: vCardData['FN']?.split(' ').skip(1).join(' ') ?? '',
            ),
            organizations: [
              Organization(
                  company: vCardData['ORG'] ?? '', title: vCardData['TITLE'] ?? '')
            ],
            phones: [
              Phone(vCardData['TEL'] ?? '', label: PhoneLabel.mobile),
            ],
            emails: [
              Email(vCardData['EMAIL'] ?? ''),
            ],
            addresses: [
              Address(vCardData['ADR'] ?? ''),
            ],
            websites: [
              Website(vCardData['URL'] ?? ''),
            ],
          );
          await FlutterContacts.openExternalInsert(contact);
        } else {
          Utils.showErrorSnackBar('Permission to access contacts was denied');
        }
      } catch (e) {}
      break;
    case QRType.business:
      try {
        final vCardData = extractVCardData(data);
        final state = await Permission.contacts.request();

        if (state.isGranted) {
          final contact = Contact(
            name: Name(
              first: vCardData['N'] ?? 'null',
            ),
            organizations: [
              Organization(
                company: vCardData['ORG'] ?? '',
                title: vCardData['N'] ?? '',
              )
            ],
            phones: [
              Phone(
                vCardData['TEL'] ?? '',
                label: PhoneLabel.work,
              ),
            ],
            emails: [
              Email(vCardData['EMAIL'] ?? ''),
            ],
            addresses: [
              Address(vCardData['ADR'] ?? '', label: AddressLabel.work),
            ],
            websites: [
              Website(vCardData['URL'] ?? ''),
            ],
          );
          await FlutterContacts.insertContact(contact);
          Utils.showSuccessSnackBar('The $tt has been added to contacts');
        } else {
          Utils.showErrorSnackBar('Permission to access contacts was denied');
        }
      } catch (e) {}
      break;
    case QRType.text:
    default:
      return;
  }
}

Map<String, String> extractVCardData(String vCardString) {
  final data = <String, String>{};

  final lines = vCardString.split('\n');

  for (var line in lines) {
    if (line.trim().isEmpty) continue;

    final parts = line.split(':');
    if (parts.length == 2) {
      final key = parts[0].trim();
      final value = parts[1].trim();
      data[key] = value;
    }
  }
  return data;
}

extension QRTypeIconExtension on QRType {
  String get iconPath {
    switch (this) {
      case QRType.text:
        return Assets.assetsSvgGenerateTextIcon;
      case QRType.website:
        return Assets.assetsSvgGenerateInternetIcon;
      case QRType.network:
        return Assets.assetsSvgGenerateNetworkIcon;
      case QRType.event:
        return Assets.assetsSvgGenerateEventIcon;
      case QRType.contact:
        return Assets.assetsSvgGenerateContactIcon;
      case QRType.business:
        return Assets.assetsSvgGenerateBusniessIcon;
      case QRType.whatsApp:
        return Assets.assetsSvgGenerateWhatsappIcon;
      case QRType.twitter:
        return Assets.assetsSvgGenerateTwitterIcon;
      case QRType.email:
        return Assets.assetsSvgGenerateEmailIcon;
      case QRType.instagram:
        return Assets.assetsSvgGenerateInstagramIcon;
      case QRType.phoneNumber:
        return Assets.assetsSvgGeneratePhoneNumberIcon;
      case QRType.location:
        return Assets.assetsImagesLocationIcon;
      default:
        return '';
    }
  }
}

extension QRTypeExtension on QRType {
  String toTitleString() {
    switch (this) {
      case QRType.text:
        return 'Text';
      case QRType.website:
        return 'Website';
      case QRType.network:
        return 'Wi-Fi';
      case QRType.event:
        return 'Events';
      case QRType.contact:
        return 'Contact';
      case QRType.business:
        return 'Business';
      case QRType.whatsApp:
        return 'WhatsApp';
      case QRType.twitter:
        return 'Twitter';
      case QRType.email:
        return 'Email';
      case QRType.instagram:
        return 'Instagram';
      case QRType.phoneNumber:
        return 'Telephone';
      case QRType.location:
        return 'Location';
      default:
        return 'Unknown';
    }
  }
}

QRType handleQRCode(String qrCode) {
  // Check for specific formats first
  if (qrCode.startsWith('WIFI:')) {
    return QRType.network;
  } else if (qrCode.startsWith('BEGIN:VCARD')) {
    return QRType.contact;
  } else if (qrCode.startsWith('BEGIN:VEVENT')) {
    return QRType.event;
  } else if (qrCode.startsWith('MECARD:')) {
    return QRType.business;
  } else if (qrCode.startsWith('geo:')) {
    return QRType.location;
  }

  // Check for URLs and email addresses
  else if (qrCode.startsWith('http://') || qrCode.startsWith('https://')) {
    if (qrCode.contains('https://wa.me/')) {
      return QRType.whatsApp;
    } else if (qrCode.contains('https://twitter.com/')) {
      return QRType.twitter;
    } else if (qrCode.contains('https://instagram.com/')) {
      return QRType.instagram;
    } else {
      return QRType.website;
    }
  } else if (qrCode.startsWith('mailto:')) {
    return QRType.email;
  } else if (qrCode.startsWith('tel:')) {
    return QRType.phoneNumber;
  }

  // Default case for unrecognized types
  return QRType.text;
}
