import '/flutter_flow/flutter_flow_util.dart';
import 'login_page_widget.dart' show LoginPageWidget;
import 'package:flutter/material.dart';

class LoginPageModel extends FlutterFlowModel<LoginPageWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  final formKey2 = GlobalKey<FormState>();
  final formKey3 = GlobalKey<FormState>();
  final formKey1 = GlobalKey<FormState>();
  // State field(s) for TabBar widget.
  TabController? tabBarController;
  int get tabBarCurrentIndex =>
      tabBarController != null ? tabBarController!.index : 0;

  // State field(s) for emailAddress widget.
  FocusNode? emailAddressFocusNode;
  TextEditingController? emailAddressController;
  String? Function(BuildContext, String?)? emailAddressControllerValidator;
  // State field(s) for password widget.
  FocusNode? passwordFocusNode;
  TextEditingController? passwordController;
  late bool passwordVisibility;
  String? Function(BuildContext, String?)? passwordControllerValidator;
  // State field(s) for emailAddress-Create widget.
  FocusNode? emailAddressCreateFocusNode;
  TextEditingController? emailAddressCreateController;
  String? Function(BuildContext, String?)?
      emailAddressCreateControllerValidator;
  // State field(s) for UsernameCreate widget.
  FocusNode? usernameCreateFocusNode;
  TextEditingController? usernameCreateController;
  String? Function(BuildContext, String?)? usernameCreateControllerValidator;
  String? _usernameCreateControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return FFLocalizations.of(context).getText(
        'j7qaytho' /* Field is required */,
      );
    }

    if (val.length < 5) {
      return FFLocalizations.of(context).getText(
        'j0jqe3ow' /* Error: Password must be at lea... */,
      );
    }

    if (!RegExp(kTextValidatorUsernameRegex).hasMatch(val)) {
      return 'Must start with a letter and can only contain letters, digits and - or _.';
    }
    return null;
  }

  // State field(s) for password-Create widget.
  FocusNode? passwordCreateFocusNode;
  TextEditingController? passwordCreateController;
  late bool passwordCreateVisibility;
  String? Function(BuildContext, String?)? passwordCreateControllerValidator;
  String? _passwordCreateControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Field is required';
    }

    if (val.length < 8) {
      return FFLocalizations.of(context).getText(
        'ho6xibl3' /* Error: Password must be at lea... */,
      );
    }

    if (!RegExp('^(?=.*[A-Z])(?=.*\\d)[A-Za-z\\d]{8,}\$').hasMatch(val)) {
      return FFLocalizations.of(context).getText(
        'inxh8oxc' /* Password needs at least 1 numb... */,
      );
    }
    return null;
  }

  // State field(s) for password-confirm widget.
  FocusNode? passwordConfirmFocusNode;
  TextEditingController? passwordConfirmController;
  late bool passwordConfirmVisibility;
  String? Function(BuildContext, String?)? passwordConfirmControllerValidator;

  /// Initialization and disposal methods.

  @override
  void initState(BuildContext context) {
    passwordVisibility = false;
    usernameCreateControllerValidator = _usernameCreateControllerValidator;
    passwordCreateVisibility = false;
    passwordCreateControllerValidator = _passwordCreateControllerValidator;
    passwordConfirmVisibility = false;
  }

  @override
  void dispose() {
    unfocusNode.dispose();
    tabBarController?.dispose();
    emailAddressFocusNode?.dispose();
    emailAddressController?.dispose();

    passwordFocusNode?.dispose();
    passwordController?.dispose();

    emailAddressCreateFocusNode?.dispose();
    emailAddressCreateController?.dispose();

    usernameCreateFocusNode?.dispose();
    usernameCreateController?.dispose();

    passwordCreateFocusNode?.dispose();
    passwordCreateController?.dispose();

    passwordConfirmFocusNode?.dispose();
    passwordConfirmController?.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
