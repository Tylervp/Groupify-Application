import '/flutter_flow/flutter_flow_util.dart';
import 'rating_page_widget.dart' show RatingPageWidget;
import 'package:flutter/material.dart';

class RatingPageModel extends FlutterFlowModel<RatingPageWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // State field(s) for RatingBar widget.
  double? ratingBarValue1;
  // State field(s) for RatingBar widget.
  double? ratingBarValue2;

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
