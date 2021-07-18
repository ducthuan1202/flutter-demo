import 'package:flutter/material.dart';
import 'package:untitled/constants.dart';
import 'package:untitled/graphql/queries/countries.dart';
import 'package:untitled/graphql/queries/species.dart';
import 'package:untitled/utils/form_helpers.dart';
import 'package:untitled/widgets/select_options/index.dart';
import 'package:untitled/widgets/text_input/index.dart';

class StoryForm extends StatefulWidget {
  const StoryForm({Key? key}) : super(key: key);

  @override
  _StoryFormState createState() => _StoryFormState();
}

class _StoryFormState extends State<StoryForm> {
  final _formKey = GlobalKey<FormState>();
  final _microchipInputController = TextEditingController();
  List<Map<String, String>> speciesData = [];
  List<Map<String, String>> breedData = [];
  List<Map<String, String>> colourData = [];
  List<Map<String, String>> genderData = [];
  List<Map<String, String>> countriesData = [];
  String? formValidateStatus;

  Map<String, dynamic> formData = {
    'country': '',
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
        _microchipInputController.clear();
      });
    }
  }

  void handleRemoveMicrochip(String item){
    final data = formData['microchips'] as List;
    final index = data.indexWhere((element) => element == item);
    if(index >= 0){
      data.removeAt(index);
      setState(() {
        formData['microchips'] = data;
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

  void getDropdownDataFromNetwork() async{
    final collect = await Future.wait([
      getSpecies(),
      getBreeds(),
      getColours(),
      getGenders(),
    ]);

    setState(() {
      speciesData = collect[0];
      breedData = collect[1];
      colourData = collect[2];
      genderData = collect[3];
    });

  }

  List<Widget> renderMicrochips(){

    final data = formData['microchips'] as List;

    return data.map((dynamic item){
      return Container(
        margin: EdgeInsets.all(5.0),
        child: Chip(
          label: Text(item),
          onDeleted: () => handleRemoveMicrochip(item),
          deleteButtonTooltipMessage: 'remove $item ?',
        ),
      );
    }).toList();

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCountriesFromNetwork();
    getDropdownDataFromNetwork();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _microchipInputController.dispose();
  }

  @override
  Widget build(BuildContext context) {

    print('--------- render widget UI');

    final keyCountry = 'country';
    final keyName = 'name';
    final keySpecies = 'species';
    final keyBreed = 'breed';
    final keyColour = 'colour';
    final keyGender = 'gender';
    final keyDateOfBirth = 'dateOfBirth';
    final keyPurchaseAdoptionDate = 'purchaseAdoptionDate';
    final keyMicrochip = 'microchip';
    final keyMicrochips = 'microchips';

    final microchipsWidget = renderMicrochips();

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
                  formValidateStatus!= null ? Text('Kiểm tra thông tin: $formValidateStatus') : Container(),

                  Text('Nam: ${formData[keyName]}'),
                  Text('Species: ${formData[keySpecies]}'),
                  Text('Breed: ${formData[keyBreed]}'),
                  Text('Colour: ${formData[keyColour]}'),
                  Text('Gender: ${formData[keyGender]}'),
                  Text('DateOfBirth: ${formData[keyDateOfBirth]}'),
                  Text('PurchaseAdoptionDate: ${formData[keyPurchaseAdoptionDate]}'),
                  Text('Microchips: ${(formData[keyMicrochips].join(', '))}'),
                ],
              ),
            ),

            SizedBox(height: 50,),

            // TODO: Country demo
            SelectOptions(
              placeholder: 'Country',
              name: keyCountry,
              initialValue: formData[keyCountry],
              dataSource: countriesData,
              validator: (String? value) => fieldValidator(
                name: keyCountry,
                value: value,
                message: 'required',
              ),
              onChanged: (String? value) => handleFieldOnChange(
                name: keyCountry,
                value: value,
              ),
            ),

            SizedBox(height: formElementSpace,),

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
              dataSource: speciesData,
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
              dataSource: breedData,
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
              dataSource: colourData,
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
              dataSource: genderData,
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

            // todo: microchips
            Row(
              children: [

                Expanded(
                  child: TextInput(
                      controller: _microchipInputController,
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

            // todo: microchips list
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
