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

Script criado para facilitar o processo de backup da pasta de saves do Recalbox. Útil caso você precise formatar seu cartão SD, atualizar o sistema ou simplesmente queira manter uma cópia segura de seus memory cards e save states.

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
- Recalbox na mesma rede (cabo ou WiFi)
- Compartilhamento SMB habilitado no Recalbox
- Permissões de sudo para instalação de pacotes

#### 📦 Dependências Necessárias

O script requer os seguintes pacotes para funcionar corretamente:


| Pacote         | Função                                  | Obrigatório     |
| ---------------- | ------------------------------------------- | ------------------ |
| `samba-client` | Acesso a compartilhamentos SMB            | ✅ Sim           |
| `cifs-utils`   | Montagem de sistemas de arquivos CIFS/SMB | ✅ Sim           |
| `rsync`        | Sincronização e cópia de arquivos      | ✅ Sim           |
| `pv`           | Barra de progresso durante backup         | ⚠️ Recomendado |

#### 🔧 Instalação Manual das Dependências

Se preferir instalar as dependências manualmente antes de executar o script:

**Ubuntu/Debian/Linux Mint/Pop!_OS:**

```bash
sudo apt update && sudo apt install -y samba-client cifs-utils rsync pv
```

**Fedora/Nobara:**

```bash
sudo dnf install -y samba-client cifs-utils rsync pv
```

**RHEL/CentOS/Rocky/AlmaLinux:**

```bash
sudo yum install -y samba-client cifs-utils rsync pv
```

**Arch Linux/Manjaro/EndeavourOS:**

```bash
sudo pacman -S samba cifs-utils rsync pv
```

**openSUSE/SLES:**

```bash
sudo zypper install -y samba-client cifs-utils rsync pv
```

> **💡 Dica:** O script detecta automaticamente sua distribuição e oferece instalar as dependências que estiverem faltando. Você pode usar a **Opção 1** do menu para verificar e instalar automaticamente.

### 🚀 Instalação

1. **[Baixe o script](https://github.com/guizmo-silva/recalbox-saves-backup-linux/releases/tag/v1.0.0) ou clone o repositório:**

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

### 🐧 Distribuições Suportadas


| Distribuição  | Gerenciador | Status |
| ----------------- | ------------- | -------- |
| Ubuntu/Debian   | `apt`       | ✅     |
| Linux Mint      | `apt`       | ✅     |
| Pop!_OS         | `apt`       | ✅     |
| Fedora          | `dnf`       | ✅     |
| Nobara          | `dnf`       | ✅     |
| RHEL/CentOS     | `yum`       | ✅     |
| Rocky/AlmaLinux | `yum`       | ✅     |
| Arch Linux      | `pacman`    | ✅     |
| Manjaro         | `pacman`    | ✅     |
| EndeavourOS     | `pacman`    | ✅     |
| openSUSE        | `zypper`    | ✅     |

### 🔧 Solução de Problemas

#### Problemas Comuns:

**❌ "Não foi possível conectar ao recalbox.local"**

- Verifique se o Recalbox está ligado e conectado à rede
- Confirme que seu computador está na mesma rede
- Teste: `ping recalbox.local`

**❌ "Compartilhamento SMB não acessível"**

- Habilite o compartilhamento de rede no Recalbox
- Vá em: Sistema → Configurações de Rede → Ativar SAMBA

**❌ "Permissão negada"**

- Execute o script como usuário normal (não root)
- O script pedirá sudo apenas quando necessário

**❌ "Comando não encontrado"**

- Execute a verificação de dependências (Opção 1)
- Instale as dependências manualmente se preferir

---

## 🇺🇸 English

### 🎯 About the Project

Script created to facilitate the backup process of the Recalbox saves folder. Useful if you need to format your SD card, update the system, or simply want to keep a safe copy of your memory cards and save states.

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

#### 📦 Required Dependencies

The script requires the following packages to work correctly:


| Package        | Function                         | Required         |
| ---------------- | ---------------------------------- | ------------------ |
| `samba-client` | Access to SMB shares             | ✅ Yes           |
| `cifs-utils`   | CIFS/SMB filesystem mounting     | ✅ Yes           |
| `rsync`        | File synchronization and copying | ✅ Yes           |
| `pv`           | Progress bar during backup       | ⚠️ Recommended |

#### 🔧 Manual Dependencies Installation

If you prefer to install dependencies manually before running the script:

**Ubuntu/Debian/Linux Mint/Pop!_OS:**

```bash
sudo apt update && sudo apt install -y samba-client cifs-utils rsync pv
```

**Fedora/Nobara:**

```bash
sudo dnf install -y samba-client cifs-utils rsync pv
```

**RHEL/CentOS/Rocky/AlmaLinux:**

```bash
sudo yum install -y samba-client cifs-utils rsync pv
```

**Arch Linux/Manjaro/EndeavourOS:**

```bash
sudo pacman -S samba cifs-utils rsync pv
```

**openSUSE/SLES:**

```bash
sudo zypper install -y samba-client cifs-utils rsync pv
```

> **💡 Tip:** The script automatically detects your distribution and offers to install missing dependencies. You can use **Option 1** from the menu to check and install automatically!

### 🚀 Installation

1. **Clone the repository or [download the script](https://github.com/guizmo-silva/recalbox-saves-backup-linux/releases/tag/v1.0.0):**

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

### 🐧 Supported Distributions


| Distribution    | Package Manager | Status |
| ----------------- | ----------------- | -------- |
| Ubuntu/Debian   | `apt`           | ✅     |
| Linux Mint      | `apt`           | ✅     |
| Pop!_OS         | `apt`           | ✅     |
| Fedora          | `dnf`           | ✅     |
| Nobara          | `dnf`           | ✅     |
| RHEL/CentOS     | `yum`           | ✅     |
| Rocky/AlmaLinux | `yum`           | ✅     |
| Arch Linux      | `pacman`        | ✅     |
| Manjaro         | `pacman`        | ✅     |
| EndeavourOS     | `pacman`        | ✅     |
| openSUSE        | `zypper`        | ✅     |

### 🔧 Troubleshooting

#### Common Issues:

**❌ "Could not connect to recalbox.local"**

- Check if Recalbox is powered on and connected to network
- Confirm your computer is on the same network
- Test: `ping recalbox.local`

**❌ "SMB share not accessible"**

- Enable network sharing on Recalbox
- Go to: System → Network Settings → Enable SAMBA

**❌ "Permission denied"**

- Run the script as normal user (not root)
- Script will ask for sudo only when necessary

**❌ "Command not found"**

- Run dependency check (Option 1)
- Install dependencies manually if preferred

---

## 🇪🇸 Español

### 🎯 Sobre el Proyecto

Script creado para facilitar el proceso de respaldo de la carpeta de guardados de Recalbox. Útil en caso de que necesites formatear tu tarjeta SD, actualizar el sistema o simplemente quieras mantener una copia segura de tus memory cards y save states.

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

#### 📦 Dependencias Necesarias

El script requiere los siguientes paquetes para funcionar correctamente:


| Paquete        | Función                                 | Requerido        |
| ---------------- | ------------------------------------------ | ------------------ |
| `samba-client` | Acceso a compartidos SMB                 | ✅ Sí           |
| `cifs-utils`   | Montaje de sistemas de archivos CIFS/SMB | ✅ Sí           |
| `rsync`        | Sincronización y copia de archivos      | ✅ Sí           |
| `pv`           | Barra de progreso durante respaldo       | ⚠️ Recomendado |

#### 🔧 Instalación Manual de Dependencias

Si prefieres instalar las dependencias manualmente antes de ejecutar el script:

**Ubuntu/Debian/Linux Mint/Pop!_OS:**

```bash
sudo apt update && sudo apt install -y samba-client cifs-utils rsync pv
```

**Fedora/Nobara:**

```bash
sudo dnf install -y samba-client cifs-utils rsync pv
```

**RHEL/CentOS/Rocky/AlmaLinux:**

```bash
sudo yum install -y samba-client cifs-utils rsync pv
```

**Arch Linux/Manjaro/EndeavourOS:**

```bash
sudo pacman -S samba cifs-utils rsync pv
```

**openSUSE/SLES:**

```bash
sudo zypper install -y samba-client cifs-utils rsync pv
```

> **💡 Consejo:** El script detecta automáticamente tu distribución y ofrece instalar las dependencias faltantes. ¡Puedes usar la **Opción 1** del menú para verificar e instalar automáticamente!

### 🚀 Instalación

1. **Clona el repositorio o [descarga el script](https://github.com/guizmo-silva/recalbox-saves-backup-linux/releases/tag/v1.0.0):**

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

### 🐧 Distribuciones Soportadas


| Distribución   | Gestor de Paquetes | Estado |
| ----------------- | -------------------- | -------- |
| Ubuntu/Debian   | `apt`              | ✅     |
| Linux Mint      | `apt`              | ✅     |
| Pop!_OS         | `apt`              | ✅     |
| Fedora          | `dnf`              | ✅     |
| Nobara          | `dnf`              | ✅     |
| RHEL/CentOS     | `yum`              | ✅     |
| Rocky/AlmaLinux | `yum`              | ✅     |
| Arch Linux      | `pacman`           | ✅     |
| Manjaro         | `pacman`           | ✅     |
| EndeavourOS     | `pacman`           | ✅     |
| openSUSE        | `zypper`           | ✅     |

### 🔧 Solución de Problemas

#### Problemas Comunes:

**❌ "No se pudo conectar a recalbox.local"**

- Verifica que Recalbox esté encendido y conectado a la red
- Confirma que tu computadora está en la misma red
- Prueba: `ping recalbox.local`

**❌ "Compartir SMB no accesible"**

- Habilita el compartir de red en Recalbox
- Ve a: Sistema → Configuración de Red → Activar SAMBA

**❌ "Permiso denegado"**

- Ejecuta el script como usuario normal (no root)
- El script pedirá sudo solo cuando sea necesario

**❌ "Comando no encontrado"**

- Ejecuta la verificación de dependencias (Opción 1)
- Instala las dependencias manualmente si prefieres

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
