#!/bin/bash

# Faz o script parar imediatamente se houver algum erro
set -e

echo "===================================================="
echo "  Iniciando a criação de Secrets e .env (Inception) "
echo "===================================================="

# 1. Criação da pasta de segredos
echo "-> Criando pasta 'secrets/'..."
mkdir -p secrets

# 2. Preenchimento dos arquivos de Secrets (Banco de Dados)
echo "-> Gerando segredos do MariaDB..."
echo -n "inception_db"            > secrets/db_name.txt
echo -n "wp_user"                 > secrets/db_user.txt
echo -n "secure_db_password_123"  > secrets/db_password.txt
echo -n "secure_root_password_456" > secrets/db_root_password.txt

# 3. Preenchimento dos arquivos de Secrets (WordPress)
echo "-> Gerando segredos do WordPress..."
echo -n "fabiomaster"             > secrets/wp_admin_user.txt
echo -n "SenhaForteDoAdminNaoColoqueAdminNoNome123" > secrets/wp_admin_password.txt
echo -n "colaborador42"           > secrets/wp_user.txt
echo -n "SenhaDoUsuarioComum42"   > secrets/wp_password.txt

echo "✓ Todos os arquivos em 'secrets/' foram gerados com sucesso."
echo "----------------------------------------------------"

# 4. Criação e preenchimento do srcs/.env
echo "-> Gerando arquivo 'srcs/.env'..."
mkdir -p srcs

cat << 'EOF' > srcs/.env
# ==============================================================================
#                      CONFIGURAÇÕES GLOBAL / USUÁRIO 42
# ==============================================================================
USER_NAME=fabialme

# ==============================================================================
#                      MAPEAMENTO DE PORTAS DO PROJETO
# ==============================================================================
WEB_PORT=443
WP_PORT=9000
DB_PORT=3306
FTP_PORT=2121
FTP_PASV_MIN_PORT=21000
FTP_PASV_MAX_PORT=21010
REDIS_HOST=redis
REDIS_PORT=6379
ADMINER_PORT=8080
STATIC_PORT=8081
PORTAINER_PORT=9001

# ==============================================================================
#                      CONFIGURAÇÕES DE REDE E SITE
# ==============================================================================
DOMAIN_NAME=${USER_NAME}.42.fr
WP_TITLE=Inception_42
WP_ADMIN_EMAIL=${USER_NAME}@42sp.org.br
WP_USER_EMAIL=user42@42sp.org.br

# ==============================================================================
#                      CAMINHOS DOS SECRETS (DENTRO DO CONTAINER)
# ==============================================================================
MYSQL_DATABASE_FILE=/run/secrets/db_name
MYSQL_USER_FILE=/run/secrets/db_user
MYSQL_PASSWORD_FILE=/run/secrets/db_password
MYSQL_ROOT_PASSWORD_FILE=/run/secrets/db_root_password

WP_ADMIN_USER_FILE=/run/secrets/wp_admin_user
WP_ADMIN_PASSWORD_FILE=/run/secrets/wp_admin_password
WP_USER_FILE=/run/secrets/wp_user
WP_USER_PASSWORD_FILE=/run/secrets/wp_password
EOF

echo "✓ Arquivo 'srcs/.env' configurado com sucesso."
echo "===================================================="
echo " Ambiente pronto para rodar! Execute 'make' para subir."
echo "===================================================="
