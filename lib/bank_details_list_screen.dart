import 'package:flutter/material.dart';
import 'package:flutter_db_bank_details/bank_details_form_screen.dart';
import 'package:flutter_db_bank_details/bank_details_model.dart';
import 'package:flutter_db_bank_details/main.dart';
import 'package:flutter_db_bank_details/database_helper.dart';
import 'package:flutter_db_bank_details/edit_bank_details_form_screen.dart';
import 'package:flutter_db_bank_details/optimized_bank_details_form_screen.dart';


class BankDetailsListScreen extends StatefulWidget {
  const BankDetailsListScreen({super.key});

  @override
  State<BankDetailsListScreen> createState() => _BankDetailsListScreenState();
}

class _BankDetailsListScreenState extends State<BankDetailsListScreen> {
  late List<BankDetailsModel> _bankDetailsList;

  @override
  void initState() {
    super.initState();
    getAllBankDetails();

  }
  getAllBankDetails() async {
    _bankDetailsList = <BankDetailsModel>[];

    var bankDetailRecords =
    await dbHelper.queryAllRows(databaseHelper.bankDetailsTable);

    bankDetailRecords.forEach((bankDetail) {
      setState(() {


        print(bankDetail['_id']);
        print(bankDetail['_bankName']);
        print(bankDetail['_branchName']);
        print(bankDetail['_accountType']);
        print(bankDetail['_accountNo']);
        print(bankDetail['_IFSCCode']);


        var bankDetailsModel = BankDetailsModel(
          bankDetail['_id'],
          bankDetail['_bankName'],
          bankDetail['_branchName'],
          bankDetail['_accountType'],
          bankDetail['_accountNo'],
          bankDetail['_IFSCCode'],
        );

        _bankDetailsList.add(bankDetailsModel);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bank Details'),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          children: [
            new Expanded(
              child: new ListView.builder(
                itemCount: _bankDetailsList.length,
                itemBuilder: (BuildContext context, int index) {
                  return new InkWell(
                    onTap: () {
                      print('---------->Edit or Delete invoked: Send Data');

                      print(_bankDetailsList[index].id);
                      print(_bankDetailsList[index].bankName);
                      print(_bankDetailsList[index].branchName);
                      print(_bankDetailsList[index].accountType);
                      print(_bankDetailsList[index].accountNo);
                      print(_bankDetailsList[index].IFSCCode);

                      /*Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => EditBankDetailsFormScreen(),
                        settings: RouteSettings(
                          arguments: _bankDetailsList[index],
                        ),
                      ));*/
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => OptimizedBankDetailsFormScreen(),
                        settings: RouteSettings(
                          arguments: _bankDetailsList[index],
                        ),
                      ));
                    },
                    child: ListTile(
                      title: Text(
                          _bankDetailsList[index].bankName +
                              '\n' +
                              _bankDetailsList[index].branchName +
                              '\n' +
                              _bankDetailsList[index].accountType +
                              '\n' +
                              _bankDetailsList[index].accountNo +
                              '\n' +
                              _bankDetailsList[index].IFSCCode),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print('--------->Launch Bank Details Form Screen');
          /*Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => BankDetailsFormScreen()));*/
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => OptimizedBankDetailsFormScreen()));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
