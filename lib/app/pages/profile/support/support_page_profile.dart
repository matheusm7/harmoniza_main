import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:harmoniza_ativos/data/data.dart';

class SupportPageProfile extends StatefulWidget {
  const SupportPageProfile({super.key});

  @override
  State<SupportPageProfile> createState() => _SupportPageProfileState();
}

class _SupportPageProfileState extends State<SupportPageProfile> {
  final bool _customTileExpanded = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[300],
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 10,
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Icon(
                            Icons.arrow_back_ios,
                            color: douradoEscuro,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 50),
                Image.asset(
                  'assets/logo.png',
                  width: 150,
                ),
                const SizedBox(height: 50),
                Text(
                  'DÚVIDAS FREQUENTES',
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: douradoEscuro,
                  ),
                ),
                const SizedBox(height: 30),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: ExpansionTile(
                    iconColor: douradoEscuro,
                    collapsedBackgroundColor: dourado,
                    title: Text(
                      'Paguei a Harmoniza por pix e ainda não liberou, o que fazer?',
                      style: TextStyle(color: douradoEscuro),
                    ),
                    children: [
                      ListTile(
                        title: Text(
                          'R: Saia e entre novamente com seu login e senha. Se o erro permanecer, entre em contato com a gente',
                          style: TextStyle(color: douradoEscuro),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: ExpansionTile(
                    iconColor: douradoEscuro,
                    collapsedBackgroundColor: dourado,
                    title: Text(
                      'A plataforma Harmoniza tem um período de teste gratis?',
                      style: TextStyle(color: douradoEscuro),
                    ),
                    children: [
                      ListTile(
                        title: Text(
                          'R: Sim, no plano mensal, após cadastrar o seu cartão você tera 7 dias grátis para testar a plataforma. Passando do período de teste será debitado o valor do seu plano no seu cartão e ocorrerá uma nova cobrança de renovação dentro de 30 dias',
                          style: TextStyle(color: douradoEscuro),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: ExpansionTile(
                    iconColor: douradoEscuro,
                    collapsedBackgroundColor: dourado,
                    title: Text(
                      'Estou com duvida sobre os planos disponíveis.',
                      style: TextStyle(color: douradoEscuro),
                    ),
                    children: [
                      ListTile(
                        title: Text(
                          'R: Na Harmoniza, temos duas modalidades de plano: recorrentes e não recorrentes. Os planos recorrentes, quando disponíveis, terão indicado no nome "recorrente" e contém informações na descrição. Planos recorrentes são assinaturas que possuem renovação automática mensal e oferecem um período de 7 dias grátis de acesso a plataforma. Já os planos não recorrentes não possuem renovação automática, portanto, após o término do plano você deverá comprá-lo novamente para liberar acesso a plataforma Harmoniza.',
                          style: TextStyle(color: douradoEscuro),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: ExpansionTile(
                    iconColor: douradoEscuro,
                    collapsedBackgroundColor: dourado,
                    title: Text(
                      'Comprei um plano não recorrente (mensal, trimestral, semestral ou anual), tenho 7 dias grátis?',
                      style: TextStyle(color: douradoEscuro),
                    ),
                    children: [
                      ListTile(
                        title: Text(
                          'R: Não. Nos planos que não são recorrentes, você terá garantia de 7 dias pela plataforma. Ou seja, caso a plataforma Harmoniza não atenda suas necessidades durante esse período, entre em contato com o suporte para acionar a garantia.',
                          style: TextStyle(color: douradoEscuro),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: ExpansionTile(
                    iconColor: douradoEscuro,
                    collapsedBackgroundColor: dourado,
                    title: Text(
                      'Estou com problemas no pagamento, o que fazer?',
                      style: TextStyle(color: douradoEscuro),
                    ),
                    children: [
                      ListTile(
                        title: Text(
                          'R: Tente mudar o cartão utilizado ou a forma de pagamento. Se o erro persistir, entre em contato com o nosso suporte e detalhe o ocorrido.',
                          style: TextStyle(color: douradoEscuro),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: ExpansionTile(
                    iconColor: douradoEscuro,
                    collapsedBackgroundColor: dourado,
                    title: Text(
                      'Tenho sugestões para melhorar a plataforma, o que fazer?',
                      style: TextStyle(color: douradoEscuro),
                    ),
                    children: [
                      ListTile(
                        title: Text(
                          'R:  Entre em contato conosco pelo e-mail ou whatsapp. Vamos adorar receber seu feedback!',
                          style: TextStyle(color: douradoEscuro),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: ExpansionTile(
                    iconColor: douradoEscuro,
                    collapsedBackgroundColor: dourado,
                    title: Text(
                      'Estava sem limite no cartão no momento da recorrência, o que fazer?',
                      style: TextStyle(color: douradoEscuro),
                    ),
                    children: [
                      ListTile(
                        title: Text(
                          'R: Libere limite do seu cartão pois dentro de 2 dias haverá uma nova tentativa de cobrança. No total, são 4 tentativas. Após as 4 tentativas, seu plano será automaticamente cancelado. Em caso de dúvidas ou caso queira cancelar seu plano durante esse período de tentativa de cobrança, entre em contato com o nosso suporte pelo WhatsApp.',
                          style: TextStyle(color: douradoEscuro),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: ExpansionTile(
                    iconColor: douradoEscuro,
                    collapsedBackgroundColor: dourado,
                    title: Text(
                      'Como faço para cancelar meu plano?',
                      style: TextStyle(color: douradoEscuro),
                    ),
                    children: [
                      ListTile(
                        title: Text(
                          'R: Caso tenha o plano recorrente, você pode cancelar sua assinatura a qualquer momento na aba "planos" clicando em "cancelar plano". Após o cancelamento, você ainda terá acesso a plataforma até zerar a contagem do tempo do seu plano. Se você tiver um plano não recorrente (mensal, trimestral, semestral ou anual), o cancelamento do seu plano é automático após a finalização do período do plano.',
                          style: TextStyle(color: douradoEscuro),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: ExpansionTile(
                    iconColor: douradoEscuro,
                    collapsedBackgroundColor: dourado,
                    title: Text(
                      'Canais para contato',
                      style: TextStyle(color: douradoEscuro),
                    ),
                    children: [
                      ListTile(
                        title: Text(
                          "E-mail para contato: suporte@gmail.com \n Whatsapp: (11)99999-9999",
                          style: TextStyle(color: douradoEscuro),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: ExpansionTile(
                    iconColor: douradoEscuro,
                    collapsedBackgroundColor: dourado,
                    title: Text(
                      'Estou com duvida sobre os planos disponíveis.',
                      style: TextStyle(color: douradoEscuro),
                    ),
                    children: [
                      ListTile(
                        title: Text(
                          'R: Na Harmoniza, temos duas modalidades de plano: recorrentes e não recorrentes. Os planos recorrentes, quando disponíveis, terão indicado no nome "recorrente" e contém informações na descrição. Planos recorrentes são assinaturas que possuem renovação automática mensal e oferecem um período de 7 dias grátis de acesso a plataforma. Já os planos não recorrentes não possuem renovação automática, portanto, após o término do plano você deverá comprá-lo novamente para liberar acesso a plataforma Harmoniza.',
                          style: TextStyle(color: douradoEscuro),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: ExpansionTile(
                    iconColor: douradoEscuro,
                    collapsedBackgroundColor: dourado,
                    title: Text(
                      'Estou com duvida sobre os planos disponíveis.',
                      style: TextStyle(color: douradoEscuro),
                    ),
                    children: [
                      ListTile(
                        title: Text(
                          'R: Na Harmoniza, temos duas modalidades de plano: recorrentes e não recorrentes. Os planos recorrentes, quando disponíveis, terão indicado no nome "recorrente" e contém informações na descrição. Planos recorrentes são assinaturas que possuem renovação automática mensal e oferecem um período de 7 dias grátis de acesso a plataforma. Já os planos não recorrentes não possuem renovação automática, portanto, após o término do plano você deverá comprá-lo novamente para liberar acesso a plataforma Harmoniza.',
                          style: TextStyle(color: douradoEscuro),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
