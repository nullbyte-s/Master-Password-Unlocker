import os
import base64
from cryptography.fernet import Fernet

# Gerar uma nova chave aleatória de 32 bytes
# key = base64.urlsafe_b64encode(os.urandom(32))
# print(key)
key = b'tJ9Vi-HZfADG94nAwdZtm6vbu_GL09T_CtFa2fY4KEk='


def criptografar(senha):
    f = Fernet(key)
    senha_criptografada = f.encrypt(senha.encode())
    return senha_criptografada


def descriptografar(senha_criptografada):
    f = Fernet(key)
    senha = f.decrypt(senha_criptografada).decode()
    return senha


senha = input("Digite a senha: ")
opcao = input("Criptografar (C) ou descriptografar (D)? ").upper()

if opcao == 'C':
    senha_criptografada = criptografar(senha)
    print("senha criptografada: ", senha_criptografada)
elif opcao == 'D':
    senha_criptografada = input(
        "Digite a senha criptografada: ").encode()
    senha = descriptografar(senha_criptografada)
    print("senha descriptografada: ", senha)
else:
    print("Opção inválida.")