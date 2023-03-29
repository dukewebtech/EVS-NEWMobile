class SendBTCModel {
  final String destinationAddress;
  final double amount;
  final String password;
  final String? oneTimePassword;

  SendBTCModel(
      {required this.destinationAddress,
      required this.amount,
      required this.password,
      this.oneTimePassword});

  factory SendBTCModel.fromJson(Map<String, dynamic> json) => SendBTCModel(
      destinationAddress: json['destination_address'],
      amount: json['amount'],
      password: json['password'],
      oneTimePassword: json['one_time_password']);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['destination_address'] = destinationAddress;
    data['amount'] = amount;
    data['password'] = password;
    data['one_time_password'] = oneTimePassword;
    return data;
  }
}
