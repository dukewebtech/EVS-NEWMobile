class NotificationModel{
  final String userName;
  final String intention;
  final String btcValue;
  final String description;
  final bool isRead;
  final String date;

  NotificationModel({required this.userName, required this.description,
    required this.btcValue, required this.intention, required this.isRead,
    this.date = "2022-09-01"
  });

}


final List<NotificationModel> notifications = [
  NotificationModel(userName: "Jane Cooper", description: "Your ad for 200 usdt has been confirmed and is active to users ", btcValue: "0.003", intention: "wants to sell btc of", isRead: true),
  NotificationModel(userName: "Jane Cooper", description: "Your ad for 200 usdt has been confirmed and is active to users ", btcValue: "0.003", intention: "wants to sell btc of", isRead: false),
  NotificationModel(userName: "Jane Cooper", description: "Your ad for 200 usdt has been confirmed and is active to users ", btcValue: "0.003", intention: "wants to sell btc of", isRead: false),
  NotificationModel(userName: "Jane Cooper", description: "Your ad for 200 usdt has been confirmed and is active to users ", btcValue: "0.003", intention: "wants to sell btc of", isRead: true),
  NotificationModel(userName: "Jane Cooper", description: "Your ad for 200 usdt has been confirmed and is active to users ", btcValue: "0.003", intention: "wants to sell btc of", isRead: false),
  NotificationModel(userName: "Jane Cooper", description: "Your ad for 200 usdt has been confirmed and is active to users ", btcValue: "0.003", intention: "wants to sell btc of", isRead: false),
  NotificationModel(userName: "Jane Cooper", description: "Your ad for 200 usdt has been confirmed and is active to users ", btcValue: "0.003", intention: "wants to sell btc of", isRead: false),
  NotificationModel(userName: "Jane Cooper", description: "Your ad for 200 usdt has been confirmed and is active to users ", btcValue: "0.003", intention: "wants to sell btc of", isRead: false),
  NotificationModel(userName: "Jane Cooper", description: "Your ad for 200 usdt has been confirmed and is active to users ", btcValue: "0.003", intention: "wants to sell btc of", isRead: false),
  NotificationModel(userName: "Jane Cooper", description: "Your ad for 200 usdt has been confirmed and is active to users ", btcValue: "0.003", intention: "wants to sell btc of", isRead: false),
  NotificationModel(userName: "Jane Cooper", description: "Your ad for 200 usdt has been confirmed and is active to users ", btcValue: "0.003", intention: "wants to sell btc of", isRead: false),
  NotificationModel(userName: "Jane Cooper", description: "Your ad for 200 usdt has been confirmed and is active to users ", btcValue: "0.003", intention: "wants to sell btc of", isRead: false),
];