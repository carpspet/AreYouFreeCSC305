import '/flutter_flow/flutter_flow_util.dart';
import 'change_password_widget.dart' show ChangePasswordWidget;
import 'package:flutter/material.dart';

class ChangePasswordModel extends FlutterFlowModel<ChangePasswordWidget> {
  ///  State fields for stateful widgets in this component.

  final formKey = GlobalKey<FormState>();
  // State field(s) for userEmailPassChange widget.
  FocusNode? userEmailPassChangeFocusNode;
  TextEditingController? userEmailPassChangeTextController;
  String? Function(BuildContext, String?)?
      userEmailPassChangeTextControllerValidator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    userEmailPassChangeFocusNode?.dispose();
    userEmailPassChangeTextController?.dispose();
  }
}
