import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'task_creation_page_widget.dart' show TaskCreationPageWidget;
import 'package:flutter/material.dart';

class TaskCreationPageModel extends FlutterFlowModel<TaskCreationPageWidget> {
  ///  Local state fields for this page.

  String temp = 'temp';

  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // State field(s) for taskName widget.
  FocusNode? taskNameFocusNode;
  TextEditingController? taskNameController;
  String? Function(BuildContext, String?)? taskNameControllerValidator;
  // State field(s) for taskDescription widget.
  FocusNode? taskDescriptionFocusNode;
  TextEditingController? taskDescriptionController;
  String? Function(BuildContext, String?)? taskDescriptionControllerValidator;
  DateTime? datePicked;
  // State field(s) for RatingBar widget.
  double? ratingBarValue;
  // State field(s) for DropDown widget.
  List<String>? dropDownValue;
  FormFieldController<List<String>>? dropDownValueController;

  /// Initialization and disposal methods.

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    unfocusNode.dispose();
    taskNameFocusNode?.dispose();
    taskNameController?.dispose();

    taskDescriptionFocusNode?.dispose();
    taskDescriptionController?.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
