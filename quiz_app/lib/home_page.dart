import 'package:flutter/material.dart';
import 'package:quiz_app/botao_alternativa.dart';
import 'package:quiz_app/controlador_quiz.dart';
import 'botao_acao.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ControladorQuiz controladorQuiz = ControladorQuiz();

  void _selecionarAlternativa(String alternativa) {
    setState(() {
      controladorQuiz.selecionarAlternativa(alternativa);
    });
  }

  void _proximaPergunta() {
    setState(() {
      // controladorQuiz.proximaPegunta();
    });
  }

  void _acao() {
    setState(() {
      controladorQuiz.acao();
    });
  }

  @override
  Widget build(BuildContext context) {
    final questao = controladorQuiz.questaoAtual;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Quiz App"),
      ),
      body: controladorQuiz.verResultados
        ? const Center(child: Text("Resultados"))
        : Container(padding: const EdgeInsets.all(50),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                  "Questão ${controladorQuiz.indiceQuestaoAtual}/${controladorQuiz.quantidadeTotalQuestoes}"),
              Divider(thickness: 5),
              Text(questao.enunciado),
              Divider(thickness: 5),
              SizedBox(height: 10),
              ...controladorQuiz.questaoAtual.alternativas.map(
                (alternativa) {
                  return BotaoAlternativa(
                    alternativa: alternativa,
                    acao: _selecionarAlternativa,
                    selecionada:
                        controladorQuiz.alternativaSelecionada == alternativa,
                    acertou: controladorQuiz.acertouResposta,
                    respondeu: controladorQuiz.respondeuPergunta,
                  );
                },
              ),
              controladorQuiz.status != StatusQuiz.AGUARDAR
                  ? BotaoAcao(
                      texto: controladorQuiz.acabou
                          ? "Resultados"
                          : controladorQuiz.respondeuPergunta
                            ? "Próxima"
                            : "Responder",
                      acao: _acao,
                    )
                  : const SizedBox(
                      height: 100,
                    )
            ],
          ),
        ),
      ),
    );
  }
}
