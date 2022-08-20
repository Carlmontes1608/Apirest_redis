# Reto PULPO
---------------

API para uso de cola de mensajes de Redis

## Solución entregada
---------------
![fullPythonAPI]
## API
---------------
Se desarrolla API en lenguaje PYTHON, utilizando FLASK como framework y dividiendo en metodos para un mejor entendimiento, esta contiene 5 endpoints para diferentes acciones, cada uno será explicado a continuación, indicando el resultado que se obtendrá de cada uno, el API a su vez crea un healtcheck y un validador de info del sistema en un docker-compose en una maquina local, la idea es poder con mas tiempo pasarlo a una EC2 en AWS dockerizado y aperturar los puertos de los security groups que requiera el reto.

[Demo Redis]  [docker-compose.yml]

Endpoint de inicio: [docker-compose.yml[main.py] este endpoint está configurado para confirmar que la API se encuentra en ejecución y lista para su consumo.

Endpoint de salud de redis: [docker-compose.yml[main.py] a través de este endpoint el usuario podrá conocer el estado de salud de redis, conociendo si el servidor de redis se encuentra funcional o no, antes de realizar cualquier otra petición.

Endpoint pop mensaje: [docker-compose.yml[main.py] a través de este endpoint el usuario podrá obtener el primer valor que se encuentra en la cola y este será eliminado de dicha cola, esto si la cola ya tiene mensajes guardados, en caso de que no tenga mensajes se indicará en el resultado del consumo.

Endpoint push mensaje: [docker-compose.yml[main.py] a través de este endpoint el usuario podrá insertar un mensaje en la cola redis.

Endpoint count mensajes: [docker-compose.yml[main.py] a través de este endpoint el usuario podrá obtener la cantidad de mensajes que se encuentran en la cola redis en un momento específico de tiempo.

## Bonus
---------------
*Docker:* La aplicación se encuentra contenerizada, a través de docker-compose se configuran dos servicios para el funcionamiento de la aplicación, uno de estos servicios esta configurado para levantar un servidor de redis utilizado como cola en la aplicación, otro de los servicios se configura para obtener la imagen de la aplicación de python y levantar el servicio dentro del servidor.

Esta imagen se crea/actualiza con un Dockerfile que hace referencia al py del build de la aplicación de python y un docker compose con las configuraciones adecuadas. Como uno de los beneficios más importantes de "dockerizar" una aplicación está la portabilidad y la facilidad de despliegue en cualquier máquina, ya sea una personal, un servidor on premise o en nube.

![DockerRunning](En la documentacion de Word)

*GitHub:* En el siguiente link se encuentra todo el proyecto para que pueda ser consultado y clonado https://github.com/Carlmontes1608/Apirest_redis

*Test unitarios:* Se desarrollan tests unitarios que ayudan a verificar funcionamiento de los servicios y controladores desarrollados, dando entrada a mejoras en el código y refactorizaciones que ayudan a mejorar su rendimiento.

![TestReport](En la documentacion de Word)

*Autenticación:* Se muestra como seria una autenticación con JWT (JSON Web Token), en donde antes de realizar cualquier petición se debe realizar un login en la aplicación con un usuario y contraseña que se encuentran cargados en BD H2, a su vez estas entidades podrían estar cargadas en un proveedor de identidad como Directorio Activo de Microsoft o AWS Cognito y en ese caso la validación se haría contra uno de esos proveedores. El JWT que retorna el endpoint de login se debe agregar en la cabecera de los métodos de la API para su correcto funcionamiento.
(En la documentacion de Word)

*Endpoint salud redis:* Se desarrolla un endpoint de salud de redis que obtiene una respuesta positiva o negativa dependiendo de si el servidor se encuentra activo o no está en funcionamiento.

## La solución del reto se realizó con el siguiente stack tecnológico:
---------------
* Python 3.7 - 3.10
* Flask 2.1.0
* Docker version 20.10.5
* Git

## Plataforma de despliegue
---------------
* Windowds 10
* Linux/UNIX (ubunntu) dockerizado
* Base de datos H2 en el mismo Ubuntu(Logs)

## Instalación y ejecución del proyecto en máquina local
---------------
Se debe de clonar el repositorio en la rama de producción https://github.com/Carlmontes1608/Apirest_redis
Después de haber clonado se ingresa al root del proyecto y allí se puede ejecutar el comando `docker-compose up -d`, dicho comando iniciará la descarga de las imágenes y pondrá en funcionamiento la aplicación para que pueda ser consumida.

## Propuesta Solución AWS:
---------------

A continuación se documentará otra posible solución que puede ser implementada completamente en AWS, en donde se utilizarían todas las capacidades de dicha nube y se podrían abstraer muchas de las configuraciones por medio de servicios de AWS.

Se entregan credenciales (llave criptográfica) a consumidor externo, dichas credenciales serán usadas para enviar una petición a Cognito, si Cognito encuentra coincidencia entre lo que se tiene almacenado y lo enviado por el consumidor, se retornará un JSON Web Token.
Teniendo este JWT, el consumidor podrá realizar peticiones hacia los métodos tipo REST configurados en API Gateway y este deberá ser incluido en las cabeceras de la petición, en API Gw se tendrá configurado Cognito como la entidad autorizadora y por esta razón API Gw dejará pasar las peticiones que vengan con un JWT autorizado por Cognito, en caso de que el JWT no sea el indicado se devolvería un error 401 Unauthorized. 
Luego de que la petición sea validada por API Gw, este funcionará como Router y enviará el payload de la petición a un VPC Endpoint previamente configurado para trasladar consumos por medio de la red interna de AWS hacia la instancia EC2 que contiene el Docker con el servicio desarrollado, este servicio estará configurado con diferentes métodos para responder según el evento que llegue.