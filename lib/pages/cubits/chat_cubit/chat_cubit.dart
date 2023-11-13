import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:scholar_chat/constants.dart';
import 'package:scholar_chat/models/message.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());

  CollectionReference messages =
      FirebaseFirestore.instance.collection(kMessagesCollections);
  void sendMessages({required String message, required String email}) {
   // print({kMessage: messages, kCreatedAt: DateTime.now(), 'id': email});
    messages.add(
      {kMessage: message, kCreatedAt: DateTime.now(), 'id': email},
    );
  }

  void getMessages() {
    messages.orderBy(kCreatedAt, descending: true).snapshots().listen((event) {
      List<Message> listMessages = [];

      for (var doc in event.docs) {
        listMessages.add(Message.fromJson(doc));
      }

      emit(ChatSuccess(messagesList: listMessages));
    });
  }
}
