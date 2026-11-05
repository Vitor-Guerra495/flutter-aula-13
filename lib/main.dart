import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(const MaterialApp(
    home: TelaEnviar(),
  ));
}

const String baseUrl = 'http://10.0.2.2/y';

class TelaEnviar extends StatefulWidget {
  const TelaEnviar({super.key});

  @override
  State<TelaEnviar> createState() => _TelaEnviarState();
}

class _TelaEnviarState extends State<TelaEnviar> {
  final TextEditingController _controller = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  XFile? _foto;
  String _status = '';

  Future<void> _tirarFoto() async {
    final XFile? fotoTirada = await _picker.pickImage(source: ImageSource.camera);
    if (fotoTirada != null) {
      setState(() {
        _foto = fotoTirada;
      });
    }
  }

  Future<void> _salvarDados() async {
    final url = Uri.parse('$baseUrl/salvar.php');
    final requisicao = http.MultipartRequest('POST', url);

    requisicao.fields['txt'] = _controller.text;

    if (_foto != null) {
      requisicao.files.add(
        await http.MultipartFile.fromPath('imagem', _foto!.path),
      );
    }

    final respostaStream = await requisicao.send();
    final resposta = await http.Response.fromStream(respostaStream);

    setState(() {
      _status = resposta.body;
      _controller.clear();
      _foto = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Enviar Foto e Descrição')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(labelText: 'Descrição da foto'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _tirarFoto,
              child: const Text('Tirar Foto'),
            ),
            const SizedBox(height: 16),
            if (_foto != null)
              Image.file(
                File(_foto!.path),
                height: 200,
              ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _salvarDados,
              child: const Text('Salvar no Site'),
            ),
            const SizedBox(height: 16),
            Text(_status),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const TelaMostrar()),
                );
              },
              child: const Text('Ver Fotos (Uma por vez)'),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const TelaTodasFotos()),
                );
              },
              child: const Text('Ver Todas as Fotos (Lista)'),
            ),
          ],
        ),
      ),
    );
  }
}

class TelaMostrar extends StatefulWidget {
  const TelaMostrar({super.key});

  @override
  State<TelaMostrar> createState() => _TelaMostrarState();
}

class _TelaMostrarState extends State<TelaMostrar> {
  int _idAtual = 0;
  String _descricaoExibida = '';
  String _imagemExibida = '';

  @override
  void initState() {
    super.initState();
    _buscarProximo();
  }

  Future<void> _buscarProximo() async {
    final url = Uri.parse('$baseUrl/recebe.php?id=$_idAtual');
    final resposta = await http.get(url);
    final dados = jsonDecode(resposta.body);

    setState(() {
      if (dados['id'] != null) {
        _idAtual = int.parse(dados['id'].toString());
        _descricaoExibida = dados['texto'].toString();
        _imagemExibida = (dados['imagem'] ?? '').toString();
      } else {
        _idAtual = 0;
        _descricaoExibida = 'Não há mais fotos. Clique novamente para voltar ao início.';
        _imagemExibida = '';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Fotos (Uma por vez)')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (_imagemExibida.isNotEmpty)
              Image.network(
                '$baseUrl/$_imagemExibida',
                height: 250,
                fit: BoxFit.contain,
              ),
            const SizedBox(height: 12),
            Text(
              _descricaoExibida,
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _buscarProximo,
              child: const Text('Próxima Foto'),
            ),
          ],
        ),
      ),
    );
  }
}

class TelaTodasFotos extends StatefulWidget {
  const TelaTodasFotos({super.key});

  @override
  State<TelaTodasFotos> createState() => _TelaTodasFotosState();
}

class _TelaTodasFotosState extends State<TelaTodasFotos> {
  List<dynamic> _listaFotos = [];

  @override
  void initState() {
    super.initState();
    _carregarFotos();
  }

  Future<void> _carregarFotos() async {
    final url = Uri.parse('$baseUrl/listar_fotos.php');
    final resposta = await http.get(url);
    final dados = jsonDecode(resposta.body);

    setState(() {
      _listaFotos = dados;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Todas as Fotos Salvas')),
      body: _listaFotos.isEmpty
          ? const Center(child: Text('Nenhuma foto encontrada.'))
          : ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: _listaFotos.length,
              itemBuilder: (context, index) {
                final item = _listaFotos[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 16.0),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (item['texto'].toString().isNotEmpty) ...[
                          Text(item['texto'].toString(), style: const TextStyle(fontSize: 16)),
                          const SizedBox(height: 8),
                        ],
                        Image.network(
                          '$baseUrl/${item['imagem']}',
                          height: 200,
                          fit: BoxFit.cover,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
