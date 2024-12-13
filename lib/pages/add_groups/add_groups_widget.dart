import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/custom_cloud_functions/custom_cloud_function_response_manager.dart';
import '/components/empty_groups_list/empty_groups_list_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
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
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
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
        body: SingleChildScrollView(
          primary: false,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
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
                          labelStyle: FlutterFlowTheme.of(context)
                              .headlineSmall
                              .override(
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
                            borderSide: BorderSide(
                              color: FFAppState().BorderColor,
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Color(0x00000000),
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: FlutterFlowTheme.of(context).error,
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: FlutterFlowTheme.of(context).error,
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          filled: true,
                          fillColor:
                              FlutterFlowTheme.of(context).secondaryBackground,
                        ),
                        style:
                            FlutterFlowTheme.of(context).titleMedium.override(
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

                          await currentUserReference!.update({
                            ...mapToFirestore(
                              {
                                'authGroup': FieldValue.arrayUnion(
                                    [_model.userGroupTextTextController.text]),
                              },
                            ),
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Sucess!',
                                style: TextStyle(
                                  color:
                                      FlutterFlowTheme.of(context).primaryText,
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
                                  color:
                                      FlutterFlowTheme.of(context).primaryText,
                                ),
                              ),
                              duration: const Duration(milliseconds: 4000),
                              backgroundColor:
                                  FlutterFlowTheme.of(context).error,
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
                        color: FFAppState().ButtonColor,
                        textStyle: FlutterFlowTheme.of(context)
                            .titleSmall
                            .override(
                              fontFamily: 'Lato',
                              color: (FFAppState().ButtonColor ==
                                          FlutterFlowTheme.of(context).black) ||
                                      (FFAppState().ButtonColor ==
                                          FlutterFlowTheme.of(context).redd) ||
                                      (FFAppState().ButtonColor ==
                                          FlutterFlowTheme.of(context).green) ||
                                      (FFAppState().ButtonColor ==
                                          FlutterFlowTheme.of(context)
                                              .realBlue) ||
                                      (FFAppState().ButtonColor ==
                                          FlutterFlowTheme.of(context)
                                              .purple) ||
                                      (FFAppState().ButtonColor ==
                                          FlutterFlowTheme.of(context).pink)
                                  ? FlutterFlowTheme.of(context).white
                                  : FlutterFlowTheme.of(context).primaryText,
                              letterSpacing: 0.0,
                            ),
                        elevation: 10.0,
                        borderSide: BorderSide(
                          color: FFAppState().BorderColor,
                          width: 2.0,
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
                            borderSide: BorderSide(
                              color: FFAppState().BorderColor,
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Color(0x00000000),
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: FlutterFlowTheme.of(context).error,
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: FlutterFlowTheme.of(context).error,
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          filled: true,
                          fillColor:
                              FlutterFlowTheme.of(context).secondaryBackground,
                        ),
                        style:
                            FlutterFlowTheme.of(context).titleMedium.override(
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
                                  color:
                                      FlutterFlowTheme.of(context).primaryText,
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
                                'UserInGroup': [currentUserDisplayName],
                              },
                            ),
                          });

                          await currentUserReference!.update({
                            ...mapToFirestore(
                              {
                                'authGroup': FieldValue.arrayUnion(
                                    [_model.createGroupTextController.text]),
                              },
                            ),
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Group sucessfully created!',
                                style: TextStyle(
                                  color:
                                      FlutterFlowTheme.of(context).primaryText,
                                ),
                              ),
                              duration: const Duration(milliseconds: 4000),
                              backgroundColor:
                                  FlutterFlowTheme.of(context).success,
                            ),
                          );
                        }

                        safeSetState(() {});
                      },
                      text: 'Create',
                      options: FFButtonOptions(
                        width: 70.0,
                        height: 40.0,
                        padding: const EdgeInsets.all(0.0),
                        iconPadding:
                            const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                        color: FFAppState().ButtonColor,
                        textStyle: FlutterFlowTheme.of(context)
                            .titleSmall
                            .override(
                              fontFamily: 'Lato',
                              color: (FFAppState().ButtonColor ==
                                          FlutterFlowTheme.of(context).black) ||
                                      (FFAppState().ButtonColor ==
                                          FlutterFlowTheme.of(context).redd) ||
                                      (FFAppState().ButtonColor ==
                                          FlutterFlowTheme.of(context).green) ||
                                      (FFAppState().ButtonColor ==
                                          FlutterFlowTheme.of(context)
                                              .realBlue) ||
                                      (FFAppState().ButtonColor ==
                                          FlutterFlowTheme.of(context)
                                              .purple) ||
                                      (FFAppState().ButtonColor ==
                                          FlutterFlowTheme.of(context).pink)
                                  ? FlutterFlowTheme.of(context).white
                                  : FlutterFlowTheme.of(context).primaryText,
                              letterSpacing: 0.0,
                            ),
                        elevation: 10.0,
                        borderSide: BorderSide(
                          color: FFAppState().BorderColor,
                          width: 2.0,
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
                    padding:
                        const EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 0.0, 0.0),
                    child: Text(
                      'Groups',
                      style:
                          FlutterFlowTheme.of(context).headlineSmall.override(
                                fontFamily: 'Lato',
                                letterSpacing: 0.0,
                              ),
                    ),
                  ),
                ],
              ),
              Divider(
                thickness: 2.0,
                color: FlutterFlowTheme.of(context).alternate,
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0.0, 20.0, 0.0, 0.0),
                  child: AuthUserStreamWidget(
                    builder: (context) => Builder(
                      builder: (context) {
                        final groups =
                            (currentUserDocument?.authGroup.toList() ?? [])
                                .toList();
                        if (groups.isEmpty) {
                          return SizedBox(
                            width: MediaQuery.sizeOf(context).width * 0.9,
                            child: const EmptyGroupsListWidget(),
                          );
                        }

                        return ListView.separated(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemCount: groups.length,
                          separatorBuilder: (_, __) => const SizedBox(height: 30.0),
                          itemBuilder: (context, groupsIndex) {
                            final groupsItem = groups[groupsIndex];
                            return Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  20.0, 0.0, 30.0, 0.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    groupsItem,
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily: 'Lato',
                                          letterSpacing: 0.0,
                                        ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsetsDirectional.fromSTEB(
                                        90.0, 0.0, 0.0, 0.0),
                                    child: FlutterFlowIconButton(
                                      borderColor: Colors.transparent,
                                      borderRadius: 8.0,
                                      buttonSize: 40.0,
                                      fillColor:
                                          FlutterFlowTheme.of(context).blue,
                                      icon: Icon(
                                        Icons.calendar_today,
                                        color:
                                            FlutterFlowTheme.of(context).info,
                                        size: 24.0,
                                      ),
                                      onPressed: () async {
                                        FFAppState().groupName = groupsItem;
                                        FFAppState().groupCalendar = true;
                                        safeSetState(() {});

                                        context.pushNamed('CalendarView');
                                      },
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsetsDirectional.fromSTEB(
                                        20.0, 0.0, 0.0, 0.0),
                                    child: FlutterFlowIconButton(
                                      borderColor: Colors.transparent,
                                      borderRadius: 8.0,
                                      buttonSize: 40.0,
                                      fillColor: const Color(0xFFEF393C),
                                      icon: Icon(
                                        Icons.clear,
                                        color:
                                            FlutterFlowTheme.of(context).info,
                                        size: 24.0,
                                      ),
                                      showLoadingIndicator: true,
                                      onPressed: () async {
                                        try {
                                          final result = await FirebaseFunctions
                                              .instance
                                              .httpsCallable('leaveGroup')
                                              .call({
                                            "groupName": groupsItem,
                                            "userID": currentUserUid,
                                          });
                                          _model.cloudFunctionnjf =
                                              LeaveGroupCloudFunctionCallResponse(
                                            succeeded: true,
                                          );
                                        } on FirebaseFunctionsException catch (error) {
                                          _model.cloudFunctionnjf =
                                              LeaveGroupCloudFunctionCallResponse(
                                            errorCode: error.code,
                                            succeeded: false,
                                          );
                                        }

                                        if (_model
                                            .cloudFunctionnjf!.succeeded!) {
                                          safeSetState(() {});
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                'Sucess!',
                                                style: TextStyle(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primaryText,
                                                ),
                                              ),
                                              duration:
                                                  const Duration(milliseconds: 4000),
                                              backgroundColor:
                                                  FlutterFlowTheme.of(context)
                                                      .success,
                                            ),
                                          );
                                        } else {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                'Error: unable to leave group',
                                                style: TextStyle(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primaryText,
                                                ),
                                              ),
                                              duration:
                                                  const Duration(milliseconds: 4000),
                                              backgroundColor:
                                                  FlutterFlowTheme.of(context)
                                                      .redd,
                                            ),
                                          );
                                        }

                                        safeSetState(() {});
                                      },
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryBackground,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
