🕶️ ObfuscatorPS

  Ferramenta de ofuscação de comandos em PowerShell para transformação e
  camuflagem de payloads.

------------------------------------------------------------------------

📌 Descrição

O ObfuscatorPS é uma ferramenta em PowerShell projetada para ofuscar
comandos e strings utilizando múltiplos métodos de transformação.

A ferramenta converte comandos legíveis em formatos alternativos,
dificultando análise estática, leitura humana e detecção simples,
mantendo a execução dinâmica através de reconstrução em tempo de
execução.

------------------------------------------------------------------------

⚙️ Uso

./obfuscator.ps1 -comand [STRING] -type [METODO]
./obfuscator.ps1 -h

------------------------------------------------------------------------

🧾 Parâmetros

-   -comand → Cadeia de caracteres ou comando a ser ofuscado
-   -type → Define o método de transformação (obrigatório)
-   -h, -help → Exibe o manual de uso

------------------------------------------------------------------------

🧠 Métodos disponíveis

-   binary → Codificação em sistema binário
-   charlength → Ofuscação baseada em valores de caracteres
-   slice → Fragmentação e reconstrução de string
-   space → Encoding baseado em espaços (ASCII length)
-   unicode → Conversão para sequências
-   boolean → Representação com $true / $false
-   decimal → Representação numérica inteira (ASCII)
-   zero → Preenchimento com caracteres zero
-   reverse → Inversão de string com reconstrução
-   base64 → Codificação compatível com EncodedCommand

------------------------------------------------------------------------

💻 Exemplos

Ofuscar string simples: ./obfuscator.ps1 -comand “whoami” -type reverse

Ofuscar comando em Base64: ./obfuscator.ps1 -comand “Get-Process” -type
base64

Exibir ajuda: ./obfuscator.ps1 -h

------------------------------------------------------------------------

⚠️ Notas

-   Use aspas duplas para comandos com caracteres especiais
-   Verifique permissões de execução no PowerShell

------------------------------------------------------------------------

🔐 Objetivo

-   Estudo de técnicas de ofuscação
-   Entendimento de evasão básica
-   Análise de reconstrução de código

------------------------------------------------------------------------

⚡ Frase

Hide the intent. Execute the payload.
