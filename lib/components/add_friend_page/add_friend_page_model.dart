import '/flutter_flow/flutter_flow_util.dart';
import 'add_friend_page_widget.dart' show AddFriendPageWidget;
import 'package:flutter/material.dart';

class AddFriendPageModel extends FlutterFlowModel<AddFriendPageWidget> {
  ///  State fields for stateful widgets in this component.

  final formKey = GlobalKey<FormState>();
  // State field(s) for addFriendEmail widget.
  FocusNode? addFriendEmailFocusNode;
  TextEditingController? addFriendEmailTextController;
  String? Function(BuildContext, String?)?
      addFriendEmailTextControllerValidator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    addFriendEmailFocusNode?.dispose();
    addFriendEmailTextController?.dispose();
  }
}
