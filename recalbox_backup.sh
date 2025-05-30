#!/bin/bash

# Script de Backup para Saves do Recalbox
# SOURCE: https://github.com/guizmo-silva/recalbox-saves-backup-linux
# Author: Guilherme "Guizmo" Silva
# Data: $(date +%Y-%m-%d)

# Configurações
RECALBOX_PATH="//recalbox.local/share/saves"
MOUNT_POINT="/tmp/recalbox_mount"
LANGUAGE="pt" # Idioma padrão

# Cores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Textos em múltiplos idiomas
declare -A TEXTS

# Português
TEXTS[pt_title]="BACKUP DE SAVES - RECALBOX"
TEXTS[pt_menu_deps]="Verificar dependências do sistema"
TEXTS[pt_menu_path]="Verificar caminho dos saves"
TEXTS[pt_menu_backup]="Realizar backup"
TEXTS[pt_menu_restore]="Restaurar saves"
TEXTS[pt_menu_exit]="Sair"
TEXTS[pt_choose_option]="Escolha uma opção"
TEXTS[pt_press_enter]="Pressione Enter para continuar..."
TEXTS[pt_invalid_option]="Opção inválida! Escolha entre"
TEXTS[pt_exiting]="Saindo do script..."
TEXTS[pt_error]="ERRO"
TEXTS[pt_success]="SUCESSO"
TEXTS[pt_warning]="AVISO"
TEXTS[pt_info]="INFO"
TEXTS[pt_checking_deps]="Verificando dependências do sistema..."
TEXTS[pt_all_deps_ok]="Todas as dependências estão instaladas!"
TEXTS[pt_missing_deps]="Dependências necessárias não estão instaladas:"
TEXTS[pt_distro_detected]="Distribuição detectada:"
TEXTS[pt_install_cmd]="Comando de instalação sugerido:"
TEXTS[pt_install_auto]="Deseja instalar as dependências automaticamente? (s/N):"
TEXTS[pt_installing]="Tentando instalar dependências automaticamente..."
TEXTS[pt_executing]="Executando:"
TEXTS[pt_install_success]="Dependências instaladas com sucesso!"
TEXTS[pt_install_failed]="Falha na instalação automática"
TEXTS[pt_distro_unsupported]="Distribuição não suportada para instalação automática"
TEXTS[pt_install_manually]="Para instalar manualmente, execute:"
TEXTS[pt_checking_connectivity]="Verificando conectividade com o Recalbox..."
TEXTS[pt_connectivity_failed]="Não foi possível conectar ao recalbox.local"
TEXTS[pt_check_network]="Verifique se:"
TEXTS[pt_recalbox_on]="O Recalbox está ligado e conectado à rede"
TEXTS[pt_smb_enabled]="O compartilhamento SMB está habilitado no Recalbox"
TEXTS[pt_same_network]="Você está na mesma rede que o Recalbox"
TEXTS[pt_connectivity_ok]="Conectividade com recalbox.local OK"
TEXTS[pt_checking_path]="Verificando se o caminho dos saves existe..."
TEXTS[pt_saves_found]="Pasta de saves encontrada:"
TEXTS[pt_saves_content]="Conteúdo da pasta saves:"
TEXTS[pt_calculating_size]="Calculando tamanho total dos saves..."
TEXTS[pt_total_size]="Tamanho total:"
TEXTS[pt_saves_not_found]="Pasta 'saves' não encontrada no compartilhamento"
TEXTS[pt_smb_access_failed]="Não foi possível acessar o compartilhamento SMB"
TEXTS[pt_check_smb_enabled]="Verifique se o compartilhamento está habilitado no Recalbox"
TEXTS[pt_mounting_smb]="Montando compartilhamento SMB..."
TEXTS[pt_mount_success]="Compartilhamento montado em"
TEXTS[pt_mount_failed]="Falha ao montar o compartilhamento SMB"
TEXTS[pt_unmounting]="Desmontando compartilhamento..."
TEXTS[pt_unmount_success]="Compartilhamento desmontado"
TEXTS[pt_starting_backup]="Iniciando processo de backup..."
TEXTS[pt_checking_recalbox]="Verificando acesso ao Recalbox..."
TEXTS[pt_cannot_continue]="Não é possível continuar com o backup"
TEXTS[pt_enter_dest_path]="Digite o caminho completo onde deseja salvar o backup:"
TEXTS[pt_dest_empty]="Caminho de destino não pode estar vazio"
TEXTS[pt_dest_not_exist]="Diretório de destino não existe"
TEXTS[pt_create_dir]="Deseja criar o diretório? (s/N):"
TEXTS[pt_dir_created]="Diretório criado:"
TEXTS[pt_create_dir_failed]="Falha ao criar diretório:"
TEXTS[pt_backup_cancelled]="Backup cancelado"
TEXTS[pt_no_write_permission]="Sem permissão de escrita no diretório:"
TEXTS[pt_copying_to]="Copiando saves para:"
TEXTS[pt_backup_success]="Backup realizado com sucesso!"
TEXTS[pt_backup_failed]="Falha ao realizar o backup"
TEXTS[pt_backup_info]="Informações do backup:"
TEXTS[pt_location]="Local:"
TEXTS[pt_size]="Tamanho:"
TEXTS[pt_files]="Arquivos:"
TEXTS[pt_date]="Data:"
TEXTS[pt_calculating_total]="Calculando tamanho total dos arquivos..."
TEXTS[pt_total_copy]="Tamanho total a copiar:"
TEXTS[pt_starting_copy]="Iniciando cópia com barra de progresso..."
TEXTS[pt_copy_success]="Cópia concluída com sucesso!"
TEXTS[pt_copy_error]="Erro durante a cópia (código"
TEXTS[pt_using_rsync]="Usando rsync (progresso menos detalhado)"
TEXTS[pt_rsync_error]="Erro durante a cópia com rsync"
TEXTS[pt_root_warning]="Não é recomendado executar este script como root"
TEXTS[pt_run_as_user]="Execute como usuário normal (o script pedirá sudo quando necessário)"
TEXTS[pt_or]="ou"
TEXTS[pt_starting_restore]="Iniciando processo de restauração..."
TEXTS[pt_enter_backup_path]="Digite o caminho completo da pasta de backup:"
TEXTS[pt_backup_path_empty]="Caminho do backup não pode estar vazio"
TEXTS[pt_backup_not_exist]="Pasta de backup não existe:"
TEXTS[pt_backup_not_readable]="Sem permissão de leitura na pasta:"
TEXTS[pt_checking_backup_content]="Verificando conteúdo do backup..."
TEXTS[pt_backup_seems_empty]="A pasta de backup parece estar vazia"
TEXTS[pt_found_folders]="Encontradas as seguintes pastas:"
TEXTS[pt_confirm_restore]="Deseja continuar com a restauração? (s/N):"
TEXTS[pt_restore_cancelled]="Restauração cancelada"
TEXTS[pt_copying_from]="Copiando saves de:"
TEXTS[pt_restore_success]="Restauração realizada com sucesso!"
TEXTS[pt_restore_failed]="Falha ao realizar a restauração"
TEXTS[pt_restore_info]="Informações da restauração:"
TEXTS[pt_folders_copied]="Pastas copiadas:"
TEXTS[pt_copied_success]="copiada com sucesso"
TEXTS[pt_copy_failed]="Falha ao copiar"

# Inglês
TEXTS[en_title]="RECALBOX SAVES BACKUP"
TEXTS[en_menu_deps]="Check system dependencies"
TEXTS[en_menu_path]="Check saves path"
TEXTS[en_menu_backup]="Perform backup"
TEXTS[en_menu_restore]="Restore saves"
TEXTS[en_menu_exit]="Exit"
TEXTS[en_choose_option]="Choose an option"
TEXTS[en_press_enter]="Press Enter to continue..."
TEXTS[en_invalid_option]="Invalid option! Choose between"
TEXTS[en_exiting]="Exiting script..."
TEXTS[en_error]="ERROR"
TEXTS[en_success]="SUCCESS"
TEXTS[en_warning]="WARNING"
TEXTS[en_info]="INFO"
TEXTS[en_checking_deps]="Checking system dependencies..."
TEXTS[en_all_deps_ok]="All dependencies are installed!"
TEXTS[en_missing_deps]="Required dependencies are not installed:"
TEXTS[en_distro_detected]="Distribution detected:"
TEXTS[en_install_cmd]="Suggested install command:"
TEXTS[en_install_auto]="Do you want to install dependencies automatically? (y/N):"
TEXTS[en_installing]="Trying to install dependencies automatically..."
TEXTS[en_executing]="Executing:"
TEXTS[en_install_success]="Dependencies installed successfully!"
TEXTS[en_install_failed]="Automatic installation failed"
TEXTS[en_distro_unsupported]="Distribution not supported for automatic installation"
TEXTS[en_install_manually]="To install manually, run:"
TEXTS[en_checking_connectivity]="Checking connectivity with Recalbox..."
TEXTS[en_connectivity_failed]="Could not connect to recalbox.local"
TEXTS[en_check_network]="Please check that:"
TEXTS[en_recalbox_on]="Recalbox is on and connected to the network"
TEXTS[en_smb_enabled]="SMB sharing is enabled on Recalbox"
TEXTS[en_same_network]="You are on the same network as Recalbox"
TEXTS[en_connectivity_ok]="Connectivity with recalbox.local OK"
TEXTS[en_checking_path]="Checking if saves path exists..."
TEXTS[en_saves_found]="Saves folder found:"
TEXTS[en_saves_content]="Saves folder contents:"
TEXTS[en_calculating_size]="Calculating total saves size..."
TEXTS[en_total_size]="Total size:"
TEXTS[en_saves_not_found]="'saves' folder not found in share"
TEXTS[en_smb_access_failed]="Could not access SMB share"
TEXTS[en_check_smb_enabled]="Check if sharing is enabled on Recalbox"
TEXTS[en_mounting_smb]="Mounting SMB share..."
TEXTS[en_mount_success]="Share mounted at"
TEXTS[en_mount_failed]="Failed to mount SMB share"
TEXTS[en_unmounting]="Unmounting share..."
TEXTS[en_unmount_success]="Share unmounted"
TEXTS[en_starting_backup]="Starting backup process..."
TEXTS[en_checking_recalbox]="Checking Recalbox access..."
TEXTS[en_cannot_continue]="Cannot continue with backup"
TEXTS[en_enter_dest_path]="Enter the full path where you want to save the backup:"
TEXTS[en_dest_empty]="Destination path cannot be empty"
TEXTS[en_dest_not_exist]="Destination directory does not exist"
TEXTS[en_create_dir]="Do you want to create the directory? (y/N):"
TEXTS[en_dir_created]="Directory created:"
TEXTS[en_create_dir_failed]="Failed to create directory:"
TEXTS[en_backup_cancelled]="Backup cancelled"
TEXTS[en_no_write_permission]="No write permission in directory:"
TEXTS[en_copying_to]="Copying saves to:"
TEXTS[en_backup_success]="Backup completed successfully!"
TEXTS[en_backup_failed]="Failed to perform backup"
TEXTS[en_backup_info]="Backup information:"
TEXTS[en_location]="Location:"
TEXTS[en_size]="Size:"
TEXTS[en_files]="Files:"
TEXTS[en_date]="Date:"
TEXTS[en_calculating_total]="Calculating total file size..."
TEXTS[en_total_copy]="Total size to copy:"
TEXTS[en_starting_copy]="Starting copy with progress bar..."
TEXTS[en_copy_success]="Copy completed successfully!"
TEXTS[en_copy_error]="Error during copy (code"
TEXTS[en_using_rsync]="Using rsync (less detailed progress)"
TEXTS[en_rsync_error]="Error during rsync copy"
TEXTS[en_root_warning]="It's not recommended to run this script as root"
TEXTS[en_run_as_user]="Run as normal user (script will ask for sudo when needed)"
TEXTS[en_or]="or"
TEXTS[en_starting_restore]="Starting restore process..."
TEXTS[en_enter_backup_path]="Enter the full path to the backup folder:"
TEXTS[en_backup_path_empty]="Backup path cannot be empty"
TEXTS[en_backup_not_exist]="Backup folder does not exist:"
TEXTS[en_backup_not_readable]="No read permission in folder:"
TEXTS[en_checking_backup_content]="Checking backup content..."
TEXTS[en_backup_seems_empty]="The backup folder seems to be empty"
TEXTS[en_found_folders]="Found the following folders:"
TEXTS[en_confirm_restore]="Do you want to continue with the restore? (y/N):"
TEXTS[en_restore_cancelled]="Restore cancelled"
TEXTS[en_copying_from]="Copying saves from:"
TEXTS[en_restore_success]="Restore completed successfully!"
TEXTS[en_restore_failed]="Failed to perform restore"
TEXTS[en_restore_info]="Restore information:"
TEXTS[en_folders_copied]="Folders copied:"
TEXTS[en_copied_success]="copied successfully"
TEXTS[en_copy_failed]="Failed to copy"

# Espanhol
TEXTS[es_title]="RESPALDO DE SAVES - RECALBOX"
TEXTS[es_menu_deps]="Verificar dependencias del sistema"
TEXTS[es_menu_path]="Verificar ruta de saves"
TEXTS[es_menu_backup]="Realizar respaldo"
TEXTS[es_menu_restore]="Restaurar saves"
TEXTS[es_menu_exit]="Salir"
TEXTS[es_choose_option]="Elige una opción"
TEXTS[es_press_enter]="Presiona Enter para continuar..."
TEXTS[es_invalid_option]="¡Opción inválida! Elige entre"
TEXTS[es_exiting]="Saliendo del script..."
TEXTS[es_error]="ERROR"
TEXTS[es_success]="ÉXITO"
TEXTS[es_warning]="ADVERTENCIA"
TEXTS[es_info]="INFO"
TEXTS[es_checking_deps]="Verificando dependencias del sistema..."
TEXTS[es_all_deps_ok]="¡Todas las dependencias están instaladas!"
TEXTS[es_missing_deps]="Dependencias requeridas no están instaladas:"
TEXTS[es_distro_detected]="Distribución detectada:"
TEXTS[es_install_cmd]="Comando de instalación sugerido:"
TEXTS[es_install_auto]="¿Deseas instalar las dependencias automáticamente? (s/N):"
TEXTS[es_installing]="Intentando instalar dependencias automáticamente..."
TEXTS[es_executing]="Ejecutando:"
TEXTS[es_install_success]="¡Dependencias instaladas exitosamente!"
TEXTS[es_install_failed]="La instalación automática falló"
TEXTS[es_distro_unsupported]="Distribución no soportada para instalación automática"
TEXTS[es_install_manually]="Para instalar manualmente, ejecuta:"
TEXTS[es_checking_connectivity]="Verificando conectividad con Recalbox..."
TEXTS[es_connectivity_failed]="No se pudo conectar a recalbox.local"
TEXTS[es_check_network]="Verifica que:"
TEXTS[es_recalbox_on]="Recalbox esté encendido y conectado a la red"
TEXTS[es_smb_enabled]="El compartir SMB esté habilitado en Recalbox"
TEXTS[es_same_network]="Estés en la misma red que Recalbox"
TEXTS[es_connectivity_ok]="Conectividad con recalbox.local OK"
TEXTS[es_checking_path]="Verificando si la ruta de saves existe..."
TEXTS[es_saves_found]="Carpeta de saves encontrada:"
TEXTS[es_saves_content]="Contenido de la carpeta saves:"
TEXTS[es_calculating_size]="Calculando tamaño total de saves..."
TEXTS[es_total_size]="Tamaño total:"
TEXTS[es_saves_not_found]="Carpeta 'saves' no encontrada en el compartir"
TEXTS[es_smb_access_failed]="No se pudo acceder al compartir SMB"
TEXTS[es_check_smb_enabled]="Verifica que el compartir esté habilitado en Recalbox"
TEXTS[es_mounting_smb]="Montando compartir SMB..."
TEXTS[es_mount_success]="Compartir montado en"
TEXTS[es_mount_failed]="Falló al montar el compartir SMB"
TEXTS[es_unmounting]="Desmontando compartir..."
TEXTS[es_unmount_success]="Compartir desmontado"
TEXTS[es_starting_backup]="Iniciando proceso de respaldo..."
TEXTS[es_checking_recalbox]="Verificando acceso a Recalbox..."
TEXTS[es_cannot_continue]="No se puede continuar con el respaldo"
TEXTS[es_enter_dest_path]="Ingresa la ruta completa donde deseas guardar el respaldo:"
TEXTS[es_dest_empty]="La ruta de destino no puede estar vacía"
TEXTS[es_dest_not_exist]="El directorio de destino no existe"
TEXTS[es_create_dir]="¿Deseas crear el directorio? (s/N):"
TEXTS[es_dir_created]="Directorio creado:"
TEXTS[es_create_dir_failed]="Falló al crear directorio:"
TEXTS[es_backup_cancelled]="Respaldo cancelado"
TEXTS[es_no_write_permission]="Sin permisos de escritura en el directorio:"
TEXTS[es_copying_to]="Copiando saves a:"
TEXTS[es_backup_success]="¡Respaldo realizado exitosamente!"
TEXTS[es_backup_failed]="Falló al realizar el respaldo"
TEXTS[es_backup_info]="Información del respaldo:"
TEXTS[es_location]="Ubicación:"
TEXTS[es_size]="Tamaño:"
TEXTS[es_files]="Archivos:"
TEXTS[es_date]="Fecha:"
TEXTS[es_calculating_total]="Calculando tamaño total de archivos..."
TEXTS[es_total_copy]="Tamaño total a copiar:"
TEXTS[es_starting_copy]="Iniciando copia con barra de progreso..."
TEXTS[es_copy_success]="¡Copia completada exitosamente!"
TEXTS[es_copy_error]="Error durante la copia (código"
TEXTS[es_using_rsync]="Usando rsync (progreso menos detallado)"
TEXTS[es_rsync_error]="Error durante la copia con rsync"
TEXTS[es_root_warning]="No se recomienda ejecutar este script como root"
TEXTS[es_run_as_user]="Ejecuta como usuario normal (el script pedirá sudo cuando sea necesario)"
TEXTS[es_or]="o"
TEXTS[es_starting_restore]="Iniciando proceso de restauración..."
TEXTS[es_enter_backup_path]="Ingresa la ruta completa de la carpeta de respaldo:"
TEXTS[es_backup_path_empty]="La ruta del respaldo no puede estar vacía"
TEXTS[es_backup_not_exist]="La carpeta de respaldo no existe:"
TEXTS[es_backup_not_readable]="Sin permisos de lectura en la carpeta:"
TEXTS[es_checking_backup_content]="Verificando contenido del respaldo..."
TEXTS[es_backup_seems_empty]="La carpeta de respaldo parece estar vacía"
TEXTS[es_found_folders]="Se encontraron las siguientes carpetas:"
TEXTS[es_confirm_restore]="¿Deseas continuar con la restauración? (s/N):"
TEXTS[es_restore_cancelled]="Restauración cancelada"
TEXTS[es_copying_from]="Copiando saves desde:"
TEXTS[es_restore_success]="¡Restauración realizada exitosamente!"
TEXTS[es_restore_failed]="Falló al realizar la restauración"
TEXTS[es_restore_info]="Información de la restauración:"
TEXTS[es_folders_copied]="Carpetas copiadas:"
TEXTS[es_copied_success]="copiada exitosamente"
TEXTS[es_copy_failed]="Falló al copiar"

# Função para obter texto traduzido
get_text() {
    local key="${LANGUAGE}_$1"
    echo "${TEXTS[$key]:-$1}"
}

# Função para exibir mensagens coloridas
print_error() {
    echo -e "${RED}[$(get_text 'error')]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[$(get_text 'success')]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[$(get_text 'warning')]${NC} $1"
}

print_info() {
    echo -e "${BLUE}[$(get_text 'info')]${NC} $1"
}

# Função para escolher idioma
select_language() {
    clear
    echo "=================================="
    echo "    LANGUAGE / IDIOMA / IDIOMA    "
    echo "=================================="
    echo
    echo "1) Português (Brasil)"
    echo "2) English (US)"
    echo "3) Español (ES)"
    echo
    read -p "Choose your language / Escolha seu idioma / Elige tu idioma [1-3]: " LANG_OPTION
    
    case $LANG_OPTION in
        1)
            LANGUAGE="pt"
            ;;
        2)
            LANGUAGE="en"
            ;;
        3)
            LANGUAGE="es"
            ;;
        *)
            echo "Invalid option / Opção inválida / Opción inválida. Using Portuguese / Usando português."
            LANGUAGE="pt"
            sleep 2
            ;;
    esac
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
    
    case "$distro" in
        ubuntu|debian|linuxmint|pop)
            echo "samba-client cifs-utils rsync pv"
            ;;
        fedora|rhel|centos|rocky|almalinux)
            echo "samba-client cifs-utils rsync pv"
            ;;
        arch|manjaro|endeavouros)
            echo "samba cifs-utils rsync pv"
            ;;
        opensuse|sles)
            echo "samba-client cifs-utils rsync pv"
            ;;
        *)
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
    
    print_info "$(get_text 'installing')"
    
    local install_cmd=$(get_install_command "$distro" "$packages")
    
    if [ -z "$install_cmd" ]; then
        print_error "$(get_text 'distro_unsupported')"
        return 1
    fi
    
    print_info "$(get_text 'executing') $install_cmd"
    
    if eval "$install_cmd"; then
        print_success "$(get_text 'install_success')"
        return 0
    else
        print_error "$(get_text 'install_failed')"
        return 1
    fi
}

# Função para verificar dependências separadamente
check_system_dependencies() {
    print_info "$(get_text 'checking_deps')"
    
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
        print_success "$(get_text 'all_deps_ok')"
        return 0
    fi
    
    # Detecta a distribuição
    local distro=$(detect_distribution)
    print_info "$(get_text 'distro_detected') $distro"
    
    print_error "$(get_text 'missing_deps')"
    for i in "${!missing_deps[@]}"; do
        echo "  - ${missing_deps[$i]} (pacote: ${missing_names[$i]})"
    done
    echo
    
    # Obtém nomes corretos dos pacotes para a distribuição
    local packages=$(get_package_names "$distro")
    local install_cmd=$(get_install_command "$distro" "$packages")
    
    if [ -n "$install_cmd" ]; then
        print_info "$(get_text 'install_cmd')"
        echo "  $install_cmd"
        echo
        
        local prompt_text="$(get_text 'install_auto')"
        read -p "$prompt_text " AUTO_INSTALL
        
        local yes_pattern="^[SsYy]$"
        if [[ $AUTO_INSTALL =~ $yes_pattern ]]; then
            if install_dependencies "$distro" "$packages"; then
                print_success "$(get_text 'install_success') $(get_text 'checking_deps')"
                echo
                # Verifica novamente após a instalação
                return $(check_system_dependencies)
            else
                print_error "$(get_text 'install_failed')"
                print_info "$(get_text 'install_manually') $install_cmd"
                return 1
            fi
        else
            print_info "$(get_text 'install_manually')"
            echo "  $install_cmd"
            return 1
        fi
    else
        print_error "$(get_text 'distro_unsupported') '$distro'"
        print_info "$(get_text 'install_manually'):"
        echo "  $packages"
        return 1
    fi
}

# Função para verificar conectividade com o Recalbox
check_connectivity() {
    print_info "$(get_text 'checking_connectivity')"
    
    # Tenta fazer ping no recalbox.local
    if ! ping -c 1 recalbox.local &> /dev/null; then
        print_error "$(get_text 'connectivity_failed')"
        print_warning "$(get_text 'check_network')"
        echo "  - $(get_text 'recalbox_on')"
        echo "  - $(get_text 'smb_enabled')"
        echo "  - $(get_text 'same_network')"
        return 1
    fi
    
    print_success "$(get_text 'connectivity_ok')"
    return 0
}

# Função para realizar a restauração dos saves
perform_restore() {
    print_info "$(get_text 'starting_restore')"
    
    # Verifica se o caminho do Recalbox existe primeiro
    print_info "$(get_text 'checking_recalbox')"
    if ! check_connectivity; then
        print_error "$(get_text 'cannot_continue')"
        return 1
    fi
    
    # Solicita o diretório do backup
    echo
    read -p "$(get_text 'enter_backup_path') " BACKUP_PATH
    
    # Verifica se o usuário digitou algo
    if [ -z "$BACKUP_PATH" ]; then
        print_error "$(get_text 'backup_path_empty')"
        return 1
    fi
    
    # Expande ~ para o diretório home se necessário
    BACKUP_PATH="${BACKUP_PATH/#\~/$HOME}"
    
    # Verifica se o diretório de backup existe
    if [ ! -d "$BACKUP_PATH" ]; then
        print_error "$(get_text 'backup_not_exist') $BACKUP_PATH"
        return 1
    fi
    
    # Verifica se o diretório de backup é legível
    if [ ! -r "$BACKUP_PATH" ]; then
        print_error "$(get_text 'backup_not_readable') $BACKUP_PATH"
        return 1
    fi
    
    # Verifica o conteúdo do backup
    print_info "$(get_text 'checking_backup_content')"
    
    # Lista as pastas dentro do backup (ignora arquivos)
    local folders=($(find "$BACKUP_PATH" -maxdepth 1 -type d ! -path "$BACKUP_PATH" | sort))
    
    if [ ${#folders[@]} -eq 0 ]; then
        print_error "$(get_text 'backup_seems_empty')"
        return 1
    fi
    
    # Mostra as pastas encontradas
    print_info "$(get_text 'found_folders')"
    for folder in "${folders[@]}"; do
        local folder_name=$(basename "$folder")
        local folder_size=$(du -sh "$folder" 2>/dev/null | cut -f1)
        local file_count=$(find "$folder" -type f 2>/dev/null | wc -l)
        echo "  - $folder_name ($folder_size, $file_count $(get_text 'files'))"
    done
    echo
    
    # Confirma a restauração
    read -p "$(get_text 'confirm_restore') " CONFIRM_RESTORE
    local yes_pattern="^[SsYy]$"
    if [[ ! $CONFIRM_RESTORE =~ $yes_pattern ]]; then
        print_error "$(get_text 'restore_cancelled')"
        return 1
    fi
    
    # Monta o compartilhamento SMB
    if ! mount_smb; then
        return 1
    fi
    
    print_info "$(get_text 'copying_from') $BACKUP_PATH"
    echo
    
    # Conta total de arquivos para progresso
    local total_files=$(find "${folders[@]}" -type f 2>/dev/null | wc -l)
    local copied_files=0
    local copied_folders=0
    
    # Copia cada pasta individualmente
    for folder in "${folders[@]}"; do
        local folder_name=$(basename "$folder")
        local folder_size=$(du -sh "$folder" 2>/dev/null | cut -f1)
        local files_in_folder=$(find "$folder" -type f 2>/dev/null | wc -l)
        
        print_info "$(get_text 'copying_to') $folder_name ($folder_size, $files_in_folder $(get_text 'files'))..."
        
        # Usa rsync para cópia simples e confiável
        if rsync -a "$folder/" "$MOUNT_POINT/$folder_name/" 2>/dev/null; then
            ((copied_folders++))
            copied_files=$((copied_files + files_in_folder))
            print_success "  ✓ $folder_name $(get_text 'copied_success')"
        else
            print_error "  ✗ $(get_text 'copy_failed') $folder_name"
        fi
    done
    
    # Verifica se pelo menos uma pasta foi copiada
    if [ $copied_folders -gt 0 ]; then
        print_success "$(get_text 'restore_success')"
        
        # Mostra informações da restauração
        echo
        print_info "$(get_text 'restore_info')"
        echo "  - $(get_text 'location') $RECALBOX_PATH"
        echo "  - $(get_text 'folders_copied') $copied_folders"
        echo "  - $(get_text 'files') $copied_files"
        echo "  - $(get_text 'date') $(date)"
        
    else
        print_error "$(get_text 'restore_failed')"
        unmount_smb
        return 1
    fi
    
    # Desmonta o compartilhamento
    unmount_smb
    
    return 0
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

# Função para verificar se o caminho existe
check_path() {
    print_info "$(get_text 'checking_path')"
    
    # Verifica conectividade
    if ! check_connectivity; then
        return 1
    fi
    
    # Tenta listar o diretório usando smbclient
    if smbclient -L //recalbox.local -N &> /dev/null; then
        if smbclient //recalbox.local/share -N -c "ls saves" &> /dev/null; then
            print_success "$(get_text 'saves_found') $RECALBOX_PATH"
            
            # Mostra informações sobre o conteúdo
            print_info "$(get_text 'saves_content')"
            smbclient //recalbox.local/share -N -c "ls saves" 2>/dev/null | grep -v "blocks available" | head -10
            
            # Calcula o tamanho total aproximado
            print_info "$(get_text 'calculating_size')"
            if mount_smb_temp; then
                TOTAL_SIZE=$(du -sh "$MOUNT_POINT" 2>/dev/null | cut -f1)
                FILE_COUNT=$(find "$MOUNT_POINT" -type f 2>/dev/null | wc -l)
                print_info "$(get_text 'total_size') $TOTAL_SIZE ($FILE_COUNT $(get_text 'files'))"
                unmount_smb_temp
            fi
            
            return 0
        else
            print_error "$(get_text 'saves_not_found')"
            return 1
        fi
    else
        print_error "$(get_text 'smb_access_failed')"
        print_warning "$(get_text 'check_smb_enabled')"
        return 1
    fi
}

# Função para montar o compartilhamento SMB
mount_smb() {
    print_info "$(get_text 'mounting_smb')"
    
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
        print_success "$(get_text 'mount_success') $MOUNT_POINT"
        return 0
    else
        print_error "$(get_text 'mount_failed')"
        return 1
    fi
}

# Função para desmontar o compartilhamento SMB
unmount_smb() {
    if mountpoint -q "$MOUNT_POINT"; then
        print_info "$(get_text 'unmounting')"
        sudo umount "$MOUNT_POINT"
        print_success "$(get_text 'unmount_success')"
    fi
}

# Função para copiar arquivos com barra de progresso (versão para backup)
copy_with_progress_backup() {
    local source="$1"
    local destination="$2"
    
    print_info "$(get_text 'calculating_total')"
    
    # Método mais preciso: calcula tamanho dos arquivos individuais
    local total_size=0
    while IFS= read -r -d '' file; do
        if [ -f "$file" ]; then
            local file_size=$(stat -c%s "$file" 2>/dev/null || echo "0")
            total_size=$((total_size + file_size))
        fi
    done < <(find "$source" -type f -print0 2>/dev/null)
    
    # Se não conseguiu calcular ou está muito pequeno, usa du como fallback
    if [ "$total_size" -lt 1024 ]; then
        total_size=$(du -sb "$source" | cut -f1)
    fi
    
    # Adiciona margem de 5% para compensar overhead do tar
    total_size=$((total_size + (total_size / 20)))
    
    local total_size_human=$(du -sh "$source" | cut -f1)
    
    print_info "$(get_text 'total_copy') $total_size_human"
    print_info "$(get_text 'starting_copy')"
    echo
    
    # Verifica se o pv está disponível
    if command -v pv &> /dev/null; then
        # Usa tar com pv para copiar apenas o conteúdo (não a pasta pai)
        tar -cf - -C "$source" . | \
        pv -s "$total_size" -p -t -e -r -b | \
        tar -xf - -C "$destination"
        
        local exit_code=${PIPESTATUS[0]}
        echo
        
        if [ $exit_code -eq 0 ]; then
            print_success "$(get_text 'copy_success')"
            return 0
        else
            print_error "$(get_text 'copy_error') $exit_code)"
            return 1
        fi
    else
        # Fallback para rsync copiando apenas o conteúdo
        print_warning "$(get_text 'using_rsync')"
        if rsync -av --progress "$source/" "$destination/"; then
            print_success "$(get_text 'copy_success')"
            return 0
        else
            print_error "$(get_text 'rsync_error')"
            return 1
        fi
    fi
}

# Função para copiar arquivos com barra de progresso (versão para restauração)
copy_with_progress_restore() {
    local source="$1"
    local destination="$2"
    
    print_info "$(get_text 'calculating_total')"
    
    # Calcula o tamanho total em bytes
    local total_size=$(du -sb "$source" | cut -f1)
    local total_size_human=$(du -sh "$source" | cut -f1)
    
    print_info "$(get_text 'total_copy') $total_size_human"
    print_info "$(get_text 'starting_copy')"
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
            print_success "$(get_text 'copy_success')"
            return 0
        else
            print_error "$(get_text 'copy_error') $exit_code)"
            return 1
        fi
    else
        # Fallback para rsync com progresso básico
        print_warning "$(get_text 'using_rsync')"
        if rsync -av --progress "$source/" "$destination/$(basename "$source")/"; then
            print_success "$(get_text 'copy_success')"
            return 0
        else
            print_error "$(get_text 'rsync_error')"
            return 1
        fi
    fi
}

# Função para realizar o backup
perform_backup() {
    print_info "$(get_text 'starting_backup')"
    
    # Verifica se o caminho existe primeiro
    print_info "$(get_text 'checking_recalbox')"
    if ! check_connectivity; then
        print_error "$(get_text 'cannot_continue')"
        return 1
    fi
    
    # Solicita o diretório de destino
    echo
    read -p "$(get_text 'enter_dest_path') " BACKUP_DEST
    
    # Verifica se o usuário digitou algo
    if [ -z "$BACKUP_DEST" ]; then
        print_error "$(get_text 'dest_empty')"
        return 1
    fi
    
    # Expande ~ para o diretório home se necessário
    BACKUP_DEST="${BACKUP_DEST/#\~/$HOME}"
    
    # Verifica se o diretório de destino existe
    if [ ! -d "$BACKUP_DEST" ]; then
        print_warning "$(get_text 'dest_not_exist')"
        read -p "$(get_text 'create_dir') " CREATE_DIR
        local yes_pattern="^[SsYy]$"
        if [[ $CREATE_DIR =~ $yes_pattern ]]; then
            if mkdir -p "$BACKUP_DEST"; then
                print_success "$(get_text 'dir_created') $BACKUP_DEST"
            else
                print_error "$(get_text 'create_dir_failed') $BACKUP_DEST"
                return 1
            fi
        else
            print_error "$(get_text 'backup_cancelled')"
            return 1
        fi
    fi
    
    # Verifica se o diretório de destino é gravável
    if [ ! -w "$BACKUP_DEST" ]; then
        print_error "$(get_text 'no_write_permission') $BACKUP_DEST"
        return 1
    fi
    
    # Monta o compartilhamento SMB
    if ! mount_smb; then
        return 1
    fi
    
    # Cria nome do backup com timestamp
    TIMESTAMP=$(date +%Y-%m-%d_%H%M)
    BACKUP_NAME="recalbox_saves_backup_$TIMESTAMP"
    BACKUP_FULL_PATH="$BACKUP_DEST/$BACKUP_NAME"
    
    print_info "$(get_text 'copying_to') $BACKUP_FULL_PATH"
    
    # Cria o diretório de destino
    mkdir -p "$BACKUP_FULL_PATH"
    
    # Realiza a cópia com barra de progresso (apenas o conteúdo dos saves)
    if copy_with_progress_backup "$MOUNT_POINT" "$BACKUP_FULL_PATH"; then
        print_success "$(get_text 'backup_success')"
        
        # Mostra informações do backup
        BACKUP_SIZE=$(du -sh "$BACKUP_FULL_PATH" | cut -f1)
        FILE_COUNT=$(find "$BACKUP_FULL_PATH" -type f | wc -l)
        FOLDER_COUNT=$(find "$BACKUP_FULL_PATH" -maxdepth 1 -type d ! -path "$BACKUP_FULL_PATH" | wc -l)
        
        echo
        print_info "$(get_text 'backup_info')"
        echo "  - $(get_text 'location') $BACKUP_FULL_PATH"
        echo "  - $(get_text 'size') $BACKUP_SIZE"
        echo "  - $(get_text 'folders_copied') $FOLDER_COUNT"
        echo "  - $(get_text 'files') $FILE_COUNT"
        echo "  - $(get_text 'date') $(date)"
        
    else
        print_error "$(get_text 'backup_failed')"
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
    echo "   $(get_text 'title')    "
    echo "=================================="
    echo
    echo "1) $(get_text 'menu_deps')"
    echo "2) $(get_text 'menu_path')"
    echo "3) $(get_text 'menu_backup')"
    echo "4) $(get_text 'menu_restore')"
    echo "5) $(get_text 'menu_exit')"
    echo
}

# Função principal
main() {
    # Seleciona o idioma primeiro
    select_language
    
    # Verifica se está rodando como root desnecessariamente
    if [ "$EUID" -eq 0 ]; then
        print_warning "$(get_text 'root_warning')"
        print_info "$(get_text 'run_as_user')"
    fi
    
    while true; do
        show_menu
        read -p "$(get_text 'choose_option') [1-5]: " OPTION
        
        case $OPTION in
            1)
                echo
                check_system_dependencies
                echo
                read -p "$(get_text 'press_enter')"
                ;;
            2)
                echo
                check_path
                echo
                read -p "$(get_text 'press_enter')"
                ;;
            3)
                echo
                perform_backup
                echo
                read -p "$(get_text 'press_enter')"
                ;;
            4)
                echo
                perform_restore
                echo
                read -p "$(get_text 'press_enter')"
                ;;
            5)
                print_info "$(get_text 'exiting')"
                # Cleanup: desmonta se estiver montado
                unmount_smb 2>/dev/null
                exit 0
                ;;
            *)
                print_error "$(get_text 'invalid_option') 1, 2, 3, 4 $(get_text 'or') 5."
                sleep 2
                ;;
        esac
    done
}

# Tratamento de sinais para cleanup
trap 'unmount_smb 2>/dev/null; exit 1' INT TERM

# Executa a função principal
main