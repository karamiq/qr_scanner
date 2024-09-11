import '../../utils/constants/assets.dart';

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
  bool get isSocialMedia {
    return this == QRType.whatsApp || this == QRType.twitter || this == QRType.instagram;
  }

  bool get isContactRelated {
    return this == QRType.contact || this == QRType.phoneNumber || this == QRType.email;
  }

  @override
  String toString() => name;
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
  } else if (qrCode.startsWith('MECARD:')) {
    return QRType.contact;
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
