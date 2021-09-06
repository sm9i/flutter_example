import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

typedef RefreshData<T> = Future<T> Function(int pageIndex);
typedef RefreshBuilder<T> = Widget Function(BuildContext context, T value);

class RefreshWidget<T> extends StatefulWidget {
  const RefreshWidget({Key? key, required this.fetchData, required this.builder}) : super(key: key);
  final RefreshData<List<T>> fetchData;
  final RefreshBuilder<List<T>> builder;

  @override
  _RefreshWidgetState<T> createState() => _RefreshWidgetState<T>();
}

class _RefreshWidgetState<T> extends State<RefreshWidget<T>> {
  final EasyRefreshController refreshController = EasyRefreshController();

  List<T> data = [];
  int pageIndex = 1;

  void getList() {
    widget.fetchData.call(pageIndex).then((List<T> value) {
      if (pageIndex == 1) {
        data = List.from(value);
        refreshController.finishRefresh();
      } else {
        data = <T>[...data, ...value];
        refreshController.finishLoad(noMore: value.isEmpty);
      }
      if (mounted) {
        setState(() {});
      }
    });
  }

  void loadMore() {
    pageIndex++;
    getList();
  }

  void refresh() {
    pageIndex = 1;
    getList();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    refreshController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return EasyRefresh(
      controller: refreshController,
      onRefresh: () async => refresh(),
      onLoad: () async => loadMore(),
      enableControlFinishLoad: true,
      enableControlFinishRefresh: true,
      child: widget.builder(context, data),
    );
  }
}
