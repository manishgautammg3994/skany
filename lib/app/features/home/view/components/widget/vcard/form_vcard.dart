import 'package:flutter/material.dart';

import 'package:vcard_maintained/vcard_maintained.dart';

import '../../../../controller/intentlistener.dart';
import '../../alert_helper.dart';

class VcardForm extends StatefulWidget {
  IntentText intentText;
  VcardForm({Key? key, required this.intentText}) : super(key: key);

  @override
  State<VcardForm> createState() => _VcardFormState();
}

class _VcardFormState extends State<VcardForm> {
  String? _vcardString;

  _generateVCard() {
    DialogHelper dialogHelper = DialogHelper();
    var vCard = VCard();

    //validation
    if (firstNameTextEditingController.text.isEmpty ||
        emailTextEditingController.text.isEmpty &&
            cellPhoneTextEditingController.text.isEmpty) {
      dialogHelper.showMessageOnlyAlertDialog(
          context, 'Please fill atleast Phone, Email and First Name', 'Error');
      return;
    }

    ///Set properties
    vCard.firstName = firstNameTextEditingController.text;
    vCard.middleName = middleNameTextEditingController.text;
    vCard.lastName = lastNameTextEditingController.text;
    vCard.organization = organizationTextEditingController.text;
    // vCard.photo.attachFromUrl(
    //     'https://www.activspaces.com/wp-content/uploads/2019/01/ActivSpaces-Logo_Dark.png',
    //     'PNG');
    vCard.workPhone = workPhoneTextEditingController.text;
    vCard.jobTitle = jobTitleTextEditingController.text;
    vCard.note = noteTextEditingController.text;
    vCard.email = emailTextEditingController.text;
    vCard.cellPhone = cellPhoneTextEditingController.text;
    vCard.role = roleTextEditingController.text;

    /// Save to file
    // vCard.saveToFile('./contact.vcf');

    /// Get as formatted string
    setState(() {
      _vcardString = vCard.getFormattedString();
    });

    widget.intentText.incomingTextController.sink
        .add((_vcardString != null) ? _vcardString : "");
    Navigator.of(context).pop();
  }

  @override
  void initState() {
    // TODO: implement initState
    // _generateVCard();
    super.initState();
  }

  //Vcard controller
  TextEditingController firstNameTextEditingController =
      TextEditingController();
  TextEditingController middleNameTextEditingController =
      TextEditingController();
  TextEditingController lastNameTextEditingController = TextEditingController();
  TextEditingController organizationTextEditingController =
      TextEditingController();
  TextEditingController workPhoneTextEditingController =
      TextEditingController();
  TextEditingController jobTitleTextEditingController = TextEditingController();
  TextEditingController noteTextEditingController = TextEditingController();
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController roleTextEditingController = TextEditingController();
  TextEditingController cellPhoneTextEditingController =
      TextEditingController();

  //qr ctext controller
  // TextEditingController _qrTopDecorationTextEditingController =
  //     TextEditingController();
  // TextEditingController _qrBottomDecorationTextEditingController =
  //     TextEditingController();

  Color backgroundColor = Colors.white;
  Color foregroundColor = Colors.black;

  // changeColor(colors, key) {
  //   if (key == 'Background Color') {
  //     backgroundColor = colors;
  //   } else {
  //     foregroundColor = colors;
  //   }
  //   setState(() {});
  // }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    HeadingWithDivider(
                      label: 'VCard Content',
                    ),
                    TextField(
                      controller: firstNameTextEditingController,
                      decoration: InputDecoration(label: Text('First Name')),
                      keyboardType: TextInputType.text,
                    ),
                    TextField(
                      controller: middleNameTextEditingController,
                      decoration: InputDecoration(label: Text('Middle Name')),
                      keyboardType: TextInputType.text,
                    ),
                    TextField(
                      controller: lastNameTextEditingController,
                      decoration: InputDecoration(label: Text('Last Name')),
                      keyboardType: TextInputType.text,
                    ),
                    TextField(
                      controller: cellPhoneTextEditingController,
                      decoration: InputDecoration(label: Text('Cell Phone')),
                      keyboardType: TextInputType.phone,
                    ),
                    TextField(
                      controller: emailTextEditingController,
                      decoration: InputDecoration(label: Text('Email')),
                      keyboardType: TextInputType.emailAddress,
                    ),
                    TextField(
                      controller: organizationTextEditingController,
                      decoration: InputDecoration(label: Text('Organization')),
                      keyboardType: TextInputType.text,
                    ),
                    TextField(
                      controller: roleTextEditingController,
                      decoration: InputDecoration(label: Text('Role')),
                      keyboardType: TextInputType.text,
                    ),
                    TextField(
                      controller: workPhoneTextEditingController,
                      decoration: InputDecoration(label: Text('Workphone')),
                      keyboardType: TextInputType.phone,
                    ),
                    TextField(
                      controller: jobTitleTextEditingController,
                      decoration: InputDecoration(label: Text('Job Title')),
                      keyboardType: TextInputType.text,
                    ),
                    TextField(
                      controller: noteTextEditingController,
                      decoration: InputDecoration(label: Text('Notes')),
                      keyboardType: TextInputType.text,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                color: const Color(0xFFF2F2F7),
                child: Column(
                  children: [
                    // HeadingWithDivider(
                    //   label: 'QR Customize',
                    // ),
                    // TextField(
                    //   controller: _qrTopDecorationTextEditingController,
                    //   decoration: InputDecoration(label: Text('Top QR Text')),
                    // ),
                    // TextField(
                    //   controller: _qrBottomDecorationTextEditingController,
                    //   decoration: InputDecoration(label: Text('Bottom QR Text')),
                    // ),
                    TextButton(
                      onPressed: () {
                        _generateVCard();
                      },
                      child: const Text('GENERATE'),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class HeadingWithDivider extends StatelessWidget {
  final String label;

  const HeadingWithDivider({
    Key? key,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      SizedBox(
        height: 15,
      ),
      Text(label,
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
      SizedBox(
        height: 5,
      ),
    ]);
  }
}
