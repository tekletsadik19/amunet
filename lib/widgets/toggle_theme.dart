import '../utils/app_theme/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../utils/app_theme/theme_notifier.dart';

class ToggleTheme extends ConsumerWidget {
  const ToggleTheme({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final themeNotifier = ref.watch(themeNotifierProvider);
    return  Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(16, 12, 16, 0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          if (Theme.of(context).brightness == Brightness.light)
            InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: () async {
                themeNotifier.toggleTheme();
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Theme.of(context).canvasColor,
                  boxShadow: const [
                    BoxShadow(
                      blurRadius: 4,
                      color: Color(0x33000000),
                      offset: Offset(0, 2),
                    )
                  ],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(24, 12, 24, 12),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Switch to Dark Mode',
                        style: AMUNETheme.bodyText2,
                      ),
                      Container(
                        width: 80,
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Stack(
                          alignment: const AlignmentDirectional(0, 0),
                          children: [
                            const Align(
                              alignment: AlignmentDirectional(0.95, 0),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0, 0, 8, 0),
                                child: Icon(
                                  Icons.nights_stay,
                                  size: 20,
                                ),
                              ),
                            ),
                            Align(
                              alignment: const AlignmentDirectional(-0.85, 0),
                              child: Container(
                                width: 36,
                                height: 36,
                                decoration: BoxDecoration(
                                  color: Theme.of(context).canvasColor,
                                  boxShadow: const [
                                    BoxShadow(
                                      blurRadius: 4,
                                      color: Color(0x430B0D0F),
                                      offset: Offset(0, 2),
                                    )
                                  ],
                                  borderRadius: BorderRadius.circular(30),
                                  shape: BoxShape.rectangle,
                                ),
                              )
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          if (Theme.of(context).brightness == Brightness.dark)
            InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: () async {
                themeNotifier.toggleTheme();
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Theme.of(context).canvasColor,
                  boxShadow: const [
                    BoxShadow(
                      blurRadius: 4,
                      color: Color(0x33000000),
                      offset: Offset(0, 2),
                    )
                  ],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(24, 12, 24, 12),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Switch to Light Mode',
                        style: AMUNETheme.bodyText2,
                      ),
                      Container(
                        width: 80,
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Stack(
                          alignment: const AlignmentDirectional(0, 0),
                          children: [
                            const Align(
                              alignment: AlignmentDirectional(-0.9, 0),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    8, 2, 0, 0),
                                child: Icon(
                                  Icons.wb_sunny_rounded,
                                  size: 24,
                                ),
                              ),
                            ),
                            Align(
                              alignment: const AlignmentDirectional(0.9, 0),
                              child: Container(
                                width: 36,
                                height: 36,
                                decoration: BoxDecoration(
                                  color: Theme.of(context).canvasColor,
                                  boxShadow: const [
                                    BoxShadow(
                                      blurRadius: 4,
                                      color: Color(0x430B0D0F),
                                      offset: Offset(0, 2),
                                    )
                                  ],
                                  borderRadius: BorderRadius.circular(30),
                                  shape: BoxShape.rectangle,
                                ),
                              )
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
