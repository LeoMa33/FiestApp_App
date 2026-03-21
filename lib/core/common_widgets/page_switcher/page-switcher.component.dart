import 'package:flutter/material.dart';

class PageSwitcher extends StatefulWidget {
  final String firstPage;
  final String secondPage;
  final int currentPage;
  final Function(int)? onPageChanged;

  const PageSwitcher({
    super.key,
    required this.firstPage,
    required this.secondPage,
    required this.currentPage,
    this.onPageChanged,
  });

  @override
  State<PageSwitcher> createState() => _PageSwitcherState();
}

class _PageSwitcherState extends State<PageSwitcher> {
  late int currentPage = 0;

  void _switchToPage(int pageIndex) {
    setState(() {
      currentPage = pageIndex;
    });
    if (widget.onPageChanged != null) {
      widget.onPageChanged!(pageIndex);
    }
  }

  @override
  void initState() {
    super.initState();
    currentPage = widget.currentPage;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () => _switchToPage(0),
                  child: Container(
                    height: 60,
                    decoration: BoxDecoration(
                      color: currentPage == 0
                          ? const Color(0xffE15B42)
                          : Colors.white,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Center(
                      child: Text(
                        widget.firstPage,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: currentPage == 0
                              ? Colors.white
                              : const Color(0xffE15B42),
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () => _switchToPage(1),
                  child: Container(
                    height: 60,
                    decoration: BoxDecoration(
                      color: currentPage == 1
                          ? const Color(0xffE15B42)
                          : Colors.white,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Center(
                      child: Text(
                        widget.secondPage,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: currentPage == 1
                              ? Colors.white
                              : const Color(0xffE15B42),
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
