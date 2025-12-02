
# Setup Manual — Windows

Este arquivo contém os passos manuais que você deve seguir para instalar IDEs, engines e ferramentas que não são adequadas para instalação automática via script:

## Exemplos de softwares para instalar manualmente

- Visual Studio Community  
- Unity (Editor + dependências)  
- Unreal Engine (via instalador oficial)  
- Android Studio  
- IntelliJ IDEA / Rider / CLion  
- Godot Engine (Mono)  
- IDEs de código / editores gráficos (Zed, VS Code, etc)  
- Frameworks específicos (MonoGame, .NET MAUI, AvaloniaUI), dependendo da ferramenta  
- Configurações de ambiente (variáveis, paths, configurações de GPU/driver se necessário)  

## Passos sugeridos

1. Baixar instalador oficial do software desejado.  
2. Executar instalador com privilégios administrativos se necessário.  
3. Configurar variáveis de ambiente (ex: adicionar `.dotnet` ao PATH, configurar SDK path nas IDEs, etc).  
4. Verificar compatibilidade com hardware e drivers — especialmente para engines de jogo 3D (GPU, Vulkan/DirectX/OpenGL).  
5. Ajustar configurações da IDE ou engine conforme seu projeto (ex: target frameworks, bibliotecas, dependências, paths).  

> ⚠️ Dado o grande número de ferramentas e a variabilidade de requisitos, recomenda-se instalar uma a uma, verificar se tudo está funcionando, antes de instalar a próxima.
