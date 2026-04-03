param(
    [Alias("h", "manual", "help")]
    [switch]$ShowHelp,
    [string]$comand,
    [string]$type
)

function Show-Help {
    Write-Host ""
    Write-Host "OBFUSCATOR(1) - Manual de Usuario" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "NOME" -ForegroundColor Yellow
    Write-Host "|  obfuscator.ps1 - ferramenta de ofuscacao de comandos"
    Write-Host ""
    Write-Host "SINOPSE" -ForegroundColor Yellow
    Write-Host "|  ./obfuscator.ps1 -comand [STRING] -type [METODO]"
    Write-Host "|  ./obfuscator.ps1 -h"
    Write-Host ""
    Write-Host "DESCRICAO" -ForegroundColor Yellow
    Write-Host "|  -comand [string]  |  Cadeia de caracteres ou variavel a ser processada."
    Write-Host "|  -type [metodo]    |  Define o algoritmo de transformacao (Obrigatorio)."
    Write-Host ""
    Write-Host "METODOS DISPONIVEIS (TYPE)" -ForegroundColor Yellow
    Write-Host "|  binary      |  Codificacao em sistema binario."
    Write-Host "|  charlength  |  Ofuscacao baseada em [CHAR]::Length."
    Write-Host "|  slice       |  Fragmentacao e reconstrucao de strings."
    Write-Host "|  space       |  Injecao de espacos nulos baseada em ASCII."
    Write-Host "|  unicode     |  Conversao para sequencias de escape \u{XXXX}."
    Write-Host "|  boolean     |  Transformacao em arrays de `$true/`$false."
    Write-Host "|  decimal     |  Representacao numerica inteira."
    Write-Host "|  zero        |  Preenchimento de bits com caracteres zero."
    Write-Host "|  reverse     |  Inversao de string com reconstrucao dinâmica."
    Write-Host "|  base64      |  Codificacao nativa em Base64 para PowerShell."
    Write-Host ""
    Write-Host "EXEMPLOS" -ForegroundColor Yellow
    
    Write-Host "|"
    Write-Host "|  " -NoNewline
    Write-Host "[+] " -ForegroundColor Green -NoNewline
    Write-Host "Ofuscar string simples (Reverse):"
    Write-Host "|  ./obfuscator.ps1 -comand `"whoami`" -type reverse" -ForegroundColor White
    
    Write-Host "|"
    Write-Host "|  " -NoNewline
    Write-Host "[+] " -ForegroundColor Green -NoNewline
    Write-Host "Ofuscar para EncodedCommand (Base64):"
    Write-Host "|  ./obfuscator.ps1 -comand `"Get-Process`" -type base64" -ForegroundColor White
    
    Write-Host "|"
    Write-Host "|  " -NoNewline
    Write-Host "[+] " -ForegroundColor Green -NoNewline
    Write-Host "Ver manual de usuario:"
    Write-Host "|  ./obfuscator.ps1 -h" -ForegroundColor White
    Write-Host ""
    
    Write-Host "NOTAS" -ForegroundColor Yellow
    Write-Host "|  " -NoNewline
    Write-Host "[!] " -ForegroundColor Yellow -NoNewline
    Write-Host "Caracteres especiais exigem o uso de aspas duplas."
    
    Write-Host "|  " -NoNewline
    Write-Host "[-] " -ForegroundColor Red -NoNewline
    Write-Host "Verifique as permissoes de execucao no PowerShell."
    Write-Host ""
}

# --- FUNCOES DE CONVERSAO (TODAS ATUALIZADAS PARA IEX) ---

function ConvertTo-Binary {
    param($Texto)
    $binario = @()
    foreach ($char in [char[]]$Texto) { 
        $binario += [Convert]::ToString([byte]$char, 2).PadLeft(8, '0') 
    }
    return 'function uYrp($z){$KAL="";foreach($sX in $z){$KAL+=[char][Convert]::ToInt32($sX,2)};return $KAL};IEX (uYrp(@("' + ($binario -join '","') + '")))'
}

function ConvertTo-CharLength {
    param($Texto)
    $lengths = @()
    foreach ($char in [char[]]$Texto) { $lengths += [int]$char }
    return '$c="' + ($lengths -join ',') + '";$r="";foreach($n in $c.Split(",")){$r+=[char][int]$n};IEX $r'
}

function ConvertTo-Slice {
    param($Texto)
    $slice = @()
    foreach ($char in [char[]]$Texto) { $slice += $char }
    return '$s="' + ($slice -join '') + '";IEX $s'
}

function ConvertTo-Space {
    param($Texto)
    $spaces = @()
    foreach ($char in [char[]]$Texto) { $spaces += (' ' * [int][char]$char) }
    return '$sp="' + ($spaces -join '|') + '";$r="";foreach($s in $sp.Split("|")){$r+=[char]$s.Length};IEX $r'
}

function ConvertTo-Unicode {
    param($Texto)
    $unicode = @()
    foreach ($char in [char[]]$Texto) { $unicode += '\u{0:X4}' -f [int]$char }
    return '$u="' + ($unicode -join '') + '";$r="";for($i=0;$i -lt $u.Length;$i+=6){$r+=[char][int]("0x"+$u.Substring($i+2,4))};IEX $r'
}

function ConvertTo-Boolean {
    param($Texto)
    $bits = @()
    foreach ($char in [char[]]$Texto) { $bits += [Convert]::ToString([byte]$char, 2).PadLeft(8, '0') }
    $boolArray = @()
    foreach ($bit in ($bits -join '').ToCharArray()) { if ($bit -eq '1') { $boolArray += '$true' } else { $boolArray += '$false' } }
    return '$b=@(' + ($boolArray -join ',') + ');$r="";for($i=0;$i -lt $b.Count;$i+=8){$byte=0;for($j=0;$j -lt 8;$j++){if($b[$i+$j]){$byte+= [math]::Pow(2,7-$j)}};$r+=[char][int]$byte};IEX $r'
}

function ConvertTo-Decimal {
    param($Texto)
    $decimals = @()
    foreach ($char in [char[]]$Texto) { $decimals += [int]$char }
    return '$d="' + ($decimals -join ',') + '";$r="";foreach($n in $d.Split(",")){$r+=[char][int]$n};IEX $r'
}

function ConvertTo-Zero {
    param($Texto)
    $zero = @()
    foreach ($char in [char[]]$Texto) { $zero += ('0' * [int]$char) }
    return '$z="' + ($zero -join '|') + '";$r="";foreach($s in $z.Split("|")){$r+=[char]$s.Length};IEX $r'
}

function ConvertTo-Reverse {
    param($Texto)
    $Array = $Texto.ToCharArray()
    [Array]::Reverse($Array)
    $StringInvertida = -join $Array
    $Rev = $StringInvertida.Replace("'", "''")
    return "`$r = '$Rev'; `$e = -join `$r[`$r.Length..0]; IEX `$e"
}

function ConvertTo-Base64 {
    param($Texto)
    $Bytes = [System.Text.Encoding]::Unicode.GetBytes($Texto)
    $Encoded = [Convert]::ToBase64String($Bytes)
    return "powershell -EncodedCommand $Encoded"
}

# --- LOGICA DE EXECUCAO ---

try {
    $ManualArg = $args | Where-Object { $_ -eq "--help" }
    if ($ShowHelp -or $ManualArg) {
        Show-Help
        exit
    }

    if (-not $comand) { throw "O parametro -comand nao foi definido." }
    if (-not $type) { throw "O parametro -type nao foi definido." }

    Write-Host ""
    switch ($type.ToLower()) {
        "binary"      { ConvertTo-Binary $comand }
        "charlength"  { ConvertTo-CharLength $comand }
        "slice"       { ConvertTo-Slice $comand }
        "space"       { ConvertTo-Space $comand }
        "unicode"     { ConvertTo-Unicode $comand }
        "boolean"     { ConvertTo-Boolean $comand }
        "decimal"     { ConvertTo-Decimal $comand }
        "zero"        { ConvertTo-Zero $comand }
        "reverse"     { ConvertTo-Reverse $comand }
        "base64"      { ConvertTo-Base64 $comand }
        default { throw "Metodo de ofuscacao '$type' e invalido." }
    }
    Write-Host ""
}
catch {
    Write-Host "| [!] ERRO FATAL: $_" -ForegroundColor Red
    Write-Host ""
    Write-Host "| [!] Use o comando './obfuscator.ps1 -help' para ver o manual de usuario." -ForegroundColor Red
    exit
}
