import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../common/types.dart';
import '../home/components/notes_grids.dart';
/// class that contains all app's widgets
class HomeMe extends StatefulWidget {
  const HomeMe({super.key});
  @override
  State<HomeMe> createState() => _HomeMeState();
}

class _HomeMeState extends State<HomeMe> {
  @override
  Widget build(BuildContext context) {
    /// Need it to connect this widget's state to children
    return ChangeNotifierProvider(
        create: (context) => NoteGlobalState(),
        child: CupertinoTabScaffold(
          tabBar: CupertinoTabBar(
            iconSize: 25,
            items: const <BottomNavigationBarItem>[
              /// it has two pages: Active notes and archived
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.cube_box_fill),
                label: 'Notes',
              ),
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.archivebox),
                label: 'Archived',
              ),
            ],
          ),
          tabBuilder: (BuildContext context, int index) {
            return CupertinoTabView(
              builder: (BuildContext context) {
                if (index == 0){
                  return const Center(
                    child: ActiveNotesGrid(),
                  );
                }
                else {
                  return const Center(
                  child: ArchivedNotesGrid(),
                );
                }
              },
            );
          },
        ));
  }
}

