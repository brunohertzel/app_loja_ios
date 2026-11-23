# Carnes Merces iOS - CORRECAO mobile_scanner / Codemagic (iOS 15.5)

## Sintoma
CocoaPods: mobile_scanner requires a higher minimum deployment target; iOS >= 15.5.

## Arquivo corrigido
`tooling/prepare_ios.py` - passa a configurar 15.5 no Podfile e no projeto Xcode sempre que o Codemagic executar `flutter create` e o gerador do projeto.

## Atualizacao no Windows / GitHub
1. Extraia este ZIP SOBRE a pasta atual `C:\app_flutter\carnes_merces_ios_codemagic`, substituindo `tooling\prepare_ios.py`.
2. Abra o Git Bash e execute:

```bash
cd /c/app_flutter/carnes_merces_ios_codemagic
git add tooling/prepare_ios.py
git commit -m "iOS: corrigir minimo 15.5 para mobile_scanner"
git push origin main
```

3. Confirme que o novo commit aparece em `https://github.com/brunohertzel/app_loja_ios`.
4. Execute um NOVO build no Codemagic do workflow `carnes-merces-ios-unsigned`.

**Nao altere o codemagic.yaml**: ele ja executa o gerador corrigido antes do build.
**Versao do app permanece 1.6.40+198**, nao requer nova licenca ou certificado.

Validacao local: sintaxe Python e geracao simulada de Podfile/projeto Xcode. Ainda depende de build real no Codemagic.
