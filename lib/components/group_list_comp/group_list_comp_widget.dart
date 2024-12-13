import '/auth/firebase_auth/auth_util.dart';
import '/backend/custom_cloud_functions/custom_cloud_function_response_manager.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'group_list_comp_model.dart';
export 'group_list_comp_model.dart';

class GroupListCompWidget extends StatefulWidget {
  const GroupListCompWidget({super.key});

  @override
  State<GroupListCompWidget> createState() => _GroupListCompWidgetState();
}

class _GroupListCompWidgetState extends State<GroupListCompWidget> {
  late GroupListCompModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => GroupListCompModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        width: 300.0,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
              blurRadius: 4.0,
              color: Color(0x33000000),
              offset: Offset(
                0.0,
                2.0,
              ),
            )
          ],
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(0.0, 12.0, 0.0, 12.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Align(
                    alignment: const AlignmentDirectional(-1.0, -1.0),
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Text(
                        'Groups ',
                        style: FlutterFlowTheme.of(context)
                            .headlineMedium
                            .override(
                              fontFamily: 'Lato',
                              letterSpacing: 0.0,
                            ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: const AlignmentDirectional(0.0, -1.0),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: FlutterFlowIconButton(
                        borderColor: FFAppState().BorderColor,
                        borderRadius: 8.0,
                        borderWidth: 2.0,
                        buttonSize: 40.0,
                        fillColor: FFAppState().ButtonColor,
                        icon: Icon(
                          Icons.close,
                          color: (FFAppState().ButtonColor ==
                                      FlutterFlowTheme.of(context).black) ||
                                  (FFAppState().ButtonColor ==
                                      FlutterFlowTheme.of(context).redd) ||
                                  (FFAppState().ButtonColor ==
                                      FlutterFlowTheme.of(context).green) ||
                                  (FFAppState().ButtonColor ==
                                      FlutterFlowTheme.of(context).realBlue) ||
                                  (FFAppState().ButtonColor ==
                                      FlutterFlowTheme.of(context).purple) ||
                                  (FFAppState().ButtonColor ==
                                      FlutterFlowTheme.of(context).pink)
                              ? FlutterFlowTheme.of(context).white
                              : FlutterFlowTheme.of(context).primaryText,
                          size: 24.0,
                        ),
                        onPressed: () async {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ),
                ],
              ),
              const Divider(
                thickness: 1.0,
                color: Color(0xFFE0E3E7),
              ),
              AuthUserStreamWidget(
                builder: (context) => Builder(
                  builder: (context) {
                    final groups =
                        (currentUserDocument?.authGroup.toList() ?? [])
                            .toList();

                    return ListView.builder(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: groups.length,
                      itemBuilder: (context, groupsIndex) {
                        final groupsItem = groups[groupsIndex];
                        return Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              20.0, 0.0, 30.0, 0.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                              FlutterFlowIconButton(
                                borderRadius: 8.0,
                                buttonSize: 40.0,
                                fillColor: FlutterFlowTheme.of(context).blue,
                                icon: Icon(
                                  Icons.calendar_today,
                                  color: FlutterFlowTheme.of(context).info,
                                  size: 24.0,
                                ),
                                onPressed: () async {
                                  FFAppState().groupName = groupsItem;
                                  FFAppState().groupCalendar = true;
                                  safeSetState(() {});

                                  context.pushNamed('CalendarView');
                                },
                              ),
                              FlutterFlowIconButton(
                                borderRadius: 8.0,
                                buttonSize: 40.0,
                                fillColor: const Color(0xFFEF393C),
                                icon: Icon(
                                  Icons.clear,
                                  color: FlutterFlowTheme.of(context).info,
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

                                  if (_model.cloudFunctionnjf!.succeeded!) {
                                    safeSetState(() {});
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          'Sucess!',
                                          style: TextStyle(
                                            color: FlutterFlowTheme.of(context)
                                                .primaryText,
                                          ),
                                        ),
                                        duration: const Duration(milliseconds: 4000),
                                        backgroundColor:
                                            FlutterFlowTheme.of(context)
                                                .success,
                                      ),
                                    );
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          'Error: unable to leave group',
                                          style: TextStyle(
                                            color: FlutterFlowTheme.of(context)
                                                .primaryText,
                                          ),
                                        ),
                                        duration: const Duration(milliseconds: 4000),
                                        backgroundColor:
                                            FlutterFlowTheme.of(context).redd,
                                      ),
                                    );
                                  }

                                  safeSetState(() {});
                                },
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
              MouseRegion(
                opaque: false,
                cursor: SystemMouseCursors.click ?? MouseCursor.defer,
                onEnter: ((event) async {
                  safeSetState(() => _model.mouseRegionHovered = true);
                }),
                onExit: ((event) async {
                  safeSetState(() => _model.mouseRegionHovered = false);
                }),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 150),
                  curve: Curves.easeInOut,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: _model.mouseRegionHovered
                        ? const Color(0xFFF1F4F8)
                        : Colors.white,
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
