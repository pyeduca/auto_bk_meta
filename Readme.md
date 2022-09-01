# Backup automático 

El repositorio está conformado por 4 archivos principales
* **autoDataBase.sh :** Script principal, se ejecuta en la maquina donde se almacenará los backup 
* **driveSinc.sh :** Se ejecuta desde una maquina donde se tenga una sesion de drive iniciada.
* **estandar.sh :** Crea los directorios necesarios.


## Instalación

1. Configurar servidor remoto
 
Auto login para acceder a  la base de datos.

Proceso a ser realizado en el servidor del cual se quiere hacer el backup.
https://stackoverflow.com/questions/16786011/postgresql-pgpass-not-working
* Crear fichero .pgpassh


```bash
sudo nano .pgpass
```



> #hostname:port:database:username:password

ej.

>localhost:5432:meta:meta:meta

- Se otorgan permisos 600 al archivo.

```bash
sudo chmod 600 .pgpassh
```
2. Configurar máquina local.
* Crear directorios de almacenamiento.
Se ejecuta por única vez.

```bash
sh estardar.sh
```

* Configurar crontab. Se configura según criterio necesario, se puede modificar de ser necesario.

Agregar en el archivo la orden 
```bash
crontab -e
``` 

_Formato de instrucción:_

**m h d ms ds comando**

**m**: minuto (0-59).

**h**: hora (0-23).

**d**: dia (1-31).

**ms**: mes (1-12).

**ds**: dia de la semana (0-6). "0" coresponde a domingo.

comando: comando a ser ejecutado

**Ej.**

**1 6 * * *  sh ~/Backup/autoDataBase.sh > ~/Backup/LogShell_$(date '+\%Y-\%m-\%d-\%T').txt 2>&1** 

Ejecuta el script autoDataBase.sh 
a las 6:01 todos los días, todos los meses, todos los días de la semana. Adicional crea un archivo txt donde registra todo el proceso. 


* Subir al drive copias de seguridad. 


Para subir al drive de forma automática se ejecuta el script driveSinc.sh, desde una máquina donde se tenga iniciada la sesión de google.
```bash
sh driveSinc.sh

``
Se podría crear un nueva tarea de crontab si es que se requiere.

* Soporte 
**Rodney Rojas.** 
**rrojas@paraguayeduca.org**
