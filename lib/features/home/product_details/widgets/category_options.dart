// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:sama_taxi/core/localization/app_strings.dart';
// import 'package:sama_taxi/core/widgets/appbar.dart';
// import 'package:sama_taxi/core/widgets/empty_widget.dart';
// import 'package:sama_taxi/core/widgets/error_widget.dart';
// import 'package:sama_taxi/core/widgets/loading_widget.dart';
// import 'package:sama_taxi/features/lists/presentation/lists_viewmodel.dart';
// import 'package:sama_taxi/features/outstation/domain/models/ride_option.dart';
// import 'package:sama_taxi/features/outstation/presentation/screens/outstation_booking_screen.dart';
// import 'package:sama_taxi/features/taxify/domain/entities/category.dart';
// import 'package:sama_taxi/features/taxify/presentation/widgets/category_item.dart';

// class CategoriesOptionsScreen extends ConsumerStatefulWidget {
//   const CategoriesOptionsScreen({super.key});

//   @override
//   ConsumerState<CategoriesOptionsScreen> createState() => _CategoriesOptionsScreenState();
// }

// class _CategoriesOptionsScreenState extends ConsumerState<CategoriesOptionsScreen> {
//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       ref.read(localcategoriesOptionViewModelProvider.notifier).loadItems();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final rideState = ref.watch(localcategoriesOptionViewModelProvider);

//     return _RideStateHandler(
//         state: rideState,
//         onRetry: _handleRetry,
//         onRefresh: _handleRefresh,
      
//     );
//   }

//   void _handleRetry() {
//     ref.read(localcategoriesOptionViewModelProvider.notifier).loadItems();
//   }

//   Future<void> _handleRefresh() async {
//     await ref.read(localcategoriesOptionViewModelProvider.notifier).loadItems();
//   }
// }

// class _RideStateHandler extends StatelessWidget {
//   const _RideStateHandler({
//     required this.state,
//     required this.onRetry,
//     required this.onRefresh,
//   });

//   final dynamic state;
//   final VoidCallback onRetry;
//   final Future<void> Function() onRefresh;

//   @override
//   Widget build(BuildContext context) {
//     if (state.isLoading) {
//       return const LoadingWidget();
//     }

//     if (state.error != null) {
//       return ErrorDisplayWidget(message: state.error, onRetry: onRetry);
//     }

//     if (state.items.isEmpty) {
//       return EmptyWidget(message: AppStrings.noData.tr(), icon: Icons.cabin);
//     }

//     return RideOptionsList(rideOptions: state.items, onRefresh: onRefresh);
//   }
// }

// class RideOptionsList extends StatelessWidget {
//   const RideOptionsList({required this.rideOptions, required this.onRefresh});

//   final List<RideOption> rideOptions;
//   final Future<void> Function() onRefresh;

//   static const EdgeInsets _listPadding = EdgeInsets.all(16);

//   @override
//   Widget build(BuildContext context) => RefreshIndicator(
//       onRefresh: onRefresh,
//       child: 
//     //   Row(
//     //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//     //   children: List.generate(
//     //     rideOptions.length,
//     //     (index)=>
        
//     //     RideOptionsCard(
//     //       option: rideOptions[index],
//     //     )
//     // )
//     // )
//       ListView.builder(
//         scrollDirection: Axis.horizontal,
//         padding: _listPadding,
//         itemCount: rideOptions.length,
//         itemBuilder: (context, index) => 
//         RideOptionsCard(option:rideOptions[index])
//         //CategoryItem(category: rideOptions[index]),
//       ),
//     );
// }

// class RideOptionsCard extends StatefulWidget {
//   final RideOption option;
//   const RideOptionsCard({super.key, required this.option});

//   @override
//   State<RideOptionsCard> createState() => _RideOptionsCardState();
// }

// class _RideOptionsCardState extends State<RideOptionsCard> {
  
  
//     String? selectedOption;
//       bool isSelected=false;

//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//                   onTap: () {
//                     debugPrint("You Selecte:${widget.option.title}");
//                     setState(() {
//                       isSelected = false;
//                       selectedOption=null;
//                       selectedOption =widget.option.title;
//                       isSelected = selectedOption == widget.option.title;
//                     });
//                   },
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(horizontal:10.0),
//                     child: Container(
//                       width: 120,
//                       height: 120,
//                       padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
//                       decoration: BoxDecoration(
//                         color: isSelected ? Colors.blue.shade50 : Colors.grey.shade100,
//                         borderRadius: BorderRadius.circular(8),
//                         border: Border.all(
//                           color: isSelected ? Colors.blue : Colors.grey.shade300,
//                           width: 1.5,
//                         ),
//                       ),
//                       child: Center(
//                         child: Column(
//                           // mainAxisAlignment: MainAxisAlignment.start,
//                           // spacing: 10,
//                           // crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                               Align(
                                
//                                 alignment: Alignment.topRight,
//                                 child:  Icon(Icons.info_outline, 
//                                 size: 16, color:isSelected ? Colors.red: Colors.grey)),
//                            Column(
//                                    mainAxisAlignment: MainAxisAlignment.center,
//                           spacing: 10,
//                           crossAxisAlignment: CrossAxisAlignment.center,
                           
//                             children: [
//                              SizedBox(
//                             width:100,
//                               child:   Icon(
//                             widget.option.icon,
//                               color: isSelected ? Colors.blue : Colors.grey,
//                               size: 32,
//                             ),
//                              ),
                         
//                             Text(
//                              widget.option.title,
//                               style: TextStyle(
//                                 color: isSelected ? Colors.blue : Colors.black87,
//                                 fontWeight: FontWeight.w500,
//                               ),
//                             ),

//                             ],
//                            )
                                             
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 );
//   }
// }