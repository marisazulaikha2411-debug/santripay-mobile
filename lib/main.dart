import 'package:flutter/material.dart';

void main() => runApp(const ArraudhohSantriPayApp());

const Color forest = Color(0xFF064E3B);
const Color green = Color(0xFF087A55);
const Color gold = Color(0xFFD6A72C);
const Color paper = Color(0xFFF7F8F3);
const Color ink = Color(0xFF18352B);

class ArraudhohSantriPayApp extends StatelessWidget {
  const ArraudhohSantriPayApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Arraudhoh SantriPay',
        theme: ThemeData(
          useMaterial3: true,
          scaffoldBackgroundColor: paper,
          colorScheme: ColorScheme.fromSeed(seedColor: forest, primary: forest),
          fontFamily: 'Roboto',
        ),
        home: const RoleSelectionPage(),
      );
}

enum UserRole { santri, waliSantri, admin }

extension UserRoleInfo on UserRole {
  String get label => switch (this) {
        UserRole.santri => 'Santri',
        UserRole.waliSantri => 'Wali Santri',
        UserRole.admin => 'Admin',
      };

  IconData get icon => switch (this) {
        UserRole.santri => Icons.school_rounded,
        UserRole.waliSantri => Icons.family_restroom_rounded,
        UserRole.admin => Icons.admin_panel_settings_rounded,
      };

  String get description => switch (this) {
        UserRole.santri => 'Akses saldo dan aktivitas kartu santri',
        UserRole.waliSantri => 'Pantau informasi dan kebutuhan putra-putri',
        UserRole.admin => 'Kelola data dan pantau aktivitas aplikasi',
      };
}

class RoleSelectionPage extends StatelessWidget {
  const RoleSelectionPage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        body: SafeArea(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(24, 38, 24, 28),
            children: [
              Center(
                child: Container(
                  width: 104,
                  height: 104,
                  padding: const EdgeInsets.all(9),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(28),
                    boxShadow: [
                      BoxShadow(
                        color: forest.withOpacity(.10),
                        blurRadius: 22,
                        offset: const Offset(0, 8),
                      )
                    ],
                  ),
                  child: Image.asset('assets/logo_arraudhoh.png'),
                ),
              ),
              const SizedBox(height: 22),
              const Text(
                'ARRAUDHOH SANTRIPAY',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: forest,
                  fontSize: 21,
                  fontWeight: FontWeight.w900,
                  letterSpacing: .8,
                ),
              ),
              const SizedBox(height: 7),
              const Text(
                'Silakan pilih jenis akun untuk melanjutkan',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black54, fontSize: 13),
              ),
              const SizedBox(height: 32),
              ...UserRole.values.map(
                (role) => Padding(
                  padding: const EdgeInsets.only(bottom: 13),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(20),
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => LoginPage(role: role),
                      ),
                    ),
                    child: Container(
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: const Color(0xFFE5EBDD)),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 52,
                            height: 52,
                            decoration: BoxDecoration(
                              color: const Color(0xFFE8F2E9),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Icon(role.icon, color: forest, size: 26),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  role.label,
                                  style: const TextStyle(
                                    color: forest,
                                    fontWeight: FontWeight.w900,
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  role.description,
                                  style: const TextStyle(
                                    color: Colors.black54,
                                    fontSize: 11,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Icon(
                            Icons.arrow_forward_ios_rounded,
                            color: gold,
                            size: 17,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 14),
              const Text(
                'Pondok Pesantren Arraudhoh · Bogor',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black45, fontSize: 11),
              ),
            ],
          ),
        ),
      );
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key, required this.role});
  final UserRole role;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final username = TextEditingController();
  final password = TextEditingController();
  bool obscure = true;

  @override
  void dispose() {
    username.dispose();
    password.dispose();
    super.dispose();
  }

  void signIn() {
    if (username.text.trim().isEmpty || password.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Isi nama pengguna dan kata sandi terlebih dahulu.'),
        ),
      );
      return;
    }

    // Prototipe: kredensial dan role belum diverifikasi oleh server.
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (_) => HomeShell(
          role: widget.role,
          username: username.text.trim(),
        ),
      ),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text('Masuk sebagai ${widget.role.label}'),
          backgroundColor: paper,
        ),
        body: SafeArea(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(24, 22, 24, 28),
            children: [
              Container(
                width: 76,
                height: 76,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(22),
                ),
                child: Image.asset('assets/logo_arraudhoh.png'),
              ),
              const SizedBox(height: 22),
              Text(
                'Selamat datang, ${widget.role.label}',
                style: const TextStyle(
                  color: forest,
                  fontSize: 23,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 7),
              const Text(
                'Masukkan data akun untuk melanjutkan.',
                style: TextStyle(color: Colors.black54, fontSize: 13),
              ),
              const SizedBox(height: 25),
              TextField(
                controller: username,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  labelText: 'Username / ID akun',
                  prefixIcon: Icon(Icons.person_outline),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 14),
              TextField(
                controller: password,
                obscureText: obscure,
                onSubmitted: (_) => signIn(),
                decoration: InputDecoration(
                  labelText: 'Kata sandi',
                  prefixIcon: const Icon(Icons.lock_outline),
                  filled: true,
                  fillColor: Colors.white,
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    onPressed: () => setState(() => obscure = !obscure),
                    icon: Icon(
                      obscure
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 22),
              SizedBox(
                height: 52,
                child: FilledButton(
                  onPressed: signIn,
                  style: FilledButton.styleFrom(
                    backgroundColor: forest,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text(
                    'Masuk',
                    style: TextStyle(fontWeight: FontWeight.w800),
                  ),
                ),
              ),
              const SizedBox(height: 14),
              Container(
                padding: const EdgeInsets.all(13),
                decoration: BoxDecoration(
                  color: const Color(0xFFE8F2E9),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Text(
                  'Catatan: ini masih prototipe. Username dan kata sandi belum diverifikasi dan belum terhubung ke database.',
                  style: TextStyle(color: forest, fontSize: 11, height: 1.5),
                ),
              ),
            ],
          ),
        ),
      );
}

class HomeShell extends StatefulWidget {
  const HomeShell({
    super.key,
    required this.role,
    required this.username,
  });

  final UserRole role;
  final String username;

  @override
  State<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell> {
  int selected = 0;

  final List<Map<String, dynamic>> transactions = [
    {
      'title': 'Top up saldo',
      'detail': 'Pengisian saldo · Contoh',
      'amount': '+ Rp50.000',
      'in': true,
      'icon': Icons.add_card_rounded,
    },
    {
      'title': 'Pembayaran kantin',
      'detail': 'Kantin pondok · Contoh',
      'amount': '- Rp12.000',
      'in': false,
      'icon': Icons.restaurant_rounded,
    },
    {
      'title': 'Pembelian perlengkapan',
      'detail': 'Koperasi · Contoh',
      'amount': '- Rp25.000',
      'in': false,
      'icon': Icons.shopping_bag_rounded,
    },
  ];

  List<NavigationDestination> get destinations {
    switch (widget.role) {
      case UserRole.santri:
        return const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home_rounded),
            label: 'Beranda',
          ),
          NavigationDestination(
            icon: Icon(Icons.receipt_long_outlined),
            selectedIcon: Icon(Icons.receipt_long_rounded),
            label: 'Transaksi',
          ),
          NavigationDestination(
            icon: Icon(Icons.qr_code_2_outlined),
            selectedIcon: Icon(Icons.qr_code_2_rounded),
            label: 'Kartu',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline_rounded),
            selectedIcon: Icon(Icons.person_rounded),
            label: 'Profil',
          ),
        ];
      case UserRole.waliSantri:
        return const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home_rounded),
            label: 'Beranda',
          ),
          NavigationDestination(
            icon: Icon(Icons.child_care_outlined),
            selectedIcon: Icon(Icons.child_care_rounded),
            label: 'Data Anak',
          ),
          NavigationDestination(
            icon: Icon(Icons.receipt_long_outlined),
            selectedIcon: Icon(Icons.receipt_long_rounded),
            label: 'Transaksi',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline_rounded),
            selectedIcon: Icon(Icons.person_rounded),
            label: 'Profil',
          ),
        ];
      case UserRole.admin:
        return const [
          NavigationDestination(
            icon: Icon(Icons.dashboard_outlined),
            selectedIcon: Icon(Icons.dashboard_rounded),
            label: 'Dashboard',
          ),
          NavigationDestination(
            icon: Icon(Icons.groups_outlined),
            selectedIcon: Icon(Icons.groups_rounded),
            label: 'Santri',
          ),
          NavigationDestination(
            icon: Icon(Icons.receipt_long_outlined),
            selectedIcon: Icon(Icons.receipt_long_rounded),
            label: 'Transaksi',
          ),
          NavigationDestination(
            icon: Icon(Icons.analytics_outlined),
            selectedIcon: Icon(Icons.analytics_rounded),
            label: 'Laporan',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline_rounded),
            selectedIcon: Icon(Icons.person_rounded),
            label: 'Profil',
          ),
        ];
    }
  }

  List<Widget> get pages {
    switch (widget.role) {
      case UserRole.santri:
        return [santriDashboard(), historyPage(), santriCardPage(), profilePage()];
      case UserRole.waliSantri:
        return [waliDashboard(), childPage(), historyPage(), profilePage()];
      case UserRole.admin:
        return [
          adminDashboard(),
          studentManagementPage(),
          historyPage(),
          reportsPage(),
          profilePage(),
        ];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: IndexedStack(index: selected, children: pages),
      ),
      bottomNavigationBar: NavigationBar(
        height: 70,
        backgroundColor: Colors.white,
        indicatorColor: const Color(0xFFE3F1E9),
        selectedIndex: selected,
        onDestinationSelected: (i) => setState(() => selected = i),
        destinations: destinations,
      ),
    );
  }

  Widget brandHeader() => Row(
        children: [
          Container(
            width: 54,
            height: 54,
            padding: const EdgeInsets.all(3),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(17),
              border: Border.all(color: const Color(0xFFE5EBDD)),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: Image.asset(
                'assets/logo_arraudhoh.png',
                fit: BoxFit.contain,
              ),
            ),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'ARRAUDHOH',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1.2,
                    color: forest,
                  ),
                ),
                Text(
                  'SANTRIPAY',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 2.4,
                    color: gold,
                  ),
                ),
                Text(
                  'Pondok Pesantren Ar-Raudhoh',
                  style: TextStyle(fontSize: 10, color: Colors.black54),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () => toast('Belum ada notifikasi baru.'),
            icon: const Icon(Icons.notifications_none_rounded, color: forest),
          ),
        ],
      );

  Widget pageHeading(String title, String subtitle) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 23,
              fontWeight: FontWeight.w900,
              color: forest,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            subtitle,
            style: const TextStyle(color: Colors.black54, fontSize: 12),
          ),
        ],
      );

  Widget whiteCard({required Widget child, EdgeInsets padding = const EdgeInsets.all(17)}) =>
      Container(
        padding: padding,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(19),
          border: Border.all(color: const Color(0xFFE8EBDD)),
        ),
        child: child,
      );

  Widget balanceCard({String label = 'SALDO SANTRI'}) => Container(
        padding: const EdgeInsets.all(21),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: forest,
          boxShadow: [
            BoxShadow(
              color: forest.withOpacity(.16),
              blurRadius: 18,
              offset: const Offset(0, 9),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(
                  Icons.account_balance_wallet_outlined,
                  color: Colors.white70,
                  size: 19,
                ),
                const SizedBox(width: 8),
                Text(
                  label,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 11,
                    letterSpacing: 1.3,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const Spacer(),
                const Icon(
                  Icons.verified_user_outlined,
                  color: gold,
                  size: 20,
                ),
              ],
            ),
            const SizedBox(height: 12),
            const Text(
              'Rp 75.000',
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(height: 5),
            const Text(
              'Contoh tampilan saldo · belum terhubung',
              style: TextStyle(color: Colors.white60, fontSize: 10),
            ),
            const SizedBox(height: 18),
            const Row(
              children: [
                Text(
                  'AR-••••-1025',
                  style: TextStyle(color: Colors.white70, fontSize: 11),
                ),
                Spacer(),
                Text(
                  'SANTRI',
                  style: TextStyle(
                    color: gold,
                    fontSize: 10,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
          ],
        ),
      );

  Widget santriDashboard() => ListView(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
        children: [
          brandHeader(),
          const SizedBox(height: 25),
          const Text(
            'Assalamu’alaikum 👋',
            style: TextStyle(
              fontSize: 23,
              fontWeight: FontWeight.w800,
              color: ink,
            ),
          ),
          Text(
            'Selamat datang, ${widget.username}',
            style: const TextStyle(color: Colors.black54, fontSize: 13),
          ),
          const SizedBox(height: 20),
          balanceCard(),
          const SizedBox(height: 22),
          const Text(
            'Akses cepat',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w800,
              color: ink,
            ),
          ),
          const SizedBox(height: 13),
          Row(
            children: [
              quickAction(Icons.qr_code_2_rounded, 'Kartu QR',
                  () => setState(() => selected = 2)),
              quickAction(Icons.receipt_long_rounded, 'Transaksi',
                  () => setState(() => selected = 1)),
              quickAction(Icons.person_rounded, 'Profil',
                  () => setState(() => selected = 3)),
            ],
          ),
          const SizedBox(height: 23),
          whiteCard(
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Informasi Santri',
                  style: TextStyle(
                    color: forest,
                    fontWeight: FontWeight.w900,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 12),
                InfoLine(label: 'Nama', value: 'Nama santri contoh'),
                InfoLine(label: 'NIS', value: 'AR-1025'),
                InfoLine(label: 'Status', value: 'Aktif'),
              ],
            ),
          ),
          const SizedBox(height: 18),
          const Text(
            'Transaksi terbaru',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w800,
              color: ink,
            ),
          ),
          const SizedBox(height: 10),
          ...transactions.take(2).map(transactionTile),
        ],
      );

  Widget waliDashboard() => ListView(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
        children: [
          brandHeader(),
          const SizedBox(height: 25),
          const Text(
            'Assalamu’alaikum 👋',
            style: TextStyle(
              fontSize: 23,
              fontWeight: FontWeight.w800,
              color: ink,
            ),
          ),
          Text(
            'Selamat datang, ${widget.username}',
            style: const TextStyle(color: Colors.black54, fontSize: 13),
          ),
          const SizedBox(height: 20),
          whiteCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Putra / Putri Anda',
                  style: TextStyle(
                    color: forest,
                    fontWeight: FontWeight.w900,
                    fontSize: 17,
                  ),
                ),
                const SizedBox(height: 14),
                const CircleAvatar(
                  radius: 29,
                  backgroundColor: Color(0xFFE8F2E9),
                  child: Icon(Icons.school_rounded, color: forest, size: 30),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Nama santri contoh',
                  style: TextStyle(
                    color: ink,
                    fontWeight: FontWeight.w900,
                    fontSize: 16,
                  ),
                ),
                const Text(
                  'NIS: AR-1025 · Status: Aktif',
                  style: TextStyle(color: Colors.black54, fontSize: 11),
                ),
                const SizedBox(height: 15),
                const Divider(),
                const InfoLine(label: 'Saldo saat ini', value: 'Rp 75.000'),
                const InfoLine(label: 'Transaksi terbaru', value: 'Kantin · Rp12.000'),
              ],
            ),
          ),
          const SizedBox(height: 18),
          const Text(
            'Pemantauan',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w800,
              color: ink,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              quickAction(Icons.child_care_rounded, 'Data Anak',
                  () => setState(() => selected = 1)),
              quickAction(Icons.receipt_long_rounded, 'Transaksi',
                  () => setState(() => selected = 2)),
              quickAction(Icons.person_rounded, 'Profil',
                  () => setState(() => selected = 3)),
            ],
          ),
          const SizedBox(height: 18),
          const Text(
            'Catatan: data anak dan saldo masih contoh tampilan.',
            style: TextStyle(color: Colors.black54, fontSize: 11),
          ),
        ],
      );

  Widget adminDashboard() => ListView(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
        children: [
          brandHeader(),
          const SizedBox(height: 25),
          const Text(
            'Dashboard Admin',
            style: TextStyle(
              fontSize: 23,
              fontWeight: FontWeight.w900,
              color: ink,
            ),
          ),
          Text(
            'Selamat bertugas, ${widget.username}',
            style: const TextStyle(color: Colors.black54, fontSize: 13),
          ),
          const SizedBox(height: 20),
          const Row(
            children: [
              Expanded(
                child: AdminMetric(
                  title: 'Total Santri',
                  value: '120',
                  icon: Icons.groups_rounded,
                ),
              ),
              SizedBox(width: 11),
              Expanded(
                child: AdminMetric(
                  title: 'Transaksi',
                  value: '38',
                  icon: Icons.receipt_long_rounded,
                ),
              ),
            ],
          ),
          const SizedBox(height: 11),
          const Row(
            children: [
              Expanded(
                child: AdminMetric(
                  title: 'Pemasukan',
                  value: 'Rp50 rb',
                  icon: Icons.trending_up_rounded,
                ),
              ),
              SizedBox(width: 11),
              Expanded(
                child: AdminMetric(
                  title: 'Pengeluaran',
                  value: 'Rp37 rb',
                  icon: Icons.trending_down_rounded,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          const Text(
            'Menu pengelolaan',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w800,
              color: ink,
            ),
          ),
          const SizedBox(height: 12),
          adminMenu(
            Icons.groups_rounded,
            'Kelola Data Santri',
            'Lihat daftar santri',
            () => setState(() => selected = 1),
          ),
          adminMenu(
            Icons.receipt_long_rounded,
            'Pantau Transaksi',
            'Lihat aktivitas transaksi',
            () => setState(() => selected = 2),
          ),
          adminMenu(
            Icons.analytics_rounded,
            'Laporan Keuangan',
            'Ringkasan pemasukan dan pengeluaran',
            () => setState(() => selected = 3),
          ),
          const SizedBox(height: 12),
          const Text(
            'Angka pada dashboard ini masih data contoh.',
            style: TextStyle(color: Colors.black54, fontSize: 11),
          ),
        ],
      );

  Widget quickAction(IconData icon, String label, VoidCallback onTap) =>
      Expanded(
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(18),
          child: Column(
            children: [
              Container(
                width: 55,
                height: 55,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: const Color(0xFFE5EBDD)),
                ),
                child: Icon(icon, color: green, size: 25),
              ),
              const SizedBox(height: 8),
              Text(
                label,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 11,
                  color: ink,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      );

  Widget adminMenu(
    IconData icon,
    String title,
    String subtitle,
    VoidCallback onTap,
  ) =>
      Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: whiteCard(
            child: Row(
              children: [
                Container(
                  width: 43,
                  height: 43,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE8F2E9),
                    borderRadius: BorderRadius.circular(13),
                  ),
                  child: Icon(icon, color: forest),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          color: forest,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        subtitle,
                        style: const TextStyle(
                          color: Colors.black54,
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ),
                const Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: gold,
                  size: 16,
                ),
              ],
            ),
          ),
        ),
      );

  Widget childPage() => ListView(
        padding: const EdgeInsets.all(20),
        children: [
          pageHeading('Data Anak', 'Informasi santri yang terhubung dengan akun wali.'),
          const SizedBox(height: 18),
          whiteCard(
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Nama santri contoh',
                  style: TextStyle(
                    color: forest,
                    fontWeight: FontWeight.w900,
                    fontSize: 17,
                  ),
                ),
                SizedBox(height: 12),
                InfoLine(label: 'NIS', value: 'AR-1025'),
                InfoLine(label: 'Kelas / Marhalah', value: 'Belum diisi'),
                InfoLine(label: 'Status', value: 'Aktif'),
                InfoLine(label: 'Saldo contoh', value: 'Rp 75.000'),
              ],
            ),
          ),
          const SizedBox(height: 14),
          const Text(
            'Data ini belum terhubung ke akun santri sebenarnya.',
            style: TextStyle(color: Colors.black54, fontSize: 11),
          ),
        ],
      );

  Widget studentManagementPage() => ListView(
        padding: const EdgeInsets.all(20),
        children: [
          pageHeading('Kelola Santri', 'Daftar santri pada sistem contoh.'),
          const SizedBox(height: 16),
          SizedBox(
            height: 48,
            child: FilledButton.icon(
              onPressed: () => toast('Form tambah santri belum dihubungkan.'),
              icon: const Icon(Icons.person_add_alt_1_rounded),
              label: const Text('Tambah Data Santri'),
              style: FilledButton.styleFrom(backgroundColor: forest),
            ),
          ),
          const SizedBox(height: 15),
          studentTile('Ahmad Fulan', 'AR-1025', 'Aktif'),
          studentTile('Muhammad Fulan', 'AR-1026', 'Aktif'),
          studentTile('Abdullah Fulan', 'AR-1027', 'Aktif'),
          const SizedBox(height: 10),
          const Text(
            'Daftar ini masih data contoh. Pengelolaan data sebenarnya memerlukan database.',
            style: TextStyle(color: Colors.black54, fontSize: 11),
          ),
        ],
      );

  Widget studentTile(String name, String nis, String status) => Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: whiteCard(
          child: Row(
            children: [
              const CircleAvatar(
                backgroundColor: Color(0xFFE8F2E9),
                child: Icon(Icons.school_rounded, color: forest),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        color: forest,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    Text(
                      nis,
                      style: const TextStyle(
                        color: Colors.black54,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                status,
                style: const TextStyle(
                  color: green,
                  fontWeight: FontWeight.w800,
                  fontSize: 11,
                ),
              ),
            ],
          ),
        ),
      );

  Widget historyPage() => ListView(
        padding: const EdgeInsets.all(20),
        children: [
          pageHeading(
            'Riwayat Transaksi',
            widget.role == UserRole.admin
                ? 'Pantau transaksi pada aplikasi.'
                : 'Pantau aktivitas saldo.',
          ),
          const SizedBox(height: 15),
          whiteCard(
            child: const Row(
              children: [
                Icon(Icons.info_outline, color: forest),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'Riwayat di bawah merupakan data contoh untuk pratinjau desain.',
                    style: TextStyle(fontSize: 11, color: forest),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          ...transactions.map(transactionTile),
        ],
      );

  Widget reportsPage() => ListView(
        padding: const EdgeInsets.all(20),
        children: [
          pageHeading('Laporan Keuangan', 'Ringkasan aktivitas transaksi aplikasi.'),
          const SizedBox(height: 16),
          reportCard('Total pemasukan', 'Rp 50.000', Icons.trending_up_rounded, green),
          reportCard('Total pengeluaran', 'Rp 37.000', Icons.trending_down_rounded, const Color(0xFFC65B4B)),
          reportCard('Saldo contoh', 'Rp 75.000', Icons.account_balance_wallet_rounded, gold),
          const SizedBox(height: 8),
          const Text(
            'Angka ini hanya contoh visual, bukan laporan keuangan aktual.',
            style: TextStyle(color: Colors.black54, fontSize: 11),
          ),
        ],
      );

  Widget reportCard(String title, String value, IconData icon, Color color) =>
      Padding(
        padding: const EdgeInsets.only(bottom: 11),
        child: whiteCard(
          child: Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: color.withOpacity(.12),
                  borderRadius: BorderRadius.circular(13),
                ),
                child: Icon(icon, color: color),
              ),
              const SizedBox(width: 13),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(color: Colors.black54, fontSize: 12),
                ),
              ),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w900,
                  color: forest,
                ),
              ),
            ],
          ),
        ),
      );

  Widget santriCardPage() => ListView(
        padding: const EdgeInsets.all(20),
        children: [
          pageHeading('Kartu Santri', 'Identitas kartu Arraudhoh SantriPay.'),
          const SizedBox(height: 18),
          Container(
            padding: const EdgeInsets.all(22),
            decoration: BoxDecoration(
              color: forest,
              borderRadius: BorderRadius.circular(24),
              gradient: const LinearGradient(
                colors: [forest, Color(0xFF147451)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Image.asset('assets/logo_arraudhoh.png', height: 75),
                ),
                const SizedBox(height: 16),
                const Center(
                  child: Text(
                    'KARTU SANTRI',
                    style: TextStyle(
                      color: gold,
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 1.5,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'NAMA SANTRI',
                  style: TextStyle(color: Colors.white70, fontSize: 10),
                ),
                const Text(
                  'Nama santri contoh',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  'NIS: AR-1025',
                  style: TextStyle(color: Colors.white70),
                ),
                const SizedBox(height: 15),
                const Center(
                  child: Icon(
                    Icons.qr_code_2_rounded,
                    color: Colors.white,
                    size: 90,
                  ),
                ),
                const Center(
                  child: Text(
                    'QR ilustrasi · belum dapat digunakan untuk pembayaran',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white70, fontSize: 9),
                  ),
                ),
              ],
            ),
          ),
        ],
      );

  Widget profilePage() => ListView(
        padding: const EdgeInsets.all(20),
        children: [
          pageHeading('Profil Akun', 'Informasi akun yang sedang digunakan.'),
          const SizedBox(height: 18),
          whiteCard(
            child: Column(
              children: [
                CircleAvatar(
                  radius: 35,
                  backgroundColor: const Color(0xFFE8F2E9),
                  child: Icon(widget.role.icon, color: forest, size: 34),
                ),
                const SizedBox(height: 12),
                Text(
                  widget.username,
                  style: const TextStyle(
                    color: forest,
                    fontWeight: FontWeight.w900,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  widget.role.label,
                  style: const TextStyle(color: Colors.black54),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          whiteCard(
            child: const Column(
              children: [
                InfoLine(label: 'Aplikasi', value: 'Arraudhoh SantriPay'),
                InfoLine(label: 'Versi', value: '1.2.0 · Role Preview'),
                InfoLine(label: 'Autentikasi', value: 'Belum terhubung database'),
              ],
            ),
          ),
          const SizedBox(height: 18),
          SizedBox(
            height: 50,
            child: OutlinedButton.icon(
              onPressed: () => Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const RoleSelectionPage()),
                (route) => false,
              ),
              icon: const Icon(Icons.logout_rounded),
              label: const Text('Keluar dari akun'),
              style: OutlinedButton.styleFrom(
                foregroundColor: forest,
                side: const BorderSide(color: forest),
              ),
            ),
          ),
        ],
      );

  Widget transactionTile(Map<String, dynamic> item) {
    final bool incoming = item['in'] as bool;
    return Padding(
      padding: const EdgeInsets.only(bottom: 9),
      child: whiteCard(
        padding: const EdgeInsets.all(13),
        child: Row(
          children: [
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: incoming
                    ? const Color(0xFFE7F4E9)
                    : const Color(0xFFFFF0E8),
                borderRadius: BorderRadius.circular(13),
              ),
              child: Icon(
                item['icon'] as IconData,
                color: incoming ? green : const Color(0xFFCB713A),
                size: 21,
              ),
            ),
            const SizedBox(width: 11),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item['title'] as String,
                    style: const TextStyle(
                      fontWeight: FontWeight.w800,
                      color: ink,
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    item['detail'] as String,
                    style: const TextStyle(color: Colors.black45, fontSize: 10),
                  ),
                ],
              ),
            ),
            Text(
              item['amount'] as String,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w900,
                color: incoming ? green : const Color(0xFFC65B4B),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void toast(String message) => ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          behavior: SnackBarBehavior.floating,
        ),
      );
}

class InfoLine extends StatelessWidget {
  const InfoLine({super.key, required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Row(
          children: [
            Expanded(
              child: Text(
                label,
                style: const TextStyle(color: Colors.black54, fontSize: 12),
              ),
            ),
            Text(
              value,
              textAlign: TextAlign.end,
              style: const TextStyle(
                color: ink,
                fontWeight: FontWeight.w800,
                fontSize: 12,
              ),
            ),
          ],
        ),
      );
}

class AdminMetric extends StatelessWidget {
  const AdminMetric({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
  });

  final String title;
  final String value;
  final IconData icon;

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: const Color(0xFFE8EBDD)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: green, size: 22),
            const SizedBox(height: 12),
            Text(
              value,
              style: const TextStyle(
                color: forest,
                fontSize: 20,
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(height: 3),
            Text(
              title,
              style: const TextStyle(color: Colors.black54, fontSize: 10),
            ),
          ],
        ),
      );
}
