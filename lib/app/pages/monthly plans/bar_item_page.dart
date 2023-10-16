import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../widgets/frosted glass/frosted_glass.dart';

class BarItemPage extends StatefulWidget {
  const BarItemPage({super.key});

  @override
  State<BarItemPage> createState() => _BarItemPageState();
}

class _BarItemPageState extends State<BarItemPage> {
  Color dourado = const Color.fromARGB(184, 76, 50, 15);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 50),
              Center(
                child: Image.asset(
                  'assets/logo.png',
                  width: 130,
                ),
              ),
              const SizedBox(height: 20),
              FrostedGlassBox(
                theWidth: 330.0,
                theHeight: 390.0,
                theChild: Column(
                  children: [
                    Text(
                      'Mensal',
                      style: GoogleFonts.poppins(color: dourado, fontSize: 25.0, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "R\$ 99,90 por mês",
                      style: GoogleFonts.poppins(fontSize: 25, color: const Color.fromARGB(255, 101, 132, 98), fontWeight: FontWeight.w400),
                    ),
                    Text(
                      "Total de R\$ 99,90",
                      style: GoogleFonts.poppins(color: dourado),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: 190,
                      height: 40,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(255, 101, 132, 98),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                          'Assinar plano!',
                          style: GoogleFonts.poppins(fontWeight: FontWeight.w600, color: Theme.of(context).colorScheme.primary),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Divider(
                      indent: 40,
                      endIndent: 40,
                      thickness: 2,
                    ),
                    const SizedBox(height: 15),
                    SizedBox(
                      width: 270,
                      height: 30,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.check,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          const Text(
                            ' Meios de pagamento: pix, boleto, \n débito e crédito',
                            style: TextStyle(color: Color.fromARGB(255, 101, 132, 98), fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(height: 5),
                        ],
                      ),
                    ),
                    const SizedBox(height: 5),
                    SizedBox(
                      width: 270,
                      height: 30,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.check,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          const Text(' Não renova automaticamente', style: TextStyle(color: Color.fromARGB(255, 101, 132, 98), fontWeight: FontWeight.w500)),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 270,
                      height: 30,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.check,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          const Text(' Valor do plano sem as taxas de \n parcelamento da operadora do cartão', style: TextStyle(color: Color.fromARGB(255, 101, 132, 98), fontWeight: FontWeight.w500)),
                          const SizedBox(height: 5),
                        ],
                      ),
                    ),
                    const SizedBox(height: 5),
                    SizedBox(
                      width: 270,
                      height: 30,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.check,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          const Text('Garantia de 7 dias', style: TextStyle(color: Color.fromARGB(255, 101, 132, 98), fontWeight: FontWeight.w500)),
                          const SizedBox(height: 5),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
       
              FrostedGlassBox(
                theWidth: 330.0,
                theHeight: 390.0,
                theChild: Column(
                  children: [
                    Text(
                      'Anual',
                      style: GoogleFonts.poppins(color: dourado, fontSize: 25.0, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "R\$ 49,90 por mês",
                      style: GoogleFonts.poppins(fontSize: 25, color: const Color.fromARGB(255, 101, 132, 98), fontWeight: FontWeight.w400),
                    ),
                    Text(
                      "Total de R\$ 598,80",
                      style: GoogleFonts.poppins(color: dourado),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: 190,
                      height: 40,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(255, 101, 132, 98),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                          'Assinar plano!',
                          style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Divider(
                      indent: 40,
                      endIndent: 40,
                      thickness: 2,
                    ),
                    const SizedBox(height: 15),
                    SizedBox(
                      width: 270,
                      height: 30,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.check,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          const Text(
                            ' Meios de pagamento: pix, boleto, \n débito e crédito',
                            style: TextStyle(color: Color.fromARGB(255, 101, 132, 98), fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(height: 5),
                        ],
                      ),
                    ),
                    const SizedBox(height: 5),
                    SizedBox(
                      width: 270,
                      height: 30,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.check,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          const Text(' Não renova automaticamente', style: TextStyle(color: Color.fromARGB(255, 101, 132, 98), fontWeight: FontWeight.w500)),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 270,
                      height: 30,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.check,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          const Text(' Valor do plano sem as taxas de \n parcelamento da operadora do cartão', style: TextStyle(color: Color.fromARGB(255, 101, 132, 98), fontWeight: FontWeight.w500)),
                          const SizedBox(height: 5),
                        ],
                      ),
                    ),
                    const SizedBox(height: 5),
                    SizedBox(
                      width: 270,
                      height: 30,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.check,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          const Text('Garantia de 7 dias', style: TextStyle(color: Color.fromARGB(255, 101, 132, 98), fontWeight: FontWeight.w500)),
                          const SizedBox(height: 5),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
    
              FrostedGlassBox(
                theWidth: 330.0,
                theHeight: 390.0,
                theChild: Column(
                  children: [
                    Text(
                      'Trimestral',
                      style: GoogleFonts.poppins(color: dourado, fontSize: 25.0, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "R\$ 79,90 por mês",
                      style: GoogleFonts.poppins(fontSize: 25, color: const Color.fromARGB(255, 101, 132, 98), fontWeight: FontWeight.w400),
                    ),
                    Text(
                      "Total de R\$ 239,70",
                      style: GoogleFonts.poppins(color: dourado),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: 190,
                      height: 40,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(255, 101, 132, 98),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                          'Assinar plano!',
                          style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Divider(
                      indent: 40,
                      endIndent: 40,
                      thickness: 2,
                    ),
                    const SizedBox(height: 15),
                    SizedBox(
                      width: 270,
                      height: 30,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.check,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          const Text(
                            ' Meios de pagamento: pix, boleto, \n débito e crédito',
                            style: TextStyle(color: Color.fromARGB(255, 101, 132, 98), fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(height: 5),
                        ],
                      ),
                    ),
                    const SizedBox(height: 5),
                    SizedBox(
                      width: 270,
                      height: 30,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.check,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          const Text(' Não renova automaticamente', style: TextStyle(color: Color.fromARGB(255, 101, 132, 98), fontWeight: FontWeight.w500)),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 270,
                      height: 30,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.check,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          const Text(' Valor do plano sem as taxas de \n parcelamento da operadora do cartão', style: TextStyle(color: Color.fromARGB(255, 101, 132, 98), fontWeight: FontWeight.w500)),
                          const SizedBox(height: 5),
                        ],
                      ),
                    ),
                    const SizedBox(height: 5),
                    SizedBox(
                      width: 270,
                      height: 30,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.check,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          const Text('Garantia de 7 dias', style: TextStyle(color: Color.fromARGB(255, 101, 132, 98), fontWeight: FontWeight.w500)),
                          const SizedBox(height: 5),
                        ],
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
}
