import 'package:flutter/material.dart';

void main() => runApp(const SantriPayApp());

const Color forest = Color(0xFF14532D);
const Color emerald = Color(0xFF087F5B);
const Color canvas = Color(0xFFF4F7F3);
const Color ink = Color(0xFF17251D);
const Color muted = Color(0xFF78847C);
const Color line = Color(0xFFE8EEE8);

class SantriPayApp extends StatelessWidget {
  const SantriPayApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SantriPay',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: canvas,
        colorScheme: ColorScheme.fromSeed(seedColor: forest),
        fontFamily: 'Roboto',
        appBarTheme: const AppBarTheme(
          backgroundColor: canvas,
          foregroundColor: ink,
          elevation: 0,
          centerTitle: false,
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          hintStyle: const TextStyle(color: muted, fontSize: 14),
          prefixIconColor: muted,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: line),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: line),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: emerald, width: 1.5),
          ),
        ),
      ),
      home: const LoginPage(),
    );
  }
}

enum UserRole { santri, pengurus, admin }

extension RoleLabel on UserRole {
  String get label {
    switch (this) {
      case UserRole.santri:
        return 'Santri';
      case UserRole.pengurus:
        return 'Pengurus';
      case UserRole.admin:
        return 'Admin';
    }
  }

  IconData get icon {
    switch (this) {
      case UserRole.santri:
        return Icons.person_rounded;
      case UserRole.pengurus:
        return Icons.groups_rounded;
      case UserRole.admin:
        return Icons.admin_panel_settings_rounded;
    }
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  UserRole role = UserRole.santri;
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
        const SnackBar(content: Text('Isi username dan password terlebih dahulu.')),
      );
      return;
    }
    // Prototype only: replace this demo sign-in with real backend authentication.
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => AppShell(role: role, displayName: username.text.trim()),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: -90,
            right: -65,
            child: Container(
              width: 260,
              height: 260,
              decoration: const BoxDecoration(
                color: Color(0xFFDDEDE2),
                shape: BoxShape.circle,
              ),
            ),
          ),
          SafeArea(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(24, 28, 24, 24),
              children: [
                const SizedBox(height: 14),
                Container(
                  width: 78,
                  height: 78,
                  decoration: BoxDecoration(
                    color: forest,
                    borderRadius: BorderRadius.circular(26),
                    boxShadow: [
                      BoxShadow(
                        color: forest.withOpacity(.18),
                        blurRadius: 22,
                        offset: const Offset(0, 10),
                      )
                    ],
                  ),
                  child: const Icon(Icons.account_balance_rounded, color: Colors.white, size: 42),
                ),
                const SizedBox(height: 20),
                const Text(
                  'SantriPay',
                  style: TextStyle(fontSize: 34, fontWeight: FontWeight.w900, color: forest, letterSpacing: -.8),
                ),
                const SizedBox(height: 5),
                const Text(
                  'Keuangan digital Pondok Pesantren Arraudhoh',
                  style: TextStyle(color: muted, height: 1.5),
                ),
                const SizedBox(height: 34),
                const Text('Selamat datang 👋', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800, color: ink)),
                const SizedBox(height: 7),
                const Text('Masuk untuk melanjutkan ke akun Anda.', style: TextStyle(color: muted)),
                const SizedBox(height: 22),
                Row(
                  children: UserRole.values.map((item) {
                    final selected = role == item;
                    return Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(right: item == UserRole.admin ? 0 : 9),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(17),
                          onTap: () => setState(() => role = item),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 180),
                            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 5),
                            decoration: BoxDecoration(
                              color: selected ? forest : Colors.white,
                              borderRadius: BorderRadius.circular(17),
                              border: Border.all(color: selected ? forest : line),
                            ),
                            child: Column(
                              children: [
                                Icon(item.icon, color: selected ? Colors.white : muted, size: 22),
                                const SizedBox(height: 7),
                                Text(item.label, style: TextStyle(color: selected ? Colors.white : ink, fontWeight: FontWeight.w700, fontSize: 12)),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: username,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(prefixIcon: Icon(Icons.person_outline_rounded), labelText: 'Username / Nomor Induk', hintText: 'Masukkan username'),
                ),
                const SizedBox(height: 13),
                TextField(
                  controller: password,
                  obscureText: obscure,
                  onSubmitted: (_) => signIn(),
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.lock_outline_rounded),
                    labelText: 'Password',
                    hintText: 'Masukkan password',
                    suffixIcon: IconButton(
                      onPressed: () => setState(() => obscure = !obscure),
                      icon: Icon(obscure ? Icons.visibility_outlined : Icons.visibility_off_outlined),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                FilledButton(
                  onPressed: signIn,
                  style: FilledButton.styleFrom(
                    backgroundColor: forest,
                    foregroundColor: Colors.white,
                    minimumSize: const Size.fromHeight(56),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(17)),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Masuk', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800)),
                      SizedBox(width: 9),
                      Icon(Icons.arrow_forward_rounded, size: 19),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(13),
                  decoration: BoxDecoration(color: const Color(0xFFE8F2EA), borderRadius: BorderRadius.circular(14)),
                  child: const Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.info_outline_rounded, color: forest, size: 19),
                      SizedBox(width: 9),
                      Expanded(
                        child: Text(
                          'Mode prototipe: isi kolom apa saja untuk mencoba tampilan. Login ini belum memverifikasi akun dan belum aman untuk penggunaan nyata.',
                          style: TextStyle(color: forest, fontSize: 12, height: 1.45),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 28),
                const Center(child: Text('Dibuat untuk Pondok Pesantren Arraudhoh', style: TextStyle(color: muted, fontSize: 11))),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class StudentRecord {
  StudentRecord(this.name, this.studentId, this.grade, this.balance);
  String name;
  String studentId;
  String grade;
  int balance;
}

class LedgerEntry {
  LedgerEntry({required this.title, required this.note, required this.amount, required this.income, DateTime? date})
      : date = date ?? DateTime.now();
  final String title;
  final String note;
  final int amount;
  final bool income;
  final DateTime date;
}

class AppShell extends StatefulWidget {
  const AppShell({super.key, required this.role, required this.displayName});
  final UserRole role;
  final String displayName;

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int tab = 0;
  final List<StudentRecord> students = [
    StudentRecord('Aisyah Putri', 'AR-202501', 'X-1', 85000),
    StudentRecord('Nabila Zahra', 'AR-202502', 'X-1', 120000),
    StudentRecord('Muhammad Rizky', 'AR-202503', 'X-2', 90000),
    StudentRecord('Ahmad Fauzan', 'AR-202504', 'X-2', 75000),
    StudentRecord('Siti Nurhaliza', 'AR-202505', 'X-3', 110000),
  ];
  final List<LedgerEntry> entries = [
    LedgerEntry(title: 'Pembayaran SPP', note: 'Contoh transaksi', amount: 100000, income: true, date: DateTime(2026, 11, 2, 8, 30)),
    LedgerEntry(title: 'Belanja di Kantin', note: 'Contoh transaksi', amount: 15000, income: false, date: DateTime(2026, 11, 1, 12, 20)),
    LedgerEntry(title: 'Donasi Pondok', note: 'Contoh transaksi', amount: 50000, income: true, date: DateTime(2026, 10, 31, 16, 45)),
  ];

  int get totalBalance => students.fold(0, (sum, s) => sum + s.balance);
  int get totalIncome => entries.where((e) => e.income).fold(0, (sum, e) => sum + e.amount);
  int get totalExpense => entries.where((e) => !e.income).fold(0, (sum, e) => sum + e.amount);
  bool get isStudent => widget.role == UserRole.santri;
  bool get canManage => widget.role != UserRole.santri;

  @override
  Widget build(BuildContext context) {
    final pages = isStudent
        ? [
            _studentHome(),
            _historyPage(),
            _studentCardPage(),
            _profilePage(),
          ]
        : [
            _adminHome(),
            _studentsPage(),
            _historyPage(),
            _profilePage(),
          ];
    final labels = isStudent
        ? const ['Beranda', 'Transaksi', 'Kartu', 'Profil']
        : const ['Ringkasan', 'Data Santri', 'Transaksi', 'Profil'];
    final icons = isStudent
        ? const [Icons.home_rounded, Icons.receipt_long_rounded, Icons.qr_code_2_rounded, Icons.person_rounded]
        : const [Icons.dashboard_rounded, Icons.groups_rounded, Icons.receipt_long_rounded, Icons.person_rounded];

    return Scaffold(
      body: SafeArea(child: IndexedStack(index: tab, children: pages)),
      bottomNavigationBar: NavigationBar(
        selectedIndex: tab,
        onDestinationSelected: (value) => setState(() => tab = value),
        backgroundColor: Colors.white,
        indicatorColor: const Color(0xFFDDEDE2),
        destinations: List.generate(labels.length, (i) => NavigationDestination(icon: Icon(icons[i]), label: labels[i])),
      ),
    );
  }

  Widget _studentHome() {
    final student = students.first;
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 28),
      children: [
        _topHeader('Assalamu’alaikum,', widget.displayName, Icons.notifications_none_rounded),
        const SizedBox(height: 25),
        const Text('Ringkasan akun', style: TextStyle(fontSize: 23, fontWeight: FontWeight.w900, color: ink)),
        const SizedBox(height: 5),
        const Text('Semoga harimu menyenangkan.', style: TextStyle(color: muted)),
        const SizedBox(height: 20),
        _balanceCard(student.balance, student.studentId),
        const SizedBox(height: 23),
        const Text('Akses cepat', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: ink)),
        const SizedBox(height: 13),
        Row(
          children: [
            _quickAction(Icons.qr_code_scanner_rounded, 'Kartu Digital', () => setState(() => tab = 2)),
            _quickAction(Icons.receipt_long_rounded, 'Riwayat', () => setState(() => tab = 1)),
            _quickAction(Icons.person_outline_rounded, 'Profil', () => setState(() => tab = 3)),
          ],
        ),
        const SizedBox(height: 24),
        _sectionHeader('Transaksi terbaru', 'Lihat semua', () => setState(() => tab = 1)),
        const SizedBox(height: 10),
        ...entries.take(3).map(_transactionTile),
        const SizedBox(height: 12),
        _notice('Informasi saldo dan transaksi di aplikasi ini masih berupa data contoh.'),
      ],
    );
  }

  Widget _adminHome() {
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 28),
      children: [
        _topHeader('Dashboard ${widget.role.label}', widget.displayName, Icons.notifications_none_rounded),
        const SizedBox(height: 24),
        const Text('Ringkasan pondok', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900, color: ink)),
        const SizedBox(height: 6),
        const Text('Pantau data dan aktivitas keuangan.', style: TextStyle(color: muted)),
        const SizedBox(height: 19),
        Row(
          children: [
            Expanded(child: _metricCard('Total Santri', '${students.length}', Icons.groups_rounded, const Color(0xFFE1F3E7), forest)),
            const SizedBox(width: 12),
            Expanded(child: _metricCard('Total Saldo', _rupiah(totalBalance), Icons.account_balance_wallet_rounded, const Color(0xFFE8E7FF), const Color(0xFF6255C7))),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(child: _metricCard('Pemasukan', _rupiah(totalIncome), Icons.trending_up_rounded, const Color(0xFFE1F3E7), forest)),
            const SizedBox(width: 12),
            Expanded(child: _metricCard('Pengeluaran', _rupiah(totalExpense), Icons.trending_down_rounded, const Color(0xFFFFE7E4), const Color(0xFFC34B43))),
          ],
        ),
        const SizedBox(height: 24),
        const Text('Menu pengelolaan', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: ink)),
        const SizedBox(height: 13),
        Row(
          children: [
            _quickAction(Icons.person_add_alt_1_rounded, 'Tambah Santri', _addStudent),
            _quickAction(Icons.add_card_rounded, 'Tambah Saldo', _chooseStudentForTopup),
            _quickAction(Icons.bar_chart_rounded, 'Laporan', _showReport),
          ],
        ),
        const SizedBox(height: 24),
        _sectionHeader('Aktivitas terbaru', 'Lihat semua', () => setState(() => tab = 2)),
        const SizedBox(height: 10),
        ...entries.take(3).map(_transactionTile),
        const SizedBox(height: 12),
        _notice('Prototipe: perubahan data hanya tersimpan selama aplikasi tetap berjalan.'),
      ],
    );
  }

  Widget _topHeader(String greeting, String name, IconData trailingIcon) {
    return Row(
      children: [
        Container(
          height: 48,
          width: 48,
          decoration: BoxDecoration(color: forest, borderRadius: BorderRadius.circular(16)),
          child: const Icon(Icons.account_balance_rounded, color: Colors.white, size: 27),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(greeting, style: const TextStyle(color: muted, fontSize: 12)),
              Text(name, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 16, color: ink)),
            ],
          ),
        ),
        IconButton(
          onPressed: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Belum ada notifikasi baru.'))),
          icon: Icon(trailingIcon, color: ink),
        ),
      ],
    );
  }

  Widget _balanceCard(int balance, String studentId) {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [forest, Color(0xFF16845D)], begin: Alignment.topLeft, end: Alignment.bottomRight),
        borderRadius: BorderRadius.circular(26),
        boxShadow: [BoxShadow(color: forest.withOpacity(.16), blurRadius: 20, offset: const Offset(0, 10))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(children: [Icon(Icons.account_balance_wallet_outlined, color: Colors.white70, size: 20), SizedBox(width: 8), Text('Saldo Anda', style: TextStyle(color: Colors.white70, fontSize: 13))]),
          const SizedBox(height: 12),
          Text(_rupiah(balance), style: const TextStyle(color: Colors.white, fontSize: 31, fontWeight: FontWeight.w900, letterSpacing: -.5)),
          const SizedBox(height: 18),
          Row(
            children: [
              Expanded(child: Text('ID Santri  $studentId', style: const TextStyle(color: Colors.white70, fontSize: 12))),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 7),
                decoration: BoxDecoration(color: Colors.white.withOpacity(.15), borderRadius: BorderRadius.circular(20)),
                child: const Text('AKUN DEMO', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w800)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _quickAction(IconData icon, String label, VoidCallback action) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(right: 9),
        child: InkWell(
          onTap: action,
          borderRadius: BorderRadius.circular(18),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 17, horizontal: 5),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(18), border: Border.all(color: line)),
            child: Column(
              children: [
                Container(
                  width: 43,
                  height: 43,
                  decoration: BoxDecoration(color: const Color(0xFFE6F2E9), borderRadius: BorderRadius.circular(14)),
                  child: Icon(icon, color: forest, size: 22),
                ),
                const SizedBox(height: 9),
                Text(label, textAlign: TextAlign.center, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: ink)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _metricCard(String title, String value, IconData icon, Color background, Color color) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(19), border: Border.all(color: line)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(padding: const EdgeInsets.all(9), decoration: BoxDecoration(color: background, borderRadius: BorderRadius.circular(12)), child: Icon(icon, color: color, size: 21)),
          const SizedBox(height: 13),
          Text(title, style: const TextStyle(color: muted, fontSize: 11)),
          const SizedBox(height: 5),
          FittedBox(fit: BoxFit.scaleDown, alignment: Alignment.centerLeft, child: Text(value, style: const TextStyle(color: ink, fontWeight: FontWeight.w900, fontSize: 17))),
        ],
      ),
    );
  }

  Widget _sectionHeader(String title, String actionLabel, VoidCallback action) {
    return Row(
      children: [
        Expanded(child: Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: ink))),
        TextButton(onPressed: action, child: Text(actionLabel, style: const TextStyle(color: forest, fontWeight: FontWeight.w700))),
      ],
    );
  }

  Widget _transactionTile(LedgerEntry entry) {
    final color = entry.income ? const Color(0xFF16834A) : const Color(0xFFD34B43);
    final bg = entry.income ? const Color(0xFFE4F5E9) : const Color(0xFFFFEAE8);
    final icon = entry.income ? Icons.south_west_rounded : Icons.shopping_cart_outlined;
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(17), border: Border.all(color: line)),
      child: Row(
        children: [
          Container(width: 43, height: 43, decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(14)), child: Icon(icon, color: color, size: 21)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(entry.title, style: const TextStyle(fontWeight: FontWeight.w800, color: ink, fontSize: 13)),
                const SizedBox(height: 4),
                Text('${entry.date.day}/${entry.date.month}/${entry.date.year} · ${entry.note}', style: const TextStyle(color: muted, fontSize: 10)),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Text('${entry.income ? '+' : '-'}${_rupiah(entry.amount)}', style: TextStyle(color: color, fontWeight: FontWeight.w900, fontSize: 12)),
        ],
      ),
    );
  }

  Widget _historyPage() {
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 28),
      children: [
        const Text('Riwayat Transaksi', style: TextStyle(fontSize: 25, fontWeight: FontWeight.w900, color: ink)),
        const SizedBox(height: 6),
        const Text('Pantau aktivitas keuangan terbaru.', style: TextStyle(color: muted)),
        const SizedBox(height: 20),
        Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(18), border: Border.all(color: line)),
          child: Row(
            children: [
              Expanded(child: _historyStat('Pemasukan', _rupiah(totalIncome), forest)),
              Container(width: 1, height: 40, color: line),
              Expanded(child: Padding(padding: const EdgeInsets.only(left: 15), child: _historyStat('Pengeluaran', _rupiah(totalExpense), const Color(0xFFC34B43)))),
            ],
          ),
        ),
        const SizedBox(height: 22),
        ...entries.map(_transactionTile),
        const SizedBox(height: 12),
        _notice('Riwayat ini masih data contoh dan belum tersinkron ke server.'),
      ],
    );
  }

  Widget _historyStat(String label, String value, Color color) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(label, style: const TextStyle(color: muted, fontSize: 11)),
      const SizedBox(height: 6),
      FittedBox(fit: BoxFit.scaleDown, child: Text(value, style: TextStyle(color: color, fontSize: 15, fontWeight: FontWeight.w900))),
    ]);
  }

  Widget _studentsPage() {
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 28),
      children: [
        Row(
          children: [
            const Expanded(child: Text('Data Santri', style: TextStyle(fontSize: 25, fontWeight: FontWeight.w900, color: ink))),
            IconButton.filled(
              onPressed: _addStudent,
              style: IconButton.styleFrom(backgroundColor: forest, foregroundColor: Colors.white),
              icon: const Icon(Icons.add_rounded),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Text('${students.length} data santri · contoh', style: const TextStyle(color: muted)),
        const SizedBox(height: 17),
        ...students.map((student) => Container(
          margin: const EdgeInsets.only(bottom: 10),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(18), border: Border.all(color: line)),
          child: Row(
            children: [
              CircleAvatar(backgroundColor: const Color(0xFFE1F0E5), child: Text(student.name.isNotEmpty ? student.name[0] : '?', style: const TextStyle(color: forest, fontWeight: FontWeight.w900))),
              const SizedBox(width: 12),
              Expanded(
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(student.name, style: const TextStyle(fontWeight: FontWeight.w800, color: ink)),
                  const SizedBox(height: 4),
                  Text('${student.studentId} · Kelas ${student.grade}', style: const TextStyle(color: muted, fontSize: 11)),
                  const SizedBox(height: 5),
                  Text(_rupiah(student.balance), style: const TextStyle(color: forest, fontWeight: FontWeight.w900, fontSize: 13)),
                ]),
              ),
              IconButton(onPressed: () => _topup(student), icon: const Icon(Icons.add_card_rounded, color: forest), tooltip: 'Tambah saldo'),
            ],
          ),
        )),
        const SizedBox(height: 12),
        _notice('Data santri masih tersimpan sementara di memori aplikasi.'),
      ],
    );
  }

  Widget _studentCardPage() {
    final student = students.first;
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 22, 20, 28),
      children: [
        const Text('Kartu Santri Digital', style: TextStyle(fontSize: 25, fontWeight: FontWeight.w900, color: ink)),
        const SizedBox(height: 6),
        const Text('Identitas digital untuk prototipe SantriPay.', style: TextStyle(color: muted)),
        const SizedBox(height: 24),
        Container(
          padding: const EdgeInsets.all(22),
          decoration: BoxDecoration(
            gradient: const LinearGradient(colors: [forest, Color(0xFF16845D)], begin: Alignment.topLeft, end: Alignment.bottomRight),
            borderRadius: BorderRadius.circular(26),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(children: [Icon(Icons.account_balance_rounded, color: Colors.white, size: 28), SizedBox(width: 10), Expanded(child: Text('PONDOK PESANTREN ARRAUDHOH', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w900, letterSpacing: .5)))]),
              const SizedBox(height: 28),
              const CircleAvatar(radius: 27, backgroundColor: Colors.white24, child: Icon(Icons.person_rounded, color: Colors.white, size: 30)),
              const SizedBox(height: 12),
              Text(student.name, style: const TextStyle(color: Colors.white, fontSize: 21, fontWeight: FontWeight.w900)),
              const SizedBox(height: 4),
              Text('Nomor Induk: ${student.studentId}', style: const TextStyle(color: Colors.white70, fontSize: 12)),
              const SizedBox(height: 20),
              const Divider(color: Colors.white24),
              Row(children: [
                Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [const Text('SALDO DEMO', style: TextStyle(color: Colors.white70, fontSize: 10)), const SizedBox(height: 5), Text(_rupiah(student.balance), style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 19))])),
                const Icon(Icons.qr_code_2_rounded, color: Colors.white, size: 62),
              ]),
            ],
          ),
        ),
        const SizedBox(height: 17),
        _notice('QR pada kartu ini hanya ilustrasi visual, belum dapat dipindai untuk pembayaran.'),
      ],
    );
  }

  Widget _profilePage() {
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 22, 20, 28),
      children: [
        const Text('Profil', style: TextStyle(fontSize: 25, fontWeight: FontWeight.w900, color: ink)),
        const SizedBox(height: 20),
        Container(
          padding: const EdgeInsets.all(22),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(22), border: Border.all(color: line)),
          child: Column(children: [
            const CircleAvatar(radius: 37, backgroundColor: Color(0xFFE1F0E5), child: Icon(Icons.person_rounded, color: forest, size: 42)),
            const SizedBox(height: 13),
            Text(widget.displayName, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w900, color: ink)),
            const SizedBox(height: 5),
            Text(widget.role.label, style: const TextStyle(color: muted)),
            const SizedBox(height: 13),
            const Chip(avatar: Icon(Icons.verified_user_outlined, size: 16), label: Text('Akun prototipe')),
          ]),
        ),
        const SizedBox(height: 17),
        _profileItem(Icons.account_balance_rounded, 'Pondok Pesantren Arraudhoh', 'Identitas aplikasi'),
        _profileItem(Icons.shield_outlined, 'Keamanan akun', 'Autentikasi belum terhubung'),
        _profileItem(Icons.help_outline_rounded, 'Bantuan', 'Hubungi pengelola aplikasi'),
        const SizedBox(height: 18),
        OutlinedButton.icon(
          onPressed: () => Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (_) => const LoginPage()), (_) => false),
          icon: const Icon(Icons.logout_rounded),
          label: const Text('Keluar'),
          style: OutlinedButton.styleFrom(foregroundColor: const Color(0xFFC34B43), minimumSize: const Size.fromHeight(52), side: const BorderSide(color: Color(0xFFF0D8D5)), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))),
        ),
        const SizedBox(height: 16),
        _notice('Versi prototipe. Jangan gunakan untuk menyimpan atau memproses uang sungguhan.'),
      ],
    );
  }

  Widget _profileItem(IconData icon, String title, String subtitle) {
    return Container(
      margin: const EdgeInsets.only(bottom: 9),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: line)),
      child: Row(children: [
        Container(padding: const EdgeInsets.all(9), decoration: BoxDecoration(color: const Color(0xFFE6F2E9), borderRadius: BorderRadius.circular(12)), child: Icon(icon, color: forest, size: 20)),
        const SizedBox(width: 12),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: const TextStyle(fontWeight: FontWeight.w800, color: ink, fontSize: 13)), const SizedBox(height: 4), Text(subtitle, style: const TextStyle(color: muted, fontSize: 11))])),
        const Icon(Icons.chevron_right_rounded, color: muted),
      ]),
    );
  }

  Widget _notice(String text) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(color: const Color(0xFFE8F2EA), borderRadius: BorderRadius.circular(15)),
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Icon(Icons.info_outline_rounded, color: forest, size: 18),
        const SizedBox(width: 9),
        Expanded(child: Text(text, style: const TextStyle(color: forest, fontSize: 11, height: 1.45))),
      ]),
    );
  }

  void _addStudent() {
    final nameController = TextEditingController();
    final idController = TextEditingController();
    final gradeController = TextEditingController();
    showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Tambah data santri'),
        content: SingleChildScrollView(
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            TextField(controller: nameController, decoration: const InputDecoration(labelText: 'Nama lengkap')),
            const SizedBox(height: 10),
            TextField(controller: idController, decoration: const InputDecoration(labelText: 'Nomor induk')),
            const SizedBox(height: 10),
            TextField(controller: gradeController, decoration: const InputDecoration(labelText: 'Kelas')),
          ]),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(dialogContext), child: const Text('Batal')),
          FilledButton(
            onPressed: () {
              if (nameController.text.trim().isEmpty || idController.text.trim().isEmpty) return;
              setState(() => students.add(StudentRecord(nameController.text.trim(), idController.text.trim(), gradeController.text.trim().isEmpty ? '-' : gradeController.text.trim(), 0)));
              Navigator.pop(dialogContext);
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Data contoh ditambahkan selama aplikasi berjalan.')));
            },
            child: const Text('Simpan'),
          ),
        ],
      ),
    ).then((_) {
      nameController.dispose();
      idController.dispose();
      gradeController.dispose();
    });
  }

  void _chooseStudentForTopup() {
    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (context) => SafeArea(
        child: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.all(16),
          children: [
            const Padding(padding: EdgeInsets.only(bottom: 10), child: Text('Pilih santri untuk tambah saldo', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800))),
            ...students.map((student) => ListTile(
              leading: const CircleAvatar(backgroundColor: Color(0xFFE1F0E5), child: Icon(Icons.person_rounded, color: forest)),
              title: Text(student.name),
              subtitle: Text('Saldo ${_rupiah(student.balance)}'),
              onTap: () {
                Navigator.pop(context);
                _topup(student);
              },
            )),
          ],
        ),
      ),
    );
  }

  void _topup(StudentRecord student) {
    final amountController = TextEditingController();
    showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text('Tambah saldo · ${student.name}'),
        content: TextField(
          controller: amountController,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(labelText: 'Nominal rupiah', prefixText: 'Rp '),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(dialogContext), child: const Text('Batal')),
          FilledButton(
            onPressed: () {
              final amount = int.tryParse(amountController.text.replaceAll('.', '').replaceAll(',', '').trim());
              if (amount == null || amount <= 0) return;
              setState(() {
                student.balance += amount;
                entries.insert(0, LedgerEntry(title: 'Tambah saldo', note: student.name, amount: amount, income: true));
              });
              Navigator.pop(dialogContext);
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Saldo demo diperbarui. Belum ada uang sungguhan yang diproses.')));
            },
            child: const Text('Tambah'),
          ),
        ],
      ),
    ).then((_) => amountController.dispose());
  }

  void _showReport() {
    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (context) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(22, 8, 22, 28),
          child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Text('Laporan ringkas', style: TextStyle(fontSize: 21, fontWeight: FontWeight.w900)),
            const SizedBox(height: 20),
            _reportLine('Jumlah santri', '${students.length} orang'),
            _reportLine('Total saldo santri', _rupiah(totalBalance)),
            _reportLine('Pemasukan contoh', _rupiah(totalIncome)),
            _reportLine('Pengeluaran contoh', _rupiah(totalExpense)),
            const SizedBox(height: 12),
            _notice('Laporan hanya menghitung data contoh di memori aplikasi.'),
          ]),
        ),
      ),
    );
  }

  Widget _reportLine(String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(children: [Expanded(child: Text(title, style: const TextStyle(color: muted))), Text(value, style: const TextStyle(fontWeight: FontWeight.w900, color: ink))]),
    );
  }
}

String _rupiah(int value) {
  final digits = value.toString();
  final buffer = StringBuffer();
  for (var i = 0; i < digits.length; i++) {
    buffer.write(digits[i]);
    final remaining = digits.length - i - 1;
    if (remaining > 0 && remaining % 3 == 0) buffer.write('.');
  }
  return 'Rp${buffer.toString()}';
}
