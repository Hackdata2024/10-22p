import 'package:flutter/material.dart';
import 'package:untitled/recycle_material.dart';
import 'package:untitled/upload_scree.dart';
class NavigationExample extends StatefulWidget {
  const NavigationExample({super.key});

  @override
  State<NavigationExample> createState() => _NavigationExampleState();
}

class _NavigationExampleState extends State<NavigationExample> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          'images/logo_app_fi.png',
          fit: BoxFit.contain,
          height: 200,
          width: 190,
        ),
        backgroundColor: Colors.transparent,
      ),
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        indicatorColor: Colors.lightGreen.shade500,
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.home),
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Badge(child: Icon(Icons.add)),
            label: 'Add',
          ),
          NavigationDestination(
            icon: Badge(
              label: Text('2'),
              child: Icon(Icons.messenger_sharp),
            ),
            label: 'Messages',
          ),
          NavigationDestination(icon: Icon(Icons.eco), label: 'Recycle')
        ],
      ),
      body: <Widget>[
        const MyHome(),
        const UploadScreen(),
        ListView.builder(
          reverse: true,
          itemCount: 2,
          itemBuilder: (BuildContext context, int index) {
            if (index == 0) {
              return Align(
                alignment: Alignment.centerRight,
                child: Container(
                  margin: const EdgeInsets.all(8.0),
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Text(
                    'Hello',
                    style: theme.textTheme.bodyLarge!
                        .copyWith(color: theme.colorScheme.onPrimary),
                  ),
                ),
              );
            }
            return Align(
              alignment: Alignment.centerLeft,
              child: Container(
                margin: const EdgeInsets.all(8.0),
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Text(
                  'Hi!',
                  style: theme.textTheme.bodyLarge!
                      .copyWith(color: theme.colorScheme.onPrimary),
                ),
              ),
            );
          },
        ),
        const Recycle()
      ][currentPageIndex],
    );
  }
}
class MyHome extends StatelessWidget {
  const MyHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // Your existing content here
              Row(
                children: [
                  Expanded(
                    child: FirstRowCardBigger(),
                  ),
                ],
              ),
              SizedBox(height: 20.0),
              Row(
                children: [
                  Expanded(
                    child: CardWidget(
                      headingText: "Reports",
                      subheadingText: "Report problems and request service",
                      iconData: Icons.report,
                    ),
                  ),
                  SizedBox(width: 8.0),
                  Expanded(
                    child: CardWidget(
                      headingText: "Find",
                      subheadingText: "Look-up collection schedules and providers",
                      iconData: Icons.find_in_page,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8.0),
              Row(
                children: [
                  Expanded(
                    child: CardWidget(
                      headingText: "Learn",
                      subheadingText: "Zero waste to landfill education resources",
                      iconData: Icons.book,
                    ),
                  ),
                  SizedBox(width: 8.0),
                  Expanded(
                    child: CardWidget(
                      headingText: "Marketplace",
                      subheadingText: "Buy, sell, or donate recyclable materials",
                      iconData: Icons.eco,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Image.asset(
            'images/bottom_main_home.png',
            height: 120,
            width: 120,
            // Replace with your image asset path
            fit: BoxFit.cover,
          ),
        ),
      ],
    );
  }
}


class FirstRowCardBigger extends StatelessWidget {
  const FirstRowCardBigger({super.key});

  @override
  Widget build(BuildContext context) {
    return const Card(
      child: Column(
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.person),
            title: Text("Hi, Raghav"),
            subtitle: Text("Your Points: 100"),
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Footprint saved:"),
                Text("League:"),
              ],
            ),
          ),
        ],
      ),
    );

  }
}


class CardWidget extends StatelessWidget {
  final String headingText;
  final String subheadingText;
  final IconData iconData;

  const CardWidget({
    Key? key,
    required this.headingText,
    required this.subheadingText,
    required this.iconData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      height: 160,
      child: InkWell(
        splashColor: Colors.blue.withAlpha(30),
        // need to handle on tap  thing here
        onTap: () {
          print('Card tapped');
        },
        child: Card(
          color: Colors.lightGreen.shade500,
          elevation: 5,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(iconData, size: 32, color: Colors.white60,),
                // Adjust the size as needed
                Text(
                  headingText,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Center(
                  child: Text(
                    subheadingText,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

