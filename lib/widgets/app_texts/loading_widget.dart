import 'package:evs_pay_mobile/widgets/loading_indicator.dart';
import 'package:flutter/cupertino.dart';


class AppLoading extends StatelessWidget {
  const AppLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(20),
        child: const LoadingIndicator(),
      ),
    );
  }
}
