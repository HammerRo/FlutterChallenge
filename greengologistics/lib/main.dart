import 'package:flutter/material.dart';

void main() {
  runApp(const GreenGoApp());
}

class GreenGoApp extends StatelessWidget {
  const GreenGoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green.shade700),
        useMaterial3: true,
      ),
      // start at LoginScreen so the user can pick role (repartidor/supervisor)
      home: LoginScreen(),
    );
  }
}

enum UserRole { deliverer, supervisor }

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);


  String get defaultDeliverer => deliveries.value.isNotEmpty ? deliveries.value.first.deliverer : 'Alice';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (kCanvaGifUrl.isNotEmpty)
              SizedBox(
                width: 220,
                height: 140,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    kCanvaGifUrl,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Center(
                        child: SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(strokeWidth: 2, value: loadingProgress.expectedTotalBytes != null ? loadingProgress.cumulativeBytesLoaded / (loadingProgress.expectedTotalBytes ?? 1) : null),
                        ),
                      );
                    },
                    errorBuilder: (context, error, stackTrace) => Container(
                      color: Colors.grey.shade200,
                      child: const Center(child: Icon(Icons.image_not_supported, size: 48, color: Colors.grey)),
                    ),
                  ),
                ),
              ),

            const SizedBox(height: 12),

            
            const SizedBox(height: 24),
            SizedBox(
              width: 220,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (_) => HomeScreen(role: UserRole.deliverer, delivererName: defaultDeliverer),
                  ));
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  child: Text('Repartidor', style: TextStyle(fontSize: 16)),
                ),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: 220,
              child: OutlinedButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (_) => const HomeScreen(role: UserRole.supervisor),
                  ));
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  child: Text('Supervisor', style: TextStyle(fontSize: 16)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


const String kCanvaGifUrl = 'https://media0.giphy.com/media/v1.Y2lkPTc5MGI3NjExaXc5Y2o2bGd3MjBuaHRsaXgzbXgzbTA3YmFhdWtuanBwM3ZhaGUwOSZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/F6WNdTpsCeJJkrc1cs/giphy.gif';
const String AliceGif = 'https://media0.giphy.com/media/v1.Y2lkPTc5MGI3NjExb2k0b3VsMHloazlscnp3NmsyejhjcmUwNm1qNjVzN293emFsanBzbSZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/zR2CHWuaeAITD9pdTC/giphy.gif';
const String BobGif = 'https://media1.giphy.com/media/v1.Y2lkPTc5MGI3NjExOGFnZzUwdjZndmNmZHI2c3l2MGgweTM5NXM0djluMTk4Ymd3M2U4NSZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/oZh8qZnmPuh7MQVOnt/giphy.gif';
const String CharlieGif = 'https://media4.giphy.com/media/v1.Y2lkPTc5MGI3NjExdmFhcGNieHJuODZ5anVycTQwMjI3N2VpZjlrNnBtMmQ3MmwyY3VqayZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/uQunwdZyZmQWPZyU8i/giphy.gif';
const String DiegoGif = 'https://media1.giphy.com/media/v1.Y2lkPTc5MGI3NjExOGo2NjJueDkzMmNuODFnM2NzbndsYjd1cWw3dG8zYXcyYXM4MmttZSZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/BjLDWsRSTyb28z1pq2/giphy.gif';
const String ElenaGif = 'https://media3.giphy.com/media/v1.Y2lkPTc5MGI3NjExbG15eXlscDQ4NTNqdG92cTZ2MzVhNmF6OHMxcjFwYWRjOG5xczY5NCZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/6veqZfEYSdfWx2U0G0/giphy.gif';


final Map<String, String> delivererGifs = {
  'Alice': AliceGif,
  'Bob': BobGif,
  'Charlie': CharlieGif,
  'Diego': DiegoGif,
  'Elena': ElenaGif,
};

String gifForDeliverer(String name) => delivererGifs[name] ?? '';

class Delivery {
  Delivery({
    required this.id,
    required this.title,
    required this.address,
    required this.deliverer,
    this.delivered = false,
  });

  final String id;
  final String title;
  final String address;
  final String deliverer;
  bool delivered;
}


final ValueNotifier<List<Delivery>> deliveries = ValueNotifier<List<Delivery>>([
  Delivery(id: '1', title: 'Pedido #1', address: 'Calle 12, 45', deliverer: 'Alice'),
  Delivery(id: '2', title: 'Pedido #2', address: 'Avenida 3, 200', deliverer: 'Bob'),
  Delivery(id: '3', title: 'Pedido #3', address: 'Plaza Central', deliverer: 'Alice'),
  Delivery(id: '4', title: 'Pedido #4', address: 'Parque Norte', deliverer: 'Charlie'),
  Delivery(id: '5', title: 'Pedido #5', address: 'Calle Luna 10', deliverer: 'Diego'),
  Delivery(id: '6', title: 'Pedido #6', address: 'Avenida Sol 8', deliverer: 'Elena'),
  Delivery(id: '7', title: 'Pedido #7', address: 'Barrio Alto', deliverer: 'Bob'),
  Delivery(id: '8', title: 'Pedido #8', address: 'Paseo Verde', deliverer: 'Diego'),
  Delivery(id: '9', title: 'Pedido #9', address: 'Mercado Central', deliverer: 'Elena'),
]);

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key, required this.role, this.delivererName}) : super(key: key);

  final UserRole role;
  final String? delivererName;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late String selectedDeliverer;

  List<String> get deliverers {
    final set = <String>{};
    for (var d in deliveries.value) {
      set.add(d.deliverer);
    }
    return set.toList()..sort();
  }

  void setDelivered(String id, bool value) {
    final list = deliveries.value;
    final index = list.indexWhere((e) => e.id == id);
    if (index == -1) return;
    list[index].delivered = value;
    deliveries.value = List<Delivery>.from(list);
  }

  @override
  void initState() {
    super.initState();
    if (widget.delivererName != null) {
      selectedDeliverer = widget.delivererName!;
    } else {
      final names = deliverers;
      selectedDeliverer = names.isNotEmpty ? names.first : 'Unknown';
    }
  }

  Widget buildDelivererView() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text('Repartidor:', style: TextStyle(fontWeight: FontWeight.w600)),
              const SizedBox(width: 12),


              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey.shade100,
                ),
                child: ClipOval(
                  child: Builder(builder: (context) {
                    final url = gifForDeliverer(selectedDeliverer);
                    if (url.isEmpty) {
                      return const Center(child: Icon(Icons.person, color: Colors.grey));
                    }
                    return Image.network(
                      url,
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Center(
                          child: SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded / (loadingProgress.expectedTotalBytes ?? 1)
                                  : null,
                            ),
                          ),
                        );
                      },
                      errorBuilder: (context, error, stack) => const Center(child: Icon(Icons.broken_image, color: Colors.grey)),
                    );
                  }),
                ),
              ),

              const SizedBox(width: 12),

              ValueListenableBuilder<List<Delivery>>(
                valueListenable: deliveries,
                builder: (context, value, _) {
                  final names = deliverers;
                  if (!names.contains(selectedDeliverer) && names.isNotEmpty) selectedDeliverer = names.first;
                  return DropdownButton<String>(
                    value: selectedDeliverer,
                    items: names.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                    onChanged: (v) => setState(() => selectedDeliverer = v ?? selectedDeliverer),
                  );
                },
              ),
              const Spacer(),
              ElevatedButton.icon(
                onPressed: () {
                  final list = deliveries.value;
                  for (var d in list) {
                    if (d.deliverer == selectedDeliverer) d.delivered = true;
                  }
                  deliveries.value = List<Delivery>.from(list);
                },
                icon: const Icon(Icons.check_circle_outline),
                label: const Text('Marcar todo'),
              )
            ],
          ),
          const SizedBox(height: 12),
          Expanded(
            child: ValueListenableBuilder<List<Delivery>>(
              valueListenable: deliveries,
              builder: (context, list, _) {
                final pending = list.where((d) => d.deliverer == selectedDeliverer && !d.delivered).toList();
                final done = list.where((d) => d.deliverer == selectedDeliverer && d.delivered).toList();
                return Column(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Pendientes (${pending.length})', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                          const SizedBox(height: 8),
                          Expanded(
                            child: pending.isEmpty
                                ? const Center(child: Text('No hay pendientes'))
                                : ListView.builder(
                                    itemCount: pending.length,
                                    itemBuilder: (context, index) {
                                      final d = pending[index];
                                      return Card(
                                        child: ListTile(
                                          onTap: () {
                                            // mark delivered
                                            setDelivered(d.id, true);
                                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('${d.title} marcado como entregado'), backgroundColor: Colors.green.shade700, duration: const Duration(milliseconds: 700)));
                                          },
                                          leading: const Icon(Icons.pedal_bike),
                                          title: Text(d.title),
                                          subtitle: Text(d.address),
                                          trailing: const Text('Marcar'),
                                        ),
                                      );
                                    },
                                  ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 12),

                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Entregados (${done.length})', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                          const SizedBox(height: 8),
                          Expanded(
                            child: done.isEmpty
                                ? const Center(child: Text('No hay entregados'))
                                : ListView.builder(
                                    itemCount: done.length,
                                    itemBuilder: (context, index) {
                                      final d = done[index];
                                      return Card(
                                        color: Colors.green.shade50,
                                        child: ListTile(
                                          onTap: () {
                                            // move back to pending
                                            setDelivered(d.id, false);
                                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Pedido vuelto a pendientes'), duration: Duration(milliseconds: 700)));
                                          },
                                          leading: const Icon(Icons.check_circle, color: Colors.green),
                                          title: Text(d.title, style: const TextStyle(decoration: TextDecoration.lineThrough)),
                                          subtitle: Text(d.address),
                                          trailing: const Text('Deshacer', style: TextStyle(color: Colors.green)),
                                        ),
                                      );
                                    },
                                  ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSupervisorView() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Progreso global', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
          ValueListenableBuilder<List<Delivery>>(
            valueListenable: deliveries,
            builder: (context, list, _) {
              final total = list.length;
              final done = list.where((d) => d.delivered).length;
              final percent = total == 0 ? 0.0 : done / total;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  LinearProgressIndicator(value: percent, minHeight: 12),
                  const SizedBox(height: 8),
                  Text('${(percent * 100).toStringAsFixed(0)}% completado ($done/$total)'),
                ],
              );
            },
          ),
          const SizedBox(height: 16),
          const Text('Todas las entregas', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
          Expanded(
            child: ValueListenableBuilder<List<Delivery>>(
              valueListenable: deliveries,
              builder: (context, list, _) {
                if (list.isEmpty) return const Center(child: Text('Sin entregas'));
                return ListView.builder(
                  itemCount: list.length,
                  itemBuilder: (context, index) {
                    final d = list[index];
                    return Card(
                      child: ListTile(
                        title: Text(d.title),
                        subtitle: Text('${d.address} — ${d.deliverer}'),
                        trailing: IconButton(
                          icon: Icon(
                            d.delivered ? Icons.check_circle : Icons.radio_button_unchecked,
                            color: d.delivered ? Colors.green : Colors.grey,
                          ),
                          onPressed: () => setDelivered(d.id, !d.delivered),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDeliverer = widget.role == UserRole.deliverer;
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
        actions: [
          IconButton(
            tooltip: 'Cerrar sesión',
            onPressed: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => LoginScreen()));
            },
            icon: const Icon(Icons.logout),
          )
        ],
      ),
      body: isDeliverer ? buildDelivererView() : buildSupervisorView(),
    );
  }
}
