import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/game_provider.dart';
import 'key_generator_screen.dart';
import '../services/subscription_service.dart';

class SubscriptionScreen extends StatefulWidget {
  const SubscriptionScreen({super.key});

  @override
  State<SubscriptionScreen> createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<SubscriptionScreen> {
  final TextEditingController _keyController = TextEditingController();
  bool _isActivating = false;
  String? _errorMessage;
  String? _successMessage;
  String _statusMessage = '';
  final SubscriptionService _subscriptionService = SubscriptionService();
  List<Map<String, dynamic>> _subscriptions = [];

  @override
  void initState() {
    super.initState();
    _loadSubscriptions();
  }

  Future<void> _loadSubscriptions() async {
    final subs = await _subscriptionService.getAllSubscriptions();
    setState(() {
      _subscriptions = subs;
    });
  }

  @override
  void dispose() {
    _keyController.dispose();
    super.dispose();
  }

  Future<void> _activateSubscription() async {
    final gameProvider = Provider.of<GameProvider>(context, listen: false);
    
    setState(() {
      _isActivating = true;
      _errorMessage = null;
      _successMessage = null;
      _statusMessage = 'Iniciando activación...';
    });
    
    try {
      final String key = _keyController.text.trim().toUpperCase();
      
      if (key.isEmpty) {
        setState(() {
          _errorMessage = 'Por favor, ingresa una clave de activación';
          _isActivating = false;
          _statusMessage = '';
        });
        return;
      }
      
      setState(() {
        _statusMessage = 'Validando clave...';
      });
      
      // Verificar formato de la clave
      if (!key.startsWith('LEVEL')) {
        setState(() {
          _errorMessage = 'Formato de clave inválido. Debe comenzar con LEVEL2 o LEVEL3';
          _isActivating = false;
          _statusMessage = '';
        });
        return;
      }
      
      setState(() {
        _statusMessage = 'Activando suscripción...';
      });
      
      final bool success = await gameProvider.activateSubscription(key);
      
      if (success) {
        setState(() {
          _successMessage = '¡Suscripción activada correctamente!';
          _keyController.clear();
          _statusMessage = '';
        });
        
        // Recargar la lista de suscripciones
        _loadSubscriptions();
        
      } else {
        setState(() {
          _errorMessage = 'Clave de activación inválida o ya utilizada';
          _statusMessage = '';
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Error al activar la suscripción: $e';
        _statusMessage = '';
      });
    } finally {
      setState(() {
        _isActivating = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Obtener el tamaño de la pantalla
    final Size screenSize = MediaQuery.of(context).size;
    final bool isSmallScreen = screenSize.width < 360 || screenSize.height < 600;
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Teolingo - Activación'),
        backgroundColor: Colors.blue.shade800,
        foregroundColor: Colors.white,
        actions: [
          // Botón para acceder al generador de claves (solo para desarrollo)
          IconButton(
            icon: const Icon(Icons.developer_mode),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const KeyGeneratorScreen()),
              );
            },
            tooltip: 'Generador de claves (desarrollo)',
          ),
          // Botón para recargar las suscripciones
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadSubscriptions,
            tooltip: 'Recargar suscripciones',
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.blue.shade700,
              Colors.indigo.shade900,
            ],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(isSmallScreen ? 16.0 : 24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Card(
                      elevation: 8,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(isSmallScreen ? 16.0 : 24.0),
                        child: Column(
                          children: [
                            Text(
                              'Activar Niveles Adicionales',
                              style: TextStyle(
                                fontSize: isSmallScreen ? 20 : 24,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Ingresa tu clave de activación para desbloquear todos los niveles del juego.',
                              style: TextStyle(
                                fontSize: isSmallScreen ? 14 : 16,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 24),
                            TextField(
                              controller: _keyController,
                              decoration: InputDecoration(
                                labelText: 'Clave de Activación',
                                hintText: 'Ej: LEVEL3-ABCD-1234',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                prefixIcon: const Icon(Icons.vpn_key),
                              ),
                              textCapitalization: TextCapitalization.characters,
                              textInputAction: TextInputAction.done,
                              onSubmitted: (_) => _activateSubscription(),
                            ),
                            const SizedBox(height: 16),
                            if (_statusMessage.isNotEmpty)
                              Padding(
                                padding: const EdgeInsets.only(bottom: 16),
                                child: Row(
                                  children: [
                                    const SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Text(
                                        _statusMessage,
                                        style: const TextStyle(
                                          color: Colors.blue,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            if (_errorMessage != null)
                              Padding(
                                padding: const EdgeInsets.only(bottom: 16),
                                child: Text(
                                  _errorMessage!,
                                  style: const TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            if (_successMessage != null)
                              Padding(
                                padding: const EdgeInsets.only(bottom: 16),
                                child: Text(
                                  _successMessage!,
                                  style: const TextStyle(
                                    color: Colors.green,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: _isActivating ? null : _activateSubscription,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.amber,
                                  padding: EdgeInsets.symmetric(
                                    vertical: isSmallScreen ? 12 : 16,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                child: _isActivating
                                    ? const SizedBox(
                                        width: 24,
                                        height: 24,
                                        child: CircularProgressIndicator(
                                          color: Colors.white,
                                          strokeWidth: 2,
                                        ),
                                      )
                                    : Text(
                                        'Activar',
                                        style: TextStyle(
                                          fontSize: isSmallScreen ? 16 : 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black87,
                                        ),
                                      ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Consumer<GameProvider>(
                      builder: (context, gameProvider, child) {
                        return Card(
                          elevation: 8,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(isSmallScreen ? 16.0 : 24.0),
                            child: Column(
                              children: [
                                Text(
                                  'Niveles Disponibles',
                                  style: TextStyle(
                                    fontSize: isSmallScreen ? 18 : 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 16),
                                _buildLevelStatus(
                                  context,
                                  'Nivel 1: Orden Normal',
                                  'Aprende las letras en orden alfabético',
                                  gameProvider.isLevelUnlocked(GameLevel.level1),
                                ),
                                const SizedBox(height: 8),
                                _buildLevelStatus(
                                  context,
                                  'Nivel 2: Orden Inverso',
                                  'Aprende las letras en orden inverso',
                                  gameProvider.isLevelUnlocked(GameLevel.level2),
                                ),
                                const SizedBox(height: 8),
                                _buildLevelStatus(
                                  context,
                                  'Nivel 3: Orden Aleatorio',
                                  'Aprende las letras en orden aleatorio',
                                  gameProvider.isLevelUnlocked(GameLevel.level3),
                                ),
                                const SizedBox(height: 8),
                                _buildLevelStatus(
                                  context,
                                  'Nivel 4: Nombre a Símbolo',
                                  'Identifica el símbolo a partir del nombre',
                                  gameProvider.isLevelUnlocked(GameLevel.level4),
                                ),
                                const SizedBox(height: 8),
                                _buildLevelStatus(
                                  context,
                                  'Nivel 5: Nombre a Símbolo Inverso',
                                  'Identifica el símbolo a partir del nombre, en orden inverso',
                                  gameProvider.isLevelUnlocked(GameLevel.level5),
                                ),
                                const SizedBox(height: 8),
                                _buildLevelStatus(
                                  context,
                                  'Nivel 6: Nombre a Símbolo Aleatorio',
                                  'Identifica el símbolo a partir del nombre, en orden aleatorio',
                                  gameProvider.isLevelUnlocked(GameLevel.level6),
                                ),
                                const SizedBox(height: 8),
                                _buildLevelStatus(
                                  context,
                                  'Nivel 7: Símbolo a Transcripción',
                                  'Identifica la transcripción en español a partir del símbolo',
                                  gameProvider.isLevelUnlocked(GameLevel.level7),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                    if (_subscriptions.isNotEmpty) ...[
                      const SizedBox(height: 24),
                      Card(
                        elevation: 8,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(isSmallScreen ? 16.0 : 24.0),
                          child: Column(
                            children: [
                              Text(
                                'Suscripciones Activas',
                                style: TextStyle(
                                  fontSize: isSmallScreen ? 18 : 20,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 16),
                              ...List.generate(
                                _subscriptions.length,
                                (index) => _buildSubscriptionItem(
                                  _subscriptions[index],
                                  isSmallScreen,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLevelStatus(BuildContext context, String title, String description, bool isUnlocked) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isUnlocked ? Colors.green.withOpacity(0.1) : Colors.grey.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isUnlocked ? Colors.green : Colors.grey,
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Icon(
            isUnlocked ? Icons.lock_open : Icons.lock,
            color: isUnlocked ? Colors.green : Colors.grey,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: isUnlocked ? Colors.black87 : Colors.grey,
                  ),
                ),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 12,
                    color: isUnlocked ? Colors.black54 : Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildSubscriptionItem(Map<String, dynamic> subscription, bool isSmallScreen) {
    final String key = subscription['key'] as String;
    final int level = subscription['level'] as int;
    final String activationDate = subscription['activationDate'] as String;
    final String? expiryDate = subscription['expiryDate'] as String?;
    
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.blue.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Colors.blue,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.vpn_key,
                color: Colors.blue,
                size: isSmallScreen ? 16 : 20,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  key,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: isSmallScreen ? 12 : 14,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Icon(
                Icons.stars,
                color: Colors.amber,
                size: isSmallScreen ? 16 : 20,
              ),
              const SizedBox(width: 8),
              Text(
                'Nivel: $level',
                style: TextStyle(
                  fontSize: isSmallScreen ? 12 : 14,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Icon(
                Icons.calendar_today,
                color: Colors.green,
                size: isSmallScreen ? 16 : 20,
              ),
              const SizedBox(width: 8),
              Text(
                'Activada: ${_formatDate(activationDate)}',
                style: TextStyle(
                  fontSize: isSmallScreen ? 12 : 14,
                ),
              ),
            ],
          ),
          if (expiryDate != null) ...[
            const SizedBox(height: 4),
            Row(
              children: [
                Icon(
                  Icons.event_busy,
                  color: Colors.red,
                  size: isSmallScreen ? 16 : 20,
                ),
                const SizedBox(width: 8),
                Text(
                  'Expira: ${_formatDate(expiryDate)}',
                  style: TextStyle(
                    fontSize: isSmallScreen ? 12 : 14,
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
  
  String _formatDate(String isoDate) {
    try {
      final DateTime date = DateTime.parse(isoDate);
      return '${date.day}/${date.month}/${date.year}';
    } catch (e) {
      return isoDate;
    }
  }
} 