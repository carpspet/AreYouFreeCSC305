import '/flutter_flow/flutter_flow_util.dart';
import 'edit_event_widget.dart' show EditEventWidget;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EditEventModel extends FlutterFlowModel<EditEventWidget> {
  ///  State fields for stateful widgets in this page.

  // State field(s) for EventName widget.
  FocusNode? eventNameFocusNode;
  TextEditingController? eventNameTextController;
  String? Function(BuildContext, String?)? eventNameTextControllerValidator;
  DateTime? datePicked1;
  DateTime? datePicked2;
  // State field(s) for Checkbox widget.
  bool? checkboxValue1;
  // State field(s) for Checkbox widget.
  bool? checkboxValue2;
  // State field(s) for Checkbox widget.
  bool? checkboxValue3;
  Color? colorPicked;
  // State field(s) for EventDesc widget.
  FocusNode? eventDescFocusNode;
  TextEditingController? eventDescTextController;
  String? Function(BuildContext, String?)? eventDescTextControllerValidator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    eventNameFocusNode?.dispose();
    eventNameTextController?.dispose();

    eventDescFocusNode?.dispose();
    eventDescTextController?.dispose();
  }
}
