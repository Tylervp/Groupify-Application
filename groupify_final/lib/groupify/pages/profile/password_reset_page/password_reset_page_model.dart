import '/flutter_flow/flutter_flow_util.dart';
import 'password_reset_page_widget.dart' show PasswordResetPageWidget;
import 'package:flutter/material.dart';

class PasswordResetPageModel extends FlutterFlowModel<PasswordResetPageWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // State field(s) for CurrentEmail widget.
  FocusNode? currentEmailFocusNode;
  TextEditingController? currentEmailController;
  String? Function(BuildContext, String?)? currentEmailControllerValidator;

  /// Initialization and disposal methods.

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    unfocusNode.dispose();
    currentEmailFocusNode?.dispose();
    currentEmailController?.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
