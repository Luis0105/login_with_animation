import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
// 2.3 implementar librería timer
import 'dart:async';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Declaramos las variables necesarias
  late TextEditingController _userPasswordController;
  // 5: Variable que indica si el bóton esta cargando o no
  bool _isLoading = false;
  bool _passwordVisible = false;
  // Cerebro de la lógica de las animaciones
  StateMachineController? controller;
  // SMI State Machine Input
  SMIBool? isChecking;
  SMIBool? isHandsUp;
  SMITrigger? trigFail;
  SMITrigger? trigSuccess;
  // 2.1 Variable de recorrido de la mirada
  SMINumber? numLook;

  // Focos email y password FocusNode paso 1.1
  final emailFocus = FocusNode();
  final passwordFocus = FocusNode();
  // 3.2 Crear timer para detener la animación al dejar de teclear email
  Timer? _typingDebouncer;
  //Paso 4.1 Declarar controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  //4.2 Errores para mostrar en la UI
  String? emailError;
  String? passwordError;

  //4.3 Validadores
  bool isValidEmail(String email) {
    // Expresiones regulares
    final emailRegex = RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$');
    return emailRegex.hasMatch(email);
  }

  // Valida la contraseña usando el checklist visual
  String? validedpassword(String password) {
    if (password.isEmpty) return 'Campo vacío';
    if (password.length < 8) return 'Debe tener al menos 8 caracteres';
    if (!password.contains(RegExp(r'[A-Z]')))
      return 'Debe incluir una mayúscula';
    if (!password.contains(RegExp(r'[a-z]')))
      return 'Debe incluir una minúscula';
    if (!password.contains(RegExp(r'[0-9]'))) return 'Debe incluir un número';
    if (!password.contains(RegExp(r'[^A-Za-z0-9]')))
      return 'Debe incluir un carácter especial';
    return null;
  }

  // 4.4 accion al boton login
  void _onlogin() async {
    if (_isLoading) return; // Evita spam o doble tap

    setState(() {
      _isLoading = true; // Activa el círculo de carga
    });

    final email = emailController.text.trim();
    final password = passwordController.text;

    // Recalcular errores
    final eError = email.isEmpty // Si la cadena esta vacia
        ? 'Campo vacio'
        : (!isValidEmail(email) ? 'Email inválido' : null);

    final pError = validedpassword(password);

    // para avisar que hubo un cambio
    setState(() {
      emailError = eError;
      passwordError = pError;
    });
    // 4.5 Cerrar el teclado y bajas
    FocusScope.of(context).unfocus();
    isChecking?.change(false);
    isHandsUp?.change(false);
    numLook?.value = 50.0; // Mirada neutral

    // Espera un mini delay
    await Future.delayed(const Duration(seconds: 1));

    // 4.7 Activar Triggers
    if (eError == null && pError == null) {
      trigSuccess?.fire();
    } else {
      trigFail?.fire();
    }

    // Mantener el spinner visible por ~1 s
    await Future.delayed(const Duration(seconds: 1));

    setState(() {
      _isLoading = false; // Se apaga el estado de carga
    });
  }

  // Listeners oyentes

  @override
  void initState() {
    super.initState();
    _userPasswordController = TextEditingController();
    _passwordVisible = false;
    emailFocus.addListener(() {
      if (emailFocus.hasFocus) {
        isHandsUp?.change(false); //manos abajo email
        // Mirada neutral al enfocar email
        numLook?.value = 50.0;
        isHandsUp?.change(false); //manos abajo email
      }
    });
    passwordFocus.addListener(() {
      isHandsUp?.change(passwordFocus.hasFocus); //manos arriba password
    });

    // 🔹 Nuevo: actualizar en vivo el checklist al escribir contraseña
    passwordController.addListener(() {
      setState(() {}); // Redibuja cada vez que cambia el texto
    });
  }

  @override
  Widget build(BuildContext context) {
    // Consulta el tamaño de la pantalla
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              SizedBox(
                width: size.width,
                height: 200,
                child: RiveAnimation.asset(
                  'assets/animated_login_character.riv',
                  stateMachines: ["Login Machine"],
                  onInit: (artboard) {
                    controller = StateMachineController.fromArtboard(
                      artboard,
                      "Login Machine",
                    );
                    // Verificar que inició bien
                    if (controller == null) return;
                    artboard.addController(controller!);
                    isChecking = controller!.findSMI('isChecking');
                    isHandsUp = controller!.findSMI('isHandsUp');
                    trigSuccess = controller!.findSMI('trigSuccess');
                    trigFail = controller!.findSMI('trigFail');
                    // paso 2.3 enlazar la variable con la animación
                    numLook = controller!.findSMI('numLook');
                  }, // Qué es clamp?? en programación y en la vida
                  // clamp: abrazadera retiene el valor dentro de un rango
                ),
              ),
              const SizedBox(height: 10),
              // Campo de texto email
              TextField(
                // llamado a los oyentes
                focusNode: emailFocus,
                // 4.8 enlazar controldores al texfield
                controller: emailController,
                onChanged: (value) {
                  // estoy escribiendo
                  isChecking!.change(true);
                  // ajuste de limite 0 a 100
                  // 80 es medida de calibración
                  final look =
                      (value.length / 80.0 * 100.0).clamp(0, 100).toDouble();
                  numLook?.value = look;
                  // Paso 3.3 Debounce: si vuelve a teclear, reinicia el timer
                  _typingDebouncer?.cancel(); // cancela un timer existente
                  _typingDebouncer = Timer(const Duration(seconds: 2), () {
                    if (!mounted) {
                      return; // si la pantalla se cierra
                    }

                    // Mirada neutral al dejar de teclear email
                    isChecking?.change(false);
                  });

                  if (isChecking == null) return;
                  // Activa el modo chismoso

                  isChecking!.change(true);
                },
                textInputAction: TextInputAction.next,

                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  //4.9 mostrar el texto de error
                  errorText: emailError,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  hintText: 'Email',
                  labelText: 'Email',
                  prefixIcon: const Icon(Icons.mail),
                ),
              ),
              const SizedBox(height: 10),
              // Campo de texto password
              TextField(
                focusNode: passwordFocus,
                controller: passwordController,
                onChanged: (value) {
                  if (isChecking != null) {
                    // No tapar los ojos al escribir email
                    //isHandsUp!.change(false);
                  }
                  if (isHandsUp == null) return;
                  // Activa el modo chismoso
                  isHandsUp!.change(true);

                  // Si deja de escribir, bajar manos después de 2 s
                  _typingDebouncer?.cancel();
                  _typingDebouncer = Timer(const Duration(seconds: 2), () {
                    if (!mounted) return;
                    isHandsUp!.change(false);
                  });
                },
                obscureText: !_passwordVisible,
                decoration: InputDecoration(
                  errorText: passwordError,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  hintText: 'Password',
                  labelText: 'Password',
                  prefixIcon: const Icon(Icons.password),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _passwordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        _passwordVisible = !_passwordVisible;
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(height: 8),
              // 🔹 Checklist visual que se actualiza en vivo
              PasswordStrengthChecklist(password: passwordController.text),

              SizedBox(height: 10),
              // Texto forgot password
              SizedBox(
                width: size.width,
                child: Text(
                  'Forgot password?',
                  textAlign: TextAlign.right,
                  style: TextStyle(decoration: TextDecoration.underline),
                ),
              ),
              // Botón login
              SizedBox(height: 10),
              // Botón estilo andriod, onPressed todos los botnones
              MaterialButton(
                minWidth: size.width,
                height: 50,
                color: Colors.purple,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                // _isLoading: controla si se muestra el texto
                // CircularProgressIndicator: muestra el indicador giratorio
                onPressed:
                    _isLoading ? null : _onlogin, // Desactiva mientras carga
                child: _isLoading
                    ? const SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(
                          color: Colors.black,
                          strokeWidth: 3, // strokeWidth:. Grosor de la línea
                        ),
                      )
                    : const Text(
                        'Login',
                        style: TextStyle(color: Colors.white),
                      ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("No tienes cuenta?"),
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        'Regístrate',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // 4.11 limpiar controladores
    emailController.dispose();
    passwordController.dispose();
    _userPasswordController.dispose();
    emailFocus.dispose();
    passwordFocus.dispose();
    _typingDebouncer?.cancel(); //3.4
    super.dispose();
  }
}

//6.7 Correción de errores de la contraseña en vivo
class PasswordStrengthChecklist extends StatelessWidget {
  final String password;
  const PasswordStrengthChecklist({super.key, required this.password});

  bool get upper => password.contains(RegExp(r'[A-Z]'));
  bool get lower => password.contains(RegExp(r'[a-z]'));
  bool get number => password.contains(RegExp(r'\d'));
  bool get special => password.contains(RegExp(r'[^A-Za-z0-9]'));
  bool get min => password.length >= 8;

  Widget _buildItem(String text, bool condition) {
    return Row(
      children: [
        Icon(
          condition ? Icons.check_circle : Icons.cancel,
          color: condition ? Colors.green : Colors.red,
          size: 18,
        ),
        const SizedBox(width: 8),
        Text(
          text,
          style: TextStyle(
            color: condition ? Colors.green : Colors.red,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    if (password.isEmpty) {
      return const SizedBox(); // Oculta mientras no escriba nada
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildItem("Al menos 8 caracteres", min),
        _buildItem("Una letra mayúscula", upper),
        _buildItem("Una letra minúscula", lower),
        _buildItem("Un número", number),
        _buildItem("Un símbolo o carácter especial", special),
      ],
    );
  }
}
