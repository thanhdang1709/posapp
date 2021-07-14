import 'package:fma/get_tool/get_tool.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:pos_app/models/table_model.dart';
import 'package:pos_app/services/table_services.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ConfirmTableController extends GetxController with GetTool {
  // handle here
  PagingController<int, TableModel> pagingController = PagingController(firstPageKey: 1);
  RefreshController refreshController = RefreshController(initialRefresh: false);
  // handle here
  RxList<TableModel> listTable = RxList<TableModel>();
  RxBool isLoading = false.obs;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    pagingController.addPageRequestListener((pageKey) {
      _handeGetTable(pageKey);
    });
  }

  onUpdateStatus({id, status}) async {
    isLoading.value = true;
    Map<String, dynamic> body = {
      'id': id,
      'status': status,
    };
    var res = await TableService().updateStatus(body: body);
    if (res != null) {
      notify.success(title: 'Thành công', message: 'Thay đổi trạng thái thành công');
      // listMenu.firstWhere((e) => e.id == id).status = status;
      isLoading.value = false;
      refreshController.resetNoData();
      refreshController.requestRefresh();
    }
  }

  _handeGetTable(pageKey) async {
    final res = await TableService().getListTable(offset: pageKey, limit: 10, ext: 'status_4');
    if (res != null) {
      listTable.assignAll(res);
      bool isLastPage = listTable.length < 10;
      if (isLastPage) {
        pagingController.appendLastPage(listTable);
      } else {
        pagingController.appendPage(listTable, pageKey + 1);
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
