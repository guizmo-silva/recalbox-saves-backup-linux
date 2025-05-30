# 🎮 Recalbox Backup Script

<div align="center">

![Bash](https://img.shields.io/badge/bash-%23121011.svg?style=for-the-badge&logo=gnu-bash&logoColor=white)
![Linux](https://img.shields.io/badge/Linux-FCC624?style=for-the-badge&logo=linux&logoColor=black)
![License](https://img.shields.io/badge/license-MIT-blue?style=for-the-badge)

**Um script completo para backup e restauração de saves do Recalbox**

*Complete script for Recalbox saves backup and restore*

*Script completo para respaldo y restauración de saves de Recalbox*

</div>

---

## 📋 Índice / Index / Índice

### 🇧🇷 Português
- [Sobre o Projeto](#-sobre-o-projeto)
- [Funcionalidades](#-funcionalidades)
- [Pré-requisitos](#-pré-requisitos)
- [Instalação](#-instalação)
- [Como Usar](#-como-usar)
- [Distribuições Suportadas](#-distribuições-suportadas)

### 🇺🇸 English
- [About the Project](#-about-the-project)
- [Features](#-features)
- [Prerequisites](#-prerequisites)
- [Installation](#-installation)
- [How to Use](#-how-to-use)
- [Supported Distributions](#-supported-distributions)

### 🇪🇸 Español
- [Sobre el Proyecto](#-sobre-el-proyecto)
- [Características](#-características)
- [Prerrequisitos](#-prerrequisitos)
- [Instalación](#-instalación)
- [Cómo Usar](#-cómo-usar)
- [Distribuciones Soportadas](#-distribuciones-soportadas)

---

## 🇧🇷 Português

### 🎯 Sobre o Projeto

O **Recalbox Backup Script** é uma solução completa e intuitiva para gerenciar os saves dos seus jogos no Recalbox. Com interface multilíngue e detecção automática de distribuições Linux, este script oferece uma experiência simples e confiável para proteger seus progressos de jogo.

### ✨ Funcionalidades

- 🔍 **Verificação de Dependências**: Detecta e instala automaticamente pacotes necessários
- 📡 **Verificação de Conectividade**: Testa conexão com o Recalbox na rede
- 💾 **Backup Completo**: Cria backups organizados com timestamp
- 🔄 **Restauração Inteligente**: Restaura saves seletivamente
- 🌍 **Interface Multilíngue**: Português, Inglês e Espanhol
- 📊 **Barra de Progresso**: Acompanhe o progresso do backup em tempo real
- 🖥️ **Detecção Automática**: Identifica sua distribuição Linux automaticamente

### 📋 Pré-requisitos

- Sistema Linux (Ubuntu, Fedora, Arch, etc.)
- Recalbox na mesma rede
- Compartilhamento SMB habilitado no Recalbox
- Permissões de sudo para instalação de pacotes

### 🚀 Instalação

1. **Clone o repositório ou baixe o script:**
```bash
wget https://raw.githubusercontent.com/seu-usuario/recalbox-backup-script/main/recalbox_backup.sh
```

2. **Torne o script executável:**
```bash
chmod +x recalbox_backup.sh
```

3. **Execute o script:**
```bash
./recalbox_backup.sh
```

### 📖 Como Usar

1. **Execute o script** e escolha seu idioma preferido
2. **Verifique as dependências** (Opção 1) - o script instalará automaticamente se necessário
3. **Teste a conectividade** (Opção 2) para verificar se o Recalbox está acessível
4. **Faça backup** (Opção 3) ou **restaure saves** (Opção 4) conforme necessário

#### Exemplo de Uso:
```bash
./recalbox_backup.sh

# Escolha o idioma
# 1) Português (Brasil)

# Menu principal
# 1) Verificar dependências do sistema
# 2) Verificar caminho dos saves  
# 3) Realizar backup
# 4) Restaurar saves
# 5) Sair
```

### 🐧 Distribuições Suportadas

| Distribuição | Gerenciador | Status |
|--------------|-------------|--------|
| Ubuntu/Debian | `apt` | ✅ |
| Linux Mint | `apt` | ✅ |
| Pop!_OS | `apt` | ✅ |
| Fedora | `dnf` | ✅ |
| Nobara | `dnf` | ✅ |
| RHEL/CentOS | `yum` | ✅ |
| Rocky/AlmaLinux | `yum` | ✅ |
| Arch Linux | `pacman` | ✅ |
| Manjaro | `pacman` | ✅ |
| EndeavourOS | `pacman` | ✅ |
| openSUSE | `zypper` | ✅ |

---

## 🇺🇸 English

### 🎯 About the Project

The **Recalbox Backup Script** is a complete and intuitive solution for managing your Recalbox game saves. With multilingual interface and automatic Linux distribution detection, this script offers a simple and reliable experience to protect your game progress.

### ✨ Features

- 🔍 **Dependency Check**: Automatically detects and installs required packages
- 📡 **Connectivity Verification**: Tests connection with Recalbox on network
- 💾 **Complete Backup**: Creates organized backups with timestamp
- 🔄 **Smart Restoration**: Selectively restores saves
- 🌍 **Multilingual Interface**: Portuguese, English, and Spanish
- 📊 **Progress Bar**: Track backup progress in real-time
- 🖥️ **Auto Detection**: Automatically identifies your Linux distribution

### 📋 Prerequisites

- Linux system (Ubuntu, Fedora, Arch, etc.)
- Recalbox on the same network
- SMB sharing enabled on Recalbox
- Sudo permissions for package installation

### 🚀 Installation

1. **Clone the repository or download the script:**
```bash
wget https://raw.githubusercontent.com/your-username/recalbox-backup-script/main/recalbox_backup.sh
```

2. **Make the script executable:**
```bash
chmod +x recalbox_backup.sh
```

3. **Run the script:**
```bash
./recalbox_backup.sh
```

### 📖 How to Use

1. **Run the script** and choose your preferred language
2. **Check dependencies** (Option 1) - the script will install automatically if needed
3. **Test connectivity** (Option 2) to verify Recalbox is accessible
4. **Backup** (Option 3) or **restore saves** (Option 4) as needed

#### Usage Example:
```bash
./recalbox_backup.sh

# Choose language
# 2) English (US)

# Main menu
# 1) Check system dependencies
# 2) Check saves path
# 3) Perform backup
# 4) Restore saves
# 5) Exit
```

### 🐧 Supported Distributions

| Distribution | Package Manager | Status |
|--------------|-----------------|--------|
| Ubuntu/Debian | `apt` | ✅ |
| Linux Mint | `apt` | ✅ |
| Pop!_OS | `apt` | ✅ |
| Fedora | `dnf` | ✅ |
| Nobara | `dnf` | ✅ |
| RHEL/CentOS | `yum` | ✅ |
| Rocky/AlmaLinux | `yum` | ✅ |
| Arch Linux | `pacman` | ✅ |
| Manjaro | `pacman` | ✅ |
| EndeavourOS | `pacman` | ✅ |
| openSUSE | `zypper` | ✅ |

---

## 🇪🇸 Español

### 🎯 Sobre el Proyecto

El **Recalbox Backup Script** es una solución completa e intuitiva para gestionar las partidas guardadas de tus juegos en Recalbox. Con interfaz multiidioma y detección automática de distribuciones Linux, este script ofrece una experiencia simple y confiable para proteger tu progreso de juego.

### ✨ Características

- 🔍 **Verificación de Dependencias**: Detecta e instala automáticamente paquetes necesarios
- 📡 **Verificación de Conectividad**: Prueba conexión con Recalbox en la red
- 💾 **Respaldo Completo**: Crea respaldos organizados con timestamp
- 🔄 **Restauración Inteligente**: Restaura saves selectivamente
- 🌍 **Interfaz Multiidioma**: Portugués, Inglés y Español
- 📊 **Barra de Progreso**: Sigue el progreso del respaldo en tiempo real
- 🖥️ **Detección Automática**: Identifica tu distribución Linux automáticamente

### 📋 Prerrequisitos

- Sistema Linux (Ubuntu, Fedora, Arch, etc.)
- Recalbox en la misma red
- Compartir SMB habilitado en Recalbox
- Permisos sudo para instalación de paquetes

### 🚀 Instalación

1. **Clona el repositorio o descarga el script:**
```bash
wget https://raw.githubusercontent.com/tu-usuario/recalbox-backup-script/main/recalbox_backup.sh
```

2. **Haz el script ejecutable:**
```bash
chmod +x recalbox_backup.sh
```

3. **Ejecuta el script:**
```bash
./recalbox_backup.sh
```

### 📖 Cómo Usar

1. **Ejecuta el script** y elige tu idioma preferido
2. **Verifica dependencias** (Opción 1) - el script instalará automáticamente si es necesario
3. **Prueba conectividad** (Opción 2) para verificar que Recalbox sea accesible
4. **Haz respaldo** (Opción 3) o **restaura saves** (Opción 4) según sea necesario

#### Ejemplo de Uso:
```bash
./recalbox_backup.sh

# Elige idioma
# 3) Español (ES)

# Menú principal
# 1) Verificar dependencias del sistema
# 2) Verificar ruta de saves
# 3) Realizar respaldo
# 4) Restaurar saves
# 5) Salir
```

### 🐧 Distribuciones Soportadas

| Distribución | Gestor de Paquetes | Estado |
|--------------|-------------------|--------|
| Ubuntu/Debian | `apt` | ✅ |
| Linux Mint | `apt` | ✅ |
| Pop!_OS | `apt` | ✅ |
| Fedora | `dnf` | ✅ |
| Nobara | `dnf` | ✅ |
| RHEL/CentOS | `yum` | ✅ |
| Rocky/AlmaLinux | `yum` | ✅ |
| Arch Linux | `pacman` | ✅ |
| Manjaro | `pacman` | ✅ |
| EndeavourOS | `pacman` | ✅ |
| openSUSE | `zypper` | ✅ |

---

## 🤝 Contribuindo / Contributing / Contribuyendo

Contribuições são bem-vindas! Sinta-se à vontade para abrir issues ou pull requests.

Contributions are welcome! Feel free to open issues or pull requests.

¡Las contribuciones son bienvenidas! Siéntete libre de abrir issues o pull requests.

## 📄 Licença / License / Licencia

Este projeto está sob a licença MIT. Veja o arquivo `LICENSE` para mais detalhes.

This project is under the MIT license. See the `LICENSE` file for more details.

Este proyecto está bajo la licencia MIT. Ver el archivo `LICENSE` para más detalles.

---

<div align="center">

**⭐ Se este projeto foi útil, considere dar uma estrela!**

**⭐ If this project was helpful, consider giving it a star!**

**⭐ ¡Si este proyecto fue útil, considera darle una estrella!**

</div>
