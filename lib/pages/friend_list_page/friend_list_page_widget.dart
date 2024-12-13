import '/auth/firebase_auth/auth_util.dart';
import '/backend/custom_cloud_functions/custom_cloud_function_response_manager.dart';
import '/components/friend_removed/friend_removed_widget.dart';
import '/components/friend_requests_comp/friend_requests_comp_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'friend_list_page_model.dart';
export 'friend_list_page_model.dart';

class FriendListPageWidget extends StatefulWidget {
  const FriendListPageWidget({super.key});

  @override
  State<FriendListPageWidget> createState() => _FriendListPageWidgetState();
}

class _FriendListPageWidgetState extends State<FriendListPageWidget> {
  late FriendListPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => FriendListPageModel());

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
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(0.0, 70.0, 0.0, 0.0),
                      child: AuthUserStreamWidget(
                        builder: (context) => Builder(
                          builder: (context) {
                            final friendList =
                                (currentUserDocument?.friendsList.toList() ??
                                        [])
                                    .toList();

                            return Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: List.generate(friendList.length,
                                  (friendListIndex) {
                                final friendListItem =
                                    friendList[friendListIndex];
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
                                              friendListItem,
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily: 'Lato',
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primaryText,
                                                        letterSpacing: 0.0,
                                                      ),
                                            ),
                                            Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                FlutterFlowIconButton(
                                                  borderRadius: 8.0,
                                                  buttonSize: 40.0,
                                                  fillColor:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .error,
                                                  icon: Icon(
                                                    Icons.remove_circle,
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .info,
                                                    size: 24.0,
                                                  ),
                                                  showLoadingIndicator: true,
                                                  onPressed: () async {
                                                    try {
                                                      final result =
                                                          await FirebaseFunctions
                                                              .instance
                                                              .httpsCallable(
                                                                  'removeFriend')
                                                              .call({
                                                        "removerID":
                                                            currentUserUid,
                                                        "friendDisplayName":
                                                            friendListItem,
                                                      });
                                                      _model.cloudFunction19z =
                                                          RemoveFriendCloudFunctionCallResponse(
                                                        succeeded: true,
                                                      );
                                                    } on FirebaseFunctionsException catch (error) {
                                                      _model.cloudFunction19z =
                                                          RemoveFriendCloudFunctionCallResponse(
                                                        errorCode: error.code,
                                                        succeeded: false,
                                                      );
                                                    }

                                                    if (_model.cloudFunction19z!
                                                        .succeeded!) {
                                                      safeSetState(() {});
                                                      await showModalBottomSheet(
                                                        isScrollControlled:
                                                            true,
                                                        backgroundColor:
                                                            Colors.transparent,
                                                        enableDrag: false,
                                                        context: context,
                                                        builder: (context) {
                                                          return GestureDetector(
                                                            onTap: () {
                                                              FocusScope.of(
                                                                      context)
                                                                  .unfocus();
                                                              FocusManager
                                                                  .instance
                                                                  .primaryFocus
                                                                  ?.unfocus();
                                                            },
                                                            child: Padding(
                                                              padding: MediaQuery
                                                                  .viewInsetsOf(
                                                                      context),
                                                              child:
                                                                  const FriendRemovedWidget(),
                                                            ),
                                                          );
                                                        },
                                                      ).then((value) =>
                                                          safeSetState(() {}));
                                                    } else {
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                        SnackBar(
                                                          content: Text(
                                                            'Error: unable to remove frend',
                                                            style: TextStyle(
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .primaryText,
                                                            ),
                                                          ),
                                                          duration: const Duration(
                                                              milliseconds:
                                                                  4000),
                                                          backgroundColor:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .redd,
                                                        ),
                                                      );
                                                    }

                                                    safeSetState(() {});
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
                              }),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Friends',
                    style: FlutterFlowTheme.of(context).displaySmall.override(
                          fontFamily: 'Lato',
                          letterSpacing: 0.0,
                        ),
                  ),
                  FlutterFlowIconButton(
                    borderColor: FFAppState().BorderColor,
                    borderRadius: 8.0,
                    borderWidth: 2.0,
                    buttonSize: 40.0,
                    fillColor: FFAppState().ButtonColor,
                    icon: Icon(
                      Icons.group_add,
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
                      await showModalBottomSheet(
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        enableDrag: false,
                        context: context,
                        builder: (context) {
                          return GestureDetector(
                            onTap: () {
                              FocusScope.of(context).unfocus();
                              FocusManager.instance.primaryFocus?.unfocus();
                            },
                            child: Padding(
                              padding: MediaQuery.viewInsetsOf(context),
                              child: const FriendRequestsCompWidget(),
                            ),
                          );
                        },
                      ).then((value) => safeSetState(() {}));
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
