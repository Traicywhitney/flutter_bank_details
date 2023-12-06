import 'package:flutter/material.dart';
import 'package:flutter_db_bank_details/database_helper.dart';
import 'package:flutter_db_bank_details/main.dart';

import 'bank_details_list_screen.dart';

class BankDetailsFormScreen extends StatefulWidget {
  const BankDetailsFormScreen({super.key});

  @override
  State<BankDetailsFormScreen> createState() => _BankDetailsFormScreenState();
}

class _BankDetailsFormScreenState extends State<BankDetailsFormScreen> {

  var _bankNameController = TextEditingController();
  var _branchNameController = TextEditingController();
  var _accountTypeController = TextEditingController();
  var _accountNoController = TextEditingController();
  var _IFSCCodeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bank Details'),
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
                  print('------->Save button Clicked');
                  _save();
                },
                    child: Text('Save')
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _save() async{
    print('----------->Save');
    print('-------------> Bank Name: ${_bankNameController.text}');
    print('-------------> Branch Name: ${_branchNameController.text}');
    print('-------------> Account Type: ${_accountTypeController.text}');
    print('-------------> Account No: ${_accountNoController.text}');
    print('-------------> IFSC Code: ${_IFSCCodeController.text}');

    Map<String, dynamic> row = {
      databaseHelper.columnBankName: _bankNameController.text,
      databaseHelper.columnBranchName: _branchNameController.text,
      databaseHelper.columnAccountType: _accountTypeController.text,
      databaseHelper.columnAccountNo: _accountNoController.text,
      databaseHelper.columnIFSCCode: _IFSCCodeController.text,
    };

    final result = await dbHelper.insertBankDetails(
        row, databaseHelper.bankDetailsTable);

    debugPrint('--------> Inserted Row Id: $result');

    if (result > 0) {
      Navigator.pop(context);
      _showSuccessSnackBar(context, 'Saved');
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

