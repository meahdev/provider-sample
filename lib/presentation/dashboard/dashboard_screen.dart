import 'package:flutter/material.dart';
import 'package:flutter_provider_test/application/provider/dashboard/dashboard_provider.dart';
import 'package:flutter_provider_test/core/app_colors.dart';
import 'package:flutter_provider_test/core/routes.dart';
import 'package:flutter_provider_test/infrastrcture/dashboard/dashboard_repo.dart';
import 'package:flutter_provider_test/presentation/dashboard/widget/product_list_item.dart';
import 'package:flutter_provider_test/presentation/widgets/custom_appbar.dart';
import 'package:provider/provider.dart';

import '../splash/loader_view.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../core/strings.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<DashBoardProvider>().getProducts();
    });
    return Scaffold(
      appBar: appBarView(context),
      body: bodyView(),
    );
  }

  Consumer<DashBoardProvider> bodyView() {
    return Consumer<DashBoardProvider>(builder: (context, task, child) {
      return SafeArea(
        child: LoaderView(
            isAsyncCall: task.isLoading,
            child: task.productListInfo.isEmpty
                ? emptyView(task)
                : alignedGridView(task)),
      );
    });
  }

  AlignedGridView alignedGridView(DashBoardProvider task) {
    return AlignedGridView.count(
        itemCount: task.productListInfo.length,
        crossAxisCount: 2,
        itemBuilder: (context, index) {
          var item = task.productListInfo[index];
          return InkWell(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            focusColor: Colors.transparent,
            onTap: () {},
            child: ProductListItem(
              image: item.image ?? "",
              title: item.title ?? "",
              price: item.price.toString(),
            ),
          );
        });
  }

  Center emptyView(DashBoardProvider task) {
    return Center(
      child: !task.isLoading
          ? const Text(AppStrings.noDataAvailable)
          : Container(),
    );
  }

  CustomAppbar appBarView(BuildContext context) {
    return CustomAppbar(
      title: "",
      backGroundColor: AppColors.primaryColor,
      isHasSettings: true,
      onSettingPress: () {
        Navigator.pushNamed(context, Routes.notification);
      },
    );
  }
}
