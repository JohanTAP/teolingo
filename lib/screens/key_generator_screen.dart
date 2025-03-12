import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../utils/key_generator.dart';

class KeyGeneratorScreen extends StatefulWidget {
  const KeyGeneratorScreen({super.key});

  @override
  State<KeyGeneratorScreen> createState() => _KeyGeneratorScreenState();
}

class _KeyGeneratorScreenState extends State<KeyGeneratorScreen> {
  final List<String> _generatedKeys = [];
  int _selectedLevel = 2;
  int _keyCount = 5;
  final TextEditingController _specialKeyController = TextEditingController();
  String? _specialKeyError;
  String? _specialKeySuccess;
  bool _isAuthenticated = false;
  int _remainingAttempts = 3;
  bool _isBlocked = false;

  @override
  void dispose() {
    _specialKeyController.dispose();
    super.dispose();
  }

  void _generateKeys() {
    setState(() {
      _generatedKeys.clear();
      _generatedKeys.addAll(
        KeyGenerator.generateMultipleKeys(_selectedLevel, _keyCount),
      );
    });
  }

  void _validateAccessKey() {
    if (_isBlocked) return;

    final key = _specialKeyController.text.trim();
    setState(() {
      if (key.isEmpty) {
        _specialKeyError = 'Por favor, ingresa la clave de acceso';
        _specialKeySuccess = null;
      } else if (key == KeyGenerator.specialKeyLevel4) {
        _specialKeyError = null;
        _specialKeySuccess = '¡Acceso concedido!';
        _isAuthenticated = true;
      } else {
        _remainingAttempts--;
        if (_remainingAttempts <= 0) {
          _specialKeyError = 'Demasiados intentos fallidos. Acceso bloqueado.';
          _isBlocked = true;
        } else {
          _specialKeyError =
              'Clave incorrecta. Intentos restantes: $_remainingAttempts';
        }
        _specialKeySuccess = null;
      }
    });
  }

  void _copyToClipboard(String text) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Clave copiada al portapapeles'),
        duration: Duration(seconds: 1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Teolingo - Generador'),
        backgroundColor: Colors.blue.shade800,
        foregroundColor: Colors.white,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue.shade700, Colors.indigo.shade900],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child:
                _isAuthenticated
                    ? _buildKeyGeneratorContent()
                    : _buildAuthenticationScreen(),
          ),
        ),
      ),
    );
  }

  Widget _buildAuthenticationScreen() {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  children: [
                    const Icon(
                      Icons.security,
                      size: 64,
                      color: Colors.deepPurple,
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Área Restringida',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Esta sección requiere una clave de acceso especial.',
                      style: TextStyle(fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 24),
                    TextField(
                      controller: _specialKeyController,
                      decoration: InputDecoration(
                        labelText: 'Clave de acceso',
                        hintText: 'Ingresa la clave de acceso',
                        errorText: _specialKeyError,
                        border: const OutlineInputBorder(),
                        prefixIcon: const Icon(Icons.vpn_key),
                        enabled: !_isBlocked,
                      ),
                      obscureText: true,
                      onSubmitted: (_) => _validateAccessKey(),
                    ),
                    if (_specialKeySuccess != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 16.0),
                        child: Text(
                          _specialKeySuccess!,
                          style: const TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _isBlocked ? null : _validateAccessKey,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepPurple,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          disabledBackgroundColor: Colors.grey.shade400,
                        ),
                        child: const Text('Verificar Acceso'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildKeyGeneratorContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Card(
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Configuración',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    const Text('Nivel: '),
                    const SizedBox(width: 8),
                    DropdownButton<int>(
                      value: _selectedLevel,
                      items: const [
                        DropdownMenuItem(value: 2, child: Text('Nivel 2')),
                        DropdownMenuItem(value: 3, child: Text('Nivel 3')),
                        DropdownMenuItem(value: 4, child: Text('Nivel 4')),
                        DropdownMenuItem(value: 5, child: Text('Nivel 5')),
                        DropdownMenuItem(value: 6, child: Text('Nivel 6')),
                        DropdownMenuItem(value: 7, child: Text('Nivel 7')),
                      ],
                      onChanged: (value) {
                        if (value != null) {
                          setState(() {
                            _selectedLevel = value;
                          });
                        }
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Text('Cantidad: '),
                    const SizedBox(width: 8),
                    DropdownButton<int>(
                      value: _keyCount,
                      items: const [
                        DropdownMenuItem(value: 1, child: Text('1 clave')),
                        DropdownMenuItem(value: 5, child: Text('5 claves')),
                        DropdownMenuItem(value: 10, child: Text('10 claves')),
                        DropdownMenuItem(value: 20, child: Text('20 claves')),
                      ],
                      onChanged: (value) {
                        if (value != null) {
                          setState(() {
                            _keyCount = value;
                          });
                        }
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _generateKeys,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.amber,
                      foregroundColor: Colors.black87,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    child: const Text('Generar Claves'),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        const Text(
          'Claves Generadas',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 8),
        Expanded(
          child: Card(
            elevation: 4,
            child:
                _generatedKeys.isEmpty
                    ? const Center(
                      child: Text(
                        'Genera claves para verlas aquí',
                        style: TextStyle(
                          color: Colors.grey,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    )
                    : ListView.separated(
                      itemCount: _generatedKeys.length,
                      separatorBuilder:
                          (context, index) => const Divider(height: 1),
                      itemBuilder: (context, index) {
                        final key = _generatedKeys[index];
                        return ListTile(
                          title: Text(key),
                          subtitle: Text(
                            'Desbloquea hasta el nivel ${KeyGenerator.getLevelFromKey(key)}',
                            style: const TextStyle(fontSize: 12),
                          ),
                          trailing: IconButton(
                            icon: const Icon(Icons.copy),
                            onPressed: () => _copyToClipboard(key),
                            tooltip: 'Copiar al portapapeles',
                          ),
                        );
                      },
                    ),
          ),
        ),
        if (_generatedKeys.isNotEmpty) ...[
          const SizedBox(height: 16),
          ElevatedButton.icon(
            onPressed: () {
              final allKeys = _generatedKeys.join('\n');
              _copyToClipboard(allKeys);
            },
            icon: const Icon(Icons.copy_all),
            label: const Text('Copiar todas las claves'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Colors.black87,
            ),
          ),
        ],
      ],
    );
  }
}
