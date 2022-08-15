import 'package:greggs_bake/framework_code/nav/nav.dart';

import '../framework_code/framework_expanded_image_view.dart';
import '../framework_code/framework_theme.dart';
import '../framework_code/framework_util.dart';
import '../framework_code/framework_widgets.dart';
import 'package:badges/badges.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';

class ItemDetailsWidget extends StatefulWidget {
  const ItemDetailsWidget({
    Key? key,
    this.sausageitem,
  }) : super(key: key);

  final dynamic sausageitem;

  @override
  _ItemDetailsWidgetState createState() => _ItemDetailsWidgetState();
}

class _ItemDetailsWidgetState extends State<ItemDetailsWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Title(
        title: 'Item_details',
        color: FrameworkTheme.of(context).primaryColor,
        child: Scaffold(
          key: scaffoldKey,
          appBar: AppBar(
            backgroundColor: FrameworkTheme.of(context).primaryColor,
            automaticallyImplyLeading: true,
            title: Text(
              'Item Details',
              style: FrameworkTheme.of(context).title2.override(
                    fontFamily: 'Poppins',
                    color: Colors.white,
                    fontSize: 22,
                  ),
            ),
            actions: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 0, 20, 0),
                child: InkWell(
                  onTap: () async {
                    context.pushNamed('cart_page');
                  },
                  child: Badge(
                    badgeContent: Text(
                      FFAppState().totalcartItems.length.toString(),
                      style: FrameworkTheme.of(context).bodyText1.override(
                            fontFamily: 'Poppins',
                            color: Colors.white,
                          ),
                    ),
                    showBadge: true,
                    shape: BadgeShape.circle,
                    badgeColor: FrameworkTheme.of(context).primaryColor,
                    elevation: 4,
                    padding: EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
                    position: BadgePosition.topEnd(),
                    animationType: BadgeAnimationType.scale,
                    toAnimate: true,
                    child: Icon(
                      Icons.shopping_basket,
                      color: FrameworkTheme.of(context).secondaryBackground,
                      size: 24,
                    ),
                  ),
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
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(5, 5, 5, 5),
                    child: Container(
                      width: double.infinity,
                      height: 300,
                      decoration: BoxDecoration(
                        color: FrameworkTheme.of(context).secondaryBackground,
                      ),
                      child: InkWell(
                        onTap: () async {
                          await Navigator.push(
                            context,
                            PageTransition(
                              type: PageTransitionType.fade,
                              child: FrameworkExpandedImageView(
                                image: CachedNetworkImage(
                                  imageUrl: getJsonField(
                                    widget.sausageitem,
                                    r'''$.imageUri''',
                                  ),
                                  fit: BoxFit.fill,
                                ),
                                allowRotation: false,
                                tag: getJsonField(
                                  widget.sausageitem,
                                  r'''$.imageUri''',
                                ),
                                useHeroAnimation: true,
                              ),
                            ),
                          );
                        },
                        child: Hero(
                          tag: getJsonField(
                            widget.sausageitem,
                            r'''$.imageUri''',
                          ),
                          transitionOnUserGestures: true,
                          child: CachedNetworkImage(
                            imageUrl: getJsonField(
                              widget.sausageitem,
                              r'''$.imageUri''',
                            ),
                            width: 100,
                            height: 100,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                        child: Text(
                          getJsonField(
                            widget.sausageitem,
                            r'''$.articleName''',
                          ).toString(),
                          style: FrameworkTheme.of(context).bodyText1,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 0, 10, 0),
                        child: Text(
                          getJsonField(
                            widget.sausageitem,
                            r'''$.eatInPrice''',
                          ).toString(),
                          style: FrameworkTheme.of(context).bodyText1,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 29, 0, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 0, 5, 0),
                          child: FFButtonWidget(
                            onPressed: () async {
                              setState(() =>
                                  FFAppState().totalcartItems.add(getJsonField(
                                        widget.sausageitem,
                                        r'''$''',
                                      )));
                            },
                            text: 'Add to cart',
                            options: FFButtonOptions(
                              width: 130,
                              height: 40,
                              color: FrameworkTheme.of(context).primaryColor,
                              textStyle: FrameworkTheme.of(context)
                                  .subtitle2
                                  .override(
                                    fontFamily: 'Poppins',
                                    color: Colors.white,
                                  ),
                              borderSide: BorderSide(
                                color: Colors.transparent,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
