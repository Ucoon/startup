import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  final GlobalKey _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: EdgeInsets.all(80.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Welcome',
                style: Theme.of(context).textTheme.headline5,
              ),
              Form(
                key: _formKey,
                autovalidate: true,
                child: Column(
                  children: [
                    TextFormField(
                      validator: (value) {
                        return value.trim().length > 0 ? null : '用户名不能为空';
                      },
                      decoration: InputDecoration(
                        icon: Icon(Icons.person),
                        hintText: '请输入用户名',
                      ),
                    ),
                    TextFormField(
                      validator: (value) {
                        return value.trim().length > 5 ? null : '密码不能少于6位';
                      },
                      obscureText: true,
                      decoration: InputDecoration(
                        icon: Icon(Icons.lock),
                        hintText: '请输入密码',
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 24,
              ),
              RaisedButton(
                color: Colors.yellow,
                child: Text('登录'),
                onPressed: () {
                  if ((_formKey.currentState as FormState).validate()) {
                    print('登录成功');
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
