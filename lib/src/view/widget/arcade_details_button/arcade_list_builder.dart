import 'package:flutter/material.dart';

import 'package:hkarcadequeue/src/model/type/arcade_store.dart';

import 'package:hkarcadequeue/src/view/screen/arcade_queue_status/arcade_details/arcade_details_screen.dart';
import 'package:hkarcadequeue/src/view/widget/crowdness_visualizer.dart';


class ArcadeListBuilder extends StatelessWidget {
  final Iterable<ArcadeStore> arcadeStores;

  const ArcadeListBuilder({super.key, required this.arcadeStores});

  @override
  Widget build(BuildContext context) {
    final ListView builder = ListView.builder(
      itemCount: arcadeStores.length,
      itemBuilder: (BuildContext context, int index) {
        final ArcadeStore arcadeStore = arcadeStores.elementAt(index);
        return Card(
          clipBehavior: Clip.hardEdge,
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (context) =>
                          ArcadeDetailsScreen(underlyingStore: arcadeStore),
                ),
              );
            },
            child: ListTile(
              title: Text(arcadeStore.chineseName),
              subtitle: Text(arcadeStore.abbreviation),
              trailing: PeopleCountShower(id: arcadeStore.id),
            ),
          ),
        );
      },
    );

    return builder;
  }
}

// class ArcadeListBuilderWithRefresh extends StatefulWidget {
//   final Iterable<ArcadeStore> arcadeStores;
//   final AsyncCallback onRefresh;

//   const ArcadeListBuilderWithRefresh({
//     super.key,
//     required this.arcadeStores,
//     required this.onRefresh,
//   });

//   @override
//   State<ArcadeListBuilderWithRefresh> createState() =>
//       _ArcadeListBuilderWithRefreshState();
// }

// class _ArcadeListBuilderWithRefreshState
//     extends State<ArcadeListBuilderWithRefresh>
//     with SingleTickerProviderStateMixin {
//   bool _isComplete = false;
//   bool _hasError = false;

//   Future<void> _handleRefresh() async {
//     try {
//       setState(() {
//         _hasError = false;
//       });
//       await widget.onRefresh();
//     } catch (_) {
//       setState(() {
//         _hasError = true;
//       });
//       rethrow;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     // Content of the ListView builder

//     return CustomRefreshIndicator(
//       durations: const RefreshIndicatorDurations(
//         completeDuration: Duration(seconds: 1),
//       ),
//       onRefresh: _handleRefresh,
//       onStateChanged: (IndicatorStateChange change) {
//         if (change.didChange(to: IndicatorState.complete)) {
//           _isComplete = true;
//         }
//         if (change.didChange(to: IndicatorState.idle)) {
//           _isComplete = false;
//         }
//       },
//       builder: (
//         BuildContext context,
//         Widget child,
//         IndicatorController controller,
//       ) {
//         final IndicatorColors colorsToUse;
//         if (_isComplete) {
//           if (_hasError) {
//             colorsToUse = defaultIndicatorStyle.error;
//           } else {
//             colorsToUse = defaultIndicatorStyle.completed;
//           }
//         } else {
//           colorsToUse = defaultIndicatorStyle.loading;
//         }

//         return AnimatedContainer(
//           duration: const Duration(milliseconds: 150),
//           alignment: Alignment.center,
//           decoration: BoxDecoration(
//             color: colorsToUse.background,
//             shape: BoxShape.circle,
//           ),
//           child: _isComplete
//               ? Icon(
//                   _hasError ? Icons.close : Icons.check,
//                   color: colorsToUse.content,
//                 )
//               : SizedBox(
//                   width: 24,
//                   height: 24,
//                   child: CircularProgressIndicator(
//                     color: colorsToUse.content,
//                     strokeWidth: 2,
//                     value: controller.isDragging || controller.isArmed ? 
//                         controller.value.clamp(0, 1)
//                         : null,
//                   ),
//                 ),
//         );
//       },
//       child: ArcadeListBuilder(arcadeStores: widget.arcadeStores),
//     );
//   }
// }
