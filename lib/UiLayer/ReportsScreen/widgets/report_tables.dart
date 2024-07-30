import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gieco_west/DataLayer/Model/my_report.dart';
import 'package:gieco_west/Utils/colors.dart';
import 'package:gieco_west/Utils/widgets/custom_text_wgt.dart';

class ReportTables extends StatelessWidget {
  const ReportTables({super.key, this.tripReport, this.shiftReport});
  final TripReport? tripReport;
  final ShiftReport? shiftReport;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 2.w),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Table(
              children: [
                TableRow(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: MyColors.blackColor,
                    ),
                  ),
                  children: [
                    TableCell(
                        child: Center(
                      child: CustomTextWgt(
                        data: tripReport == null
                            ? "تقرير الوردية (غرب الدلتا)"
                            : "تقرير السفرية (غرب الدلتا)",
                        fontSize: 7.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                  ],
                ),
              ],
            ),
            Table(
              border: const TableBorder(verticalInside: BorderSide()),
              children: [
                TableRow(
                  decoration: const BoxDecoration(
                    border: Border(
                      left: BorderSide(),
                      bottom: BorderSide(),
                      right: BorderSide(),
                    ),
                  ),
                  children: [
                    TableCell(
                        child: Center(
                      child: CustomTextWgt(
                        data: "رقم الجرار",
                        fontSize: 3.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                    TableCell(
                        child: Center(
                      child: CustomTextWgt(
                        fontSize: 3.sp,
                        data: tripReport == null
                            ? shiftReport?.generalReportData?.locoNo ?? ""
                            : tripReport?.generalReportData?.locoNo ?? "",
                      ),
                    )),
                    TableCell(
                        child: Center(
                      child: CustomTextWgt(
                        data: "التاريخ",
                        fontSize: 3.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                    TableCell(
                        child: Center(
                      child: CustomTextWgt(
                        fontSize: 3.sp,
                        data: tripReport == null
                            ? shiftReport?.generalReportData?.locoDate ?? ""
                            : tripReport?.generalReportData?.locoDate ?? "",
                      ),
                    )),
                  ],
                )
              ],
            ),
            Table(
              children: [
                TableRow(
                  decoration: const BoxDecoration(
                    border: Border(
                      left: BorderSide(),
                      bottom: BorderSide(),
                      right: BorderSide(),
                    ),
                  ),
                  children: [
                    TableCell(
                        child: Center(
                      child: CustomTextWgt(
                        data: "الطاقم",
                        fontSize: 3.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                  ],
                ),
              ],
            ),
            Table(
              border: const TableBorder(verticalInside: BorderSide()),
              columnWidths: const {
                // 0: FixedColumnWidth(3), // Fixed width for the first column
                1: FlexColumnWidth(
                    2.0), // Flex factor of 2 for the second column
                // 2: FlexColumnWidth(1.0),
                // 3: FlexColumnWidth(
                //     1.0), // Flex factor of 1 for the third column
// Flex factor of 1 for the third column
              },
              children: [
                TableRow(
                  decoration: const BoxDecoration(
                    border: Border(
                      left: BorderSide(),
                      bottom: BorderSide(),
                      right: BorderSide(),
                    ),
                  ),
                  children: [
                    TableCell(
                        child: Center(
                      child: CustomTextWgt(
                        data: "القائد",
                        fontSize: 3.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                    TableCell(
                        child: Center(
                      child: CustomTextWgt(
                        data: tripReport == null
                            ? shiftReport?.employeeReportData?.trainCap ?? ""
                            : tripReport?.employeeReportData?.trainCap ?? "",
                        fontSize: 1.sp,
                      ),
                    )),
                    TableCell(
                        child: Center(
                      child: CustomTextWgt(
                        data: "الساب",
                        fontSize: 3.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                    TableCell(
                        child: Center(
                      child: CustomTextWgt(
                        data: tripReport == null
                            ? shiftReport?.employeeReportData?.trainCapSap ?? ""
                            : tripReport?.employeeReportData?.trainCapSap ?? "",
                        fontSize: 3.sp,
                      ),
                    )),
                  ],
                ),
                TableRow(
                  decoration: const BoxDecoration(
                    border: Border(
                      left: BorderSide(),
                      bottom: BorderSide(),
                      right: BorderSide(),
                    ),
                  ),
                  children: [
                    TableCell(
                        child: Center(
                      child: CustomTextWgt(
                        data: "المساعد",
                        fontSize: 3.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                    TableCell(
                        child: Center(
                      child: CustomTextWgt(
                        data: tripReport == null
                            ? shiftReport?.employeeReportData?.trainCapAsst ??
                                ""
                            : tripReport?.employeeReportData?.trainCapAsst ??
                                "",
                        fontSize: 1.sp,
                      ),
                    )),
                    TableCell(
                        child: Center(
                      child: CustomTextWgt(
                        data: "الساب",
                        fontSize: 3.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                    TableCell(
                        child: Center(
                      child: CustomTextWgt(
                        data: tripReport == null
                            ? shiftReport
                                    ?.employeeReportData?.trainCapAsstSap ??
                                ""
                            : tripReport?.employeeReportData?.trainCapAsstSap ??
                                "",
                        fontSize: 3.sp,
                      ),
                    )),
                  ],
                ),
                TableRow(
                  decoration: const BoxDecoration(
                    border: Border(
                      left: BorderSide(),
                      bottom: BorderSide(),
                      right: BorderSide(),
                    ),
                  ),
                  children: [
                    TableCell(
                        child: Center(
                      child: CustomTextWgt(
                        data: "المشرف",
                        fontSize: 3.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                    TableCell(
                        child: Center(
                      child: CustomTextWgt(
                        data: tripReport == null
                            ? shiftReport?.employeeReportData?.trainConductor ??
                                ""
                            : tripReport?.employeeReportData?.trainConductor ??
                                "",
                        fontSize: 1.sp,
                      ),
                    )),
                    TableCell(
                        child: Center(
                      child: CustomTextWgt(
                        data: "الساب",
                        fontSize: 3.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                    TableCell(
                        child: Center(
                      child: CustomTextWgt(
                        data: tripReport == null
                            ? shiftReport
                                    ?.employeeReportData?.trainConductorSap ??
                                ""
                            : tripReport
                                    ?.employeeReportData?.trainConductorSap ??
                                "",
                        fontSize: 3.sp,
                      ),
                    )),
                  ],
                ),
              ],
            ),
            Table(
              children: [
                TableRow(
                  decoration: const BoxDecoration(
                    border: Border(
                      left: BorderSide(),
                      bottom: BorderSide(),
                      right: BorderSide(),
                    ),
                  ),
                  children: [
                    TableCell(
                        child: Center(
                      child: CustomTextWgt(
                        data: "القطار",
                        fontSize: 3.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                  ],
                ),
              ],
            ),
            Table(
              columnWidths: const {
                0: FlexColumnWidth(2),
                // 1: FixedColumnWidth(1), // Fixed width for the first column
                // // Flex factor of 2 for the second column
                // 2: FlexColumnWidth(1),
                // 3: FlexColumnWidth(1),
                // 4: FlexColumnWidth(1), // Flex factor of 1 for the third column
// Flex factor of 1 for the third column
              },
              border: const TableBorder(verticalInside: BorderSide()),
              children: [
                TableRow(
                  decoration: const BoxDecoration(
                    border: Border(
                      left: BorderSide(),
                      bottom: BorderSide(),
                      right: BorderSide(),
                    ),
                  ),
                  children: [
                    TableCell(
                        child: Center(
                      child: CustomTextWgt(
                        data: "نوع القطار",
                        fontSize: 3.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                    TableCell(
                        child: Center(
                      child: CustomTextWgt(
                        data: "العربات",
                        fontSize: 3.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                    TableCell(
                        child: Center(
                      child: CustomTextWgt(
                        data: "اول عربة",
                        fontSize: 3.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                    TableCell(
                        child: Center(
                      child: CustomTextWgt(
                        data: "اخر عربة",
                        fontSize: 3.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                    TableCell(
                        child: Center(
                      child: CustomTextWgt(
                        data: "السبنسة",
                        fontSize: 3.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ))
                  ],
                ),
                TableRow(
                  decoration: const BoxDecoration(
                    border: Border(
                      left: BorderSide(),
                      bottom: BorderSide(),
                      right: BorderSide(),
                    ),
                  ),
                  children: [
                    TableCell(
                        child: Center(
                      child: CustomTextWgt(
                        data: tripReport?.stockTripReportData?.trainType ?? "",
                        fontSize: 3.sp,
                        maxLines: 2,
                      ),
                    )),
                    TableCell(
                        child: Center(
                      child: CustomTextWgt(
                        data: tripReport?.stockTripReportData?.coachQuantity ??
                            "",
                        fontSize: 3.sp,
                      ),
                    )),
                    TableCell(
                        child: Center(
                      child: CustomTextWgt(
                        data:
                            tripReport?.stockTripReportData?.firstCoachNo ?? "",
                        fontSize: 3.sp,
                      ),
                    )),
                    TableCell(
                        child: Center(
                      child: CustomTextWgt(
                        data:
                            tripReport?.stockTripReportData?.lastCoachNo ?? "",
                        fontSize: 3.sp,
                      ),
                    )),
                    TableCell(
                        child: Center(
                      child: CustomTextWgt(
                        data: tripReport?.stockTripReportData?.sebensaNo ?? "",
                        fontSize: 3.sp,
                      ),
                    )),
                  ],
                ),
              ],
            ),
            Table(
              columnWidths: const {
                // 0: FixedColumnWidth(3), // Fixed width for the first column
                0: FlexColumnWidth(
                    2.0), // Flex factor of 2 for the second column
                1: FlexColumnWidth(2.0),
                2: FlexColumnWidth(1),
                3: FlexColumnWidth(
                    2.0), // Flex factor of 1 for the third column
// Flex factor of 1 for the third column
              },
              border: const TableBorder(verticalInside: BorderSide()),
              children: [
                TableRow(
                  decoration: const BoxDecoration(
                    border: Border(
                      left: BorderSide(),
                      bottom: BorderSide(),
                      right: BorderSide(),
                    ),
                  ),
                  children: [
                    TableCell(
                        child: Center(
                      child: CustomTextWgt(
                        data: "حالة القطار",
                        fontSize: 3.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                    TableCell(
                        child: Center(
                      child: CustomTextWgt(
                        data: "برسم",
                        fontSize: 3.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                    TableCell(
                        child: Center(
                      child: CustomTextWgt(
                        data: "البوليصة",
                        fontSize: 3.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                    TableCell(
                        child: Center(
                      child: CustomTextWgt(
                        data: "اماكن التخزين",
                        fontSize: 3.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                  ],
                ),
                TableRow(
                  decoration: const BoxDecoration(
                    border: Border(
                      left: BorderSide(),
                      bottom: BorderSide(),
                      right: BorderSide(),
                    ),
                  ),
                  children: [
                    TableCell(
                        child: Center(
                      child: CustomTextWgt(
                        data: tripReport?.stockTripReportData?.trainState ?? "",
                        fontSize: 3.sp,
                        maxLines: 2,
                      ),
                    )),
                    TableCell(
                        child: Center(
                      child: CustomTextWgt(
                        data: tripReport?.stockTripReportData?.tariff ?? "",
                        fontSize: 3.sp,
                        maxLines: 2,
                      ),
                    )),
                    TableCell(
                        child: Center(
                      child: CustomTextWgt(
                        data: tripReport?.stockTripReportData?.waybillNo ?? "",
                        fontSize: 3.sp,
                      ),
                    )),
                    TableCell(
                        child: Center(
                      child: CustomTextWgt(
                          data: tripReport?.stockTripReportData?.tempStation ??
                              "",
                          fontSize: 3.sp,
                          maxLines: 4),
                    )),
                  ],
                ),
              ],
            ),
            Table(
              children: [
                TableRow(
                  decoration: const BoxDecoration(
                    border: Border(
                      left: BorderSide(),
                      bottom: BorderSide(),
                      right: BorderSide(),
                    ),
                  ),
                  children: [
                    TableCell(
                        child: Center(
                      child: CustomTextWgt(
                        data: "الرحلة",
                        fontSize: 3.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                  ],
                ),
              ],
            ),
            Table(
              columnWidths: const {
                // 0: FixedColumnWidth(3), // Fixed width for the first column
                0: FlexColumnWidth(
                    2.0), // Flex factor of 2 for the second column
                2: FlexColumnWidth(2.0),
                // 2: FlexColumnWidth(1.0),
                // 3: FlexColumnWidth(
                //     1.0), // Flex factor of 1 for the third column
// Flex factor of 1 for the third column
              },
              border: const TableBorder(verticalInside: BorderSide()),
              children: [
                TableRow(
                  decoration: const BoxDecoration(
                    border: Border(
                      left: BorderSide(),
                      bottom: BorderSide(),
                      right: BorderSide(),
                    ),
                  ),
                  children: [
                    TableCell(
                        child: Center(
                      child: CustomTextWgt(
                        data: "محطة القيام",
                        fontSize: 3.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                    TableCell(
                        child: Center(
                      child: CustomTextWgt(
                        data: "قيام",
                        fontSize: 3.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                    TableCell(
                        child: Center(
                      child: CustomTextWgt(
                        data: "محطة الوصول",
                        fontSize: 3.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                    TableCell(
                        child: Center(
                      child: CustomTextWgt(
                        data: "وصول",
                        fontSize: 3.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                  ],
                ),
                TableRow(
                  decoration: const BoxDecoration(
                    border: Border(
                      left: BorderSide(),
                      bottom: BorderSide(),
                      right: BorderSide(),
                    ),
                  ),
                  children: [
                    TableCell(
                        child: Center(
                      child: CustomTextWgt(
                        data: tripReport?.depStation ?? "",
                        fontSize: 3.sp,
                        maxLines: 2,
                      ),
                    )),
                    TableCell(
                        child: Center(
                      child: CustomTextWgt(
                        data: tripReport?.depTime ?? "",
                        fontSize: 3.sp,
                      ),
                    )),
                    TableCell(
                        child: Center(
                      child: CustomTextWgt(
                        data: tripReport?.arrStation ?? "",
                        fontSize: 3.sp,
                        maxLines: 2,
                      ),
                    )),
                    TableCell(
                        child: Center(
                      child: CustomTextWgt(
                        data: tripReport?.arrTime ?? "",
                        fontSize: 3.sp,
                      ),
                    )),
                  ],
                ),
              ],
            ),
            Table(
              border: const TableBorder(verticalInside: BorderSide()),
              children: [
                TableRow(
                  decoration: const BoxDecoration(
                    border: Border(
                      left: BorderSide(),
                      bottom: BorderSide(),
                      right: BorderSide(),
                    ),
                  ),
                  children: [
                    TableCell(
                        child: Center(
                      child: CustomTextWgt(
                        data: "السولار عند القيام",
                        fontSize: 3.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                    TableCell(
                        child: Center(
                      child: CustomTextWgt(
                        data: "السولار عند الوصول",
                        fontSize: 3.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                  ],
                ),
                TableRow(
                  decoration: const BoxDecoration(
                    border: Border(
                      left: BorderSide(),
                      bottom: BorderSide(),
                      right: BorderSide(),
                    ),
                  ),
                  children: [
                    TableCell(
                        child: Center(
                      child: CustomTextWgt(
                        data: tripReport?.gazOnDep ?? "",
                        fontSize: 3.sp,
                      ),
                    )),
                    TableCell(
                        child: Center(
                      child: CustomTextWgt(
                        data: tripReport?.gazOnArr ?? "",
                        fontSize: 3.sp,
                      ),
                    )),
                  ],
                ),
              ],
            ),
            Table(
              children: [
                TableRow(
                  decoration: const BoxDecoration(
                    border: Border(
                      left: BorderSide(),
                      bottom: BorderSide(),
                      right: BorderSide(),
                    ),
                  ),
                  children: [
                    TableCell(
                        child: Center(
                      child: CustomTextWgt(
                        data: "الوردية",
                        fontSize: 3.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                  ],
                ),
              ],
            ),
            Table(
              columnWidths: const {
                // 0: FixedColumnWidth(3), // Fixed width for the first column
                0: FlexColumnWidth(
                    2.0), // Flex factor of 2 for the second column
                1: FlexColumnWidth(2.0),
                2: FlexColumnWidth(1),
                3: FlexColumnWidth(1), // Flex factor of 1 for the third column
// Flex factor of 1 for the third column
              },
              border: const TableBorder(verticalInside: BorderSide()),
              children: [
                TableRow(
                  decoration: const BoxDecoration(
                    border: Border(
                      left: BorderSide(),
                      bottom: BorderSide(),
                      right: BorderSide(),
                    ),
                  ),
                  children: [
                    TableCell(
                        child: Center(
                      child: CustomTextWgt(
                        data: "نوع الوردية",
                        fontSize: 3.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                    TableCell(
                        child: Center(
                      child: CustomTextWgt(
                        data: "محطة البداية",
                        fontSize: 3.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                    TableCell(
                        child: Center(
                      child: CustomTextWgt(
                        data: "البداية",
                        fontSize: 3.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                    TableCell(
                        child: Center(
                      child: CustomTextWgt(
                        data: "النهاية",
                        fontSize: 3.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                  ],
                ),
                TableRow(
                  decoration: const BoxDecoration(
                    border: Border(
                      left: BorderSide(),
                      bottom: BorderSide(),
                      right: BorderSide(),
                    ),
                  ),
                  children: [
                    TableCell(
                        child: Center(
                      child: CustomTextWgt(
                        data: shiftReport?.shiftType ?? "",
                        fontSize: 3.sp,
                        maxLines: 2,
                      ),
                    )),
                    TableCell(
                        child: Center(
                      child: CustomTextWgt(
                        data: shiftReport?.depStation ?? "",
                        fontSize: 3.sp,
                        maxLines: 2,
                      ),
                    )),
                    TableCell(
                        child: Center(
                      child: CustomTextWgt(
                        data: shiftReport?.depTime ?? "",
                        fontSize: 3.sp,
                      ),
                    )),
                    TableCell(
                        child: Center(
                      child: CustomTextWgt(
                        data: shiftReport?.arrTime ?? "",
                        fontSize: 3.sp,
                      ),
                    )),
                  ],
                ),
              ],
            ),
            Table(
              border: const TableBorder(verticalInside: BorderSide()),
              children: [
                TableRow(
                  decoration: const BoxDecoration(
                    border: Border(
                      left: BorderSide(),
                      bottom: BorderSide(),
                      right: BorderSide(),
                    ),
                  ),
                  children: [
                    TableCell(
                        child: Center(
                      child: CustomTextWgt(
                        data: "السولار عند القيام",
                        fontSize: 3.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                    TableCell(
                        child: Center(
                      child: CustomTextWgt(
                        data: "السولار عند الوصول",
                        fontSize: 3.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                  ],
                ),
                TableRow(
                  decoration: const BoxDecoration(
                    border: Border(
                      left: BorderSide(),
                      bottom: BorderSide(),
                      right: BorderSide(),
                    ),
                  ),
                  children: [
                    TableCell(
                        child: Center(
                      child: CustomTextWgt(
                        data: shiftReport?.gazOnDep ?? "",
                        fontSize: 3.sp,
                      ),
                    )),
                    TableCell(
                        child: Center(
                      child: CustomTextWgt(
                        data: shiftReport?.gazOnArr ?? "",
                        fontSize: 3.sp,
                      ),
                    )),
                  ],
                ),
              ],
            ),
            Table(
              children: [
                TableRow(
                  decoration: const BoxDecoration(
                    border: Border(
                      left: BorderSide(),
                      bottom: BorderSide(),
                      right: BorderSide(),
                    ),
                  ),
                  children: [
                    TableCell(
                        child: Center(
                      child: CustomTextWgt(
                        data: "التموين",
                        fontSize: 3.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                  ],
                ),
              ],
            ),
            Table(
              columnWidths: const {
                // 0: FixedColumnWidth(3), // Fixed width for the first column
                0: FlexColumnWidth(
                    2.0), // Flex factor of 2 for the second column
                // 2: FlexColumnWidth(1.0),
                // 3: FlexColumnWidth(
                //     1.0), // Flex factor of 1 for the third column
// Flex factor of 1 for the third column
              },
              border: const TableBorder(verticalInside: BorderSide()),
              children: [
                TableRow(
                  decoration: const BoxDecoration(
                    border: Border(
                      left: BorderSide(),
                      bottom: BorderSide(),
                      right: BorderSide(),
                    ),
                  ),
                  children: [
                    TableCell(
                        child: Center(
                      child: CustomTextWgt(
                        data: "نوع التموين",
                        fontSize: 3.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                    TableCell(
                        child: Center(
                      child: CustomTextWgt(
                        data: "كمية السولار",
                        fontSize: 3.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                    TableCell(
                        child: Center(
                      child: CustomTextWgt(
                        data: "كمية الزيت",
                        fontSize: 3.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                    TableCell(
                        child: Center(
                      child: CustomTextWgt(
                        data: "رقم البون",
                        fontSize: 3.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                  ],
                ),
                TableRow(
                  decoration: const BoxDecoration(
                    border: Border(
                      left: BorderSide(),
                      bottom: BorderSide(),
                      right: BorderSide(),
                    ),
                  ),
                  children: [
                    TableCell(
                        child: Center(
                      child: CustomTextWgt(
                        data: tripReport == null
                            ? shiftReport?.fuelReportData?.fuelType ?? ""
                            : tripReport?.fuelReportData?.fuelType ?? "",
                        fontSize: 3.sp,
                        maxLines: 2,
                      ),
                    )),
                    TableCell(
                        child: Center(
                      child: CustomTextWgt(
                        data: tripReport == null
                            ? shiftReport?.fuelReportData?.gazQty ?? ""
                            : tripReport?.fuelReportData?.gazQty ?? "",
                        fontSize: 3.sp,
                      ),
                    )),
                    TableCell(
                        child: Center(
                      child: CustomTextWgt(
                        data: tripReport == null
                            ? shiftReport?.fuelReportData?.oilQty ?? ""
                            : tripReport?.fuelReportData?.oilQty ?? "",
                        fontSize: 3.sp,
                      ),
                    )),
                    TableCell(
                        child: Center(
                      child: CustomTextWgt(
                        data: tripReport == null
                            ? shiftReport?.fuelReportData?.fuelInvoiceNo ?? ""
                            : tripReport?.fuelReportData?.fuelInvoiceNo ?? "",
                        fontSize: 3.sp,
                      ),
                    )),
                  ],
                ),
              ],
            ),
            Table(
              border: const TableBorder(verticalInside: BorderSide()),
              children: [
                TableRow(
                  decoration: const BoxDecoration(
                    border: Border(
                      left: BorderSide(),
                      bottom: BorderSide(),
                      right: BorderSide(),
                    ),
                  ),
                  children: [
                    TableCell(
                        child: Center(
                      child: CustomTextWgt(
                        data: "أمن القطار",
                        fontSize: 3.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                    TableCell(
                        child: Center(
                      child: CustomTextWgt(
                        data: tripReport?.stockTripReportData?.trainSecurity ??
                            "لا يوجد",
                        fontSize: 3.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                  ],
                ),
              ],
            ),
            Table(
              border: const TableBorder(verticalInside: BorderSide()),
              children: [
                TableRow(
                  decoration: const BoxDecoration(
                    border: Border(
                      left: BorderSide(),
                      bottom: BorderSide(),
                      right: BorderSide(),
                    ),
                  ),
                  children: [
                    TableCell(
                        child: Center(
                      child: CustomTextWgt(
                        data: "ملاحظات القائد",
                        fontSize: 3.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                  ],
                ),
                TableRow(
                  decoration: const BoxDecoration(
                    border: Border(
                      left: BorderSide(),
                      bottom: BorderSide(),
                      right: BorderSide(),
                    ),
                  ),
                  children: [
                    TableCell(
                        child: Center(
                      child: CustomTextWgt(
                        data: tripReport == null
                            ? "  ${shiftReport?.generalReportData?.locoCapNotes} "
                            : "  ${tripReport?.generalReportData?.locoCapNotes} ",
                        fontSize: 3.sp,
                        fontWeight: FontWeight.bold,
                        maxLines: 10,
                      ),
                    )),
                  ],
                ),
              ],
            ),
            Table(
              border: const TableBorder(verticalInside: BorderSide()),
              children: [
                TableRow(
                  decoration: const BoxDecoration(
                    border: Border(
                      left: BorderSide(),
                      bottom: BorderSide(),
                      right: BorderSide(),
                    ),
                  ),
                  children: [
                    TableCell(
                        child: Center(
                      child: CustomTextWgt(
                        data: "ملاحظات عامة",
                        fontSize: 3.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                  ],
                ),
                TableRow(
                  decoration: const BoxDecoration(
                    border: Border(
                      left: BorderSide(),
                      bottom: BorderSide(),
                      right: BorderSide(),
                    ),
                  ),
                  children: [
                    TableCell(
                        child: Center(
                      child: CustomTextWgt(
                        data: tripReport == null
                            ? "  ${shiftReport?.generalReportData?.globalNote} "
                            : "  ${tripReport?.generalReportData?.globalNote} ",
                        fontSize: 3.sp,
                        fontWeight: FontWeight.bold,
                        maxLines: 10,
                      ),
                    )),
                  ],
                ),
              ],
            ),
            Table(
              border: const TableBorder(verticalInside: BorderSide()),
              children: [
                TableRow(
                  decoration: const BoxDecoration(
                    border: Border(
                      left: BorderSide(),
                      bottom: BorderSide(),
                      right: BorderSide(),
                    ),
                  ),
                  children: [
                    TableCell(
                        child: Center(
                      child: CustomTextWgt(
                        data: "التوقيعات",
                        fontSize: 3.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                  ],
                ),
              ],
            ),
            Table(
              border: const TableBorder(verticalInside: BorderSide()),
              children: [
                TableRow(
                  decoration: const BoxDecoration(
                    border: Border(
                      left: BorderSide(),
                      bottom: BorderSide(),
                      right: BorderSide(),
                    ),
                  ),
                  children: [
                    TableCell(
                        child: Center(
                      child: CustomTextWgt(
                        data: "قائد القطار",
                        fontSize: 3.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                    TableCell(
                        child: Center(
                      child: CustomTextWgt(
                        data: "مشرف القطار",
                        fontSize: 3.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                  ],
                ),
                TableRow(
                  decoration: const BoxDecoration(
                    border: Border(
                      left: BorderSide(),
                      bottom: BorderSide(),
                      right: BorderSide(),
                    ),
                  ),
                  children: [
                    TableCell(
                        child: Center(
                      child: CustomTextWgt(
                        data: tripReport == null
                            ? shiftReport?.employeeReportData?.trainCap ?? ""
                            : tripReport?.employeeReportData?.trainCap ?? "",
                        fontSize: 3.sp,
                      ),
                    )),
                    TableCell(
                        child: Center(
                      child: CustomTextWgt(
                        data: tripReport == null
                            ? shiftReport?.employeeReportData?.trainConductor ??
                                ""
                            : tripReport?.employeeReportData?.trainConductor ??
                                "",
                        fontSize: 3.sp,
                      ),
                    )),
                  ],
                ),
              ],
            ),
            Table(
              border: const TableBorder(verticalInside: BorderSide()),
              children: [
                TableRow(
                  decoration: const BoxDecoration(
                    border: Border(
                      left: BorderSide(),
                      bottom: BorderSide(),
                      right: BorderSide(),
                    ),
                  ),
                  children: [
                    TableCell(
                        child: Center(
                      child: CustomTextWgt(
                        data:
                            "جميع البيانات التي تخص القاطرة تخص السائق وتحت مسئوليتة\n وجميع بيانات القطار تخص مشرف القطار وتحت مسئوليتة",
                        fontSize: 3.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
