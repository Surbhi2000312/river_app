class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _selectedIndex = 0;
  // HomeLendingPage? homeLendingPage = HomeLendingPage();
  SearchPage? searchPage;
  WishlistPage? wishlistPage;
  CartPage? cartPage;
  ProfilePage? profilePage;

  @override
  Widget build(BuildContext context) {


    final _widgetOptions = [
      HomeLendingPage(_scaffoldKey,),
      const SearchPage(),
      const WishlistPage(),
      const CartPage(),
      const ProfilePage(),

    ];
    return Scaffold(

      key: _scaffoldKey,
      drawer: DrawerWidget(),


      body:  _widgetOptions.elementAt(_selectedIndex),

      bottomNavigationBar:BottomAppBar(
        // padding: EdgeInsets.only(top: 14),
          color: ColorConst.primary,
          child: Row(

              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                iconPosition(Iconsax.home_25, 0,"home"),
                iconPosition(Iconsax.search_normal_1, 1,"Search"),
                iconPosition(Iconsax.heart, 2,"favorite"),
                iconPosition(Icons.shopping_cart_outlined,3,"Cart" ),
                iconAssetPosition(AssetsConst.profileIcon,4,"Profile" ),

              ])),
    );

  }
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;

      print("object $_selectedIndex");
    });
  }
  iconPosition(IconData icon, int index,String name) {
    return InkWell(
        onTap: () => _onItemTapped(index),
        child: Column(
          children: [
            Icon(
              icon,
              color: _selectedIndex == index
                  ? ColorConst.green
                  : ColorConst.grey_c,
              semanticLabel: 'A red up arrow',
              size: 22,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: getTxtColor(
                  msg: name,
                  fontSize: 14,
                  txtColor: _selectedIndex == index
                      ? ColorConst.green
                      : ColorConst.grey_c,
              ),
            )
          ],
        ));
  }
  iconAssetPosition(String icon, int index,String name) {
     return InkWell(
        onTap: () => _onItemTapped(index),
        child: Column(
          children: [
            SvgPicture.asset(icon,
                color: _selectedIndex == index
                    ? ColorConst.green
                    : ColorConst.grey_c,
                semanticsLabel: 'A red up arrow',
                height: 22,


            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: getTxtColor(
                msg: name,
                fontSize: 14,
                txtColor: _selectedIndex == index
                    ? ColorConst.green
                    : ColorConst.grey_c,
              ),
            )
          ],
        ));
  }
}
