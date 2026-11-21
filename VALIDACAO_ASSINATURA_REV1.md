# Validação da assinatura Android — REV1

Executado em Linux com JDK 17, usando o mesmo Java fonte que será chamado pelo JDK do Gradle: criação real do JKS/RSA; validação de senhas/alias; preservação de chave/configuração existentes; reaproveitamento em outro projeto; recusa de chave debug; recusa de senha incorreta; recusa de backup incompleto sem regenerar; preservação de keystore solto no projeto; caminhos com espaços/acentos; duas preparações concorrentes com a mesma chave; senhas ausentes da saída.

O patch 1.6.29+187 → 1.6.29+187 REV1 foi aplicado a uma cópia limpa da versão anterior e reproduziu o pacote completo byte a byte. ZIPs íntegros e sem chave privada/senhas incluídas. Código Dart e recursos do aplicativo permanecem idênticos à 1.6.29.

Não houve build Flutter/Gradle completo nem execução em Windows nesta máquina. Os testes anteriores de API/banco e análise Dart permanecem descritos em VALIDACAO_1.6.29.md. Esta revisão altera preparação e documentação do build Android; não altera API, banco ou iOS.
