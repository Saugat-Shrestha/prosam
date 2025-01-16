import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prosam/bloc_view/login/bloc/login_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late LoginBloc _loginBloc;

  final emailFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _loginBloc = LoginBloc();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("login"),
        ),
        body: BlocProvider(
          create: (_) => _loginBloc,
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                BlocBuilder<LoginBloc, LoginState>(
                  buildWhen: (p, c) => p.email != c.email,
                  builder: (context, state) {
                    return TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      focusNode: emailFocusNode,
                      decoration: InputDecoration(
                          hintText: "Email", border: OutlineInputBorder()),
                      onChanged: (value) {
                        context
                            .read<LoginBloc>()
                            .add(EmailChanged(email: value));
                      },
                      onFieldSubmitted: (value) {},
                    );
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                BlocBuilder<LoginBloc, LoginState>(
                  buildWhen: (p, c) => p.password != c.password,
                  builder: (context, state) {
                    return TextFormField(
                      keyboardType: TextInputType.text,
                      focusNode: passwordFocusNode,
                      decoration: InputDecoration(
                          hintText: "Password", border: OutlineInputBorder()),
                      onChanged: (value) {
                        context
                            .read<LoginBloc>()
                            .add(PasswordChanged(password: value));
                      },
                      onFieldSubmitted: (value) {},
                    );
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                BlocListener<LoginBloc, LoginState>(
                  listener: (context, state) {
                    if (state.loginStatus == LoginStatus.error) {
                      ScaffoldMessenger.of(context)
                        ..hideCurrentSnackBar()
                        ..showSnackBar(
                          SnackBar(
                            content: Text(
                              state.message.toString(),
                            ),
                          ),
                        );
                    }
                    if (state.loginStatus == LoginStatus.loading) {
                      ScaffoldMessenger.of(context)
                        ..hideCurrentSnackBar()
                        ..showSnackBar(
                          SnackBar(
                            content: Text(
                              "Submitting",
                            ),
                          ),
                        );
                    }
                    if (state.loginStatus == LoginStatus.success) {
                      ScaffoldMessenger.of(context)
                        ..hideCurrentSnackBar()
                        ..showSnackBar(
                          SnackBar(
                            content: Text(
                              "Login Sucessful",
                            ),
                          ),
                        );
                    }
                  },
                  child: BlocBuilder<LoginBloc, LoginState>(
                    buildWhen: (p, c) => false,
                    builder: (context, state) {
                      return ElevatedButton(
                        onPressed: () {
                          context.read<LoginBloc>().add(LoginApi());
                        },
                        child: Text("login"),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
