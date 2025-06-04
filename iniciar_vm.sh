#!/bin/bash

CONTAINER_NAME="ubuntu-xfce-vnc"

# Comprobar si el contenedor ya está en ejecución
if sudo docker ps --format '{{.Names}}' | grep -q "^${CONTAINER_NAME}$"; then
    echo "El contenedor '$CONTAINER_NAME' ja està en execució."
else
    echo "Iniciant el contenidor '$CONTAINER_NAME'..."
    sudo docker run -d \
        -p 5901:5901 -p 2222:22 \
        -e USER=docker \
        --name $CONTAINER_NAME \
        ubuntu-xfce-vnc

    sleep 3
    echo "Contenidor iniciat."
fi

echo ""
echo "Connecta't des de Remmina:"
echo "   - Protocol: VNC"
echo "   - Adreça: 127.0.0.1:5901"
echo "   - Contrasenya: docker"
echo ""
echo " Connexió SSH (opcional):"
echo "   ssh docker@127.0.0.1 -p 2222"
echo "   Contrasenya: docker"
echo ""
echo " Per veure logs: sudo docker logs -f $CONTAINER_NAME"
echo " Per parar el contenidor: sudo docker stop $CONTAINER_NAME"
