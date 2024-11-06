#!/bin/bash
#Archivo donde almacenaremos los resultados
OUTPUT="reporte_recursos.txt"
#Tiempo de monitoreo
TOTAL_TIME=300
#Intervalo de captura
INTERVAL=60
#encabezado del archivo de salida
echo "Tempo, % Total de CPU libre, % Memoria Libre, % Disco Libre" > $OUTPUT
#Tiempo transcurrido
ELAPSED=0
while [ $ELAPSED -lt $TOTAL_TIME ]; do
	#Captura % de CPU libre
	CPU_FREE=$(top -bn1 | grep "Cpu(s)" | awk '{print 100 - $8}')
	#Captura % de memoria libre
	MEM_FREE=$(free | grep Mem | awk '{print $4/$2 * 100.0}')
	#Captura % de disco libre en el sistema raiz
	DISK_FREE=$(df -h / | grep / | awk '{print 100 - $5}' | sed 's/%//')
	#Guardar en el archivo de salida
	echo "${ELAPSED}s, ${CPU_FREE}, ${MEM_FREE}, ${DISK_FREE}" >> $OUTPUT
	#Esperar el intervalo antes de la siguiente captura de datos
	sleep $INTERVAL
	ELAPSED=$((ELAPSED + INTERVAL))
done
