import 'package:get/get.dart';
import 'package:task_manager/UI/controllers/auth_controller.dart';
import 'package:task_manager/data/models/login_model.dart';
import 'package:task_manager/data/service/network_client.dart';
import 'package:task_manager/data/utils/urls.dart';

class LoginController extends GetxController {
  bool _loginInProgress = false;

  bool get loginInprogress => _loginInProgress;

  String? _errorMassage;

  String? get errorMassage => _errorMassage;

  Future<bool> login(String email, String password) async {
    bool isSuccess = false;

    _loginInProgress = true;
    update();

    Map<String, dynamic> requestBody = {"email": email, "password": password};

    NetworkResponse response = await NetworkClient.postRequest(
      url: Urls.loginUrl,
      body: requestBody,
    );

    if (response.isSuccess) {
      LoginModel loginModel = LoginModel.fromJson(response.data!);
      await AuthController.saveUserInformation(
        loginModel.token,
        loginModel.userModel,
      );
      isSuccess = true;
      _errorMassage = null;
    } else {
      _errorMassage = response.errorMessage;
    }
    _loginInProgress = false;
    update();

    return isSuccess;
  }
}
