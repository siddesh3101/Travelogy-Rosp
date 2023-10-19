import 'social_category.dart';

class SocialMediaQr {
  SocialMediaQr() : userDetails = [];

  late String name;
  late String description;
  late List<SocialMediaData> userDetails;
}

class SocialMediaData {
  SocialMediaData(this.socialMediaType, this.text) {
    text = '${socialMediaType.prefixUrl}$text';
  }

  late QrCategory socialMediaType;
  late String text;

  Map<String, dynamic> toJson() => {
        'id': '6518004ca59da31963547d35',
        'username': text,
        'website': socialMediaType.string
      };
}
