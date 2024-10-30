import 'dart:developer';

import 'package:flutter/material.dart';

class ExampleParallax extends StatefulWidget {
  //  in this i just called the LocationListItem and handling the direction of scroll of list
  const ExampleParallax({
    super.key,
  });

  @override
  State<ExampleParallax> createState() => _ExampleParallaxState();
}

class _ExampleParallaxState extends State<ExampleParallax> {
  PageController _pageController = PageController();

// Function to move to the next page
  // void nextPage() {
  //   _pageController.animateToPage(
  //     _pageController.page!.toInt() + 1,
  //     duration: const Duration(milliseconds: 100),
  //     curve: Curves.easeIn,
  //   );
  // }

// Function to move to the previous page
  // void previousPage() {
  //   _pageController.animateToPage(
  //     _pageController.page!.toInt() - 1,
  //     duration: const Duration(milliseconds: 100),
  //     curve: Curves.easeOut,
  //   );
  // }

// Logic to make sure the page index never goes out of bounds
// This will make sure that the user can swipe infinitely

  // void pageController() {
  //   _pageController.addListener(() {
  //     if (_pageController.page!.toInt() >= locations.length - 1) {
  //       _pageController.animateToPage(
  //         0,
  //         duration: const Duration(milliseconds: 5000),
  //         curve: Curves.easeIn,
  //       );
  //     } else if (_pageController.page!.toInt() <= 0) {
  //       _pageController.animateToPage(
  //         locations.length - 1,
  //         duration: const Duration(milliseconds: 5000),
  //         curve: Curves.easeOut,
  //       );
  //     }
  //   });
  // }

  int page_index = 5000;
  @override
  void initState() {
    _pageController =
        PageController(initialPage: page_index, viewportFraction: 0.8);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          const SizedBox(height: 50),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: 400,
              child: PageView.builder(
                controller:
                    _pageController, // Center the initial page to allow bi-directional scrolling
                scrollDirection: Axis.horizontal,

                onPageChanged: (value) {
                  // Log the current page index if needed
                  log("Current Page Index: $value");
                  // setState(() {
                  //   page_index = value;
                  //   if (page_index == 0) {
                  //     page_index = locations.length - value;
                  //     _pageController = PageController(
                  //         initialPage: page_index, viewportFraction: 0.8);
                  //   }
                  // });
                },
                itemBuilder: (context, index) {
                  // Use modulus operator to cycle through the list infinitely
                  final locationIndex = index % locations.length;

                  return SizedBox(
                    width: 300, // Set fixed width
                    height: 400, // Set fixed height
                    child: LocationListItem(
                      imageUrl: locations[locationIndex].imageUrl,
                      name: locations[locationIndex].name,
                      country: locations[locationIndex].place,
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class LocationListItem extends StatelessWidget {
  // in this i have did stacking
  LocationListItem({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.country,
  });

  final String imageUrl;
  final String name;
  final String country;
  final GlobalKey _backgroundImageKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          children: [
            _buildParallaxBackground(context),
            // _buildGradient(),
            // _buildTitleAndSubtitle(),
          ],
        ),
      ),
    );
  }

  Widget _buildParallaxBackground(BuildContext context) {
    return Flow(
      delegate: ParallaxFlowDelegate(
        scrollable: Scrollable.of(context),
        listItemContext: context,
        backgroundImageKey: _backgroundImageKey,
      ),
      children: [
        Image.network(
          imageUrl,
          key: _backgroundImageKey,
          fit: BoxFit.cover,
          width: 200, // Ensure fixed width
          height: 100, // Ensure fixed height
        ),
      ],
    );
  }

  // Widget _buildGradient() {
  //   return Positioned.fill(
  //     child: DecoratedBox(
  //       decoration: BoxDecoration(
  //         gradient: LinearGradient(
  //           colors: [Colors.transparent, Colors.black.withOpacity(0.7)],
  //           begin: Alignment.topCenter,
  //           end: Alignment.bottomCenter,
  //           stops: const [0.6, 0.95],
  //         ),
  //       ),
  //     ),
  //   );
  // }

  // Widget _buildTitleAndSubtitle() {
  //   return Positioned(
  //     left: 16,
  //     bottom: 16,
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Text(
  //           name,
  //           style: const TextStyle(
  //             color: Colors.white,
  //             fontSize: 16,
  //             fontWeight: FontWeight.bold,
  //           ),
  //         ),
  //         Text(
  //           country,
  //           style: const TextStyle(
  //             color: Colors.white,
  //             fontSize: 12,
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }
}

class ParallaxFlowDelegate extends FlowDelegate {
  /*This class, ParallaxFlowDelegate, is designed to create a parallax effect for background images in a scrollable list in Flutter.
   The parallax effect is a visual technique where background images move at a different speed relative to   foreground content while scrolling,
   giving the illusion of depth. Here's a breakdown of each part of the class: */

  ParallaxFlowDelegate({
    required this.scrollable,
    required this.listItemContext,
    required this.backgroundImageKey,
  }) : super(repaint: scrollable.position);

/*scrollable: Refers to the ScrollableState object (like a ListView) that controls the scrolling.
listItemContext: The BuildContext of the list item in which the background image is displayed.
backgroundImageKey: A GlobalKey used to access the RenderBox of the background image.
 */

  final ScrollableState scrollable;
  final BuildContext listItemContext;
  final GlobalKey backgroundImageKey;

  @override
  /*This method is overriding FlowDelegate's method to specify how much space should be given to each child of the Flow. 
  In this case, it expands the background image to a fixed size of 400x500 pixels. */
  BoxConstraints getConstraintsForChild(int i, BoxConstraints constraints) {
    return const BoxConstraints.expand(
      width: 400, // Ensure fixed width
      height: 500, // Ensure fixed height
    );
  }

  @override
  //This is where the parallax effect is calculated and applied:
  void paintChildren(FlowPaintingContext context) {
    // Calculate the position of this list item within the viewport.
    final scrollableBox = scrollable.context.findRenderObject() as RenderBox;
    final listItemBox = listItemContext.findRenderObject() as RenderBox;
    final listItemOffset = listItemBox.localToGlobal(
        listItemBox.size
            .centerLeft(Offset.zero), // Adjust for horizontal scrolling
        ancestor: scrollableBox);
    /* here this all are doing this
     The scrollableBox is the rendering box of the scrollable area.
The listItemBox is the rendering box of the current list item.
The listItemOffset calculates the position of the list item within the scrollable area. */

    // Determine the percent position of this list item within the scrollable area.
    final viewportDimension = scrollable.position.viewportDimension;
    final scrollFraction =
        (listItemOffset.dx / viewportDimension).clamp(0.0, 1.0);
/*This calculates how far along the horizontal scroll the list item is. It results in a value between 0.0 (fully on the left) and 1.0 (fully on the right). */
    // Calculate the horizontal alignment of the background based on the scroll percent.

    final horizontalAlignment = Alignment(-(scrollFraction * 2 - 1), 0.0);
/*The horizontalAlignment determines how the background image should be aligned based on the scroll position. When the list item is in the middle of the viewport, the background is centered.
 As it moves left or right, the background shifts. */

    // Convert the background alignment into a pixel offset for painting.
    final backgroundSize =
        (backgroundImageKey.currentContext!.findRenderObject() as RenderBox)
            .size;
    final listItemSize = context.size;
    final childRect = horizontalAlignment.inscribe(
        backgroundSize, Offset.zero & listItemSize);
    /*
The backgroundSize is the size of the background image.
The listItemSize is the size of the list item.
horizontalAlignment.inscribe calculates the area where the background should be drawn within the list item. 
*/

// Paint the background.
//This paints the background image at the calculated position, using a horizontal translation.
    context.paintChild(
      0,
      transform:
          Transform.translate(offset: Offset(childRect.left, 0.0)).transform,
    );
  }

  @override
  bool shouldRepaint(ParallaxFlowDelegate oldDelegate) {
    return scrollable != oldDelegate.scrollable ||
        listItemContext != oldDelegate.listItemContext ||
        backgroundImageKey != oldDelegate.backgroundImageKey;
  }
  /*This method tells Flutter whether the FlowDelegate should repaint based on changes to its internal properties. 
  It checks if the scrollable, listItemContext, or backgroundImageKey has changed. 
  If any of these change, the delegate repaints. */
}

//this is just a location model
class Location {
  const Location({
    required this.name,
    required this.place,
    required this.imageUrl,
  });

  final String name;
  final String place;
  final String imageUrl;
}

// this is a base url
const urlPrefix =
    'https://docs.flutter.dev/cookbook/img-files/effects/parallax';
// this is a list of location data
const locations = [
  Location(
    name: 'Mount Rushmore',
    place: 'U.S.A',
    imageUrl: '$urlPrefix/01-mount-rushmore.jpg',
  ),
  Location(
    name: 'Gardens By The Bay',
    place: 'Singapore',
    imageUrl: '$urlPrefix/02-singapore.jpg',
  ),
  Location(
    name: 'Machu Picchu',
    place: 'Peru',
    imageUrl: '$urlPrefix/03-machu-picchu.jpg',
  ),
  Location(
    name: 'Vitznau',
    place: 'Switzerland',
    imageUrl: '$urlPrefix/04-vitznau.jpg',
  ),
  Location(
    name: 'Bali',
    place: 'Indonesia',
    imageUrl: '$urlPrefix/05-bali.jpg',
  ),
  Location(
    name: 'Mexico City',
    place: 'Mexico',
    imageUrl: '$urlPrefix/06-mexico-city.jpg',
  ),
  Location(
    name: 'Cairo',
    place: 'Egypt',
    imageUrl: '$urlPrefix/07-cairo.jpg',
  ),
];
