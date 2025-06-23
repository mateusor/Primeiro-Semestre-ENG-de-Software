print("Hello, ESP32!")

import network
from machine import Pin
from time import sleep
led = Pin(19, Pin.OUT)
led_2 = Pin(4, Pin.OUT)
led_3 = Pin(16, Pin.OUT)

try:
    import usocket as socket
except:
    import socket

rede = network.WLAN(network.STA_IF)
rede.active(True)
print(rede.scan())

rede.connect("Wokwi-GUEST", "")
while not rede.isconnected():
    print(".", end = "")
    sleep(0.5)

print(rede.ifconfig())

def web_page():
    html = """
        <html><titlex></title>
        <body> <H1> SLMM </H1> </body>
        </html>"""
    return html

s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
s.bind(('',80))
s.listen(5)
print("Wait connection...")
while True:
    conn,addr = s.accept()
    print("Conectado de %s" % str(addr))
    request = conn.recv(1024)
    request = str(request)
    print(request)
    resp = request.find("/on")
    if resp > 0:
        led.value(1)
        led_2.value(1)
        led_3.value(1)
    resp = request.find("/off")
    if resp > 0:
        led.value(0)
        led_2.value(0)
        led_3.value(0)
    conn.send("HTTP/1.1 200 OK/n")
    conn.send("Content-Type: text/html\n")
    conn.send("Connection close\n\n")
    response = web_page()
    conn.sendall(response)
    conn.close()