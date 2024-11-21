import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'add_groups_widget.dart' show AddGroupsWidget;
import 'package:flutter/material.dart';

class AddGroupsModel extends FlutterFlowModel<AddGroupsWidget> {
  ///  State fields for stateful widgets in this page.

  // State field(s) for userGroupText widget.
  FocusNode? userGroupTextFocusNode;
  TextEditingController? userGroupTextTextController;
  String? Function(BuildContext, String?)? userGroupTextTextControllerValidator;
  // Stores action output result for [Backend Call - Create Document] action in Button widget.
  GroupsRecord? allGroups;
  // State field(s) for CreateGroup widget.
  FocusNode? createGroupFocusNode;
  TextEditingController? createGroupTextController;
  String? Function(BuildContext, String?)? createGroupTextControllerValidator;
  // Stores action output result for [Firestore Query - Query a collection] action in Button widget.
  GroupsRecord? singleGroup;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    userGroupTextFocusNode?.dispose();
    userGroupTextTextController?.dispose();

    createGroupFocusNode?.dispose();
    createGroupTextController?.dispose();
  }
}
