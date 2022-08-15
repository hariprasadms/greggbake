import 'package:greggs_bake/framework_code/custom_functions.dart';
import '../framework_code/framework_theme.dart';
import '../framework_code/framework_util.dart';
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';

class CartPageWidget extends StatefulWidget {
  const CartPageWidget({Key? key}) : super(key: key);

  @override
  _CartPageWidgetState createState() => _CartPageWidgetState();
}

class _CartPageWidgetState extends State<CartPageWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Title(
        title: 'cart_page',
        color: FrameworkTheme.of(context).primaryColor,
        child: Scaffold(
          key: scaffoldKey,
          appBar: AppBar(
            backgroundColor: FrameworkTheme.of(context).primaryColor,
            automaticallyImplyLeading: true,
            title: Text(
              'Cart Page',
              style: FrameworkTheme.of(context).title2.override(
                    fontFamily: 'Poppins',
                    color: Colors.white,
                    fontSize: 22,
                  ),
            ),
            actions: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 0, 20, 0),
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
                    Icons.shopping_basket_sharp,
                    color: FrameworkTheme.of(context).secondaryBackground,
                    size: 24,
                  ),
                ),
              ),
            ],
            centerTitle: false,
            elevation: 2,
          ),
          backgroundColor: FrameworkTheme.of(context).primaryBackground,
          floatingActionButton: FFAppState().totalcartItems.isNotEmpty
              ? FloatingActionButton.extended(
                  onPressed: () {
                    print('FloatingActionButton pressed ...');
                  },
                  backgroundColor: FrameworkTheme.of(context).primaryColor,
                  elevation: 8,
                  label: Container(
                    child: Text(
                        'Total ${count(FFAppState().totalcartItems)}\$ pay now'),
                  ),
                )
              : Container(
                  child: Center(
                    child: Text('There are no items in the cart'),
                  ),
                ),
          body: SafeArea(
            child: GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: Builder(
                builder: (context) {
                  final cartitems = FFAppState().totalcartItems.toList();
                  return ListView.builder(
                    padding: EdgeInsets.zero,
                    scrollDirection: Axis.vertical,
                    itemCount: cartitems.length,
                    itemBuilder: (context, cartitemsIndex) {
                      final cartitemsItem = cartitems[cartitemsIndex];
                      return InkWell(
                        onTap: () async {
                          setState(() => FFAppState()
                              .totalcartItems
                              .remove(cartitemsItem));
                        },
                        child: ListTile(
                          title: Text(
                            getJsonField(
                              cartitemsItem,
                              r'''$.articleName''',
                            ).toString(),
                            style: FrameworkTheme.of(context).title3,
                          ),
                          subtitle: Text(
                            getJsonField(
                              cartitemsItem,
                              r'''$.eatInPrice''',
                            ).toString(),
                            style: FrameworkTheme.of(context).subtitle2,
                          ),
                          trailing: Icon(
                            Icons.close,
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
              ),
            ),
          ),
        ));
  }
}
