Examen parcial
Giancarlo Lopez
I698281

Ejercicio 1

En este ejercio se utlizo 
se debe tener una cuenta en digital ocean porque se utilizara para configurar las variables
en el archivo de roles en main.yml de wordpress dentro de playbooks
donde se deben introducir: usuario, password y correo de digitalocean
    
1. terraform init para inicializar el recurso
2. luego se uso terraform plan para revisar que estuviere error y verlo
3. luego con terraform apply se pudo aplicar todo a digitalocean para cargar tanto la vpc, y los dos servidores
   con la cuenta, password, email que tiene digitalocean registrado.
4. se hara un destroy de lo creado en ditialocean para su eliminacion de la practica de ambos tanto 
   el server web como la base de datos.


Ejercicio 2

Para la implementacion de esto se utulizo vagran para realizar lo solicitado,
se agrego varias vagran cloud pero la que me funciono para utilizar docker fue:
williamyeh/ubuntu-trusty64-docker dado que probe varias pero no funcionaba el docker
como la siguientes config.vm.box = "phusion/ubuntu-14.04-amd64", config.vm.box = "williamyeh/centos7-docker",
config.vm.box = "thdengops/ubuntu-14.04-dev".

Luego de haberlas probado hice la implementacion llamando
1. vagrant init para empezar a trabajar en la realizacion 
2. vagrant up que con ello se empezo a crear las 2 VM que son: managerV & workerV
3. luego al terminar sigue de revisar el estatus de vagrant con : vagrant status, se instalo un 
   plug-in para que lo pudiera correr en vmware desktop dado que solo en virtualbox me corrian.
4. luego por via SSH pude crear el nodo para la utilizacion del managerV al workerV con el comando
vagrant ssh managerV y asi poder usar el doker swarm con la direccion ip 192.168.198.1 managerV
ip 192.168.198.2 workerV.
estas son nuestras VM hechas
PS C:\Users\Dell 5570\Desktop\parcial1\ej2> vagrant status
Current machine states:

managerV                  running (vmware_desktop)
workerV                   running (vmware_desktop)
vagrant@managerv ~ $ docker swarm init --advertise-addr 192.168.198.1 para crear el swarm
luego en la workerV le dariamos el join 
vagrant@workerv ~ $ docker swarm join \
>     --token SWMTKN-1-1aets3e3ckk6ebi032e5cywe1nxe86y3eugxbjed2m0t2wm9w3-athagggvska9in4w18xojaciv \
>     192.168.198.1:2377
y ya con ello estaria agregado el el worker al managerV
vagrant@managerv ~ $ docker node ls
ID                           HOSTNAME   STATUS  AVAILABILITY  MANAGER STATUS
6sekjp3x2b6rrcor5t14deu7w *  localhost  Ready   Active        Leader
blp7a3wea43pc4isrc2kgqls4    localhost  Ready   Active
luego usaremos vagrant destroy para eliminar las 2 VM
end.

