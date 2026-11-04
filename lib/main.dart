
import 'package:flutter/material.dart';

void main() {
  runApp(const SantriPayApp());
}

const Color hijau = Color(0xFF14532D);
const Color latar = Color(0xFFF5F8F5);

class SantriPayApp extends StatelessWidget {
  const SantriPayApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SantriPay',
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: latar,
        colorScheme: ColorScheme.fromSeed(
          seedColor: hijau,
          primary: hijau,
        ),
        fontFamily: 'Roboto',
      ),
      home: const DashboardPage(),
    );
  }
}

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int selectedIndex = 0;

  final List<Map<String, dynamic>> transaksi = [
    {
      'judul': 'Pembayaran SPP',
      'keterangan': 'Contoh transaksi',
      'jumlah': 0,
      'masuk': true,
      'ikon': Icons.school_rounded,
    },
    {
      'judul': 'Belanja kebutuhan',
      'keterangan': 'Contoh transaksi',
      'jumlah': 0,
      'masuk': false,
      'ikon': Icons.shopping_bag_rounded,
    },
    {
      'judul': 'Donasi pondok',
      'keterangan': 'Contoh transaksi',
      'jumlah': 0,
      'masuk': true,
      'ikon': Icons.volunteer_activism_rounded,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: IndexedStack(
          index: selectedIndex,
          children: [
            buildDashboard(),
            buildRiwayat(),
            buildLaporan(),
            buildProfil(),
          ],
        ),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedIndex,
        onDestinationSelected: (index) {
          setState(() => selectedIndex = index);
        },
        backgroundColor: Colors.white,
        indicatorColor: const Color(0xFFDCEBDD),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.dashboard_outlined),
            selectedIcon: Icon(Icons.dashboard_rounded),
            label: 'Beranda',
          ),
          NavigationDestination(
            icon: Icon(Icons.receipt_long_outlined),
            selectedIcon: Icon(Icons.receipt_long_rounded),
            label: 'Transaksi',
          ),
          NavigationDestination(
            icon: Icon(Icons.bar_chart_rounded),
            label: 'Laporan',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline_rounded),
            selectedIcon: Icon(Icons.person_rounded),
            label: 'Profil',
          ),
        ],
      ),
    );
  }

  Widget buildDashboard() {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        Row(
          children: [
            Container(
              height: 48,
              width: 48,
              decoration: BoxDecoration(
                color: hijau,
                borderRadius: BorderRadius.circular(15),
              ),
              child: const Icon(
                Icons.account_balance_wallet_rounded,
                color: Colors.white,
                size: 27,
              ),
            ),
            const SizedBox(width: 12),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'SantriPay',
                    style: TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                      color: hijau,
                    ),
                  ),
                  Text(
                    'Arraudhoh · Laporan Keuangan',
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Belum ada notifikasi baru.'),
                  ),
                );
              },
              icon: const Icon(Icons.notifications_none_rounded),
            ),
          ],
        ),
        const SizedBox(height: 28),
        const Text(
          'Assalamu’alaikum!',
          style: TextStyle(
            fontSize: 23,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 5),
        const Text(
          'Pantau keuangan pondok dengan mudah.',
          style: TextStyle(color: Colors.black54),
        ),
        const SizedBox(height: 22),
        Container(
          padding: const EdgeInsets.all(22),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF14532D), Color(0xFF267348)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(24),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                children: [
                  Icon(
                    Icons.account_balance_wallet_outlined,
                    color: Colors.white70,
                  ),
                  SizedBox(width: 8),
                  Text(
                    'Saldo keseluruhan',
                    style: TextStyle(color: Colors.white70),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              const Text(
                'Rp0',
                style: TextStyle(
                  fontSize: 34,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  'Data awal · belum terhubung',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 22),
        const Text(
          'Ringkasan Keuangan',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 14),
        Row(
          children: [
            Expanded(
              child: summaryCard(
                'Pemasukan',
                'Rp0',
                Icons.trending_up_rounded,
                const Color(0xFF16834A),
                const Color(0xFFE4F5E9),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: summaryCard(
                'Pengeluaran',
                'Rp0',
                Icons.trending_down_rounded,
                const Color(0xFFD34B43),
                const Color(0xFFFFEAE8),
              ),
            ),
          ],
        ),
        const SizedBox(height: 26),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Transaksi Terbaru',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextButton(
              onPressed: () {
                setState(() => selectedIndex = 1);
              },
              child: const Text('Lihat semua'),
            ),
          ],
        ),
        const SizedBox(height: 8),
        ...transaksi.take(3).map(buildTransactionTile),
        const SizedBox(height: 16),
        const Text(
          'Informasi: nominal di atas masih berupa data awal. '
          'Hubungkan aplikasi ke backend sebelum digunakan '
          'untuk pencatatan keuangan sebenarnya.',
          style: TextStyle(
            fontSize: 12,
            color: Colors.black54,
          ),
        ),
      ],
    );
  }

  Widget summaryCard(
    String title,
    String amount,
    IconData icon,
    Color color,
    Color background,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(9),
            decoration: BoxDecoration(
              color: background,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 23),
          ),
          const SizedBox(height: 16),
          Text(
            title,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.black54,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            amount,
            style: const TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildTransactionTile(Map<String, dynamic> item) {
    final bool masuk = item['masuk'] as bool;

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(17),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: masuk
                  ? const Color(0xFFE4F5E9)
                  : const Color(0xFFFFEAE8),
              borderRadius: BorderRadius.circular(13),
            ),
            child: Icon(
              item['ikon'] as IconData,
              color: masuk
                  ? const Color(0xFF16834A)
                  : const Color(0xFFD34B43),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item['judul'] as String,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  item['keterangan'] as String,
                  style: const TextStyle(
                    color: Colors.black54,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Text(
            '${masuk ? '+' : '-'}Rp0',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: masuk
                  ? const Color(0xFF16834A)
                  : const Color(0xFFD34B43),
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildRiwayat() {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const Text(
          'Riwayat Transaksi',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        const Text(
          'Daftar contoh transaksi keuangan pondok.',
          style: TextStyle(color: Colors.black54),
        ),
        const SizedBox(height: 20),
        ...transaksi.map(buildTransactionTile),
        const SizedBox(height: 12),
        const Text(
          'Data di halaman ini masih contoh, bukan catatan keuangan asli.',
          style: TextStyle(color: Colors.black54, fontSize: 12),
        ),
      ],
    );
  }

  Widget buildLaporan() {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const Text(
          'Laporan Keuangan',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        const Text(
          'Ringkasan keuangan pondok.',
          style: TextStyle(color: Colors.black54),
        ),
        const SizedBox(height: 24),
        reportCard('Total Pemasukan', 'Rp0', Icons.south_west_rounded),
        reportCard('Total Pengeluaran', 'Rp0', Icons.north_east_rounded),
        reportCard('Saldo Akhir', 'Rp0', Icons.account_balance_wallet_rounded),
        const SizedBox(height: 12),
        const Text(
          'Laporan belum memakai data transaksi asli.',
          style: TextStyle(color: Colors.black54, fontSize: 12),
        ),
      ],
    );
  }

  Widget reportCard(String title, String value, IconData icon) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          Icon(icon, color: hijau, size: 28),
          const SizedBox(width: 14),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(color: Colors.black54),
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 17,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildProfil() {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const Text(
          'Profil Aplikasi',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 22),
        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(22),
          ),
          child: const Column(
            children: [
              CircleAvatar(
                radius: 36,
                backgroundColor: hijau,
                child: Icon(
                  Icons.account_balance_rounded,
                  color: Colors.white,
                  size: 36,
                ),
              ),
              SizedBox(height: 16),
              Text(
                'SantriPay',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: hijau,
                ),
              ),
              SizedBox(height: 6),
              Text(
                'Laporan Keuangan Pondok Pesantren Arraudhoh',
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 12),
              Text(
                'Versi awal aplikasi mobile',
                style: TextStyle(color: Colors.black54, fontSize: 12),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
