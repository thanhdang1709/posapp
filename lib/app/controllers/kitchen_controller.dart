import 'package:fma/get_tool/get_tool.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:pos_app/models/kitchen_model.dart';
import 'package:pos_app/services/kitchen_services.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class KitchenController extends GetxController with GetTool {
  PagingController<int, KitchenModel> pagingController = PagingController(firstPageKey: 0);
  RefreshController refreshController = RefreshController(initialRefresh: false);
  // handle here
  RxList<KitchenModel> listMenu = RxList<KitchenModel>();
  RxBool isLoading = false.obs;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    pagingController.addPageRequestListener((pageKey) {
      _handeGetKitchen(pageKey);
    });
  }

  onUpdateStatus({id, status}) async {
    isLoading.value = true;
    Map<String, String> body = {
      'id': id.toString(),
      'status': status.toString(),
    };
    var res = await KitchenService().cook(body: body);
    if (res != null) {
      notify.success(title: 'Thành công', message: 'Thay đổi trạng thái thành công');
      // listMenu.firstWhere((e) => e.id == id).status = status;
      isLoading.value = false;
      refreshController.resetNoData();
      refreshController.requestRefresh();
    }
  }

  _handeGetKitchen(pageKey) async {
    final res = await KitchenService().getListItem(offset: pageKey, limit: 10);
    if (res != null) {
      listMenu.assignAll(res);

      bool isLastPage = listMenu.length < 10;
      if (isLastPage) {
        pagingController.appendLastPage(listMenu);
      } else {
        pagingController.appendPage(listMenu, pageKey + 1);
      }
      refreshController.refreshCompleted();
    } else {
      notify.error(title: 'common.failure'.tr, message: 'Tải thất bại', timeout: 30000);
      refreshController.loadFailed();
    }
  }

  void onRefresh() async {
    print('onRefresh');
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    // _handleGetCars(1);
    pagingController.refresh();
  }
}
