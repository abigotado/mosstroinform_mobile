import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:mosstroinform_mobile/features/chat/data/models/chat_model.dart';
import 'package:mosstroinform_mobile/features/chat/domain/datasources/chat_remote_data_source.dart';

part 'chat_remote_data_source.g.dart';

/// Удалённый источник данных для чатов (Retrofit)
/// Реализует интерфейс из domain слоя
@RestApi()
abstract class ChatRemoteDataSource implements IChatRemoteDataSource {
  factory ChatRemoteDataSource(Dio dio, {String baseUrl}) =
      _ChatRemoteDataSource;

  @override
  @GET('/chats')
  Future<List<ChatModel>> getChats();

  @override
  @GET('/chats/{chatId}')
  Future<ChatModel> getChatById(@Path('chatId') String chatId);

  @override
  @GET('/chats/{chatId}/messages')
  Future<List<MessageModel>> getMessages(@Path('chatId') String chatId);

  @override
  @POST('/chats/{chatId}/messages')
  Future<MessageModel> sendMessage(
    @Path('chatId') String chatId,
    @Body() Map<String, dynamic> body,
  );

  @override
  @POST('/chats/{chatId}/messages/read')
  Future<void> markMessagesAsRead(@Path('chatId') String chatId);
}
