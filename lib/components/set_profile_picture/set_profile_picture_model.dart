import '/flutter_flow/flutter_flow_util.dart';
import 'set_profile_picture_widget.dart' show SetProfilePictureWidget;
import 'package:flutter/material.dart';

class SetProfilePictureModel extends FlutterFlowModel<SetProfilePictureWidget> {
  ///  State fields for stateful widgets in this component.

  bool isDataUploading = false;
  FFUploadedFile uploadedLocalFile =
      FFUploadedFile(bytes: Uint8List.fromList([]));
  String uploadedFileUrl = '';

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
