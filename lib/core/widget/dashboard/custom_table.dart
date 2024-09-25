import 'package:bootstrap_grid/bootstrap_grid.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wallpaper_app/constants_dashboard.dart';
import 'package:wallpaper_app/core/config.dart';
import 'package:responsive_table/responsive_table.dart';

class CustomTable extends StatelessWidget {
  CustomTable(this.title, this.headers, this.rows, this.actions,
      {required this.total,
      required this.currentPage,
      required this.paginate,
      required this.nextPage,
      this.leading,
      required this.prevPage,
      this.isLoading = false,
      this.searchController,
      this.onSearch,
      this.addItem});

  String title;
  List<Map<String, dynamic>> headers = [];
  List<DatatableHeader>? actions;
  List<DatatableHeader>? leading;
  List<int> _perPages = [15];
  int total;
  int? _currentPerPage = 15;
  List<bool>? _expanded;
  Function()? addItem;
  int currentPage = 1;

  List<Map<String, dynamic>> rows = [];
  List<Map<String, dynamic>> _selecteds = [];
  // ignore: unused_field
  final String _selectableKey = "id";
  Function(int) paginate;
  Function(String)? onSearch;
  TextEditingController? searchController;
  bool isLoading;
  bool showSelect = true;

  String? nextPage;
  String? prevPage;

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 400,
      padding: const EdgeInsets.all(defaultPadding),
      decoration: const BoxDecoration(
        color: secondaryColor,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BootstrapRow(
            textDirection: TextDirection.rtl,
            children: [
              BootstrapCol(
                lg: addItem == null || onSearch == null ? 9 : 8,
                md: 4,
                sm: addItem == null || onSearch == null ? 6 : 12,
                xs: addItem == null || onSearch == null ? 4 : 12,
                child: Text(
                  title,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(color: Config.secondColor, fontSize: 18),
                ),
              ),
              BootstrapCol(
                lg: addItem == null || onSearch == null ? 3 : 4,
                md: 8,
                sm: addItem == null || onSearch == null ? 4 : 12,
                xs: addItem == null || onSearch == null ? 7 : 12,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    onSearch != null
                        ? Container(
                            width: 220,
                            decoration: BoxDecoration(
                                border: Border(
                              bottom: BorderSide(color: Colors.grey[100]!),
                            )),
                            child: TextField(
                              keyboardType: TextInputType.text,
                              onChanged: onSearch,
                              controller: searchController,
                              decoration: InputDecoration(
                                  suffixIcon: InkWell(
                                    onTap: () {
                                      searchController?.text = "";
                                      onSearch!("");
                                    },
                                    child: const Icon(Icons.close),
                                  ),
                                  border: InputBorder.none,
                                  hintText: "بحث...",
                                  prefixIcon: Icon(Icons.search),
                                  hintStyle:
                                      TextStyle(color: Colors.grey[400])),
                            ),
                          )
                        : const SizedBox(width: 0),
                    const SizedBox(width: 14),
                    addItem != null
                        ? ElevatedButton.icon(
                            style: TextButton.styleFrom(),
                            onPressed: addItem,
                            icon: Icon(Icons.add),
                            label: Text("جديد"),
                          )
                        : const SizedBox(),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 8),
          SizedBox(
            height: Get.height - 200,
            child: ResponsiveDatatable(
              reponseScreenSizes: [ScreenSize.xs],
              headers: [
                if (leading != null) ...leading!,
                ...headers
                    .map((e) =>
                        DatatableHeader(text: e["text"], value: e["value"]))
                    .toList(),
                if (actions != null) ...actions!
              ],
              source: rows,
              selecteds: _selecteds,
              isExpandRows: false,
              showSelect: false,
              autoHeight: false,
              onChangedRow: (value, header) {
                /// print(value);
                /// print(header);
              },
              onSubmittedRow: (value, header) {
                /// print(value);
                /// print(header);
              },
              onTabRow: (data) {
                print(data);
              },
              expanded: rows.map((e) => true).toList(),
              isLoading: isLoading,
              footers: [
                // Container(
                //   padding: const EdgeInsets.symmetric(horizontal: 15),
                //   child: Text("عدد العناصر : "),
                // ),
                // if (_perPages.isNotEmpty)
                //   Container(
                //     padding: const EdgeInsets.symmetric(horizontal: 15),
                //     child: DropdownButton<int>(
                //       value: _currentPerPage,
                //       items: _perPages
                //           .map((e) => DropdownMenuItem<int>(
                //                 child: Text("$e"),
                //                 value: e,
                //               ))
                //           .toList(),
                //       onChanged: (dynamic value) {
                //         // setState(() {
                //         //   _currentPerPage = value;
                //         //   _currentPage = 1;
                //         //   _resetData();
                //         // });
                //       },
                //       isExpanded: false,
                //     ),
                //   ),

                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Text("$currentPage - $_currentPerPage من $total"),
                ),
                IconButton(
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    size: 16,
                    color: Colors.white,
                  ),
                  onPressed: prevPage == null
                      ? null
                      : () {
                          paginate(currentPage - 1);
                        },
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                ),
                IconButton(
                  icon: const Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                    color: Colors.white,
                  ),
                  onPressed: nextPage == null
                      ? null
                      : () {
                          paginate(currentPage + 1);
                        },
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                )
              ],
            ),
          ),
          // SizedBox(
          //   width: double.infinity,
          //   child: DataTable(
          //     columnSpacing: defaultPadding,
          //     columns: const [
          //       DataColumn(
          //         label: Text("الاسم"),
          //       ),
          //       DataColumn(
          //         label: Text("السعر"),
          //       ),
          //       DataColumn(
          //         label: Text("الوصف"),
          //       ),
          //     ],
          //     rows: rows,
          //   ),
          // ),
        ],
      ),
    );
  }
}
