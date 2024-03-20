import '/flutter_flow/flutter_flow_util.dart';
import 'change_profile_photo_widget.dart' show ChangeProfilePhotoWidget;
import 'package:flutter/material.dart';

class ChangeProfilePhotoModel
    extends FlutterFlowModel<ChangeProfilePhotoWidget> {
  ///  Local state fields for this page.

  String inputForuserName = 'User1';

  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();

  /// Initialization and disposal methods.

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    unfocusNode.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
