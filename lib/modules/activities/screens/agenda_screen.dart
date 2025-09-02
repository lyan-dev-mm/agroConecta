import 'package:flutter/material.dart';
import 'package:agroconecta/models/actividad_model.dart';
import 'package:agroconecta/modules/activities/calendar/widgets/calendar_widget.dart';
import 'package:agroconecta/modules/activities/widgets/actividad_tile.dart';
import 'package:agroconecta/modules/activities/widgets/actividad_form.dart';
import 'package:agroconecta/modules/activities/widgets/menu_act.dart';
import 'package:flutter/rendering.dart';

class AgendaScreen extends StatefulWidget {
  const AgendaScreen({Key? key}) : super(key: key);

  @override
  State<AgendaScreen> createState() => _AgendaScreenState();
}

class _AgendaScreenState extends State<AgendaScreen> {
  DateTime _selectedDate = DateTime.now();
  List<Actividad> _actividades = [];

  late ScrollController _scrollController;
  bool _fabVisible = true;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_handleScroll);
  }

  void _handleScroll() {
    final direction = _scrollController.position.userScrollDirection;
    if (direction == ScrollDirection.reverse && _fabVisible) {
      setState(() => _fabVisible = false);
    } else if (direction == ScrollDirection.forward && !_fabVisible) {
      setState(() => _fabVisible = true);
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_handleScroll);
    _scrollController.dispose();
    super.dispose();
  }

  List<Actividad> get actividadesDelDia {
    return _actividades
        .where(
          (a) =>
              a.fecha.year == _selectedDate.year &&
              a.fecha.month == _selectedDate.month &&
              a.fecha.day == _selectedDate.day,
        )
        .toList();
  }

  void _agregarActividad(Actividad nueva) {
    setState(() {
      _actividades.add(nueva);
    });
  }

  void _editarActividad(Actividad actividad) {
    // Aquí podrías abrir el mismo formulario con datos precargados
  }

  void _cambiarEstado(Actividad actividad, bool nuevoEstado) {
    setState(() {
      actividad.completada = nuevoEstado;
    });
  }

  void _mostrarFormulario() {
    showDialog(
      context: context,
      builder: (context) => ActividadForm(onSave: _agregarActividad),
    );
  }

  void _abrirFormularioActividad(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) => ActividadForm(
        onSave: (actividad) {
          setState(() => _actividades.add(actividad));
          print('Actividad recibida: ${actividad.descripcion}');
          Navigator.pop(context);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Agenda Agrícola',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
            fontFamily: 'Franklin Gothic Demi Cond',
            color: Color(0xFF4BA43F),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _mostrarFormulario,
          ),
        ],
      ),
      body: Column(
        children: [
          CalendarWidget(
            selectedDate: _selectedDate,
            onDateSelected: (date) {
              setState(() => _selectedDate = date);
            },
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Actividades:',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.green[800],
                ),
              ),
            ),
          ),
          Expanded(
            child: actividadesDelDia.isEmpty
                ? const Center(child: Text('No hay actividades para este día'))
                : ListView.builder(
                    controller: _scrollController,
                    itemCount: actividadesDelDia.length,
                    itemBuilder: (context, index) {
                      final actividad = actividadesDelDia[index];
                      return ActividadTile(
                        actividad: actividad,
                        onEdit: () => _editarActividad(actividad),
                        onStatusChange: (nuevoEstado) =>
                            _cambiarEstado(actividad, nuevoEstado),
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: MenuAgenda(
        isVisible: true,
        onNuevaActividad: () => _abrirFormularioActividad(context),
      ),
    );
  }
}
