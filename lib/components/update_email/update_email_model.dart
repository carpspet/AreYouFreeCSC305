import '/flutter_flow/flutter_flow_util.dart';
import 'update_email_widget.dart' show UpdateEmailWidget;
import 'package:flutter/material.dart';

class UpdateEmailModel extends FlutterFlowModel<UpdateEmailWidget> {
  ///  State fields for stateful widgets in this component.

  final formKey = GlobalKey<FormState>();
  // State field(s) for newEmail widget.
  FocusNode? newEmailFocusNode;
  TextEditingController? newEmailTextController;
  String? Function(BuildContext, String?)? newEmailTextControllerValidator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    newEmailFocusNode?.dispose();
    newEmailTextController?.dispose();
  }
}
