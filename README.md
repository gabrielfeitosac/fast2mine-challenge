## 📲 Instalação

### 1. Baixar o APK

👉 [Clique aqui para baixar o APK]()

### 2. Instalar
- Ative a permissão de "Fontes desconhecidas" no dispositivo.
- Instale o APK e abra o app normalmente.


## ⚙️ Como usar

1. Abra o aplicativo.
2. Clique no botão **"SIMULAR PROXIMA LEITURA**" para realizar uma leitura de dados simulados
3. Acompanhe a interface ser atualizada em tempo real
4. Ao completar um ciclo, ele será salvo localmente
5. Cliquem em **"SINCRONIZAR DADOS**" para exporta o JSON de simulação do sincronismo


## 🧠 Arquitetura e Decisões Técnicas

- SQFlite para permanência de dados localmente
- Implementação de arquitetura limpa, utilizando DataSources, Repositorys, Usecases.
- Organização de pastas da arquitetura limpa Features, Data, Domain, Presentation.
- Utilização do pacote GetIt para controle de instâncias Singleton
- Utilização dos pacotes JsonSerializable e JsonAnnotation para auxílio da criação das models.
- Preferência por salvar GPS e Etapas como JSON no banco local, utilizando conversores JSON.


## 💾 Local de Armazenamento

O arquivo gerado com os dados sincronizados é:

- **📁 sync_servidor.jsonl**
- **Localização no dispositivo: /storage/emulated/0/Download/sync_servidor.jsonl (Pasta Downloads)**

> Para acessar o arquivo, utilize ferramentas como o Android Studio ou o próprio gerenciador de arquivos do dispositivo.


## ❓ Dúvidas Técnicas

- Era necessário validação automática de múltiplos ciclos em sequência? (Repetir o processo)
- Necessária importação dinâmica de arquivos `.jsonl` pelo usuário? (FilePicker)
- O caminhão precisa estar parado por 5 segundos pra estar na etapa `EM FILA CARREGAMENTO`, porém na primeira leitura eu ainda não tenho uma data anterior para comparar o tempo, qual etapa deveria ser considerada?
- O app deveria manter a etapa atual ao ser fechado?