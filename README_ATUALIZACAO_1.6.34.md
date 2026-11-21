# App 1.6.34+192 / Mobile 1.14.5

Instale primeiro a atualização da loja ou gere/aplique o módulo Mobile pelo Soft Licenças completo 2.14.5. Mantém o motor de localidades e ajustes de checkout Web já aplicados. A atualização inclui o mesmo helper de endereços que passou no site; não substitui loja/cadastro.php, loja/minha_conta.php ou wrappers públicos.

No Admin > Mobile > Android/iOS, configure a versão/build do novo release (1.6.34 / 192). O build continua buscando API, branding, nome, identidade, versão e build no servidor. Dados da loja não são chumbados no comando.

Android, PowerShell na pasta do projeto:
`.\COMPILAR_ANDROID.cmd https://domlevi.com.br/api/mobile/v1`
Preserve sua android/key.properties e sua chave de produção. Completo e patch não incluem nem substituem keystores/senhas. Não use debug como chave de release.

No iOS, codemagic.yaml mantém os workflows:
- ios-sem-assinatura: release sem assinatura enquanto aguarda a Apple, para verificar compilação. Não instala em iPhone/TestFlight.
- ios-production: IPA com certificado/perfil App Store do Bundle ID configurado.
No Mac para simulador: `bash tooling/prepare_ios.sh https://domlevi.com.br/api/mobile/v1`, `open -a Simulator`, `flutter run --dart-define=SOFT_API_BASE_URL=https://domlevi.com.br/api/mobile/v1`.
Para IPA com assinatura disponível: `bash tooling/build_ipa.sh https://domlevi.com.br/api/mobile/v1`.

Cadastro e Conta compartilham o formulário de endereço. Selecione CPF/CNPJ; CNPJ mostra Razão social, fantasia e IE opcionais e aguarda aprovação comercial da loja sem emitir tokens. CPF preserva login após criar conta. Conclusão do cadastro via Google segue as mesmas regras e os mesmos termos.

Consultar CEP preenche dados do endereço. Em CEP de rua, bairro normal e sem localidade fixa. CEP regional (final 000 ou consulta sem rua), no modo localidade e cidade com opções ativas do canal, exige Bairro / Balneário / Distrito. Não mostra tarifas nessa lista. Rua e Número permanecem obrigatórios. Nomes das localidades vêm do cadastro da loja sem tradução automática. Interface PT/EN/ES preservada.

Fora da área ou sem localidades ativas pode cadastrar endereço completo; entrega continua validada pelo checkout. CEP/regras vêm da API, com cache limitado da consulta postal e validação também ao salvar. Mudanças de cidade/UF/CEP/tipo de conta descartam respostas antigas e recarregam a lista. Falha no serviço de CEP permite preenchimento manual e nova consulta de regras.

Conta > Meus Endereços: botão +, edição do principal e dos alternativos. Mudança real marca PENDENTE no sincronizador ERP existente; preserva códigos cliente/local, aprovação, bloqueio, tabela de preços e histórico dos pedidos. Limpa coordenadas se o endereço físico mudou. Exige que a integração esteja configurada/rodando; não executa Firebird na requisição do cliente. B2C usa o robô vigente; CNPJ segue fluxo comercial/administrativo. Não altera a política de exclusão de locais no ERP.

Preserva catálogo Read Model: nenhuma reconstrução via requisição; filas/worker/índices continuam iguais. Preserva pedidos, SAC, LGPD, notificações/idioma/biometria, contatos, pesáveis e branding dinâmico. Não acrescenta envio automático de notificações de pedidos.

Pacotes são projetos fonte para compilar. Não contêm APK/IPA pré-compilados. Patches somente para 1.6.33+191; para outras bases use o completo, preservando assinatura local. Consulte VALIDACAO_1.6.34.md para testes e limites.
