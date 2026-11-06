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
  Widget build(BuildContext context) {
    return MaterialApp(
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
    body: SafeArea(child: ListView(padding: const EdgeInsets.fromLTRB(24, 38, 24, 28), children: [
      Center(child: Container(width: 104, height: 104, padding: const EdgeInsets.all(9), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(28), boxShadow: [BoxShadow(color: forest.withOpacity(.10), blurRadius: 22, offset: const Offset(0, 8))]), child: Image.asset('assets/logo_arraudhoh.png'))),
      const SizedBox(height: 22),
      const Text('ARRAUDHOH SANTRIPAY', textAlign: TextAlign.center, style: TextStyle(color: forest, fontSize: 21, fontWeight: FontWeight.w900, letterSpacing: .8)),
      const SizedBox(height: 7),
      const Text('Silakan pilih jenis akun untuk melanjutkan', textAlign: TextAlign.center, style: TextStyle(color: Colors.black54, fontSize: 13)),
      const SizedBox(height: 32),
      ...UserRole.values.map((role) => Padding(padding: const EdgeInsets.only(bottom: 13), child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => LoginPage(role: role))),
        child: Container(padding: const EdgeInsets.all(18), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), border: Border.all(color: const Color(0xFFE5EBDD))), child: Row(children: [
          Container(width: 52, height: 52, decoration: BoxDecoration(color: const Color(0xFFE8F2E9), borderRadius: BorderRadius.circular(16)), child: Icon(role.icon, color: forest, size: 26)),
          const SizedBox(width: 14), Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(role.label, style: const TextStyle(color: forest, fontWeight: FontWeight.w900, fontSize: 16)), const SizedBox(height: 4), Text(role.description, style: const TextStyle(color: Colors.black54, fontSize: 11))])),
          const Icon(Icons.arrow_forward_ios_rounded, color: gold, size: 17),
        ])),
      ))),
      const SizedBox(height: 14),
      const Text('Pondok Pesantren Arraudhoh · Bogor', textAlign: TextAlign.center, style: TextStyle(color: Colors.black45, fontSize: 11)),
    ])),
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
  void dispose() { username.dispose(); password.dispose(); super.dispose(); }
  void signIn() {
    if (username.text.trim().isEmpty || password.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Isi nama pengguna dan kata sandi terlebih dahulu.')));
      return;
    }
    // Login demo: belum memverifikasi akun melalui server.
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => const HomeShell()), (route) => false);
  }
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: Text('Masuk sebagai ${widget.role.label}'), backgroundColor: paper),
    body: SafeArea(child: ListView(padding: const EdgeInsets.fromLTRB(24, 22, 24, 28), children: [
      Container(width: 76, height: 76, padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(22)), child: Image.asset('assets/logo_arraudhoh.png')),
      const SizedBox(height: 22),
      Text('Selamat datang, ${widget.role.label}', style: const TextStyle(color: forest, fontSize: 23, fontWeight: FontWeight.w900)),
      const SizedBox(height: 7),
      const Text('Masukkan data akun untuk melanjutkan.', style: TextStyle(color: Colors.black54, fontSize: 13)),
      const SizedBox(height: 25),
      TextField(controller: username, textInputAction: TextInputAction.next, decoration: const InputDecoration(labelText: 'Username / ID akun', prefixIcon: Icon(Icons.person_outline))),
      const SizedBox(height: 14),
      TextField(controller: password, obscureText: obscure, onSubmitted: (_) => signIn(), decoration: InputDecoration(labelText: 'Kata sandi', prefixIcon: const Icon(Icons.lock_outline), suffixIcon: IconButton(onPressed: () => setState(() => obscure = !obscure), icon: Icon(obscure ? Icons.visibility_outlined : Icons.visibility_off_outlined)))),
      const SizedBox(height: 22),
      SizedBox(height: 52, child: FilledButton(onPressed: signIn, style: FilledButton.styleFrom(backgroundColor: forest, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))), child: const Text('Masuk', style: TextStyle(fontWeight: FontWeight.w800)))),
      const SizedBox(height: 14),
      Container(padding: const EdgeInsets.all(13), decoration: BoxDecoration(color: const Color(0xFFE8F2E9), borderRadius: BorderRadius.circular(14)), child: const Text('Catatan: halaman masuk ini masih prototipe. Username dan kata sandi belum diverifikasi dan belum terhubung ke database.', style: TextStyle(color: forest, fontSize: 11, height: 1.5))),
    ])),
  );
}

class HomeShell extends StatefulWidget {
  const HomeShell({super.key});
  @override
  State<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell> {
  int selected = 0;
  final List<Map<String, dynamic>> transactions = [
    {'title': 'Top up saldo', 'detail': 'Pengisian saldo · Contoh', 'amount': '+ Rp50.000', 'in': true, 'icon': Icons.add_card_rounded},
    {'title': 'Pembayaran kantin', 'detail': 'Kantin pondok · Contoh', 'amount': '- Rp12.000', 'in': false, 'icon': Icons.restaurant_rounded},
    {'title': 'Pembelian perlengkapan', 'detail': 'Koperasi · Contoh', 'amount': '- Rp25.000', 'in': false, 'icon': Icons.shopping_bag_rounded},
  ];

  @override
  Widget build(BuildContext context) {
    final pages = [dashboard(), history(), reports(), profile()];
    return Scaffold(
      body: SafeArea(child: IndexedStack(index: selected, children: pages)),
      bottomNavigationBar: NavigationBar(
        height: 70,
        backgroundColor: Colors.white,
        indicatorColor: const Color(0xFFE3F1E9),
        selectedIndex: selected,
        onDestinationSelected: (i) => setState(() => selected = i),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home_rounded), label: 'Beranda'),
          NavigationDestination(icon: Icon(Icons.receipt_long_outlined), selectedIcon: Icon(Icons.receipt_long_rounded), label: 'Transaksi'),
          NavigationDestination(icon: Icon(Icons.insights_outlined), selectedIcon: Icon(Icons.insights_rounded), label: 'Laporan'),
          NavigationDestination(icon: Icon(Icons.person_outline_rounded), selectedIcon: Icon(Icons.person_rounded), label: 'Profil'),
        ],
      ),
    );
  }

  Widget brandHeader() => Row(children: [
    Container(width: 54, height: 54, padding: const EdgeInsets.all(3), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(17), border: Border.all(color: const Color(0xFFE5EBDD))), child: ClipRRect(borderRadius: BorderRadius.circular(14), child: Image.asset('assets/logo_arraudhoh.png', fit: BoxFit.contain))),
    const SizedBox(width: 12),
    const Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text('ARRAUDHOH', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w900, letterSpacing: 1.2, color: forest)),
      Text('SANTRIPAY', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w800, letterSpacing: 2.4, color: gold)),
      Text('Pondok Pesantren Ar-Raudhoh', style: TextStyle(fontSize: 10, color: Colors.black54)),
    ])),
    IconButton(onPressed: () => toast('Belum ada notifikasi baru.'), icon: const Icon(Icons.notifications_none_rounded, color: forest)),
  ]);

  Widget dashboard() => ListView(padding: const EdgeInsets.fromLTRB(20, 16, 20, 24), children: [
    brandHeader(),
    const SizedBox(height: 26),
    const Text('Assalamu’alaikum 👋', style: TextStyle(fontSize: 23, fontWeight: FontWeight.w800, color: ink)),
    const SizedBox(height: 5),
    const Text('Selamat datang di layanan keuangan pondok.', style: TextStyle(color: Colors.black54, fontSize: 13)),
    const SizedBox(height: 20),
    balanceCard(),
    const SizedBox(height: 22),
    const Text('Akses cepat', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800, color: ink)),
    const SizedBox(height: 13),
    Row(children: [
      quickAction(Icons.add_circle_outline_rounded, 'Top Up', () => toast('Fitur top up akan dihubungkan ke sistem admin.')),
      quickAction(Icons.qr_code_2_rounded, 'Kartu QR', () => showCard()),
      quickAction(Icons.qr_code_scanner_rounded, 'Bayar', () => toast('Pembayaran QR belum diaktifkan.')),
      quickAction(Icons.swap_horiz_rounded, 'Transfer', () => toast('Transfer belum diaktifkan.')),
    ]),
    const SizedBox(height: 23),
    Container(padding: const EdgeInsets.all(18), decoration: BoxDecoration(borderRadius: BorderRadius.circular(22), gradient: const LinearGradient(colors: [forest, Color(0xFF147451)], begin: Alignment.topLeft, end: Alignment.bottomRight)), child: Row(children: [
      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: const [Text('SATU APLIKASI\nUNTUK SANTRI', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 17, height: 1.25)), SizedBox(height: 7), Text('Transaksi lebih praktis, tertib, dan terpantau.', style: TextStyle(color: Colors.white70, fontSize: 12, height: 1.4))])),
      const SizedBox(width: 8),
      Container(width: 62, height: 62, padding: const EdgeInsets.all(5), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(18)), child: Image.asset('assets/logo_arraudhoh.png')),
    ])),
    const SizedBox(height: 23),
    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [const Text('Transaksi terbaru', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800, color: ink)), TextButton(onPressed: () => setState(() => selected = 1), child: const Text('Lihat semua'))]),
    const SizedBox(height: 4),
    ...transactions.take(3).map(transactionTile),
    const SizedBox(height: 10),
    const Text('Tampilan ini masih menggunakan data contoh. Saldo dan transaksi asli memerlukan database serta verifikasi admin.', style: TextStyle(fontSize: 11, color: Colors.black54, height: 1.4)),
  ]);

  Widget balanceCard() => Container(padding: const EdgeInsets.all(21), decoration: BoxDecoration(borderRadius: BorderRadius.circular(25), color: forest, boxShadow: [BoxShadow(color: forest.withOpacity(.16), blurRadius: 18, offset: const Offset(0, 9))]), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Row(children: const [Icon(Icons.account_balance_wallet_outlined, color: Colors.white70, size: 19), SizedBox(width: 8), Text('SALDO SANTRI', style: TextStyle(color: Colors.white70, fontSize: 11, letterSpacing: 1.3, fontWeight: FontWeight.w700)), Spacer(), Icon(Icons.verified_user_outlined, color: gold, size: 20)]),
    const SizedBox(height: 12),
    const Text('Rp 75.000', style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.w900, letterSpacing: .2)),
    const SizedBox(height: 5),
    const Text('Contoh tampilan saldo · belum terhubung', style: TextStyle(color: Colors.white60, fontSize: 10)),
    const SizedBox(height: 18),
    Row(children: [const Text('AR-••••-1025', style: TextStyle(color: Colors.white70, fontSize: 11, letterSpacing: 1)), const Spacer(), Container(padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 6), decoration: BoxDecoration(color: gold, borderRadius: BorderRadius.circular(20)), child: const Text('SANTRI', style: TextStyle(color: forest, fontSize: 10, fontWeight: FontWeight.w900, letterSpacing: 1)))]),
  ]));

  Widget quickAction(IconData icon, String label, VoidCallback onTap) => Expanded(child: InkWell(onTap: onTap, borderRadius: BorderRadius.circular(18), child: Column(children: [Container(width: 55, height: 55, decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(18), border: Border.all(color: const Color(0xFFE5EBDD))), child: Icon(icon, color: green, size: 25)), const SizedBox(height: 8), Text(label, style: const TextStyle(fontSize: 11, color: ink, fontWeight: FontWeight.w700))])));

  Widget transactionTile(Map<String, dynamic> item) {
    final bool incoming = item['in'] as bool;
    return Container(margin: const EdgeInsets.only(bottom: 9), padding: const EdgeInsets.all(13), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(17), border: Border.all(color: const Color(0xFFF0F0E9))), child: Row(children: [
      Container(width: 42, height: 42, decoration: BoxDecoration(color: incoming ? const Color(0xFFE7F4E9) : const Color(0xFFFFF0E8), borderRadius: BorderRadius.circular(13)), child: Icon(item['icon'] as IconData, color: incoming ? green : const Color(0xFFCB713A), size: 21)),
      const SizedBox(width: 11),
      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(item['title'] as String, style: const TextStyle(fontWeight: FontWeight.w800, color: ink, fontSize: 13)), const SizedBox(height: 3), Text(item['detail'] as String, style: const TextStyle(color: Colors.black45, fontSize: 10))])),
      Text(item['amount'] as String, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w900, color: incoming ? green : const Color(0xFFC65B4B))),
    ]));
  }

  Widget pageTitle(String title, String subtitle) => Padding(padding: const EdgeInsets.fromLTRB(20, 22, 20, 16), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w900, color: forest)), const SizedBox(height: 5), Text(subtitle, style: const TextStyle(color: Colors.black54, fontSize: 12))]));

  Widget history() => ListView(padding: EdgeInsets.zero, children: [pageTitle('Riwayat Transaksi', 'Pantau aktivitas saldo Arraudhoh SantriPay.'), Padding(padding: const EdgeInsets.symmetric(horizontal: 20), child: Container(padding: const EdgeInsets.all(15), decoration: BoxDecoration(color: const Color(0xFFE8F2E9), borderRadius: BorderRadius.circular(16)), child: const Row(children: [Icon(Icons.info_outline, color: forest), SizedBox(width: 10), Expanded(child: Text('Riwayat di bawah merupakan data contoh untuk pratinjau desain.', style: TextStyle(fontSize: 11, color: forest)))]))), const SizedBox(height: 16), ...transactions.map((t) => Padding(padding: const EdgeInsets.symmetric(horizontal: 20), child: transactionTile(t)))]);

  Widget reports() => ListView(padding: EdgeInsets.zero, children: [pageTitle('Ringkasan Keuangan', 'Ikhtisar transaksi dalam aplikasi.'), Padding(padding: const EdgeInsets.symmetric(horizontal: 20), child: Column(children: [reportCard('Total pemasukan', 'Rp 50.000', Icons.trending_up_rounded, green), reportCard('Total pengeluaran', 'Rp 37.000', Icons.trending_down_rounded, const Color(0xFFC65B4B)), reportCard('Saldo contoh', 'Rp 75.000', Icons.account_balance_wallet_rounded, gold), const SizedBox(height: 8), const Text('Angka ini hanya contoh visual, bukan laporan keuangan aktual.', style: TextStyle(color: Colors.black54, fontSize: 11))]))]);

  Widget reportCard(String title, String value, IconData icon, Color color) => Container(margin: const EdgeInsets.only(bottom: 12), padding: const EdgeInsets.all(18), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(18)), child: Row(children: [Container(width: 44, height: 44, decoration: BoxDecoration(color: color.withOpacity(.12), borderRadius: BorderRadius.circular(13)), child: Icon(icon, color: color)), const SizedBox(width: 13), Expanded(child: Text(title, style: const TextStyle(color: Colors.black54, fontSize: 12))), Text(value, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w900, color: forest))]));

  Widget profile() => ListView(padding: const EdgeInsets.fromLTRB(20, 22, 20, 24), children: [const Text('Profil & Identitas', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900, color: forest)), const SizedBox(height: 5), const Text('Identitas resmi aplikasi pondok.', style: TextStyle(color: Colors.black54, fontSize: 12)), const SizedBox(height: 22), Container(padding: const EdgeInsets.all(24), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24), border: Border.all(color: const Color(0xFFE8EBDD))), child: Column(children: [Container(width: 112, height: 112, padding: const EdgeInsets.all(5), decoration: BoxDecoration(color: const Color(0xFFF7F8F3), borderRadius: BorderRadius.circular(28)), child: Image.asset('assets/logo_arraudhoh.png')), const SizedBox(height: 17), const Text('ARRAUDHOH SANTRIPAY', textAlign: TextAlign.center, style: TextStyle(fontSize: 19, color: forest, fontWeight: FontWeight.w900, letterSpacing: .5)), const SizedBox(height: 6), const Text('Pondok Pesantren Ar-Raudhoh\nBogor · Jawa Barat', textAlign: TextAlign.center, style: TextStyle(color: Colors.black54, height: 1.5, fontSize: 12)), const SizedBox(height: 16), Container(height: 3, width: 65, decoration: BoxDecoration(color: gold, borderRadius: BorderRadius.circular(9))), const SizedBox(height: 15), const Text('Transaksi mudah, pondok makin berkah.', textAlign: TextAlign.center, style: TextStyle(color: forest, fontWeight: FontWeight.w700, fontSize: 12))])), const SizedBox(height: 16), profileRow(Icons.verified_outlined, 'Identitas aplikasi', 'Arraudhoh SantriPay'), profileRow(Icons.security_outlined, 'Keamanan', 'Fitur autentikasi belum diaktifkan'), profileRow(Icons.info_outline_rounded, 'Versi aplikasi', '1.1.0 · UI Preview')]);

  Widget profileRow(IconData icon, String title, String subtitle) => Container(margin: const EdgeInsets.only(bottom: 9), padding: const EdgeInsets.all(15), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)), child: Row(children: [Icon(icon, color: green), const SizedBox(width: 12), Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: const TextStyle(fontWeight: FontWeight.w800, color: ink, fontSize: 12)), const SizedBox(height: 3), Text(subtitle, style: const TextStyle(color: Colors.black54, fontSize: 10))]))]));

  void showCard() => showDialog(context: context, builder: (_) => Dialog(backgroundColor: Colors.transparent, child: Container(padding: const EdgeInsets.all(22), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(25)), child: Column(mainAxisSize: MainAxisSize.min, children: [Image.asset('assets/logo_arraudhoh.png', height: 82), const SizedBox(height: 12), const Text('KARTU SANTRI', style: TextStyle(color: forest, fontWeight: FontWeight.w900, letterSpacing: 1.5, fontSize: 18)), const SizedBox(height: 5), const Text('Arraudhoh SantriPay', style: TextStyle(color: gold, fontWeight: FontWeight.w800)), const SizedBox(height: 15), Container(height: 1, color: const Color(0xFFE9EBDD)), const SizedBox(height: 14), const Text('NIS: •••• 1025', style: TextStyle(fontWeight: FontWeight.w700)), const Text('Nama dan QR santri akan diisi setelah data resmi tersedia.', textAlign: TextAlign.center, style: TextStyle(color: Colors.black54, fontSize: 11)), const SizedBox(height: 16), FilledButton(onPressed: () => Navigator.pop(context), style: FilledButton.styleFrom(backgroundColor: forest), child: const Text('Tutup'))]))));

  void toast(String message) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message), behavior: SnackBarBehavior.floating));
}
