import 'package:FeebackTask/Common/Service/Implementation/SheetManager.dart';
import 'package:FeebackTask/Common/Widget/feeback_app_bar_widget.dart';
import 'package:FeebackTask/Row%20List/Data/row_card_cell_view_model.dart';
import 'package:FeebackTask/Row%20List/UI/Bloc/row_list_screen_bloc.dart';
import 'package:FeebackTask/Row%20List/UI/Bloc/row_list_screen_event.dart';
import 'package:FeebackTask/Row%20List/UI/Bloc/row_list_screen_state.dart';
import 'package:FeebackTask/Row%20List/UI/Widget/feeback_row_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../Common/Constant/app_constants.dart' as AppConstants;

class RowListScreen extends StatelessWidget {
  RowListScreenBloc _bloc;

  @override
  Widget build(BuildContext context) {
    _bloc = BlocProvider.of<RowListScreenBloc>(context);
    _bloc.add(GetRowsRowListScreenEvent());
    return renderScreen(context);
  }

  Widget renderScreen(BuildContext context) {
    return BlocBuilder<RowListScreenBloc, RowListScreenState>(
        builder: (context, state) {
      if (state is ShowRowsRowListScreenState) {
        return buildScreen(context, state.cells, state.sheetURL);
      } else if (state is ShowLoadingRowListScreenState) {
        return buildLoadingScreen();
      }
    });
  }

  Widget buildScreen(
      BuildContext context, List<RowCardCellViewModel> cells, String sheetURL) {
    return Scaffold(
      backgroundColor: AppConstants.BACKROUND_COLOR,
      appBar: FeebackAppBarWidget(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: FloatingActionButton(
        // isExtended: true,
        child: Icon(Icons.add),
        backgroundColor: Colors.green,
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Center(
          child: ListView.builder(
              padding: const EdgeInsets.all(24),
              itemCount: cells.length + 1,
              itemBuilder: (BuildContext context, int index) {
                if (index == 0) {
                  return FlatButton(
                    onPressed: () async {
                      await launch(sheetURL);
                    },
                    child: Text(
                      'Sheet URL',
                      style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: Colors.blue,
                          fontSize: 18.0),
                    ),
                  );
                } else {
                  return FeebackRowCardWidget(
                    viewModel: cells[index - 1],
                    deleteCallback: () =>
                        {_bloc.add(DeleteRowRowListScreenEvent(index))},
                  );
                }
              }),
        ),
      ),
    );
  }

  Widget buildLoadingScreen() {
    return Scaffold(
      appBar: FeebackAppBarWidget(),
      body: Center(
          child: CircularProgressIndicator(
              valueColor: new AlwaysStoppedAnimation<Color>(
                  AppConstants.FEEBACK_SECONDARY_COLOR))),
    );
  }
}
