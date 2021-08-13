import 'package:get_it/get_it.dart';
import 'package:phone_app/services/call_and_message_services.dart';


final getIt = GetIt.instance;

void setupLocator() {
  getIt.registerSingleton(CallsAndMessageService());
}
