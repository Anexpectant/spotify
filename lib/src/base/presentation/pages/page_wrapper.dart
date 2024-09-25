import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:oktoast/oktoast.dart';
import 'package:spotify/core/constants/assets.dart';
import 'package:spotify/core/constants/numbers/spacings.dart';
import 'package:spotify/core/utils/services/alert_handler/alert_handler_cubit.dart';
import 'package:spotify/src/base/presentation/widgets/dynamic_holder.dart/dynamic_holder.dart';
import 'package:spotify/src/base/presentation/widgets/side_bar_menu/side_bar_menu.dart';
import 'package:spotify/src/base/presentation/widgets/toasts/toast_widgets.dart';

abstract class PageWrapper<T extends StatefulWidget> extends State<T>
    with WidgetsBindingObserver {
  int stateHelper = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      setState(() {
        stateHelper += 1;
      });
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: _handleBlocListenerBasePage(),
      child: _handleResponsivePage(),
    );
  }

  List<BlocListener> _handleBlocListenerBasePage() {
    return [
      BlocListener<AlertHandlerCubit, AlertHandlerState>(
          listener: _handleFailures)
    ];
  }

  Widget _handleResponsivePage() {
    return LayoutBuilder(builder: (context, viewportConstraints) {
      final bool bigPage = viewportConstraints.maxWidth > maxPageWidth;
      return _handleStatusBarConfig(viewportConstraints, bigPage);
    });
  }

  Widget _handleStatusBarConfig(
      BoxConstraints viewportConstraints, bool bigPage) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
      child: _buildScaffoldForBasePage(viewportConstraints, bigPage),
    );
  }

  Widget _buildScaffoldForBasePage(
      BoxConstraints viewportConstraints, bool bigPage) {
    return Scaffold(
      floatingActionButtonLocation: getFloatingActionButtonLocation(context),
      floatingActionButton: bigPage ? null : getFloatingActionBar(context),
      bottomNavigationBar: bigPage ? null : getBottomNavBar(context),
      backgroundColor: getPageBackgroundColor(context),
      body: _buildScaffoldBody(viewportConstraints, bigPage),
    );
  }

  Widget _buildScaffoldBody(BoxConstraints viewportConstraints, bool bigPage) {
    return Container(
      alignment: Alignment.center,
      constraints: BoxConstraints(
        maxWidth: viewportConstraints.maxWidth,
        maxHeight: viewportConstraints.maxHeight -
            MediaQuery.of(context).padding.bottom,
      ),
      child: _handleRatioAppBarAndScaffoldBody(bigPage),
    );
  }

  Widget _handleRatioAppBarAndScaffoldBody(bool bigPage) {
    return Column(
      children: [
        appBarShow() ? buildAppBar(context) : Container(),
        Expanded(
          child: Container(
            height: double.infinity,
            child: _buildWholeBodyPage(bigPage),
          ),
        ),
      ],
    );
  }

  Widget _buildWholeBodyPage(bool bigPage) {
    return Container(
      constraints: BoxConstraints(maxWidth: maxPageWidth),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          _handleSideBarMenuConfig(bigPage),
          _buildPageBodyOverrided(bigPage),
        ],
      ),
    );
  }

  Widget _buildPageBodyOverrided(bool bigPage) {
    return Expanded(
      flex: 16,
      child: Container(
        margin: EdgeInsets.only(
          top: bigPage ? Spacings.marginLg : 0,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(
            bigPage ? Spacings.radiusXXl : 0,
          ),
          child: buildPage(context),
        ),
      ),
    );
  }

  Widget _handleSideBarMenuConfig(bool bigPage) {
    return (sideBarMenu() != null && bigPage)
        ? Expanded(
            flex: 5,
            child: Container(
              margin: const EdgeInsets.symmetric(
                vertical: Spacings.marginLg,
                horizontal: Spacings.marginMd,
              ),
              child: sideBarMenu(),
            ))
        : Container();
  }

  // ** APPBAR WIDGET ** //
  Widget buildAppBar(BuildContext context) {
    return AppBarWithUserIcon(
      appBarDecoration: appBarDecoration(),
      appBarIcon: appBarIcon,
      appBarLead: appBarLead,
      appBarTitle: appBarTitle(),
      marginSet: marginSet(),
      maxWidth: maxPageWidth,
      isBigPage: isBigPage,
    );
  }

  // ** OVERRIDE METHOD'S ** //
  bool get isBigPage => MediaQuery.of(context).size.width > maxPageWidth;
  double get maxPageWidth => Spacings.sizeMaxPageWidth;
  Widget buildPage(BuildContext context);
  bool appBarShow() => true;
  Widget appBarTitle() => Container();
  Widget appBarLead() => Container();
  Widget? getBottomNavBar(BuildContext context) => null;
  Widget? getFloatingActionBar(BuildContext context) => null;
  FloatingActionButtonLocation? getFloatingActionButtonLocation(
          BuildContext context) =>
      FloatingActionButtonLocation.startFloat;
  SideBarMenu? sideBarMenu() => null;
  BoxDecoration? appBarDecoration() =>
      BoxDecoration(color: Theme.of(context).primaryColorLight);
  Color getPageBackgroundColor(BuildContext context) =>
      Theme.of(context).primaryColor;
  Widget appBarIcon() {
    final bool bigPage = MediaQuery.of(context).size.width > maxPageWidth;
    if (bigPage) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: Spacings.paddingMd),
        child: Row(
          children: [
            SvgPicture.asset(
              Assets.PLACEHOLDER,
              width: Spacings.sizeXs,
            ),
            const SizedBox(
              width: Spacings.marginSm,
            ),
          ],
        ),
      );
    }
    return Container();
  }

  EdgeInsetsGeometry? marginSet() => EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + Spacings.marginMd,
        bottom: Spacings.marginSm,
        right: Spacings.marginXl,
        left: Spacings.marginXl,
      );

  // ** HANDLE FAILURE'S APP AND SHOW TOAST ** //
  _handleFailures(context, state) {
    if (state is FailureOccurred)
      _showToast(state.failure.message, error: true);
    if (state is InfoState) _showToast(state.message.message);
  }

  _showToast(String message, {bool error = false}) {
    Widget toast = SuccessToast(message: message);
    if (error) toast = ErrorToast(message: message);
    showToastWidget(
      toast,
    );
  }
}

class AppBarWithUserIcon extends StatelessWidget {
  final appBarIcon;
  final appBarLead;
  final appBarTitle;
  final marginSet;
  final appBarDecoration;
  final maxWidth;
  final bool isBigPage;

  const AppBarWithUserIcon(
      {Key? key,
      this.appBarIcon,
      this.appBarLead,
      this.appBarTitle,
      this.marginSet,
      this.appBarDecoration,
      this.maxWidth,
      this.isBigPage = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DynamicHolder(
      decoration: appBarDecoration,
      padding: marginSet,
      alignment: Alignment.center,
      maxWidth: maxWidth,
      child: Stack(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [appBarIcon(), appBarLead()],
          ),
          Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(
                  top: isBigPage ? Spacings.marginLg : Spacings.marginSm),
              child: appBarTitle)
        ],
      ),
    );
  }
}
