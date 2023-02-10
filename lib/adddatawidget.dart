import 'package:flutter/material.dart';
import 'models/cases.dart';
import 'services/api_service.dart';

enum Gender { male, female }

enum Status { positive, dead, recovered }

class AddDataWidget extends StatefulWidget {
  AddDataWidget();

  @override
  _AddDataWidgetState createState() => _AddDataWidgetState();
}

class _AddDataWidgetState extends State<AddDataWidget> {
  _AddDataWidgetState();

  final ApiService api = ApiService();
  final _addFormKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  String gender = 'male';
  Gender _gender = Gender.male;
  final _ageController = TextEditingController();
  final _addressController = TextEditingController();
  final _cityController = TextEditingController();
  final _countryController = TextEditingController();
  String status = 'positive';
  Status _status = Status.positive;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Entrada '),
      ),
      body: Form(
        key: _addFormKey,
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(20.0),
            child: Card(
                child: Container(
                    padding: EdgeInsets.all(10.0),
                    width: 440,
                    child: Column(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                          child: Column(
                            children: <Widget>[
                              Text('Nome do cliente'),
                              TextFormField(
                                controller: _nameController,
                                decoration: const InputDecoration(
                                  hintText: 'Nome completo',
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Por favor inserir nome completo';
                                  }
                                  return null;
                                },
                                onChanged: (value) {},
                              ),
                            ],
                          ),
                        ),
                        /*Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                          child: Column(
                            children: <Widget>[
                              Text('Gender'),
                              ListTile(
                                title: const Text('Male'),
                                leading: Radio(
                                  value: Gender.male,
                                  groupValue: _gender,
                                  onChanged: (Gender? value) {
                                    setState(() {
                                      _gender = value!;
                                      gender = 'male';
                                    });
                                  },
                                ),
                              ),
                              ListTile(
                                title: const Text('Female'),
                                leading: Radio(
                                  value: Gender.female,
                                  groupValue: _gender,
                                  onChanged: (Gender? value) {
                                    setState(() {
                                      _gender = value!;
                                      gender = 'female';
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),*/
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                          child: Column(
                            children: <Widget>[
                              Text('RG'),
                              TextFormField(
                                controller: _ageController,
                                decoration: const InputDecoration(
                                  hintText: 'RG',
                                ),
                                keyboardType: TextInputType.number,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Por favor insira o RG';
                                  }
                                  return null;
                                },
                                onChanged: (value) {},
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                          child: Column(
                            children: <Widget>[
                              Text('Descrição do item'),
                              TextFormField(
                                controller: _addressController,
                                decoration: const InputDecoration(
                                  hintText: 'Descrição do item',
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Por favor informar o item';
                                  }
                                  return null;
                                },
                                onChanged: (value) {},
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                          child: Column(
                            children: <Widget>[
                              Text('S/N ou alguma identificação'),
                              TextFormField(
                                controller: _cityController,
                                decoration: const InputDecoration(
                                  hintText: 'S/N ou alguma identificação',
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Por favor, informe S/N ou alguma identificação';
                                  }
                                  return null;
                                },
                                onChanged: (value) {},
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                          child: Column(
                            children: <Widget>[
                              Text('Cidade'),
                              TextFormField(
                                controller: _countryController,
                                decoration: const InputDecoration(
                                  hintText: 'Cidade',
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Por favor, informe a cidade';
                                  }
                                  return null;
                                },
                                onChanged: (value) {},
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                          child: Column(
                            children: <Widget>[
                              Text('Tamanho do item'),
                              ListTile(
                                title: const Text('Grande'),
                                leading: Radio(
                                  value: Status.positive,
                                  groupValue: _status,
                                  onChanged: (Status? value) {
                                    setState(() {
                                      _status = value!;
                                      status = 'grande';
                                    });
                                  },
                                ),
                              ),
                              ListTile(
                                title: const Text('Medio'),
                                leading: Radio(
                                  value: Status.dead,
                                  groupValue: _status,
                                  onChanged: (Status? value) {
                                    setState(() {
                                      _status = value!;
                                      status = 'medio';
                                    });
                                  },
                                ),
                              ),
                              ListTile(
                                title: const Text('Pequeno'),
                                leading: Radio(
                                  value: Status.recovered,
                                  groupValue: _status,
                                  onChanged: (Status? value) {
                                    setState(() {
                                      _status = value!;
                                      status = 'pequeno';
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                          child: Column(
                            children: <Widget>[
                              ElevatedButton(
                                onPressed: () {
                                  if (_addFormKey.currentState!.validate()) {
                                    _addFormKey.currentState!.save();
                                    api.createCase(Cases(
                                        name: _nameController.text,
                                        gender: gender,
                                        age: int.parse(_ageController.text),
                                        address: _addressController.text,
                                        city: _cityController.text,
                                        country: _countryController.text,
                                        status: status,
                                        updated: '',
                                        id: ''));

                                    Navigator.pop(context);
                                  }
                                },
                                child: Text('Save',
                                    style: TextStyle(color: Colors.white)),
                              )
                            ],
                          ),
                        ),
                      ],
                    ))),
          ),
        ),
      ),
    );
  }
}
