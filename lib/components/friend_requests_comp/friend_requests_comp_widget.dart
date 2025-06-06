import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/add_friend_page/add_friend_page_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'friend_requests_comp_model.dart';
export 'friend_requests_comp_model.dart';

class FriendRequestsCompWidget extends StatefulWidget {
  const FriendRequestsCompWidget({super.key});

  @override
  State<FriendRequestsCompWidget> createState() =>
      _FriendRequestsCompWidgetState();
}

class _FriendRequestsCompWidgetState extends State<FriendRequestsCompWidget> {
  late FriendRequestsCompModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => FriendRequestsCompModel());

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
                        'Friend Requests',
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
              StreamBuilder<List<FriendRequestsRecord>>(
                stream: queryFriendRequestsRecord(
                  queryBuilder: (friendRequestsRecord) =>
                      friendRequestsRecord.where(
                    'receiverID',
                    isEqualTo: currentUserEmail,
                  ),
                ),
                builder: (context, snapshot) {
                  // Customize what your widget looks like when it's loading.
                  if (!snapshot.hasData) {
                    return Center(
                      child: SizedBox(
                        width: 50.0,
                        height: 50.0,
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                            FlutterFlowTheme.of(context).primary,
                          ),
                        ),
                      ),
                    );
                  }
                  List<FriendRequestsRecord> listViewFriendRequestsRecordList =
                      snapshot.data!;

                  return ListView.builder(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: listViewFriendRequestsRecordList.length,
                    itemBuilder: (context, listViewIndex) {
                      final listViewFriendRequestsRecord =
                          listViewFriendRequestsRecordList[listViewIndex];
                      return Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(
                            0.0, 12.0, 0.0, 44.0),
                        child: ListView(
                          padding: EdgeInsets.zero,
                          primary: false,
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          children: [
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  20.0, 0.0, 30.0, 0.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    listViewFriendRequestsRecord.username,
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily: 'Lato',
                                          letterSpacing: 0.0,
                                        ),
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      FlutterFlowIconButton(
                                        borderColor: Colors.transparent,
                                        borderRadius: 8.0,
                                        buttonSize: 40.0,
                                        icon: const Icon(
                                          Icons.check,
                                          color: Color(0xFF7BFF79),
                                          size: 24.0,
                                        ),
                                        onPressed: () async {
                                          FFAppState().addToUserFriendsList(
                                              listViewFriendRequestsRecord
                                                  .senderID);
                                          safeSetState(() {});
                                          await listViewFriendRequestsRecord
                                              .reference
                                              .delete();
                                        },
                                      ),
                                      FlutterFlowIconButton(
                                        borderColor: Colors.transparent,
                                        borderRadius: 8.0,
                                        buttonSize: 40.0,
                                        icon: const Icon(
                                          Icons.clear,
                                          color: Color(0xFFFF0004),
                                          size: 24.0,
                                        ),
                                        onPressed: () async {
                                          await listViewFriendRequestsRecord
                                              .reference
                                              .delete();
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
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
                  child: Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0.0, 8.0, 0.0, 8.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Align(
                          alignment: const AlignmentDirectional(0.0, 0.0),
                          child: FFButtonWidget(
                            onPressed: () async {
                              await showModalBottomSheet(
                                isScrollControlled: true,
                                backgroundColor: Colors.transparent,
                                context: context,
                                builder: (context) {
                                  return Padding(
                                    padding: MediaQuery.viewInsetsOf(context),
                                    child: const AddFriendPageWidget(),
                                  );
                                },
                              ).then((value) => safeSetState(() {}));
                            },
                            text: 'Send Friend Request',
                            options: FFButtonOptions(
                              width: 200.0,
                              height: 50.0,
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  16.0, 0.0, 16.0, 0.0),
                              iconPadding: const EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 0.0, 0.0),
                              color: FFAppState().ButtonColor,
                              textStyle: FlutterFlowTheme.of(context)
                                  .titleSmall
                                  .override(
                                    fontFamily: 'Lato',
                                    color:
                                        (FFAppState().ButtonColor ==
                                                    FlutterFlowTheme.of(context)
                                                        .black) ||
                                                (FFAppState().ButtonColor ==
                                                    FlutterFlowTheme.of(context)
                                                        .redd) ||
                                                (FFAppState().ButtonColor ==
                                                    FlutterFlowTheme.of(context)
                                                        .green) ||
                                                (FFAppState().ButtonColor ==
                                                    FlutterFlowTheme.of(context)
                                                        .realBlue) ||
                                                (FFAppState().ButtonColor ==
                                                    FlutterFlowTheme.of(context)
                                                        .purple) ||
                                                (FFAppState().ButtonColor ==
                                                    FlutterFlowTheme.of(context)
                                                        .pink)
                                            ? FlutterFlowTheme.of(context).white
                                            : FlutterFlowTheme.of(context)
                                                .primaryText,
                                    letterSpacing: 0.0,
                                  ),
                              elevation: 0.0,
                              borderSide: BorderSide(
                                color: FFAppState().BorderColor,
                                width: 2.0,
                              ),
                              borderRadius: BorderRadius.circular(18.0),
                            ),
                          ),
                        ),
                      ],
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
