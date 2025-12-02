
#!/usr/bin/env bash
set -e  # aborta se um comando falhar

echo "=== INÍCIO DO SETUP AUTOMÁTICO (Linux) ==="

# Detecta se é Linux
OS="$(uname -s)"
if [[ "$OS" != "Linux" ]]; then
  echo "Erro: este script deve ser executado em Linux."
  exit 1
fi

# Detecta a distro
if [ -f /etc/os-release ]; then
  . /etc/os-release
  DISTRO="$ID"
  echo "Distro detectada: $DISTRO"
else
  echo "Não foi possível detectar a distribuição Linux."
  exit 1
fi

echo "=== ATUALIZANDO SISTEMA E INSTALANDO PACOTES BÁSICOS ==="
case "$DISTRO" in
  ubuntu|debian)
    sudo apt update
    sudo apt install -y curl wget git build-essential cmake make python3 python3-pip \
      zsh flatpak unzip \
      lua5.1 lua5.1-dev \
      nodejs npm \
      openjdk-17-jdk \
      llvm clang clang-tools \
      pkg-config
    ;;

  fedora)
    sudo dnf upgrade -y
    sudo dnf install -y curl wget git gcc gcc-c++ make cmake python3 python3-pip \
      zsh flatpak unzip \
      lua lua-devel \
      nodejs npm \
      java-17-openjdk-devel \
      llvm clang pkg-config
    ;;

  arch)
    sudo pacman -Syu --noconfirm
    sudo pacman -S --noconfirm base-devel git curl wget zsh cmake make python python-pip \
      flatpak unzip \
      lua lua-dev \
      nodejs npm \
      jdk-openjdk \
      llvm clang pkgconf pkg-config
    # opcional: pamac GUI/cli
    if ! command -v pamac &> /dev/null; then
      sudo pacman -S --noconfirm --needed pamac-cli
    fi
    ;;

  *)
    echo "Aviso: distro $DISTRO não automaticamente suportada por este script."
    ;;
esac

echo "=== INSTALANDO .NET SDKs (8, 9, 10) via script oficial ==="
DOTNET_INSTALL_URL="https://dot.net/v1/dotnet-install.sh"
curl -L "$DOTNET_INSTALL_URL" -o /tmp/dotnet-install.sh
chmod +x /tmp/dotnet-install.sh

for VER in 8.0 9.0 10.0; do
  echo "Instalando .NET SDK $VER..."
  /tmp/dotnet-install.sh --channel "$VER" --install-dir "$HOME/.dotnet"
done

if ! grep -q 'DOTNET_ROOT' "$HOME/.bashrc"; then
  echo "" >> "$HOME/.bashrc"
  echo "# .NET SDKs" >> "$HOME/.bashrc"
  echo "export DOTNET_ROOT=\$HOME/.dotnet" >> "$HOME/.bashrc"
  echo "export PATH=\$PATH:\$HOME/.dotnet:\$HOME/.dotnet/tools" >> "$HOME/.bashrc"
fi
export DOTNET_ROOT="$HOME/.dotnet"
export PATH="$PATH:$DOTNET_ROOT:$DOTNET_ROOT/tools"

echo ".NET SDK instalado. Versões disponíveis:"
dotnet --list-sdks || true

echo "=== CONFIGURAÇÕES E DEPENDÊNCIAS ADICIONAIS PARA ENGINES / COMPILAÇÃO ==="

if [[ "$DISTRO" == "ubuntu" || "$DISTRO" == "debian" ]]; then
  sudo apt install -y clang mono-devel cmake ninja-build build-essential \
    libvulkan-dev libsdl2-dev libgtk-3-dev libxrandr-dev libxinerama-dev libxi-dev \
    libssl-dev libicu-dev libxml2-dev libxcursor-dev libxcb-keysyms1-dev \
    libxcb-image0-dev libxcb-icccm4-dev libxcb-render-util0-dev \
    libxkbcommon-dev libxkbcommon-x11-dev || true
  echo "Dependências comuns para build de engines instaladas."
fi

echo "=== HABILITANDO flatpak (se aplicável) ==="
if ! command -v flatpak &> /dev/null; then
  echo "flatpak não encontrado — tente instalar manualmente."
else
  flatpak --version || true
fi

echo "=== CONCLUÍDO: configuração automática básica feita ==="
echo "Próximos passos (manuais ou semiautomáticos):"
echo " - Instalar IDEs (VS Code, Rider, CLion, Zed, IntelliJ, Android Studio, etc)"
echo " - Instalar engines (Unreal, Unity, Godot, etc)"
echo " - Instalar frameworks UI / game (MonoGame, AvaloniaUI, etc)"
echo " - Configurar ambientes gráficos e drivers se for usar GUI"
echo " - Instalar ambientes gráficos / desktops (se desejar) — KDE, GNOME, Hyprland etc"
echo " - Revisar versões e compatibilidades de SDKs, drivers, bibliotecas"

echo "Script de base finalizado com sucesso."
