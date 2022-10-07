// Gabriel Moreira Silva - 303
import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home>
{
  final _salariosMinimoController = TextEditingController();
  final _numeroFilhosController = TextEditingController();

  bool _filhosVacinados = false;
  bool _maeSolteira = false;

  String _textoResultado = "Preencha os dados";

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Calculadora de Auxílios"),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[

              //Icon
              Center(
                child: Icon(Icons.accessibility_new, size: 120.0, color: Colors.green,),
              ),

              //Salarios
              Material(
                color: Colors.white,
                child: Flexible(
                  child: FractionallySizedBox(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(50, 20, 50, 50),
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        controller: _salariosMinimoController,
                        decoration: const InputDecoration(
                          icon: Icon(
                              Icons.money,
                              color: Colors.green
                          ),
                          labelText: "Quanto você recebe? (em reais)",
                          helperText: "Salário Minimo atual = R\$1212",
                        ),
                        validator: (val)
                        {
                          if(val == null || val.isEmpty) return "Insira os dados";
                          if(double.tryParse(val) == null) return "Insira apenas numeros";
                          if(double.parse(val) < 0) return "Insira numeros positivos";
                        },
                      ),
                    ),
                  ),
                ),
              ),

              //Criancas
              Material(
                color: Colors.white,
                child: Flexible(
                  child: FractionallySizedBox(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(50.0, 0, 50.0, 50),
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        controller: _numeroFilhosController,
                        decoration: const InputDecoration(
                          icon: Icon(
                              Icons.child_care,
                              color: Colors.green
                          ),
                          labelText: "Número de filhos na escola",
                          helperText: "Filhos matriculados regularmente",
                        ),
                        validator: (val)
                        {
                          if(val == null || val.isEmpty) return "Insira os dados";
                          if(double.tryParse(val) == null) return "Insira apenas numeros";
                          if(double.parse(val) < 0) return "Insira numeros positivos";
                        },
                      ),
                    ),
                  ),
                ),
              ),

              //Mae Solteira
              Padding(
                padding: const EdgeInsets.fromLTRB(50, 0, 50.0, 50.0),
                child: FractionallySizedBox(
                  widthFactor: 1,
                  child: Row(
                    children: <Widget>[
                      Text(
                        "A chefe da familia é mãe solteira?",
                        style: TextStyle(
                          fontSize: 15.0,
                        ),
                      ),

                      Checkbox(
                        checkColor: Colors.white,
                        fillColor: MaterialStateProperty.resolveWith ((Set  states)
                        {
                          if (states.contains(MaterialState.disabled)) {
                            return Colors.green.withOpacity(.32);
                          }
                          return Colors.green;
                        }),
                        value: _maeSolteira,
                        onChanged: (bool? value) {
                          setState(() {
                            _maeSolteira = value!;
                          });
                        },
                      ),
                    ],

                    mainAxisAlignment: MainAxisAlignment.center,
                  ),
                ),
              ),

              //Vacinados
              Padding(
                padding: const EdgeInsets.fromLTRB(50, 0, 50.0, 50.0),
                child: FractionallySizedBox(
                  widthFactor: 1,
                  child: Row(
                    children: <Widget>[
                      Text(
                        "Os filhos estão vacinados?",
                        style: TextStyle(
                          fontSize: 15.0,
                        ),
                      ),

                      Checkbox(
                        checkColor: Colors.white,
                        fillColor: MaterialStateProperty.resolveWith ((Set  states)
                        {
                          if (states.contains(MaterialState.disabled)) {
                            return Colors.green.withOpacity(.32);
                          }
                          return Colors.green;
                        }),
                        value: _filhosVacinados,
                        onChanged: (bool? value) {
                          setState(() {
                            _filhosVacinados = value!;
                          });
                        },
                      ),
                    ],

                    mainAxisAlignment: MainAxisAlignment.center,
                  ),
                ),
              ),

              //Botao
              Padding(
                padding: const EdgeInsets.fromLTRB(50, 0, 50.0, 50.0),
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith ((Set  states)
                    {
                      if (states.contains(MaterialState.disabled)) {
                        return Colors.green.withOpacity(.32);
                      }
                      return Colors.green;
                    }),
                  ),
                  onPressed: (){
                    double salarios = double.parse(_salariosMinimoController.text) / 1212;
                    double filhos = double.parse(_numeroFilhosController.text);
                    bool maeSolteira = _maeSolteira;
                    bool vacinados = _filhosVacinados;

                    if(vacinados)
                    {
                      if(salarios <= 2 && filhos <= 2)
                      {
                        if(maeSolteira)
                        {
                          setState(() {
                            _textoResultado = "Auxílio de 1,5 salários mínimos + 600 reais (R\$1418)";
                          });
                        }
                        else
                        {
                          setState(() {
                            _textoResultado = "Auxílio de 1,5 salaŕios (R\$1818)";
                          });
                        }
                      }

                      if(salarios <= 1 && filhos <= 2)
                      {
                        if(maeSolteira)
                        {
                          setState(() {
                            _textoResultado = "Auxílio de 2,5 salários mínimos + 600 reais (R\$3630)";
                          });
                        }
                        else
                        {
                          setState(() {
                            _textoResultado = "Auxílio de 2,5 salaŕios (R\$2030)";
                          });
                        }
                      }

                      if(filhos > 3)
                      {
                        if(maeSolteira)
                        {
                          setState(() {
                            _textoResultado = "Auxílio de 3 salários mínimos + 600 reais (R\$4236)";
                          });
                        }
                        else
                        {
                          setState(() {
                            _textoResultado = "Auxílio de 3 salaŕios (R\$2424)";
                          });
                        }
                      }
                    }
                    else
                    {
                      _textoResultado = "Vacine seus filhos!";
                    }

                    _salariosMinimoController.text = "";
                    _numeroFilhosController.text = "";

                    setState(() {
                      _maeSolteira = false;
                      _filhosVacinados = false;
                    });

                  },
                  child: const Text("Calcular"),
                ),
              ),

              //Texto resultado
              Padding(
                padding: const EdgeInsets.fromLTRB(50, 0, 50.0, 50.0),
                child: FractionallySizedBox(
                  widthFactor: 1,
                  child: Container(
                    height: 150,
                    decoration: const BoxDecoration(
                      color: Colors.grey,
                    ),
                    child: Center(
                      child: Text(
                        "$_textoResultado",
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),

    );
  }
}
