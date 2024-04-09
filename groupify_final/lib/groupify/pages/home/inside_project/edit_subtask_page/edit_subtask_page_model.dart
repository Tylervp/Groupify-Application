import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'edit_subtask_page_widget.dart' show EditSubtaskPageWidget;
import 'package:flutter/material.dart';

class EditSubtaskPageModel extends FlutterFlowModel<EditSubtaskPageWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // State field(s) for emailAddress widget.
  FocusNode? subtaskNameFocusNode;
  TextEditingController? subtaskNameController;
  String? Function(BuildContext, String?)? subtaskNameControllerValidator;
  // State field(s) for emailAddress widget.
  FocusNode? subtaskDescriptionFocusNode;
  TextEditingController? subtaskDescriptionController;
  String? Function(BuildContext, String?)? subtaskDescriptionControllerValidator;
  DateTime? datePicked;
  // State field(s) for DropDown widget.
  List<String>? dropDownValue;
  FormFieldController<List<String>>? dropDownValueController;
  // State field(s) for RatingBar widget.
  double? ratingBarValue;

  /// Initialization and disposal methods.

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    unfocusNode.dispose();
    subtaskNameFocusNode?.dispose();
    subtaskNameController?.dispose();

    subtaskDescriptionFocusNode?.dispose();
    subtaskDescriptionController?.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
