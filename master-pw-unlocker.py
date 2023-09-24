import re
import datetime
import time
import psutil
import requests
import pyautogui
import pywinauto
import win32api
import pygetwindow as gw
from pywinauto.application import Application
from pywinauto import Desktop
from cryptography.fernet import Fernet

pyautogui.PAUSE = 0.25
pyautogui.FAILSAFE = True

key = b'tJ9Vi-HZfADG94nAwdZtm6vbu_GL09T_CtFa2fY4KEk='

def open_search():
    pyautogui.hotkey('winleft', 's')

def descriptografar(senha_criptografada):
    f = Fernet(key)
    mensagem = f.decrypt(senha_criptografada).decode()
    return mensagem


def gen():
    agora = datetime.datetime.now()
    dia = agora.day
    hora = agora.hour
    fator = ((((dia + hora) * 4.27) + 99783.6) ** 3) + (hora * 100)
    senha = fator % 100000000
    return int(senha)


currentpw = gen() % 100000000

url = 'https://server.example.com/mpunlocker/'
data = {'password': currentpw}

# Usando o Scroll Lock como um pequeno artifício para prevenir que terceiros que acessam a máquina desbloqueiem acidentalmente a senha mestra.
# O código foi construído para substituir uma das teclas de atalho do teclado (neste exemplo, coloquei a tecla de busca). Se pressionada sem o Scroll Lock ativado, a função normal da tecla será executada; do contrário, rodaremos o código de desbloqueio.
scroll_lock_state = win32api.GetKeyState(0x91)
scroll_is_enabled = scroll_lock_state == 1 or scroll_lock_state == -127
processos_em_execucao = psutil.process_iter(attrs=['name'])
browser_em_execucao = any(
    p.info['name'] == 'brave.exe' for p in processos_em_execucao)

try:
    # "verify=False" para certificados SSL autoassinados
    response = requests.post(url, data=data, verify=True)

    print(response.status_code)
    if response.status_code == 200:

        if scroll_is_enabled and browser_em_execucao:
            pyautogui.press('scrolllock')
            windows = gw.getWindowsWithTitle('Brave')

            if len(windows) > 0:
                window = windows[0]
                window.activate()
                window.maximize()

                if window.title != "Nova guia - Brave":
                    pyautogui.hotkey('ctrl', 't')
                    newtab = True
                else:
                    newtab = False
                parte_do_titulo = " - Brave"
                pyautogui.hotkey('ctrl', 'shift', 'f')
                time.sleep(0.25)

                desktop = Desktop(backend="uia")
                janela = desktop.window(
                    title_re=fr".*{parte_do_titulo}.*", top_level_only=False)

                if janela.exists():
                    campo_de_texto = janela["Edit"]
                    if campo_de_texto.exists():
                        campo_de_texto.set_text(descriptografar(response.text))
                        pyautogui.press('enter')
                        time.sleep(1.25)
                        pyautogui.hotkey('ctrl', 'shift', 'f')
                        if newtab == True:
                            pyautogui.hotkey('ctrl', 'w')
                    else:
                        print("Controle de entrada de texto não encontrado.")
                else:
                    print("Janela não encontrada.")
        elif not (scroll_is_enabled):
            open_search()
    else:
        open_search()
except requests.exceptions.RequestException as e:
    if not (scroll_is_enabled):
        open_search()