import 'package:url_launcher/url_launcher.dart';

class CallsAndMessageService {
  void call(String number) => launch("tel:$number");
  void sendSms(String number) => launch("sms:$number");
}