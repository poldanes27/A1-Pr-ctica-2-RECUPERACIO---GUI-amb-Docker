# Ubuntu 24.04 amb XFCE, VNC, VSCode, Python i SSH (Docker)

Aquest projecte crea una imatge Docker basada en Ubuntu 24.04 amb un entorn gràfic complet (XFCE) accessible via VNC i SSH. Està pensat per ser utilitzat en una màquina virtual Ubuntu (VirtualBox) amb redirecció de ports per accedir des del sistema host.

L'objectiu és tenir un entorn gràfic des d'on es pugui programar en Python utilitzant Visual Studio Code, dins d’un contenidor Docker.

## Contingut del projecte

- Ubuntu 24.04 com a sistema base
- XFCE com a entorn d'escriptori
- VNC per accés gràfic remot
- Visual Studio Code preinstal·lat
- Python 3 i pip
- SSH per accés en mode terminal

## Fitxers del projecte

- `Dockerfile`: defineix la imatge Docker amb tot el necessari instal·lat i configurat.
- `scripts/startup.sh`: script executat pel servidor VNC per iniciar l'entorn XFCE.
- `iniciar_vm.sh`: script per arrancar fàcilment el contenidor Docker amb els ports adequats.
- `README.md`: aquest document explicatiu.

## Requisits previs

- Docker instal·lat a la màquina virtual Ubuntu 24.04
- Redirecció de ports configurada a VirtualBox:
  - Port 5901 (VNC)
  - Port 2222 (SSH)
- Client VNC instal·lat al sistema host (com Remmina)

## Com construir i executar el projecte
- Per Construir la imatge executar "sudo docker build -t ubuntu-xfce-vnc ."
- Per executar el projecte utilitzar "sudo ./iniciar_vm.sh"

## Conexions

- Per probar les diferents conexions podem utilirzar
- SSH: 
- ssh docker@127.0.0.1 -p 2222
# Contrasenya: docker
- VNC:

- Protocol: VNC
- Host: 127.0.0.1
- Port: 5901
- Contrasenya: docker
