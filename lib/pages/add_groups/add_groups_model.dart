import '/backend/backend.dart';
import '/backend/custom_cloud_functions/custom_cloud_function_response_manager.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'add_groups_widget.dart' show AddGroupsWidget;
import 'package:flutter/material.dart';

class AddGroupsModel extends FlutterFlowModel<AddGroupsWidget> {
  ///  State fields for stateful widgets in this page.

  // State field(s) for userGroupText widget.
  FocusNode? userGroupTextFocusNode;
  TextEditingController? userGroupTextTextController;
  String? Function(BuildContext, String?)? userGroupTextTextControllerValidator;
  // Stores action output result for [Firestore Query - Query a collection] action in Button widget.
  GroupsRecord? groupOutput;
  // State field(s) for CreateGroup widget.
  FocusNode? createGroupFocusNode;
  TextEditingController? createGroupTextController;
  String? Function(BuildContext, String?)? createGroupTextControllerValidator;
  // Stores action output result for [Firestore Query - Query a collection] action in Button widget.
  GroupsRecord? singleGroup;
  // Stores action output result for [Cloud Function - leaveGroup] action in IconButton widget.
  LeaveGroupCloudFunctionCallResponse? cloudFunctionnjf;

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
