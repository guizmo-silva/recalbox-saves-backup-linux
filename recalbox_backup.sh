#!/bin/bash

# Script de Backup para Saves do Recalbox
# Autor: Guilherme Silva
# Source: https://github.com/guizmo-silva
# Data: $(date +%Y-%m-%d)

# Configurações
RECALBOX_PATH="//recalbox.local/share/saves"
MOUNT_POINT="/tmp/recalbox_mount"

# Cores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Função para exibir mensagens coloridas
print_error() {
    echo -e "${RED}[ERRO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCESSO]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[AVISO]${NC} $1"
}

print_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

# Função para verificar se os pacotes necessários estão instalados
check_dependencies() {
    local missing_deps=()
    
    if ! command -v smbclient &> /dev/null; then
        missing_deps+=("samba-client")
    fi
    
    if ! command -v mount.cifs &> /dev/null; then
        missing_deps+=("cifs-utils")
    fi
    
    if [ ${#missing_deps[@]} -gt 0 ]; then
        print_error "Dependências críticas não estão instaladas:"
        for dep in "${missing_deps[@]}"; do
            echo "  - $dep"
        done
        return 1
    fi
    
    return 0
}

# Função para verificar conectividade com o Recalbox
check_connectivity() {
    print_info "Verificando conectividade com o Recalbox..."
    
    # Tenta fazer ping no recalbox.local
    if ! ping -c 1 recalbox.local &> /dev/null; then
        print_error "Não foi possível conectar ao recalbox.local"
        print_warning "Verifique se:"
        echo "  - O Recalbox está ligado e conectado à rede"
        echo "  - O compartilhamento SMB está habilitado no Recalbox"
        echo "  - Você está na mesma rede que o Recalbox"
        return 1
    fi
    
    print_success "Conectividade com recalbox.local OK"
    return 0
}

# Função para detectar a distribuição Linux
detect_distribution() {
    if [ -f /etc/os-release ]; then
        . /etc/os-release
        echo "$ID"
    elif [ -f /etc/redhat-release ]; then
        echo "rhel"
    elif [ -f /etc/debian_version ]; then
        echo "debian"
    elif [ -f /etc/arch-release ]; then
        echo "arch"
    else
        echo "unknown"
    fi
}

# Função para mapear pacotes por distribuição
get_package_names() {
    local distro="$1"
    local base_packages=("smbclient" "cifs-utils" "rsync" "pv")
    
    case "$distro" in
        ubuntu|debian|linuxmint|pop)
            # Debian/Ubuntu: samba-client ao invés de smbclient
            echo "samba-client cifs-utils rsync pv"
            ;;
        fedora|rhel|centos|rocky|almalinux)
            # Red Hat based: samba-client ao invés de smbclient
            echo "samba-client cifs-utils rsync pv"
            ;;
        arch|manjaro|endeavouros)
            # Arch: smbclient está no pacote samba
            echo "samba cifs-utils rsync pv"
            ;;
        opensuse|sles)
            # SUSE
            echo "samba-client cifs-utils rsync pv"
            ;;
        *)
            # Fallback genérico
            echo "samba-client cifs-utils rsync pv"
            ;;
    esac
}

# Função para obter o comando de instalação por distribuição
get_install_command() {
    local distro="$1"
    local packages="$2"
    
    case "$distro" in
        ubuntu|debian|linuxmint|pop)
            echo "sudo apt update && sudo apt install -y $packages"
            ;;
        fedora)
            echo "sudo dnf install -y $packages"
            ;;
        rhel|centos|rocky|almalinux)
            echo "sudo yum install -y $packages"
            ;;
        arch|manjaro|endeavouros)
            echo "sudo pacman -S --noconfirm $packages"
            ;;
        opensuse|sles)
            echo "sudo zypper install -y $packages"
            ;;
        *)
            echo ""
            ;;
    esac
}

# Função para instalar dependências automaticamente
install_dependencies() {
    local distro="$1"
    local packages="$2"
    
    print_info "Tentando instalar dependências automaticamente..."
    
    local install_cmd=$(get_install_command "$distro" "$packages")
    
    if [ -z "$install_cmd" ]; then
        print_error "Distribuição não suportada para instalação automática"
        return 1
    fi
    
    print_info "Executando: $install_cmd"
    
    if eval "$install_cmd"; then
        print_success "Dependências instaladas com sucesso!"
        return 0
    else
        print_error "Falha na instalação automática"
        return 1
    fi
}

# Função para verificar dependências separadamente
check_system_dependencies() {
    print_info "Verificando dependências do sistema..."
    
    local missing_deps=()
    local missing_names=()
    
    # Verifica cada dependência
    if ! command -v smbclient &> /dev/null; then
        missing_deps+=("smbclient")
        missing_names+=("samba-client")
    fi
    
    if ! command -v mount.cifs &> /dev/null; then
        missing_deps+=("mount.cifs")
        missing_names+=("cifs-utils")
    fi
    
    if ! command -v rsync &> /dev/null; then
        missing_deps+=("rsync")
        missing_names+=("rsync")
    fi
    
    if ! command -v pv &> /dev/null; then
        missing_deps+=("pv")
        missing_names+=("pv")
    fi
    
    if [ ${#missing_deps[@]} -eq 0 ]; then
        print_success "Todas as dependências estão instaladas!"
        return 0
    fi
    
    # Detecta a distribuição
    local distro=$(detect_distribution)
    print_info "Distribuição detectada: $distro"
    
    print_error "Dependências necessárias não estão instaladas:"
    for i in "${!missing_deps[@]}"; do
        echo "  - ${missing_deps[$i]} (pacote: ${missing_names[$i]})"
    done
    echo
    
    # Obtém nomes corretos dos pacotes para a distribuição
    local packages=$(get_package_names "$distro")
    local install_cmd=$(get_install_command "$distro" "$packages")
    
    if [ -n "$install_cmd" ]; then
        print_info "Comando de instalação sugerido:"
        echo "  $install_cmd"
        echo
        
        read -p "Deseja instalar as dependências automaticamente? (s/N): " AUTO_INSTALL
        
        if [[ $AUTO_INSTALL =~ ^[Ss]$ ]]; then
            if install_dependencies "$distro" "$packages"; then
                print_success "Instalação concluída! Verificando novamente..."
                echo
                # Verifica novamente após a instalação
                return $(check_system_dependencies)
            else
                print_error "Instalação automática falhou"
                print_info "Tente executar manualmente: $install_cmd"
                return 1
            fi
        else
            print_info "Para instalar manualmente, execute:"
            echo "  $install_cmd"
            return 1
        fi
    else
        print_error "Distribuição '$distro' não suportada para instalação automática"
        print_info "Instale manualmente os seguintes pacotes:"
        echo "  $packages"
        return 1
    fi
}

# Função para verificar se o caminho existe
check_path() {
    print_info "Verificando se o caminho dos saves existe..."
    
    # Verifica conectividade
    if ! check_connectivity; then
        return 1
    fi
    
    # Tenta listar o diretório usando smbclient
    if smbclient -L //recalbox.local -N &> /dev/null; then
        if smbclient //recalbox.local/share -N -c "ls saves" &> /dev/null; then
            print_success "Pasta de saves encontrada: $RECALBOX_PATH"
            
            # Mostra informações sobre o conteúdo
            print_info "Conteúdo da pasta saves:"
            smbclient //recalbox.local/share -N -c "ls saves" 2>/dev/null | grep -v "blocks available" | head -10
            
            # Calcula o tamanho total aproximado
            print_info "Calculando tamanho total dos saves..."
            if mount_smb_temp; then
                TOTAL_SIZE=$(du -sh "$MOUNT_POINT" 2>/dev/null | cut -f1)
                FILE_COUNT=$(find "$MOUNT_POINT" -type f 2>/dev/null | wc -l)
                print_info "Tamanho total: $TOTAL_SIZE ($FILE_COUNT arquivos)"
                unmount_smb_temp
            fi
            
            return 0
        else
            print_error "Pasta 'saves' não encontrada no compartilhamento"
            return 1
        fi
    else
        print_error "Não foi possível acessar o compartilhamento SMB"
        print_warning "Verifique se o Recalbox está ligado e conectado à sua rede"
        return 1
    fi
}

# Função para montar temporariamente (para verificações)
mount_smb_temp() {
    if [ ! -d "$MOUNT_POINT" ]; then
        sudo mkdir -p "$MOUNT_POINT"
    fi
    
    if mountpoint -q "$MOUNT_POINT"; then
        return 0
    fi
    
    sudo mount -t cifs "$RECALBOX_PATH" "$MOUNT_POINT" -o guest,uid=$(id -u),gid=$(id -g),iocharset=utf8 &>/dev/null
    return $?
}

# Função para desmontar temporariamente
unmount_smb_temp() {
    if mountpoint -q "$MOUNT_POINT"; then
        sudo umount "$MOUNT_POINT" 2>/dev/null
    fi
}

# Função para montar o compartilhamento SMB
mount_smb() {
    print_info "Montando compartilhamento SMB..."
    
    # Cria o ponto de montagem se não existir
    if [ ! -d "$MOUNT_POINT" ]; then
        sudo mkdir -p "$MOUNT_POINT"
    fi
    
    # Desmonta se já estiver montado
    if mountpoint -q "$MOUNT_POINT"; then
        sudo umount "$MOUNT_POINT" 2>/dev/null
    fi
    
    # Monta o compartilhamento
    if sudo mount -t cifs "$RECALBOX_PATH" "$MOUNT_POINT" -o guest,uid=$(id -u),gid=$(id -g),iocharset=utf8; then
        print_success "Compartilhamento montado em $MOUNT_POINT"
        return 0
    else
        print_error "Falha ao montar o compartilhamento SMB"
        return 1
    fi
}

# Função para copiar arquivos com barra de progresso
copy_with_progress() {
    local source="$1"
    local destination="$2"
    
    print_info "Calculando tamanho total dos arquivos..."
    
    # Calcula o tamanho total em bytes
    local total_size=$(du -sb "$source" | cut -f1)
    local total_size_human=$(du -sh "$source" | cut -f1)
    
    print_info "Tamanho total a copiar: $total_size_human"
    print_info "Iniciando cópia com barra de progresso..."
    echo
    
    # Verifica se o pv está disponível
    if command -v pv &> /dev/null; then
        # Usa tar com pv para mostrar progresso
        tar -cf - -C "$(dirname "$source")" "$(basename "$source")" | \
        pv -s "$total_size" -p -t -e -r -b | \
        tar -xf - -C "$destination"
        
        local exit_code=${PIPESTATUS[0]}
        echo
        
        if [ $exit_code -eq 0 ]; then
            print_success "Cópia concluída com sucesso!"
            return 0
        else
            print_error "Erro durante a cópia (código $exit_code)"
            return 1
        fi
    else
        # Fallback para rsync com progresso básico
        print_warning "Usando rsync (progresso menos detalhado)"
        if rsync -av --progress "$source/" "$destination/$(basename "$source")/"; then
            print_success "Cópia concluída com sucesso!"
            return 0
        else
            print_error "Erro durante a cópia com rsync"
            return 1
        fi
    fi
}

# Função para desmontar o compartilhamento SMB
unmount_smb() {
    if mountpoint -q "$MOUNT_POINT"; then
        print_info "Desmontando compartilhamento..."
        sudo umount "$MOUNT_POINT"
        print_success "Compartilhamento desmontado"
    fi
}

# Função para realizar o backup
perform_backup() {
    print_info "Iniciando processo de backup..."
    
    # Verifica se o caminho existe primeiro
    print_info "Verificando acesso ao Recalbox..."
    if ! check_connectivity; then
        print_error "Não é possível continuar com o backup"
        return 1
    fi
    
    # Solicita o diretório de destino
    echo
    read -p "Digite o caminho completo onde deseja salvar o backup: " BACKUP_DEST
    
    # Verifica se o usuário digitou algo
    if [ -z "$BACKUP_DEST" ]; then
        print_error "Caminho de destino não pode estar vazio"
        return 1
    fi
    
    # Expande ~ para o diretório home se necessário
    BACKUP_DEST="${BACKUP_DEST/#\~/$HOME}"
    
    # Verifica se o diretório de destino existe
    if [ ! -d "$BACKUP_DEST" ]; then
        print_warning "Diretório de destino não existe"
        read -p "Deseja criar o diretório? (s/N): " CREATE_DIR
        if [[ $CREATE_DIR =~ ^[Ss]$ ]]; then
            if mkdir -p "$BACKUP_DEST"; then
                print_success "Diretório criado: $BACKUP_DEST"
            else
                print_error "Falha ao criar diretório: $BACKUP_DEST"
                return 1
            fi
        else
            print_error "Backup cancelado"
            return 1
        fi
    fi
    
    # Verifica se o diretório de destino é gravável
    if [ ! -w "$BACKUP_DEST" ]; then
        print_error "Sem permissão de escrita no diretório: $BACKUP_DEST"
        return 1
    fi
    
    # Monta o compartilhamento SMB
    if ! mount_smb; then
        return 1
    fi
    
    # Cria nome do backup com timestamp
    TIMESTAMP=$(date +%d-%m-%Y_%H%M)
    BACKUP_NAME="recalbox_saves_backup_$TIMESTAMP"
    BACKUP_FULL_PATH="$BACKUP_DEST/$BACKUP_NAME"
    
    print_info "Copiando saves para: $BACKUP_FULL_PATH"
    
    # Cria o diretório de destino
    mkdir -p "$BACKUP_FULL_PATH"
    
    # Realiza a cópia com barra de progresso
    if copy_with_progress "$MOUNT_POINT" "$BACKUP_DEST"; then
        # Renomeia o diretório copiado para o nome correto
        if [ -d "$BACKUP_DEST/$(basename "$MOUNT_POINT")" ]; then
            mv "$BACKUP_DEST/$(basename "$MOUNT_POINT")" "$BACKUP_FULL_PATH"
        fi
        
        print_success "Backup realizado com sucesso!"
        
        # Mostra informações do backup
        BACKUP_SIZE=$(du -sh "$BACKUP_FULL_PATH" | cut -f1)
        FILE_COUNT=$(find "$BACKUP_FULL_PATH" -type f | wc -l)
        
        echo
        print_info "Informações do backup:"
        echo "  - Local: $BACKUP_FULL_PATH"
        echo "  - Tamanho: $BACKUP_SIZE"
        echo "  - Arquivos: $FILE_COUNT"
        echo "  - Data: $(date)"
        
    else
        print_error "Falha ao realizar o backup"
        # Remove diretório parcial se existir
        [ -d "$BACKUP_FULL_PATH" ] && rm -rf "$BACKUP_FULL_PATH"
        unmount_smb
        return 1
    fi
    
    # Desmonta o compartilhamento
    unmount_smb
    
    return 0
}

# Função para exibir o menu
show_menu() {
    clear
    echo "=================================="
    echo "   BACKUP DE SAVES - RECALBOX    "
    echo "=================================="
    echo
    echo "1) Verificar dependências do sistema"
    echo "2) Verificar caminho dos saves"
    echo "3) Realizar backup"
    echo "4) Sair"
    echo
}

# Função principal
main() {
    # Verifica se está rodando como root desnecessariamente
    if [ "$EUID" -eq 0 ]; then
        print_warning "Não é recomendado executar este script como root"
        print_info "Execute como usuário normal (o script pedirá sudo quando necessário)"
    fi
    
    while true; do
        show_menu
        read -p "Escolha uma opção [1-4]: " OPTION
        
        case $OPTION in
            1)
                echo
                check_system_dependencies
                echo
                read -p "Pressione Enter para continuar..."
                ;;
            2)
                echo
                check_path
                echo
                read -p "Pressione Enter para continuar..."
                ;;
            3)
                echo
                perform_backup
                echo
                read -p "Pressione Enter para continuar..."
                ;;
            4)
                print_info "Saindo do script..."
                # Cleanup: desmonta se estiver montado
                unmount_smb 2>/dev/null
                exit 0
                ;;
            *)
                print_error "Opção inválida! Escolha entre 1, 2, 3 ou 4."
                sleep 2
                ;;
        esac
    done
}

# Tratamento de sinais para cleanup
trap 'unmount_smb 2>/dev/null; exit 1' INT TERM

# Executa a função principal
main