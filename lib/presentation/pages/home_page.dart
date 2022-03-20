import 'package:core/core.dart';
import 'package:ditonton/presentation/provider/home_notifier.dart';
import 'package:flutter/material.dart';
import 'package:movie/movie.dart';
import 'package:provider/provider.dart';
import 'package:tv_show/tv_show.dart';

class HomePage extends StatelessWidget {
  final GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeNotifier>(builder: (ctx, data, child) {
      final activeDrawerItem = data.selectedDrawerItem;

      return Scaffold(
        key: _drawerKey,
        drawer: _buildDrawer(ctx, (DrawerItem newSelectedItem) {
          data.setSelectedDrawerItem(newSelectedItem);
        }, activeDrawerItem),
        appBar: _buildAppBar(ctx, activeDrawerItem),
        body: _buildBody(ctx, activeDrawerItem),
      );
    });
  }

  Widget _buildBody(BuildContext context, DrawerItem seletedDrawerItem) {
    if (seletedDrawerItem == DrawerItem.Movie) {
      return HomeMoviePage();
    } else if (seletedDrawerItem == DrawerItem.TVShow) {
      return HomeTVShowPage();
    }
    return Container();
  }

  AppBar _buildAppBar(
    BuildContext context,
    DrawerItem activeDrawerItem,
  ) {
    return AppBar(
      title: Text(APP_NAME),
      actions: [
        IconButton(
          onPressed: () {
            Navigator.pushNamed(
              context,
              toSearch,
              arguments: activeDrawerItem,
            );
          },
          icon: Icon(Icons.search),
        )
      ],
    );
  }

  Drawer _buildDrawer(
    BuildContext context,
    Function(DrawerItem) itemCallback,
    DrawerItem activeDrawerItem,
  ) {
    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            currentAccountPicture: CircleAvatar(
              backgroundImage: AssetImage('assets/circle-g.png'),
            ),
            accountName: Text(APP_NAME),
            accountEmail: Text('ditonton@dicoding.com'),
          ),
          ListTile(
            tileColor: activeDrawerItem == DrawerItem.Movie ? kDavysGrey : kGrey,
            leading: Icon(Icons.movie_creation_outlined),
            title: Text(moviesPage),
            onTap: () {
              Navigator.pop(context);
              itemCallback(DrawerItem.Movie);
            },
          ),
          ListTile(
            tileColor: activeDrawerItem == DrawerItem.TVShow ? kDavysGrey : kGrey,
            leading: Icon(Icons.live_tv_rounded),
            title: Text(tvShowsPage),
            onTap: () {
              Navigator.pop(context);
              itemCallback(DrawerItem.TVShow);
            },
          ),
          ListTile(
            leading: Icon(Icons.save_alt),
            title: Text(watchlistPage),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, toWatchlist);
            },
          ),
          ListTile(
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, toAbout);
            },
            leading: Icon(Icons.info_outline),
            title: Text(aboutPage),
          ),
        ],
      ),
    );
  }
}
