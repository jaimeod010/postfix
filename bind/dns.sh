#!/bin/bash
#interface, resolv,directo,inverso,root,network manager 192.168.0.1
#par1=$1
#Colours
greenColour="\e[0;32m\033[1m"
endColour="\033[0m\e[0m"
redColour="\e[0;31m\033[1m"
blueColour="\e[0;34m\033[1m"
yellowColour="\e[0;33m\033[1m"
purpleColour="\e[0;35m\033[1m"
turquoiseColour="\e[0;36m\033[1m"
grayColour="\e[0;37m\033[1m"
trap ctrl_c INT
whoami |grep -o "root" > /dev/null 2>&1
if [ $? = 0 ]
then
clear
else
echo "no eres el root "
exit 1
fi
while [ true ]
do
clear
echo  "${redColour}----------------------------------------${endColour}"
echo "1-instalar paquete dns"
echo "2-desactivar network manager , añadir ip y dns "
echo "3-configuracion directa db"
echo "4.-configuracion inversa db"
echo "5.-configuracion zone"
echo "6.-salir"
echo  "${redColour}----------------------------------------${endColour}"
read -p "Elige una opcion: " opcion
case $opcion in
1)
echo "Instalando las dns POGSLIDE"# buscar version mas reciente # mostrar la actual
sleep 1
clear
apt policy bind9 | grep -w "ninguno" > /dev/null 2>&1
clear
if [ $? = 0 ]
then
echo "ya LAS tienes instalado las dns  "
echo "${greenColour}
⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⣀⠠⠒⠄⣰⣾⣿⣿⣿⠉⠐⠠⠤⢄⠄⠄⠄⠄⠄⠄
⠄⠄⠄⠄⠄⠄⣠⠔⠊⡽⠄⠄⠄⠄⢸⣿⣿⣿⣿⠃⠄⠄⠄⠄⣷⣦⡄⠄⠄⠄
⠄⠄⠄⠄⡤⠊⠄⠄⠄⡇⠄⠄⠄⠄⠻⣿⣿⣿⣿⡇⠄⠄⠄⠄⣹⣿⣿⡀⠄⠄
⠄⠄⣠⣾⡦⠄⠄⠄⠄⢳⠄⠄⠄⠄⣰⣿⣿⣿⡋⠄⠄⠄⠄⠄⠹⣿⣿⡃⠄⠄
⠄⢀⣹⣿⣷⠄⠄⠄⠄⠘⢆⣀⠄⠄⢋⣭⣭⠭⣶⣬⡛⢋⣴⠟⣣⣬⣍⠃⠄⠄
⠄⣿⣿⣿⣿⣆⡀⠄⠄⠄⣀⣨⣭⣶⢋⣩⣶⣿⣶⠶⣦⡈⠁⣾⣿⠄⠄⠱⡄⠄
⠠⣾⣿⣿⣿⡿⢟⣠⣼⣿⣿⣿⣿⣿⣮⡹⣿⣿⠁⢀⢸⣿⡄⢻⣿⣇⠄⢃⡿⠄
⠄⠈⢋⣉⣵⣾⣿⣿⣿⣿⣿⣿⣿⣿⢸⡇⣿⡇⠄⠋⣸⠋⠄⠄⠈⠉⢉⠥⠖⠁
⣠⣾⣿⣿⠟⣫⣔⣒⠻⣿⣿⣿⠹⣿⡘⠷⣭⣭⣭⡭⣥⠄⠄⠄⠄⠄⢰⣵⣾⡧
⣿⣿⣿⣿⢸⡟⣍⠻⣷⣜⡻⠿⣿⣶⣤⣤⣤⣤⣴⣾⣿⣦⣀⠄⢀⣠⡿⢟⣋⠄
⣿⣿⣿⣿⠸⣧⡹⢿⣮⣙⡻⠷⢦⣭⣛⣛⣛⣛⣛⣛⣛⣛⣛⣫⠭⢖⣚⡍⠁⠄
⢿⣿⣿⣿⣧⡻⢷⣤⣀⠄⠙⠛⠷⣦⣬⣭⣭⣭⣭⡍⠉⠁⠄⠄⢀⠰⠛⠄⠄⠄
⣦⡙⢿⣿⣿⣿⣷⣮⣝⡻⠷⠶⢤⣤⣬⣭⣭⡭⠥⢤⣤⡤⠶⣊⠁⠄⠄⠄⠄⠄
⣿⣿⣦⣭⣛⠻⠿⠿⢟⡻⠐⢃⠒⢥⣤⣄⢤⠠⢈⠂⣵⣶⣾⣿⣆⠄⠄⠄⠄⠄
⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠐⠂⠴⢞⠒⠒⡸⠐⢬⢀⣿⣿⣿⣿⣿⣷⡄⠄⠄⠄${endColour}"
sleep 1
else
apt update
apt install bind9 -y > /dev/null 2>&1
fi
;;
2)
clear
###quitarnetworkmanager,ponernetworkmanager,configuracioninterfaz,resol
quitarnetworkmanager(){
clear
systemctl disable NetworkManager > /dev/null 2>&1
echo "quitando networkmanager"
}
ponernetworkmanager(){
clear
systemctl enable NetworkManager > /dev/null 2>&1
echo "activando network_manager"
}
 
configuracioninterfaz(){
#podria poner para que se quedara guardada o si quiere añadir que si lo pongo asi lo borra todo
ip link|grep -E "enp|eth"| cut -d : -f2>tarjetas.tmp
interfazja=$(cat tarjetas.tmp |sed 's/00//g')
rm -f tarjetas.tmp
clear
echo "Interfaces disponibles : \n ""$interfazja"""
read -p "dime la interfaz que quieres : " interfaz
read -p "dime que ip quieres : " ip
read -p "pon la mascara que quieres : " mascara
read -p "puerta de enlace (si no quieres pon: no ) : " penlace
read -p "dime el broadcast : " broadcast
read -p "Dime que red quieres " red
echo " " > /etc/network/interfaces
echo "source /etc/network/interfaces.d/*" >> /etc/network/interfaces
echo "auto lo" >> /etc/network/interfaces
echo "iface lo inet loopback" >> /etc/network/interfaces
echo "auto $interfaz " >> /etc/network/interfaces
echo "iface $interfaz inet static " >> /etc/network/interfaces
echo "address $ip" >> /etc/network/interfaces
echo "netmask $mascara" >> /etc/network/interfaces
if [ "$penlace" = no ]
then
echo "no te pongo p enlace"
else
echo "gateway $penlace" >> /etc/network/interfaces
fi
echo "broadcast $broadcast" >> /etc/network/interfaces
echo "network $red" >> /etc/network/interfaces
systemctl restart #reinicio red
clear
echo "Asi tienes tu configuracion"
cat /etc/network/interfaces
sleep 2
clear
}
#por si no quiero tocar el resolv.conf
#dns-nameservers 192.168.208.1
#dns-search jaime.org
resol(){
clear
read -p "dime dominio de busqueda (por ejemplo :jaime.org) : " dominio
read -p "dime ip del nameserver : " ipnameserver
echo " " > /etc/resolv.conf
echo "nameserver $ipnameserver" >> /etc/resolv.conf
echo "search $dominio" >> /etc/resolv.conf
}
while [ true ]
do
clear
echo "${blueColour}----------------------------------------${endColour}"
echo "10-activar network manager (no obligatoria)"
echo "20-desactivar network manager "
echo "30-configurar la interfaz"
echo "40.-resolucion dns"
echo "50.-atras"
echo "${blueColour}----------------------------------------${endColour}"
read -p "Elige una opcion: " opcionip
case $opcionip in
10)
ponernetworkmanager
;;
20)
quitarnetworkmanager
;;
30)
configuracioninterfaz
;;
40)
resol
;;
50)
break
esac
done
;;
3)
while [ true ]
do
clear
echo "${turquoiseColour}----------------------------------------${endColour}"
echo "70-añadir directa (primero creas, luego agregas)"
echo "80-añadir cname a la directa"
echo "90.-atras"
echo "${turquoiseColour}----------------------------------------${endColour}"
read -p "Elige una opcion: " opciondirecta
case $opciondirecta in
70)
cd /etc/bind
read -p "quieres crear un archivo nuevo (s/n) : " archivonuevo
if [ "$archivonuevo" = s ]
then
read -p "como quieres llamar al archivo : " nombrearchivo
cp db.local db."$nombrearchivo"
sed -i s/localhost/"$nombrearchivo"/g  db."$nombrearchivo"
sed -i s/127.0.0.1/"$ip"/g  db."$nombrearchivo"
else
read -p "dime el nombre del archivo : " nombrearchivo
read -p "dime el nombre del dns : " nombredns
read -p " ip del nombre del dns anterior : " ipnombredns
echo "$nombredns  IN      A       $ipnombredns" >> /etc/bind/db."$nombrearchivo"
fi
;;
80)
read -p "Dime un nombre añadirlo al cname : " nombredelnocname
echo """$nombredelnocname""     IN       CNAME  server" >> /etc/bind/db."$nombrearchivo"
;;
90)
break
esac
done
;;
4)
while [ true ]
do
clear
echo "${yellowColour}----------------------------------------${endColour}"
echo "100-añadir inversa"
echo "200.-atras"
echo "${yellowColour}----------------------------------------${endColour}"
read -p "Elige una opcion: " opciondirecta
case $opciondirecta in
100)
cd /etc/bind
read -p "dime que ip quieres para el servidor : " ip
read -p "como quieres llamar al archivo inversa : " nombrearchivoinversa
read -p "dominio de busqueda (jaime.org) : " nombrearchivo
cp db.local db."$nombrearchivoinversa"
sed -i s/localhost/"$nombrearchivo"/g  db."$nombrearchivoinversa"
sed -i s/127.0.0.1/"$ip"/g  db."$nombrearchivoinversa"
echo "vale dime solo 1 nombre para la inversa"      
read -p "dime el nombre del dns : " nombrednsinversa8
read -p " ip del nombre del dns anterior : " ipnombrednsinversa89
echo $nombrednsinversa8  IN      A       $ipnombrednsinversa89.$nombrearchivo. >> /etc/bind/db."$nombrearchivo"
##configuracion inicial
;;
200)
break
esac
done
;;
5)
clear
echo "vamos a configurar los zones"
#####funciones
directazone(){
ls /etc/bind/*db.*| cut -d / -f4
read -p "dime el archivo que quieres poner en el archivo (son los que te acabo de enseñar y tienes que poner el nombre completo) : " archivozone
read -p "dime el dominio de busqueda (jaime.org)" dominiodeloszone
echo "zone ""$dominiodeloszone""{ " >> /etc/bind/named.conf.local
echo "       type master; "  >> /etc/bind/named.conf.local
echo "       file '/etc/bind/"$archivozone"'; "  >> /etc/bind/named.conf.local
echo " };" >> /etc/bind/named.conf.local
sed -i s/\'/\"/g  /etc/bind/named.conf.local
}
inversazone(){
ls /etc/bind/*db.*| cut -d / -f4
read -p "dime el archivo que quieres poner en el archivo (son los que te acabo de enseñar y tienes que poner el nombre completo) : " archivozoneinversa
echo "zone ""$archivozoneinversa".IN-ADDR.ARPA"{ " >> /etc/bind/named.conf.local
echo "       type master; "  >> /etc/bind/named.conf.local
echo "       file '/etc/bind/"$archivozone"'; "  >> /etc/bind/named.conf.local
echo " };" >> /etc/bind/named.conf.local
sed -i s/\'/\"/g  /etc/bind/named.conf.local
}
while [ true ]
do
clear
echo "${grayColour}----------------------------------------${endColour}"
echo "a-añadir directa"
echo "b-añadir inversa"
echo "c.-atras"
echo "${grayColour}----------------------------------------${endColour}"
read -p "Elige una opcion: " opcionzone
case $opcionzone in
a)
directazone
;;
b)
inversazone
;;
c)
break
;;
*)
echo "opcion incorrecta, elija una opcion correcta  por favor"
;;
esac
done
;;
6)
clear
echo "salida exitosa ${purpleColour}            
⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠿⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
⣿⣿⣿⣿⣿⣿⣿⣟⠝⠃⠉⠉⠉⠐⠋⢟⣿⠻⠍⠛⠛⠛⠫⣿⣿⣿⣿⣿⣿⣿
⣿⣿⣿⣿⣿⢟⠝⠁⠀⢀⡠⠤⠤⠤⠄⣀⠱⡀⠀⠀⠀⠀⠀⠈⠎⣿⣿⣿⣿⣿
⣿⣿⣿⣿⢏⠂⠀⠀⠘⠁⠀⠀⠀⣀⣀⣀⣉⣫⡉⠉⠉⠉⣉⣉⣊⣛⠹⡻⣿⣿
⣿⣿⢹⠟⡟⠷⣦⣄⠀⡀⠤⣪⠝⣖⣉⣉⠉⠶⣊⣷⣎⣛⠳⡶⣶⡚⣟⣡⣮⣭
⣿⠣⠁⠸⠃⠀⠀⠙⠿⣿⣿⣷⣾⣿⣿⣿⣿⣿⣿⡿⠉⣿⣿⣿⣿⣿⣿⣿⣿⣿
⢷⠁⠀⠀⠀⠀⠀⠀⠀⠹⣿⣿⣿⣿⣿⣿⣿⣿⣟⠕⠒⠘⠿⢿⣿⣿⣿⣿⣿⣵
⡆⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠙⠛⣛⡫⠝⠋⠀⠀⠠⢤⣤⠤⠤⢔⣮⣾⣿⣿
⡇⠀⠀⠀⠀⠀⠀⠀⡠⠤⣀⠀⠀⠈⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠱⣻⣿⣿
⣷⣄⠀⠀⠀⠀⠀⢸⡀⠠⣀⠑⠢⠤⣀⣀⡀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣠⠽⢻⣿
⣿⣿⣷⣦⣄⡀⠀⠀⠑⠤⣀⡉⠒⠂⠤⠤⢌⣉⣉⣉⣁⣀⣀⣉⣉⡁⢤⣢⣾⣿
⣿⣿⣿⣿⣿⣿⣷⣶⣤⣤⣀⣉⠉⠓⠒⠒⠤⠤⠤⠤⠤⠤⠤⠀⡀⣤⣰⣿⣿⣿
⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⡆⠀⠀⠀⠀⣀⣠⣴⣿⣷⣿⣽⣿⡿⣿
⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣟⠚⠛⢋⣩⣿⣿⣿⣿⣿⣿⣿⡿⣻⣵⣿
⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣽⣿⣿⣿
${endColour}"

exit 0
;;
*)
echo "[!] opcion incorrecta, elija una opcion correcta  por favor"
;;
esac
done

