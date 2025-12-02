
# Ambiente de Desenvolvimento — Visão Geral

Este documento descreve os softwares / frameworks / ferramentas / engines que pretendo usar, organizados por categoria. Use como checklist para instalar manualmente (GUI) ou complementar com scripts.

---

## 🧪 Linguagens / SDKs / Runtimes / Ferramentas de Linha de Comando

- .NET SDK 8, 9, 10  
- Mono / Mono runtime / suporte a .NET em Linux (para engines que usam C#)  
- C#  
- C / C++ (g++, gcc, clang) + build tools (cmake, make)  
- Java / OpenJDK + JavaFX (quando aplicável)  
- Lua (e frameworks como Love2D)  
- Python (e bibliotecas como para animações ou matemática, por exemplo para uso com frameworks gráficos/educacionais)  
- Rust  
- Go  
- Elixir  
- Node.js + npm (JavaScript / TypeScript) + Electron  
- Git (controle de versão)  

---

## 🖥️ IDEs, Editores

- Visual Studio Code  
- Rider (JetBrains)  
- CLion (JetBrains)  
- IntelliJ IDEA  
- Zed (editor de código leve)
  
---

## 🎮 Engines, Frameworks e Ferramentas para Jogos / UI / Multiplataforma

- Unreal Engine (versão para Linux ou Windows conforme o caso)  
- Unity (via Unity Hub) 
- Godot Engine (versão Mono se desejar C#) — pode usar gerenciadores como `godl` via Flatpak. 
- Framework de UI / multiplataforma: MonoGame (C#) — requer .NET SDK adequado. 
- (Se aplicável) UI frameworks / bibliotecas como AvaloniaUI, .NET MAUI — para aplicações desktop multiplataforma  
- Outras ferramentas, engines e frameworks conforme suas necessidades (2D/3D, jogos, aplicações, scripts, etc)  

---

## 🧰 Ferramentas de Sistema e Utilitários

- Gerenciador de pacotes / build tools (make, cmake, build-essential, base-devel, etc)  
- `curl`, `wget`, `unzip`, `git`, `pkg-config`, ferramentas de sistema necessárias para builds / dependências  
- `flatpak` (e repositórios como Flathub) — para instalar apps sandboxed / multiplataforma no Linux  
- Para Arch Linux: utilitários adicionais como `pamac` (GUI/CLI) para facilitar instalação de pacotes via AUR  

---

## ✅ Observações e Passos Manuais Necessários / Riscos / Considerações

- **Drivers gráficos / GPU / Vulkan / OpenGL / suporte a gráficos**: se você pretende usar engines 3D (Unreal, Unity, Godot com 3D, etc), precisa garantir que o driver da GPU esteja instalado e configurado corretamente.  
- **Instaladores gráficos e licenças**: muitas engines e IDEs exigem download manual, aceitação de termos de licença, configuração via GUI — não é viável automatizar 100%.  
- **Compatibilidade de versões**: ao usar múltiplas linguagens, frameworks e engines, verifique compatibilidade de versões (ex: .NET SDK vs MonoGame; Java/JDK vs JavaFX; Lua vs Love2D; Node/Electron vs dependências; etc).  
- **Ambientes gráficos / Desktop Environments (DE) / gerenciadores de janelas**: se pretende usar DEs específicos (KDE, GNOME, Hyprland, Deepin etc), talvez seja necessário instalar pacotes extras e configurar drivers e composição de janelas.  
- **Testar progressivamente**: instale primeiro ferramentas básicas (SDKs, compiladores, runtimes), depois ferramentas intermediárias (interpretes, utilitários), depois IDEs e engines — verificando a funcionalidade a cada passo.  
- **Backups / snapshots**: especialmente se você estiver alterando ambiente gráfico ou instalando muitas dependências, é recomendável ter backups ou snapshots do sistema (ex: via ferramentas como `timeshift`).  

---

## 🎯 Como usar este repositório / checklist

1. Rodar o script `install-env-linux.sh` para instalar pacotes básicos, SDKs e dependências essenciais.  
2. Manualmente (ou via scripts separados) instalar IDEs, engines e ferramentas de GUI conforme lista no README.  
3. Marcar no README o que já foi instalado — servir como checklist de progresso.  
4. Ao instalar cada engine / IDE — testar se funciona, verificar drivers, bibliotecas, requisitos, compatibilidade.  
5. Em caso de ambiente gráfico alterado ou instalação de DEs, criar snapshot / backup antes de mudanças importantes.  

---

## 🧾 Conclusão

Para a instalação do restante dos pacotes e configs verifique no [Linux-Instructions-pt2.md](https://github.com/Raph-Rodrigues/Setup-Development-Enviroment/blob/main/Linux-Intructions-pt2.md)
