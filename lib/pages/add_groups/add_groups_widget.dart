import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'add_groups_model.dart';
export 'add_groups_model.dart';

class AddGroupsWidget extends StatefulWidget {
  const AddGroupsWidget({super.key});

  @override
  State<AddGroupsWidget> createState() => _AddGroupsWidgetState();
}

class _AddGroupsWidgetState extends State<AddGroupsWidget> {
  late AddGroupsModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AddGroupsModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      FFAppState().userFriendsList =
          (currentUserDocument?.friendsList.toList() ?? [])
              .toList()
              .cast<String>();
      safeSetState(() {});
    });

    _model.userGroupTextTextController ??= TextEditingController();
    _model.userGroupTextFocusNode ??= FocusNode();

    _model.createGroupTextController ??= TextEditingController();
    _model.createGroupFocusNode ??= FocusNode();

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        appBar: AppBar(
          backgroundColor: const Color(0xFFF1F4F8),
          automaticallyImplyLeading: false,
          title: Text(
            'Add/Create Groups',
            style: FlutterFlowTheme.of(context).headlineSmall.override(
                  fontFamily: 'Outfit',
                  color: const Color(0xFF14181B),
                  fontSize: 24.0,
                  letterSpacing: 0.0,
                  fontWeight: FontWeight.w500,
                ),
          ),
          actions: const [],
          centerTitle: false,
          elevation: 0.0,
        ),
        body: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: SizedBox(
                    width: 200.0,
                    child: TextFormField(
                      controller: _model.userGroupTextTextController,
                      focusNode: _model.userGroupTextFocusNode,
                      autofocus: false,
                      obscureText: false,
                      decoration: InputDecoration(
                        isDense: true,
                        labelStyle:
                            FlutterFlowTheme.of(context).headlineSmall.override(
                                  fontFamily: 'Lato',
                                  letterSpacing: 0.0,
                                ),
                        hintText: 'Add Group',
                        hintStyle:
                            FlutterFlowTheme.of(context).bodyMedium.override(
                                  fontFamily: 'Lato',
                                  fontSize: 17.0,
                                  letterSpacing: 0.0,
                                ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Color(0x00000000),
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Color(0x00000000),
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: FlutterFlowTheme.of(context).error,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: FlutterFlowTheme.of(context).error,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        filled: true,
                        fillColor:
                            FlutterFlowTheme.of(context).secondaryBackground,
                      ),
                      style: FlutterFlowTheme.of(context).titleMedium.override(
                            fontFamily: 'Lato',
                            letterSpacing: 0.0,
                          ),
                      cursorColor: FlutterFlowTheme.of(context).primaryText,
                      validator: _model.userGroupTextTextControllerValidator
                          .asValidator(context),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: FFButtonWidget(
                    onPressed: () async {
                      _model.groupOutput = await queryGroupsRecordOnce(
                        queryBuilder: (groupsRecord) => groupsRecord.where(
                          'GroupName',
                          isEqualTo: _model.userGroupTextTextController.text,
                        ),
                        singleRecord: true,
                      ).then((s) => s.firstOrNull);
                      if (_model.groupOutput?.groupName ==
                          _model.userGroupTextTextController.text) {
                        await _model.groupOutput!.reference.update({
                          ...mapToFirestore(
                            {
                              'UserInGroup': FieldValue.arrayUnion(
                                  [currentUserDisplayName]),
                            },
                          ),
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Sucess!',
                              style: TextStyle(
                                color: FlutterFlowTheme.of(context).primaryText,
                              ),
                            ),
                            duration: const Duration(milliseconds: 4000),
                            backgroundColor:
                                FlutterFlowTheme.of(context).secondary,
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Group name does not exist. Please check your spelling',
                              style: TextStyle(
                                color: FlutterFlowTheme.of(context).primaryText,
                              ),
                            ),
                            duration: const Duration(milliseconds: 4000),
                            backgroundColor: FlutterFlowTheme.of(context).error,
                          ),
                        );
                      }

                      safeSetState(() {});
                    },
                    text: 'Add',
                    options: FFButtonOptions(
                      width: 70.0,
                      height: 40.0,
                      padding: const EdgeInsets.all(0.0),
                      iconPadding:
                          const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                      color: const Color(0xFFA86CA9),
                      textStyle:
                          FlutterFlowTheme.of(context).titleSmall.override(
                                fontFamily: 'Lato',
                                color: FlutterFlowTheme.of(context).primaryText,
                                letterSpacing: 0.0,
                              ),
                      elevation: 10.0,
                      borderSide: BorderSide(
                        color: FlutterFlowTheme.of(context).primaryText,
                      ),
                      borderRadius: BorderRadius.circular(14.0),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: SizedBox(
                    width: 200.0,
                    child: TextFormField(
                      controller: _model.createGroupTextController,
                      focusNode: _model.createGroupFocusNode,
                      autofocus: false,
                      obscureText: false,
                      decoration: InputDecoration(
                        isDense: true,
                        labelStyle:
                            FlutterFlowTheme.of(context).titleLarge.override(
                                  fontFamily: 'Lato',
                                  letterSpacing: 0.0,
                                ),
                        hintText: 'Create Group',
                        hintStyle:
                            FlutterFlowTheme.of(context).bodyMedium.override(
                                  fontFamily: 'Lato',
                                  fontSize: 17.0,
                                  letterSpacing: 0.0,
                                ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Color(0x00000000),
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Color(0x00000000),
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: FlutterFlowTheme.of(context).error,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: FlutterFlowTheme.of(context).error,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        filled: true,
                        fillColor:
                            FlutterFlowTheme.of(context).secondaryBackground,
                      ),
                      style: FlutterFlowTheme.of(context).titleMedium.override(
                            fontFamily: 'Lato',
                            letterSpacing: 0.0,
                          ),
                      cursorColor: FlutterFlowTheme.of(context).primaryText,
                      validator: _model.createGroupTextControllerValidator
                          .asValidator(context),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: FFButtonWidget(
                    onPressed: () async {
                      _model.singleGroup = await queryGroupsRecordOnce(
                        queryBuilder: (groupsRecord) => groupsRecord.where(
                          'GroupName',
                          isEqualTo: _model.createGroupTextController.text,
                        ),
                        singleRecord: true,
                      ).then((s) => s.firstOrNull);
                      if (_model.singleGroup?.groupName != null &&
                          _model.singleGroup?.groupName != '') {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Group Has already been created. Please choose a new name.',
                              style: TextStyle(
                                color: FlutterFlowTheme.of(context).primaryText,
                              ),
                            ),
                            duration: const Duration(milliseconds: 4000),
                            backgroundColor:
                                FlutterFlowTheme.of(context).secondary,
                          ),
                        );
                      } else {
                        await GroupsRecord.collection.doc().set({
                          ...createGroupsRecordData(
                            groupName: _model.createGroupTextController.text,
                          ),
                          ...mapToFirestore(
                            {
                              'UserInGroup': [currentUserUid],
                            },
                          ),
                        });
                      }

                      safeSetState(() {});
                    },
                    text: 'Add',
                    options: FFButtonOptions(
                      width: 70.0,
                      height: 40.0,
                      padding: const EdgeInsets.all(0.0),
                      iconPadding:
                          const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                      color: const Color(0xFFA86CA9),
                      textStyle:
                          FlutterFlowTheme.of(context).titleSmall.override(
                                fontFamily: 'Lato',
                                color: FlutterFlowTheme.of(context).primaryText,
                                letterSpacing: 0.0,
                              ),
                      elevation: 10.0,
                      borderSide: BorderSide(
                        color: FlutterFlowTheme.of(context).primaryText,
                      ),
                      borderRadius: BorderRadius.circular(14.0),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
