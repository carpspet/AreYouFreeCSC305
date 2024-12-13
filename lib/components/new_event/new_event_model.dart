import '/flutter_flow/flutter_flow_util.dart';
import 'new_event_widget.dart' show NewEventWidget;
import 'package:flutter/material.dart';

class NewEventModel extends FlutterFlowModel<NewEventWidget> {
  ///  State fields for stateful widgets in this component.

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
  // State field(s) for Checkbox widget.
  bool? checkboxValue4;

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
