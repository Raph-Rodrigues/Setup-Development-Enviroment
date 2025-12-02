
#!/usr/bin/env bash
set -e

echo "=== INICIANDO SETUP: GPU AMD, drivers, IDE/editor, DE/WM (opcional), engines (opcionais) ==="

OS="$(uname -s)"
if [[ "$OS" != "Linux" ]]; then
  echo "Este script deve ser executado em Linux."
  exit 1
fi

if [ -f /etc/os-release ]; then
  . /etc/os-release
  DISTRO="$ID"
  echo "Distro detectada: $DISTRO"
else
  echo "Não foi possível detectar a distribuição."
  exit 1
fi

# --- GPU AMD / drivers gráficos Mesa + Vulkan
install_gpu_amd() {
  echo "Instalando drivers Mesa/Vulkan para AMD..."
  case "$DISTRO" in
    ubuntu|debian)
      sudo apt update
      sudo apt install -y mesa-utils mesa-vulkan-drivers libvulkan1 vulkan-utils
      ;;
    fedora)
      sudo dnf install -y mesa-dri-drivers mesa-vulkan-drivers vulkan mesa-libGL mesa-libEGL
      ;;
    arch)
      sudo pacman -Syu --noconfirm
      sudo pacman -S --noconfirm mesa vulkan-radeon lib32-mesa lib32-vulkan-radeon
      ;;
    *)
      echo "Distro $DISTRO: verificar drivers manually se necessário."
      ;;
  esac
}

# --- IDEs / editores
install_ides_editors() {
  echo "Instalando IDE/editor básico..."
  case "$DISTRO" in
    ubuntu|debian)
      # ajustar repositório para VS Code se ainda não tiver
      sudo apt update
      sudo apt install -y wget gpg software-properties-common apt-transport-https
      wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
      sudo install -o root -g root -m 644 packages.microsoft.gpg /usr/share/keyrings/
      sudo sh -c 'echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
      sudo apt update
      sudo apt install -y code
      ;;
    fedora)
      # pode usar flatpak ou baixar rpm manualmente
      sudo dnf install -y flatpak
      echo "VS Code pode ser instalado via Flatpak manualmente."
      ;;
    arch)
      # usa AUR (assumindo yay instalado)
      if ! command -v yay &> /dev/null; then
        sudo pacman -S --noconfirm --needed base-devel git
        git clone https://aur.archlinux.org/yay.git /tmp/yay
        cd /tmp/yay
        makepkg -si --noconfirm
        cd - && rm -rf /tmp/yay
      fi
      yay -S --noconfirm visual-studio-code-bin
      ;;
  esac
}

# --- Instalar DE/WM / ambiente gráfico / Hyprland (opcional)
install_desktop_envs() {
  echo "Instalando DE/WM — apenas Hyprland no Arch (HyDE config), outros ambientes exigem intervenção manual..."
  if [[ "$DISTRO" == "arch" ]]; then
    sudo pacman -S --noconfirm git base-devel pipewire pipewire-pulse xdg-desktop-portal-hyprland \
      qt5-wayland qt6-wayland rofi-wayland alacritty waybar hyprland

    # Clonar e instalar HyDE config (dotfiles/config para Hyprland)
    git clone --depth 1 https://github.com/prasanthrangan/hyprdots ~/HyDE
    cd ~/HyDE/Scripts
    ./install.sh || { echo "Falha ao rodar HyDE install.sh"; exit 1; }
    cd -
  else
    echo "Para distros diferentes de Arch: instale manualmente o DE/WM de sua preferência (GNOME, KDE, Deepin, etc)."
  fi
}

# --- Seções opcionais — engines / ferramentas de game / frameworks
### Para ativar, remova os comentários `# >>>` e `# <<<` correspondentes

# >>> Installing Godot Engine (stable, com suporte C#)
install_godot() {
  echo "Instalando Godot Engine (com C#)..."
  case "$DISTRO" in
    arch)
      sudo pacman -S --noconfirm godot godot-mono
      ;;
    ubuntu|debian|fedora)
      # Usando Flatpak / Snap / binário oficial — exemplo com Flatpak (requer flatpak já instalado)
      flatpak install --user flathub org.godotengine.Godot || true
      # Alternativamente, baixar manualmente de https://godotengine.org/download/linux
      ;;
    *)
      echo "Distro $DISTRO não prevista automaticamente para Godot — instalar manualmente."
      ;;
  esac
}
# install_godot
# <<<

# >>> Installing Unity (via Unity Hub / repositório / Flatpak) — ideal para adicionar manualmente se preferir
install_unity() {
  echo "Instalação do Unity (via Unity Hub ou pacote oficial)..."
  case "$DISTRO" in
    ubuntu|debian)
      # adicionar repositório Unity Hub + instalar
      sudo sh -c 'echo "deb https://hub.unity3d.com/linux/repos/deb stable main" > /etc/apt/sources.list.d/unityhub.list'
      wget -qO - https://hub.unity3d.com/linux/keys/public | sudo apt-key add -
      sudo apt update
      sudo apt install -y unityhub
      ;;
    fedora|arch)
      echo "Por favor, instale o Unity Hub manualmente (download oficial ou Flatpak se disponível)."
      ;;
    *)
      echo "Distro $DISTRO: instalação manual recomendada para Unity."
      ;;
  esac
}
# install_unity
# <<<

# >>> Installing Unreal Engine — exige clone + build manual
install_unreal() {
  echo "Iniciando procedimento para Unreal Engine..."
  echo "ATENÇÃO: Unreal geralmente requer compilação manual e configuração de drivers gráficos."
  echo "Certifique-se ter >= 8GB RAM, compiladores C++, dependências, Vulkan/Mesa configurados."
  # Exemplos genéricos (não garantido funcionar): clone do repo, build
  git clone --depth 1 https://github.com/EpicGames/UnrealEngine.git ~/UnrealEngine
  cd ~/UnrealEngine
  ./Setup.sh
  ./GenerateProjectFiles.sh
  make
  cd -
}
# install_unreal
# <<<

# --- Execução dos passos principais
install_gpu_amd
install_ides_editors
install_desktop_envs

echo "=== SETUP BÁSICO + GUI concluído ==="
echo "Você pode agora habilitar manualmente a instalação de engines, removendo comentários no script e executando novamente."
