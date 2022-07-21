class PaymentMethodModel{
  final String method;

  PaymentMethodModel({required this.method});

}


final List<PaymentMethodModel> paymentMethods = [
  PaymentMethodModel(method: "Any payment Method"),
  PaymentMethodModel(method: "Bank Transfer"),
  PaymentMethodModel(method: "USSD"),
  PaymentMethodModel(method: "Cash"),
];