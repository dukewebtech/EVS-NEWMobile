import 'dart:convert';
import 'dart:io';
import 'package:evs_pay_mobile/model/wallet_model.dart';
import 'package:evs_pay_mobile/resources/constants/constants.dart';
import 'package:evs_pay_mobile/resources/ednpoints.dart';
import 'package:evs_pay_mobile/utils/firebase.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../model/user_model/user_model.dart';
import '../../resources/navigation_utils.dart';
import '../../widgets/loading_indicator.dart';

class AuthenticationProvider extends ChangeNotifier {
  ///Setter
  bool _isLoading = false;
  bool _success = false;
  String _resMessage = '';
  String _phoneNumber = "";
  final String _pin = "";
  UserModel? _userData;

  WalletModel? _walletData;

  ///Getter
  bool get isLoading => _isLoading;
  bool get success => _success;
  String get resMessage => _resMessage;
  String get phoneNumber => _phoneNumber;
  UserModel get userData => _userData!;

  WalletModel get walletData => _walletData!;

  String get pin => _pin;

  set phoneNumber(String value) {
    if (value != _phoneNumber) {
      _phoneNumber = value;
      notifyListeners();
    }
  }

  //Login
  void loginUser({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    _isLoading = true;
    _success = false;
    final prefs = await SharedPreferences.getInstance();
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) => const LoadingIndicator());
    notifyListeners();
    final body = {
      "email": email,
      "password": password,
      "extra": {
        "ip_address": "127.0.0.1",
        "browser": "Mobile App",
        "platform": Platform.isAndroid ? "Android" : "iOS"
      }
    };
    try {
      final response = await http.post(Uri.parse("$baseURL${Endpoints.login}"),
          headers: {
            'Content-Type': 'application/json',
          },
          body: json.encode(body));
      if (response.statusCode == 200 || response.statusCode == 201) {
        //first check for the user role
        _userData = userModelFromJson(response.body);
        prefs.setString(accessToken, _userData!.accessToken!);
        print("Saved token: ${prefs.getString(accessToken)}");
        _isLoading = false;
        _success = true;
        _resMessage = "";
        notifyListeners();
        Navigator.pop(context);
      

        //update device token
        var deviceToken = await FirebaseHandler().getToken();
        await updateProfile({'device_id': deviceToken});

        await getWalletAddress(context: context);
        openNavScreen(context);

        print('e tapp me o');
      } else if (response.statusCode == 422) {
        final res = json.decode(response.body);
        print("$res");
        final userNameError = res['errors']['email'][0] ?? "";
        _resMessage = "${res['message']}$userNameError";
        _isLoading = false;
        _success = false;
        notifyListeners();
        Navigator.pop(context);
      } else {
        final res = json.decode(response.body);
        _resMessage = res['message'];
        _isLoading = false;
        _success = false;
        notifyListeners();
        Navigator.pop(context);
      }
    } on SocketException catch (_) {
      _isLoading = false;
      _success = false;
      _resMessage = "Internet connection is not available";
      notifyListeners();
      Navigator.pop(context);
    } catch (e) {
      _isLoading = false;
      _success = false;
      _resMessage = "Please try again";
      notifyListeners();
      Navigator.pop(context);
      // print("exception: $e");
    }
  }

  //RECOVER PASSWORD
  void recoverPassword({
    required String email,
    required BuildContext context,
  }) async {
    _isLoading = true;
    _success = false;
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) => const LoadingIndicator());
    notifyListeners();
    final body = {
      "email": email,
    };
    try {
      final response =
          await http.put(Uri.parse("$baseURL${Endpoints.recoverPassword}"),
              headers: {
                'Content-Type': 'application/json',
              },
              body: json.encode(body));
      if (response.statusCode == 200 || response.statusCode == 201) {
        //first check for the user role
        _isLoading = false;
        _success = true;
        print("Success: $success");
        _resMessage =
            "Success! We have sent a password reset token to your email. Please check your email to continue the reset process.";
        notifyListeners();
        Navigator.pop(context);

        openLoginScreen(context);
      } else if (response.statusCode == 422) {
        final res = json.decode(response.body);
        print("$res");
        final userNameError = res['errors']['email'][0] ?? "";
        _resMessage = "${res['message']}$userNameError";
        _isLoading = false;
        _success = false;
        notifyListeners();
        Navigator.pop(context);
      } else {
        final res = json.decode(response.body);
        _resMessage = res['message'];
        _isLoading = false;
        _success = false;
        notifyListeners();
        Navigator.pop(context);
      }
    } on SocketException catch (_) {
      _isLoading = false;
      _success = false;
      _resMessage = "Internet connection is not available";
      notifyListeners();
      Navigator.pop(context);
    } catch (e) {
      _isLoading = false;
      _success = false;
      _resMessage = "Please try again";
      notifyListeners();
      Navigator.pop(context);
      // print("exception: $e");
    }
  }

  //VERIFY PHONE NUMBER
  void verifyPhoneNumberInit({
    required String phoneNumber,
    required BuildContext context,
  }) async {
    _isLoading = true;
    _success = false;
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) => const LoadingIndicator());
    notifyListeners();
    final body = {
      "phone_number": phoneNumber,
    };
    try {
      final response = await http.put(
          Uri.parse("$baseURL${Endpoints.verifyPhoneNumberInit}"),
          headers: {
            'Authorization': 'Bearer ${_userData!.accessToken}',
            'Content-Type': 'application/json',
          },
          body: json.encode(body));
      if (response.statusCode == 200 || response.statusCode == 201) {
        //first check for the user role
        _isLoading = false;
        _success = true;
        print("Success: $success");
        _resMessage = "Success! OTP has been sent.";
        notifyListeners();
        Navigator.pop(context);

        openPhoneNumberVerificationScreen(context);
      } else if (response.statusCode == 422) {
        final res = json.decode(response.body);
        print("$res");
        _resMessage = res['message'];
        _isLoading = false;
        _success = false;
        notifyListeners();
        Navigator.pop(context);
      } else {
        final res = json.decode(response.body);
        _resMessage = res['message'];
        _isLoading = false;
        _success = false;
        notifyListeners();
        Navigator.pop(context);
      }
    } on SocketException catch (_) {
      _isLoading = false;
      _success = false;
      _resMessage = "Internet connection is not available";
      notifyListeners();
      Navigator.pop(context);
    } catch (e) {
      _isLoading = false;
      _success = false;
      _resMessage = "Please try again";
      notifyListeners();
      Navigator.pop(context);
      // print("exception: $e");
    }
  }

  //VERIFY PHONE NUMBER
  void verifyEmailInit({
    required String email,
    required BuildContext context,
  }) async {
    _isLoading = true;
    _success = false;
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) => const LoadingIndicator());
    notifyListeners();
    final body = {
      "email": email,
    };
    try {
      final response =
          await http.put(Uri.parse("$baseURL${Endpoints.verifyEmail}"),
              headers: {
                'Authorization': 'Bearer ${_userData!.accessToken}',
                'Content-Type': 'application/json',
              },
              body: json.encode(body));
      if (response.statusCode == 200 || response.statusCode == 201) {
        //first check for the user role
        _isLoading = false;
        _success = true;
        print("Success: $success");
        _resMessage = "Success! OTP has been sent.";
        notifyListeners();
        Navigator.pop(context);

        openNavScreen(context);
      } else if (response.statusCode == 422) {
        final res = json.decode(response.body);
        print("$res");
        _resMessage = res['message'];
        _isLoading = false;
        _success = false;
        notifyListeners();
        Navigator.pop(context);
      } else {
        final res = json.decode(response.body);
        _resMessage = res['message'];
        _isLoading = false;
        _success = false;
        notifyListeners();
        Navigator.pop(context);
      }
    } on SocketException catch (_) {
      _isLoading = false;
      _success = false;
      _resMessage = "Internet connection is not available";
      notifyListeners();
      Navigator.pop(context);
    } catch (e) {
      _isLoading = false;
      _success = false;
      _resMessage = "Please try again";
      notifyListeners();
      Navigator.pop(context);
      // print("exception: $e");
    }
  }

  //VERIFY PHONE NUMBER
  void verifyPhoneNumberComplete({
    required String otp,
    required BuildContext context,
  }) async {
    _isLoading = true;
    _success = false;
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) => const LoadingIndicator());
    notifyListeners();
    final body = {
      "otp": otp,
    };
    try {
      final response = await http.put(
          Uri.parse("$baseURL${Endpoints.verifyPhoneNumberComplete}"),
          headers: {
            'Authorization': 'Bearer ${_userData!.accessToken}',
            'Content-Type': 'application/json',
          },
          body: json.encode(body));
      if (response.statusCode == 200 || response.statusCode == 201) {
        //first check for the user role
        _isLoading = false;
        _success = true;
        print("Success: $success");
        _resMessage = "Success! OTP has been sent.";
        notifyListeners();
        Navigator.pop(context);

        openLoginScreen(context);
      } else if (response.statusCode == 422) {
        final res = json.decode(response.body);
        print("$res");
        _resMessage = res['message'];
        _isLoading = false;
        _success = false;
        notifyListeners();
        Navigator.pop(context);
      } else {
        final res = json.decode(response.body);
        _resMessage = res['message'];
        _isLoading = false;
        _success = false;
        notifyListeners();
        Navigator.pop(context);
      }
    } on SocketException catch (_) {
      _isLoading = false;
      _success = false;
      _resMessage = "Internet connection is not available";
      notifyListeners();
      Navigator.pop(context);
    } catch (e) {
      _isLoading = false;
      _success = false;
      _resMessage = "Please try again";
      notifyListeners();
      Navigator.pop(context);
      // print("exception: $e");
    }
  }

  //VERIFY PHONE NUMBER
  void verifyIdentity({
    required String idCard,
    required BuildContext context,
    required String endPoint,
  }) async {
    _isLoading = true;
    _success = false;

    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) => const LoadingIndicator());
    notifyListeners();
    final body = {
      "file": idCard,
    };
    try {
      final response = await http.put(Uri.parse("$baseURL$endPoint"),
          headers: {
            'Authorization': 'Bearer ${_userData!.accessToken}',
            'Content-Type': 'application/json',
          },
          body: json.encode(body));
      print(" Status code: ${response.statusCode}");
      if (response.statusCode == 200 || response.statusCode == 201) {
        final res = json.decode(response.body);
        //first check for the user role
        _isLoading = false;
        _success = true;
        print("Success: $success");
        _resMessage = res['message'] ?? "";
        notifyListeners();
        Navigator.pop(context);
        openVerificationSubmittedScreen(context);
        // openNavScreen(context);

      } else if (response.statusCode == 422) {
        final res = json.decode(response.body);
        print("$res");
        _resMessage = res['message'];
        _isLoading = false;
        _success = false;
        notifyListeners();
        Navigator.pop(context);
      } else {
        final res = json.decode(response.body);
        _resMessage = res['message'] ?? "";

        _isLoading = false;
        _success = false;
        notifyListeners();
        Navigator.pop(context);
      }
    } on SocketException catch (_) {
      _isLoading = false;
      _success = false;
      _resMessage = "Internet connection is not available";
      notifyListeners();
      Navigator.pop(context);
    } catch (e) {
      _isLoading = false;
      _success = false;
      _resMessage = "Please try again";
      notifyListeners();
      Navigator.pop(context);
      // print("exception: $e");
    }
  }

  Future<bool> updateProfile(Map data) async {
    _isLoading = true;
    bool updated = false;
    notifyListeners();

    try {
      final response = await http.patch(Uri.parse("${baseURL}accounts/profile"),
          headers: {
            'Authorization': 'Bearer ${_userData!.accessToken}',
            'Content-Type': 'application/json',
          },
          body: json.encode(data));
      print(" Status code: ${response.body}");
      if (response.statusCode == 200 || response.statusCode == 201) {
        final res = json.decode(response.body);
        //first check for the user role
        _isLoading = false;
        updated = true;
        print("Success: $success");
        _resMessage = res['message'] ?? "";
        notifyListeners();
      } else {
        final res = json.decode(response.body);
        print("$res");
        _resMessage = res['message'];
        _isLoading = false;
        _success = false;
        notifyListeners();
      }
    } on SocketException catch (_) {
      _isLoading = false;
      _success = false;
      _resMessage = "Internet connection is not available";
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _success = false;
      _resMessage = "Please try again";
      notifyListeners();
    }

    return updated;
  }

  Future<bool> updateProfilePhoto({
    required String idCard,
    required BuildContext context,
    required String endPoint,
  }) async {
    _isLoading = true;
    bool updated = false;

    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) => const LoadingIndicator());
    notifyListeners();
    final body = {
      "file": idCard,
    };
    try {
      final response = await http.put(Uri.parse("$baseURL$endPoint"),
          headers: {
            'Authorization': 'Bearer ${_userData!.accessToken}',
            'Content-Type': 'application/json',
          },
          body: json.encode(body));
      print(" Status code: ${response.body}");
      if (response.statusCode == 200 || response.statusCode == 201) {
        final res = json.decode(response.body);
        //first check for the user role
        _isLoading = false;
        updated = true;
        print("Success: $success");
        _resMessage = res['message'] ?? "";
        notifyListeners();
        Navigator.pop(context);
        // openNavScreen(context);

      } else if (response.statusCode == 422) {
        final res = json.decode(response.body);
        print("$res");
        _resMessage = res['message'];
        _isLoading = false;
        _success = false;
        notifyListeners();
        Navigator.pop(context);
      } else {
        final res = json.decode(response.body);
        _resMessage = res['message'] ?? "";

        _isLoading = false;
        _success = false;
        notifyListeners();
        Navigator.pop(context);
      }
    } on SocketException catch (_) {
      _isLoading = false;
      _success = false;
      _resMessage = "Internet connection is not available";
      notifyListeners();
      Navigator.pop(context);
    } catch (e) {
      _isLoading = false;
      _success = false;
      _resMessage = "Please try again";
      notifyListeners();
      Navigator.pop(context);
      // print("exception: $e");
    }
    return updated;
  }

  //REGISTER USER
  void registerUser({
    required String email,
    required String password,
    required BuildContext context,
    required phone,
    required username,
  }) async {
    _isLoading = true;
    _success = false;
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) => const LoadingIndicator());
    notifyListeners();
    final body = {
      "email": email,
      "password": password,
      "phone": phone,
      "username": username,
    };
    try {
      final response =
          await http.post(Uri.parse("$baseURL${Endpoints.register}"),
              headers: {
                'Content-Type': 'application/json',
              },
              body: json.encode(body));
      print("Registration response: ${response.body}");
      if (response.statusCode == 200 || response.statusCode == 201) {
        //first check for the user role
        _success = true;
        _isLoading = false;
        _resMessage = "Registered successfully";
        notifyListeners();
        Navigator.pop(context);

        /// when a user registers, user should be redirected to the bottomNav screen not the login screen *Kelvin*
        await getWalletAddress(context: context);
        openNavScreen(context);

        /// I kelvin, commented this code because  after registration a user should be directed to the botoom nav screen.
        // openLoginScreen(context);
      } else if (response.statusCode == 422) {
        final res = json.decode(response.body);
        print("response: ${response.body}");
        final userNameError = res['errors']['username'] == null
            ? ""
            : res['errors']['username'][0];

        final emailError =
            res['errors']['email'] == null ? "" : res['errors']['email'][0];
        _resMessage = "${res['message']}$userNameError $emailError";
        _isLoading = false;
        notifyListeners();
        Navigator.pop(context);
      } else {
        final res = json.decode(response.body);
        _resMessage = res['message'];
        // print(res);
        _isLoading = false;
        notifyListeners();
        Navigator.pop(context);
      }
    } on SocketException catch (_) {
      _isLoading = false;
      _resMessage = "Internet connection is not available";
      notifyListeners();
      Navigator.pop(context);
    } catch (e) {
      _isLoading = false;
      _resMessage = "Please try again";
      notifyListeners();
      Navigator.pop(context);
      print("exception: $e");
    }
  }

  void clear() {
    _resMessage = "";
    notifyListeners();
  }

  Future<void> getWalletAddress({
    required BuildContext context,
  }) async {
    _isLoading = true;
    notifyListeners();
    try {
      final response = await http.get(
        Uri.parse("$baseURL${Endpoints.wallet}"),
        headers: {
          'Authorization': 'Bearer ${_userData!.accessToken}',
          'Content-Type': 'application/json',
        },
      );
      print("Wallet info Response body: ${response.body}");
      if (response.statusCode == 200 || response.statusCode == 201) {
        //first check for the user role
        _walletData = walletModelFromJson(response.body);
        _resMessage = "";
        _isLoading = false;
        notifyListeners();
        // Navigator.pop(context);

      } else if (response.statusCode == 422) {
        final res = json.decode(response.body);
        print("$res");
        final userNameError = res['errors']['email'][0] ?? "";
        _resMessage = "${res['message']}$userNameError";
        _isLoading = false;
        notifyListeners();
        Navigator.pop(context);
      } else {
        final res = json.decode(response.body);
        _resMessage = res['message'];
        notifyListeners();
        // Navigator.pop(context);
      }
    } on SocketException catch (_) {
      _resMessage = "Internet connection is not available";
      _isLoading = false;
      notifyListeners();
      Navigator.pop(context);
    } catch (e) {
      _resMessage = "Please try again";
      _isLoading = false;
      notifyListeners();
      Navigator.pop(context);
      print("exception: $e");
    }
  }
}
