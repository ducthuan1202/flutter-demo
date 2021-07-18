import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:untitled/constants.dart';
import 'package:untitled/graphql/queries/countries.dart';
import 'package:untitled/utils/form_helpers.dart';
import 'package:untitled/widgets/select_options/index.dart';
import 'package:untitled/widgets/text_input/index.dart';

const List<Map<String, String>> categories = [
  {'id': '1', 'name': 'Ký sự'},
  {'id': '2', 'name': 'Truyện ngắn'},
  {'id': '3', 'name': 'Thơ ca'},
  {'id': '4', 'name': 'Truyện cổ tích'},
];

const List<Map<String, String>> authors = [
  {'id': '1', 'name': 'Ngô Tất Tố'},
  {'id': '2', 'name': 'Vũ Trọng Phụng'},
  {'id': '3', 'name': 'Nam Cao'},
  {'id': '4', 'name': 'Nguyễn Du'},
];

class StoryForm extends StatefulWidget {
  const StoryForm({Key? key}) : super(key: key);

  @override
  _StoryFormState createState() => _StoryFormState();
}

class _StoryFormState extends State<StoryForm> {
  final _formKey = GlobalKey<FormState>();
  final _hashtagInputController = TextEditingController();

  String? formValidateStatus;

  Map<String, dynamic> formData = {
    'name': '',
    'species' : '',
    'breed' : '',
    'colour' : '',
    'gender' : '',
    'dateOfBirth' : '',
    'purchaseAdoptionDate' : '',
    'microchip': '',
    'microchips': <String> [],
  };

  List<Map<String, String>> countriesData = [];

  void handleSubmitForm(){
    final msg = _formKey.currentState!.validate() ? 'ok' : 'fail';
    setState((){
      formValidateStatus = msg;
    });
  }

  void handleFieldOnChange({required String name, String? value}){
    setState(() {
      formData[name] = value!;
    });
  }

  void handleAddMicrochip(){
    final value = formData['microchip'].toString().trim();
    if(value.isNotEmpty){
      setState(() {
        formData['microchips'] = [...formData['microchips'], value];
        formData['microchip'] = '';
        _hashtagInputController.clear();
      });
    }
  }

  void handleRemoveMicrochip(String item){
    final data = formData['hashtags'] as List;
    final index = data.indexWhere((element) => element == item);
    if(index >= 0){
      data.removeAt(index);
      setState(() {
        formData['hashtags'] = data;
      });
    }
  }

  String? fieldValidator({required String name, required String? value, required String message}){
    if(value == null || value.isEmpty){
      return message;
    }
    return null;
  }

  void getCountriesFromNetwork() async{
    final data = await getCountries();
    if(!data.isLoading && !data.hasException){
      setState(() {
        countriesData = mapCountries(data.data);
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCountriesFromNetwork();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _hashtagInputController.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final keyName = 'name';
    final keySpecies = 'species';
    final keyBreed = 'breed';
    final keyColour = 'colour';
    final keyGender = 'gender';
    final keyDateOfBirth = 'dateOfBirth';
    final keyPurchaseAdoptionDate = 'purchaseAdoptionDate';
    final keyMicrochip = 'microchip';
    final keyMicrochips = 'microchips';

    List<Widget> microchipsWidget = [];
    formData[keyMicrochips].forEach((item){
      microchipsWidget.add(
          Container(
            margin: EdgeInsets.all(5.0),
            child: Chip(
              label: Text(item),
              onDeleted: () => handleRemoveMicrochip(item),
              deleteButtonTooltipMessage: 'remove $item ?',
            ),
          )
      );
    });

    return Container(
      padding: EdgeInsets.all(defaultPadding),
      child: Form(
        key: _formKey,

        child: Column(
          children: [

            Container(
              width: double.infinity,
              color: Colors.black12,
              padding: EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  formValidateStatus!= null ? Text('Kiểm tra thông tin: ${formValidateStatus}') : Container(),

                  Text('Truyện: ${formData[keyName]}'),
                  Text('keySpecies: ${formData[keySpecies]}'),
                  Text('keyBreed: ${formData[keyBreed]}'),
                  Text('keyColour: ${formData[keyColour]}'),
                  Text('keyGender: ${formData[keyGender]}'),
                  Text('keyDateOfBirth: ${formData[keyDateOfBirth]}'),
                  Text('keyPurchaseAdoptionDate: ${formData[keyPurchaseAdoptionDate]}'),
                  Text('keyMicrochips: ${(formData[keyMicrochips].join(', '))}'),
                ],
              ),
            ),

            SizedBox(height: 50,),

            // todo: name
            TextInput(
                name: keyName,
                initialValue: formData[keyName],
                hintText: 'Name',
                validator: (String? value) => fieldValidator(
                  name: keyName,
                  value: value,
                  message: 'required',
                ),
                onChanged: (String? value) => handleFieldOnChange(
                  name: keyName,
                  value: value,
                ),
            ),

            SizedBox(height: formElementSpace,),

            // TODO: Species
            SelectOptions(
              placeholder: 'Species',
              name: keySpecies,
                initialValue: formData[keySpecies],
                dataSource: categories,
                validator: (String? value) => fieldValidator(
                  name: keySpecies,
                  value: value,
                  message: 'required',
                ),
                onChanged: (String? value) => handleFieldOnChange(
                  name: keySpecies,
                  value: value,
                ),
            ),

            SizedBox(height: formElementSpace,),

            // TODO: Breed
            SelectOptions(
              placeholder: 'Breed',
              name: keyBreed,
              initialValue: formData[keyBreed],
              dataSource: authors,
              validator: (String? value) => fieldValidator(
                name: keyBreed,
                value: value,
                message: 'required',
              ),
              onChanged: (String? value) => handleFieldOnChange(
                name: keyBreed,
                value: value,
              ),
            ),

            SizedBox(height: formElementSpace,),

            // TODO: Colour
            SelectOptions(
              placeholder: 'Colour',
              name: keyColour,
              initialValue: formData[keyColour],
              dataSource: countriesData,
              validator: (String? value) => fieldValidator(
                name: keyColour,
                value: value,
                message: 'required',
              ),
              onChanged: (String? value) => handleFieldOnChange(
                name: keyColour,
                value: value,
              ),
            ),

            SizedBox(height: formElementSpace,),

            // TODO: Gender
            SelectOptions(
              placeholder: 'Gender',
              name: keyGender,
              initialValue: formData[keyGender],
              dataSource: countriesData,
              validator: (String? value) => fieldValidator(
                name: keyGender,
                value: value,
                message: 'required',
              ),
              onChanged: (String? value) => handleFieldOnChange(
                name: keyGender,
                value: value,
              ),
            ),

            SizedBox(height: formElementSpace,),

            // todo: Date of birth
            TextInput(
              name: keyDateOfBirth,
              initialValue: formData[keyDateOfBirth],
              hintText: 'Date of birth',
              validator: (String? value) => fieldValidator(
                name: keyDateOfBirth,
                value: value,
                message: 'required',
              ),
              onChanged: (String? value) => handleFieldOnChange(
                name: keyDateOfBirth,
                value: value,
              ),
            ),

            SizedBox(height: formElementSpace,),

            // todo: Purchase / Adoption date
            TextInput(
              name: keyPurchaseAdoptionDate,
              initialValue: formData[keyPurchaseAdoptionDate],
              hintText: 'Purchase / Adoption date',
              validator: (String? value) => fieldValidator(
                name: keyPurchaseAdoptionDate,
                value: value,
                message: 'required',
              ),
              onChanged: (String? value) => handleFieldOnChange(
                name: keyPurchaseAdoptionDate,
                value: value,
              ),
            ),

            SizedBox(height: formElementSpace,),

            Row(
              children: [

                Expanded(
                  child: TextInput(
                      controller: _hashtagInputController,
                      name: keyMicrochip,
                      initialValue: formData[keyMicrochip],
                      hintText: 'Microchip',
                      onChanged: (String? value) => handleFieldOnChange(
                        name: keyMicrochip,
                        value: value,
                      ),
                    ),
                ),

                Container(
                  height: 50.0,
                  margin: EdgeInsets.only(left: defaultMargin),
                  child: OutlinedButton(
                    onPressed: handleAddMicrochip,
                    child: Column(
                      children: [
                        Icon(Icons.add, color: Colors.black54,),
                        Text('Add another', style: TextStyle(color: Colors.black54),),
                      ],
                    ),
                    style: ElevatedButton.styleFrom(
                        side: BorderSide(color: formEnabledBorderColor),
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: formElementSpace,),

            Container(
              width: double.infinity,
              child: Wrap(
                direction: Axis.horizontal,
                alignment: WrapAlignment.start,
                children: microchipsWidget,
              ),
            ),

            SizedBox(height: formElementSpace,),

            ElevatedButton(
                onPressed: handleSubmitForm,
                child: Text('SAVE')
            ),
          ],
        ),
      ),
    );
  }
}
