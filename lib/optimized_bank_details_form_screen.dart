import 'package:flutter/material.dart';
import 'package:flutter_db_bank_details/bank_details_list_screen.dart';
import 'package:flutter_db_bank_details/bank_details_model.dart';
import 'package:flutter_db_bank_details/database_helper.dart';
import 'package:flutter_db_bank_details/main.dart';


class OptimizedBankDetailsFormScreen extends StatefulWidget {
  const OptimizedBankDetailsFormScreen({super.key});

  @override
  State<OptimizedBankDetailsFormScreen> createState() => _OptimizedBankDetailsFormScreenState();
}

class _OptimizedBankDetailsFormScreenState extends State<OptimizedBankDetailsFormScreen> {

  var _bankNameController = TextEditingController();
  var _branchNameController = TextEditingController();
  var _accountTypeController = TextEditingController();
  var _accountNoController = TextEditingController();
  var _IFSCCodeController = TextEditingController();

  bool firstTimeFlag = false;
  int _selectedId = 0;
  // Optimized
  String buttonText = 'Save';

  _deleteFormDialog(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (param) {
          return AlertDialog(
            actions: <Widget>[
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () async {
                  final result = await dbHelper.deleteBankDetails(
                      _selectedId, databaseHelper.bankDetailsTable);

                  debugPrint('-----------------> Deleted Row Id: $result');

                  if (result > 0) {
                    _showSuccessSnackBar(context, 'Deleted.');
                    Navigator.pop(context);

                    setState(() {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => BankDetailsListScreen()));
                    });
                  }
                },
                child: const Text('Delete'),
              )
            ],
            title: const Text('Are you sure you want to delete this?'),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    // Edit/Delete - Received Data - Optimized
    if (firstTimeFlag == false) {
      print('---------->once execute');

      firstTimeFlag = true;

      //final bankDetails = ModalRoute.of(context)!.settings.arguments as BankDetailsModel;
      final bankDetails = ModalRoute
          .of(context)!
          .settings
          .arguments;

      if (bankDetails == null) {
        print('----------->FAB: Insert/Save:'); // save
      } else {
        print('----------->ListView: Received Data: Edit/Delete');

        bankDetails as BankDetailsModel;


        print(bankDetails.id);
        print(bankDetails.bankName);
        print(bankDetails.branchName);
        print(bankDetails.accountType);
        print(bankDetails.accountNo);
        print(bankDetails.IFSCCode);

        _selectedId = bankDetails.id!;
        buttonText = 'Update';

        _bankNameController.text = bankDetails.bankName;
        _branchNameController.text = bankDetails.branchName;
        _accountTypeController.text = bankDetails.accountType;
        _accountNoController.text = bankDetails.accountNo;
        _IFSCCodeController.text = bankDetails.IFSCCode;
      }
    }

      return Scaffold(
        appBar: AppBar(
          title: Text('Bank Account Details Form'),
          actions: _selectedId == 0 ? null : [
            PopupMenuButton<int>(
              itemBuilder: (context) =>
              [
                PopupMenuItem(value: 1, child: Text("Delete")),
              ],
              elevation: 2,
              onSelected: (value) {
                if (value == 1) {
                  print('Delete option clicked');
                  _deleteFormDialog(context);
                }
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  TextFormField(
                    controller: _bankNameController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(),
                        ),
                        labelText: 'Bank Name',
                        hintText: 'Enter the bank name'
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    controller: _branchNameController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(),
                        ),
                        labelText: 'Branch Name',
                        hintText: 'Enter the branch name'
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    controller: _accountTypeController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(),
                        ),
                        labelText: 'Account Type',
                        hintText: 'Enter Account Type'
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    controller: _accountNoController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(),
                        ),
                        labelText: 'Account No',
                        hintText: 'Enter Account No'
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    controller: _IFSCCodeController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(),
                        ),
                        labelText: 'IFSC Code',
                        hintText: 'Enter IFSC Code'
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  ElevatedButton(onPressed: () {
                    if (_selectedId == 0) {
                      print('---------------> Save');
                      _save();
                    } else {
                      print('---------------> Update');
                      _update();
                    }
                  },
                    child: Text(buttonText),
                  )
                ],
              ),
            ),
          ),
        ),
      );
    }
    void _save() async {
      print('---------------> _save');
      print('---------------> BankName: ${_bankNameController.text}');
      print('---------------> BranchName: ${_branchNameController.text}');
      print('---------------> AccountType: ${_accountTypeController.text}');
      print('---------------> AccountNo: ${_accountNoController.text}');
      print('---------------> IFSCCode: ${_IFSCCodeController.text}');

      Map<String, dynamic> row = {
        databaseHelper.columnBankName: _bankNameController.text,
        databaseHelper.columnBranchName: _branchNameController.text,
        databaseHelper.columnAccountType: _accountTypeController.text,
        databaseHelper.columnAccountNo: _accountNoController.text,
        databaseHelper.columnIFSCCode: _IFSCCodeController.text,
      };
      final result =
      await dbHelper.insertBankDetails(row, databaseHelper.bankDetailsTable);

      debugPrint('--------> Inserted Row Id: $result');

      if (result > 0) {
        Navigator.pop(context);
        _showSuccessSnackBar(context, 'Saved');
      }

      setState(() {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => BankDetailsListScreen()));
      });
    }

    void _update() async {
      print('----------->update');
      print('---------------> Selected ID: $_selectedId');

      print('-------------> Bank Name: ${_bankNameController.text}');
      print('-------------> Branch Name: ${_branchNameController.text}');
      print('-------------> Account Type: ${_accountTypeController.text}');
      print('-------------> Account No: ${_accountNoController.text}');
      print('-------------> IFSC Code: ${_IFSCCodeController.text}');

      Map<String, dynamic> row = {
        databaseHelper.columnId: _selectedId,
        databaseHelper.columnBankName: _bankNameController.text,
        databaseHelper.columnBranchName: _branchNameController.text,
        databaseHelper.columnAccountType: _accountTypeController.text,
        databaseHelper.columnAccountNo: _accountNoController.text,
        databaseHelper.columnIFSCCode: _IFSCCodeController.text,
      };

      final result = await dbHelper.updateBankDetails(
          row, databaseHelper.bankDetailsTable);

      debugPrint('--------> Updated  Row Id: $result');

      if (result > 0) {
        Navigator.pop(context);
        _showSuccessSnackBar(context, 'updated');
      }

      setState(() {
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => BankDetailsListScreen()));
      });
    }

    void _showSuccessSnackBar(BuildContext context, String message) {
      ScaffoldMessenger.of(context)
          .showSnackBar(new SnackBar(content: new Text(message)));
    }
  }



