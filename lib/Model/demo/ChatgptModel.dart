class ChatgptModel {
  Data data;
  bool status;
  String message;

  ChatgptModel({required this.data, required this.status, required this.message});

  factory ChatgptModel.fromJson(Map<String, dynamic> json) {
    return ChatgptModel(
      data: Data.fromJson(json['data']),
      status: json['status'],
      message: json['message'],
    );
  }
}

class Data {
  Chat chat;

  Data({required this.chat});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(chat: Chat.fromJson(json['chat']));
  }
}

class Chat {
  int currentPage;
  List<ChatData> chatData;
  String firstPageUrl;
  int from;
  int lastPage;
  String lastPageUrl;
  List<Link> links;
  dynamic nextPageUrl;
  String path;
  int perPage;
  dynamic prevPageUrl;
  int to;
  int total;

  Chat({
    required this.currentPage,
    required this.chatData,
    required this.firstPageUrl,
    required this.from,
    required this.lastPage,
    required this.lastPageUrl,
    required this.links,
    required this.nextPageUrl,
    required this.path,
    required this.perPage,
    required this.prevPageUrl,
    required this.to,
    required this.total,
  });

  factory Chat.fromJson(Map<String, dynamic> json) {
    var list = json['data'] as List;
    List<ChatData> chatDataList = list.map((i) => ChatData.fromJson(i)).toList();

    var linksList = json['links'] as List;
    List<Link> links = linksList.map((i) => Link.fromJson(i)).toList();

    return Chat(
      currentPage: json['current_page'],
      chatData: chatDataList,
      firstPageUrl: json['first_page_url'],
      from: json['from'],
      lastPage: json['last_page'],
      lastPageUrl: json['last_page_url'],
      links: links,
      nextPageUrl: json['next_page_url'],
      path: json['path'],
      perPage: json['per_page'],
      prevPageUrl: json['prev_page_url'],
      to: json['to'],
      total: json['total'],
    );
  }
}

class ChatData {
  int id;
  String userId;
  int isSender;
  String message;
  String createdAt;
  String updatedAt;

  ChatData({
    required this.id,
    required this.userId,
    required this.isSender,
    required this.message,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ChatData.fromJson(Map<String, dynamic> json) {
    return ChatData(
      id: json['id'],
      userId: json['user_id'],
      isSender: json['is_sender'],
      message: json['message'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}

class Link {
  dynamic url;
  String label;
  bool active;

  Link({required this.url, required this.label, required this.active});

  factory Link.fromJson(Map<String, dynamic> json) {
    return Link(
      url: json['url'],
      label: json['label'],
      active: json['active'],
    );
  }
}
