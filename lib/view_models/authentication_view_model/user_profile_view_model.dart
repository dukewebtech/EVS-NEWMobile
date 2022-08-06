import 'package:evs_pay_mobile/model/user_model/user_profile_model.dart';
import 'package:evs_pay_mobile/repos/profile_repo/profile_repo.dart';
import 'package:flutter/material.dart';

import '../../model/user_profile_error.dart';
import '../../utils/api_status.dart';

class UserProfileViewModel extends ChangeNotifier{
  bool _loading = false;
  UserProfileModel _userProfile = UserProfileModel() ;
  UserError? _userError;

  TextEditingController nameEditingController = TextEditingController();

  bool get loading => _loading;
  UserProfileModel  get userProfile => _userProfile;
  UserError? get userError => _userError;




  UserProfileViewModel(){
    getUserProfile();
  }



  setLoading(bool loading)async{
    _loading = loading;
    notifyListeners();
  }



  setUseError(UserError? userError){
    _userError = userError;
  }

  setUserProfile(UserProfileModel? userProfile){
    _userProfile = userProfile!;
    nameEditingController.text = "${_userProfile.data!.firstName} ${_userProfile.data!.middleName ?? ''} ${_userProfile.data!.lastName}";
  }

  getUserProfile() async{
    setLoading(true);

    var response = await UserProfileService.getUserProfile();

    if(response is Success){
      setUserProfile(response.response as UserProfileModel);
    }

    if(response is Failure){
      final userError =  UserError(code: response.code, message: response.errorResponse);
      setUseError(userError);
    }




    setLoading(false);
  }
}