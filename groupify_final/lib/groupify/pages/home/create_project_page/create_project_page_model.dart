import '/flutter_flow/flutter_flow_util.dart';
import 'create_project_page_widget.dart' show CreateProjectPageWidget;
import 'package:flutter/material.dart';

class CreateProjectPageModel extends FlutterFlowModel<CreateProjectPageWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // State field(s) for projectName widget.
  FocusNode? projectNameFocusNode;
  TextEditingController? projectNameController; // cont1
  String? Function(BuildContext, String?)? projectNameControllerValidator;

  // State field(s) for projectDescription widget.
  FocusNode? projectDescriptionFocusNode;
  TextEditingController? projectDescriptionController;
  String? Function(BuildContext, String?)? projectDescriptionControllerValidator;
  DateTime? datePicked;

  /// Initialization and disposal methods.

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    unfocusNode.dispose();
    projectNameFocusNode?.dispose();
    projectNameController?.dispose();

    projectDescriptionFocusNode?.dispose();
    projectDescriptionController?.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
