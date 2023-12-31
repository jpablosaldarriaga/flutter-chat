import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:chat/models/usuario.dart';

class UsuariosPage extends StatefulWidget {
  @override
  State<UsuariosPage> createState() => _UsuariosPageState();
}

class _UsuariosPageState extends State<UsuariosPage> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  final usuarios = [
    Usuario(online: true, email: 'juan@prueba.com', nombre: 'Juan', uid: '1'),
    Usuario(
        online: true, email: 'prueba1@prueba.com', nombre: 'Prueba1', uid: '2'),
    Usuario(online: true, email: 'pablo@prueba.com', nombre: 'Pablo', uid: '3'),
    Usuario(
        online: false,
        email: 'prueba2@prueba.com',
        nombre: 'Prueba2',
        uid: '4'),
    Usuario(online: true, email: 'este@prueba.com', nombre: 'Este', uid: '5'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Mi nombre',
          style: TextStyle(color: Colors.black54),
        ),
        elevation: 1,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.exit_to_app,
            color: Colors.black54,
          ),
        ),
        actions: [
          Container(
            margin: EdgeInsets.only(right: 10),
            child: Icon(
              Icons.check_circle,
              color: Colors.blue[400],
            ),
            // child: Icon(Icons.offline_bolt, color: Colors.red,),
          ),
        ],
      ),
      body: SmartRefresher(
        controller: _refreshController,
        enablePullDown: true,
        onRefresh: _cargarUsuarios,
        header: WaterDropHeader(
          complete: Icon(Icons.check, color: Colors.green[400]),
          waterDropColor: Colors.blue,
        ),
        child: _listViewUsuarios(),
      ),
    );
  }

  ListView _listViewUsuarios() {
    return ListView.separated(
      physics: BouncingScrollPhysics(),
      itemBuilder: (_, i) => _usuarioListTile(usuarios[i]),
      separatorBuilder: (_, i) => Divider(),
      itemCount: usuarios.length,
    );
  }

  ListTile _usuarioListTile(Usuario usuario) {
    return ListTile(
      title: Text(usuario.nombre),
      subtitle: Text(usuario.email),
      leading: CircleAvatar(
        child: Text(usuario.nombre.substring(0, 2)),
        backgroundColor: Colors.blue[100],
      ),
      trailing: Container(
        width: 10,
        height: 10,
        decoration: BoxDecoration(
            color: usuario.online ? Colors.green[200] : Colors.red[200],
            borderRadius: BorderRadius.circular(100)),
      ),
    );
  }

  _cargarUsuarios() async {
    await Future.delayed(Duration(milliseconds: 1000));

    _refreshController.refreshCompleted();
  }
}
