import 'package:meta/meta.dart';

@immutable
class MessageData {
  MessageData(
      {required this.message,
      required this.dateMessage,
      required this.messageData,
      required this.profilePicture,
      required this.senderName});

  final String senderName;
  final String message;
  final DateTime messageData;
  final String dateMessage;
  final String profilePicture;
}
