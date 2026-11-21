#!/usr/bin/env python3
"""Sync PUBLIC visual identity from /api/mobile/v1/bootstrap.php for Codemagic.

Runs once at build time. Never reads admin passwords or writes secrets.
Fails closed: a build must not silently ship the provisional icon/colors.
"""
from __future__ import annotations

import argparse
import json
import os
from pathlib import Path
import re
import shutil
import sys
from urllib.parse import urljoin, urlparse
from urllib.request import Request, urlopen

ROOT = Path(__file__).resolve().parent.parent
API_DEFAULT = 'https://loja.carnesmerces.com.br/api/mobile/v1'


def get_json(url: str) -> dict:
    req = Request(url, headers={
        'Accept': 'application/json',
        'User-Agent': 'SoftEcommerce-Codemagic-iOS-Branding/1.0',
        'X-Soft-Platform': 'IOS',
        'X-Soft-App-Version': '1.6.40',
        'X-Soft-App-Build': '198',
    })
    with urlopen(req, timeout=30) as resp:
        if resp.status != 200:
            raise RuntimeError(f'Bootstrap retornou HTTP {resp.status}')
        data = resp.read(1_000_000)
    parsed = json.loads(data)
    if not isinstance(parsed, dict) or parsed.get('ok') is not True:
        raise RuntimeError('Bootstrap nao retornou ok=true')
    return parsed


def get_image(url: str, destination: Path, api_url: str) -> None:
    resolved = urljoin(api_url.rstrip('/') + '/', url)
    target = urlparse(resolved)
    if target.scheme != 'https' or not target.hostname:
        raise ValueError(f'URL de imagem deve ser HTTPS: {resolved}')
    req = Request(resolved, headers={'User-Agent': 'SoftEcommerce-Codemagic-iOS-Branding/1.0', 'Accept': 'image/png,image/jpeg,image/webp,image/*'})
    with urlopen(req, timeout=30) as resp:
        if resp.status != 200: raise RuntimeError(f'Imagem retornou HTTP {resp.status}: {resolved}')
        data = resp.read(12_000_001)
    if len(data)>12_000_000 or len(data)<80:
        raise RuntimeError(f'Imagem vazia ou grande demais: {resolved}')
    if not (data.startswith(b'\x89PNG\r\n\x1a\n') or data.startswith(b'\xff\xd8\xff') or data[:4]==b'RIFF'):
        raise RuntimeError(f'A URL nao retornou PNG/JPEG/WEBP valido: {resolved}')
    destination.parent.mkdir(parents=True, exist_ok=True)
    destination.write_bytes(data)


def dart_literal(value: str) -> str:
    return "'"+value.replace('\\','\\\\').replace("'","\\'").replace('$','\\$').replace('\n','\\n')+"'"


def update_generated_app_config(app: dict) -> None:
    f=ROOT/'lib/core/config/generated_app_config.dart'
    source=f.read_text('utf-8')
    replacements={
        'appName':str(app['name']),
        'primaryColor':str(app['primary_color']),
        'secondaryColor':str(app['secondary_color']),
        'themeDefault':str(app.get('theme_default') or 'SYSTEM').upper(),
        'logoUrl':str(app.get('logo_url') or ''),
        'splashUrl':str(app.get('splash_url') or ''),
        'iconIosUrl':str(app.get('icon_ios_url') or ''),
    }
    for key, val in replacements.items():
        pattern=rf"(static const String {key}\s*=\s*)(?:'(?:\\.|[^'\\])*'|\"(?:\\.|[^\"\\])*\")\s*;"
        source,count=re.subn(pattern,lambda m:m.group(1)+dart_literal(val)+';',source,count=1,flags=re.S)
        if count!=1: raise RuntimeError(f'Campo de branding nao localizado em generated_app_config.dart: {key}')
    f.write_text(source,encoding='utf-8')


def main() -> None:
    parser=argparse.ArgumentParser()
    parser.add_argument('--api-url',default=os.environ.get('SOFT_API_BASE_URL',API_DEFAULT))
    parser.add_argument('--bootstrap-json', help='Somente teste offline: JSON local de bootstrap')
    parser.add_argument('--images-dir', help='Somente teste offline: imagens locais logo.png, icon_ios.png, splash.png')
    args=parser.parse_args()
    base=args.api_url.rstrip('/')
    if not base.startswith('https://') and not args.bootstrap_json:
        raise SystemExit('A API deve usar HTTPS')
    data=json.loads(Path(args.bootstrap_json).read_text('utf-8')) if args.bootstrap_json else get_json(base+'/bootstrap.php')
    if data.get('ok') is not True: raise SystemExit('Bootstrap nao autorizado ou invalido (ok!=true)')
    app=data.get('app')
    if not isinstance(app,dict):raise SystemExit('Bootstrap nao contem app')
    for field in ('primary_color','secondary_color'):
        if not re.fullmatch(r'#[a-fA-F0-9]{6}',str(app.get(field,''))):
            raise SystemExit(f'Cor de marca ausente ou invalida na API: {field}')
    if not app.get('name') or not app.get('logo_url'):
        raise SystemExit('Logo ou nome da loja ausente no cadastro Mobile: interrompendo build')
    pairs={
        'logo.png':app['logo_url'],
        'icon_ios.png':app.get('icon_ios_url') or app['logo_url'],
        'splash.png':app.get('splash_url') or app['logo_url'],
    }
    cached=ROOT/'tooling/ios_branding_downloads'
    target_asset=ROOT/'assets/brand'
    for name,url in pairs.items():
        dest=cached/name
        if args.images_dir:
            src=Path(args.images_dir)/name
            if not src.is_file():raise SystemExit(f'Arquivo de teste ausente: {src}')
            cached.mkdir(parents=True,exist_ok=True)
            shutil.copyfile(src,dest)
        else:
            get_image(str(url),dest,base)
        if name!='icon_ios.png':
            target_asset.mkdir(parents=True,exist_ok=True)
            shutil.copyfile(dest,target_asset/name)
        print(f'Branding iOS: {name} - {dest.stat().st_size} bytes')
    update_generated_app_config(app)
    snapshot={k:app.get(k) for k in ('name','primary_color','secondary_color','logo_url','splash_url','icon_ios_url','theme_default')}
    (cached/'branding_snapshot.json').write_text(json.dumps(snapshot,ensure_ascii=False,indent=2)+'\n',encoding='utf-8')
    print('Branding sincronizado: '+str(app['name'])+' '+str(app['primary_color'])+' / '+str(app['secondary_color']))

if __name__=='__main__':
    try: main()
    except Exception as exc:
        print('ERRO: falha ao sincronizar identidade visual da loja. O build foi interrompido para evitar um aplicativo com logo/cores incorretos.',file=sys.stderr)
        print(f'Detalhe: {exc}',file=sys.stderr)
        sys.exit(2)
