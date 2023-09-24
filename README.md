# Master Password Unlocker
---

## Descrição
Automatização para desbloqueio de senha mestra, utilizando uma abordagem de segurança não convencional. O código de exemplo desbloqueia um cofre do navegador Brave, na extensão PfP: Pain-free Passwords; no entanto, é facilmente adaptável para trabalhar em outras aplicações e contextos.

O objetivo desse software é tentar balancear a relação segurança x conveniência, fornecendo um meio relativamente seguro de armazenar e desbloquear a senha de um cofre digital. Esse software não tem o intuito de ser, necessariamente, uma solução robusta, mas a mera demonstração de um conceito. Ainda assim, se aliado a outras medidas de segurança, pode ser até mesmo mais eficiente que outras abordagens (por exemplo, nenhum tipo de screenlogger ou keylogger, até o "invencível" keylogger físico, seria capaz de capturar a senha mestra, em virtude da base funcional do código - embora um ataque direto a este software possa ser fatal, se não for aprimorado para proteger os dados sensíveis da memória em outras camadas de criptografia).

## Mais umas camadas de segurança
É recomendável que o servidor aonde a senha criptografada vai ficar armazenada (no index.php) tenha um recurso de lista branca que restrinja/isole o máximo possível o acesso de terceiros, filtrando por IP. Além disso, usar um sistema de banimento para bloquear tentativas de invasão. Para esses dois casos, indico as seguintes documentações como orientação geral:
  - [Lista branca no nginx com atualização de IPs dinâmicos](https://guides.wp-bullet.com/auto-whitelist-multiple-dynamic-dns-addresses-for-nginx-security/)
  - [Configurar fail2ban para banir solicitações proibidas no nginx](https://guides.wp-bullet.com/configure-fail2ban-to-ban-nginx-403-forbidden-requests/)

## Referências
- [Hidec](https://github.com/tostercx/hidec): software para ocultar a janela do Prompt de Comando que roda o Python

- [PfP: Pain-free Passwords](https://github.com/palant/pfp): extensão de cofre virtual para navegadores
