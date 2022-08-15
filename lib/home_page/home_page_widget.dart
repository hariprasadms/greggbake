import 'package:greggs_bake/framework_code/nav/nav.dart';
import '../backend/api_requests/api_calls.dart';
import '../framework_code/framework_theme.dart';
import '../framework_code/framework_util.dart';
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import '../framework_code/nav/serialization_util.dart';

class HomePageWidget extends StatefulWidget {
  const HomePageWidget({Key? key}) : super(key: key);

  @override
  _HomePageWidgetState createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Title(
        title: 'HomePage',
        color: FrameworkTheme.of(context).primaryColor,
        child: Scaffold(
          key: scaffoldKey,
          appBar: AppBar(
            backgroundColor: FrameworkTheme.of(context).primaryColor,
            automaticallyImplyLeading: false,
            title: Text(
              'Choose Items',
              style: FrameworkTheme.of(context).title2.override(
                    fontFamily: 'Poppins',
                    color: Colors.white,
                    fontSize: 22,
                  ),
            ),
            actions: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 10, 20, 0),
                child: InkWell(
                  onTap: () async {
                    context.pushNamed('cart_page');
                  },
                  child: FFAppState().totalcartItems.isNotEmpty
                      ? Badge(
                          badgeContent: Text(
                            FFAppState().totalcartItems.length.toString(),
                            style:
                                FrameworkTheme.of(context).bodyText1.override(
                                      fontFamily: 'Poppins',
                                      color: Colors.white,
                                    ),
                          ),
                          showBadge: true,
                          shape: BadgeShape.circle,
                          badgeColor: FrameworkTheme.of(context).alternate,
                          elevation: 4,
                          padding: EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
                          position: BadgePosition.topEnd(),
                          animationType: BadgeAnimationType.scale,
                          toAnimate: true,
                          child: Icon(
                            Icons.shopping_basket,
                            color: Colors.white,
                            size: 24,
                          ),
                        )
                      : Icon(Icons.shopping_basket_rounded),
                ),
              ),
            ],
            centerTitle: false,
            elevation: 2,
          ),
          backgroundColor: FrameworkTheme.of(context).primaryBackground,
          body: SafeArea(
            child: GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: FutureBuilder<ApiCallResponse>(
                future: JsonlistsCall.call(),
                builder: (context, snapshot) {
                  // Customize what your widget looks like when it's loading.
                  if (!snapshot.hasData) {
                    return Center(
                      child: SizedBox(
                        width: 50,
                        height: 50,
                        child: CircularProgressIndicator(
                          color: FrameworkTheme.of(context).primaryColor,
                        ),
                      ),
                    );
                  }
                  final listViewJsonlistsResponse = snapshot.data!;
                  return Builder(
                    builder: (context) {
                      final sausageitems = getJsonField(
                        listViewJsonlistsResponse.jsonBody,
                        r'''$''',
                      ).toList();
                      return ListView.builder(
                        padding: EdgeInsets.zero,
                        scrollDirection: Axis.vertical,
                        itemCount: sausageitems.length,
                        itemBuilder: (context, sausageitemsIndex) {
                          final sausageitemsItem =
                              sausageitems[sausageitemsIndex];
                          return InkWell(
                            onTap: () async {
                              context.pushNamed(
                                'Item_details',
                                queryParams: {
                                  'sausageitem': serializeParam(
                                      getJsonField(
                                        sausageitemsItem,
                                        r'''$''',
                                      ),
                                      ParamType.JSON),
                                }.withoutNulls,
                              );
                            },
                            child: ListTile(
                              title: Text(
                                getJsonField(
                                  sausageitemsItem,
                                  r'''$.articleName''',
                                ).toString(),
                                style: FrameworkTheme.of(context).title3,
                              ),
                              subtitle: Text(
                                getJsonField(
                                  sausageitemsItem,
                                  r'''$.customerDescription''',
                                ).toString().maybeHandleOverflow(maxChars: 30),
                                style: FrameworkTheme.of(context).subtitle2,
                              ),
                              trailing: Icon(
                                Icons.arrow_forward_ios,
                                color: Color(0xFF303030),
                                size: 20,
                              ),
                              tileColor: Color(0xFFF5F5F5),
                              dense: false,
                            ),
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ));
  }
}
