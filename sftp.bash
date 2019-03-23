#!/bin/bash

#if [ $(id -u) -eq 0 ]
#then
#echo ''
#else
#	if echo $(id) |grep sudo > /dev/null
#	then
#	clear
#	echo -e "$white Você nao é usuário root"
#	echo -e "$white Seu usuário está no grupo sudo"
#	echo -e "$white Para tornar-se um usuário root execute $red sudo su$white  ou execute $red sudo $0 $f"
#	exit
#	else
#	clear
#	echo -e "Você não está como usuario root, nem com seus direitos (sudo)\nPara tornar-se um usuário root execute $red su $f e digite sua senha root"
#	exit
#	fi
#fi

# CORES
white="\033[1;37m";
red="\033[1;31m";
green="\033[1;32m";
yellow="\033[1;33m";
cyano="\033[1;36m";
blue="\033[1;34m";
mag="\033[1;35m";

# de fundo
magneta="\033[1;37;45m";
f="\033[0m";

VERSION="v1.0.1";
ABOUT="SOBRE";
USERNAME="USUÁRIO";
SYSTEM="SISTEMA";
USERPROFILENAME=$USER;
directory=/etc/rdy/hostSFTPList.rdy
about="© ${blue}Copyright ${yellow}RDY ${red}SOFTWARE ${yellow}{${red}}$f ${blue}2019$f"
cat -n /etc/issue |grep 1 |cut -d' ' -f6,7,8 |sed 's/1//' |sed 's/	//' > /etc/so
# VERIFICAR O IP DO SERVIDOR
ip=$(ip addr | grep 'inet' | grep -v inet6 | grep -vE '127\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | grep -o -E '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | head -1)
if [[ "$ip" = "" ]]; then
ip=$(wget -qO- ipv4.icanhazip.com)
fi

if [ -d /etc/rdy ]
then
if [ ! -f $directory ]; then
touch $directory
fi
else
mkdir -p /etc/rdy
touch $directory
fi

numberlist=$(wc -l $directory)
numberlist2=$(echo "$numberlist" |awk -F " " '{print $1}')

DIVIS="${white}==$f${blue}/$f${white}==$f${blue}/$f${white}==$f${blue}/$f${white}==$f${blue}/$f${white}==$f${blue}/$f${white}==$f${blue}/$f${white}==$f${blue}/$f${white}==$f${blue}/$f${white}==$f${blue}/$f${white}==$f${blue}/$f${white}==$f${blue}/$f${white}==$f${blue}/$f${white}==$f${blue}/$f${white}==$f${blue}/$f${white}==$f${blue}/$f${white}==$f${blue}/$f${white}==$f${blue}/$f${white}==$f${blue}/$f${white}==$f${blue}/$f${white}==$f${blue}/$f${white}==$f${blue}/$f${white}==$f${blue}/$f${white}==$f";


addend(){
echo -ne "${white} (${mag}<${green}i${mag}>${white})  ${blue}EX. ${white}root${red}@${yellow}192.168.0.1\n ${green}Defina uma novo endereço:$f"; read -p "" -e -i root@ endereco
echo "$endereco" >> $directory
echo "";
echo -e "${green} OK ${yellow}/// ${green} ENDEREÇO ${yellow}$endereco${green} ADICIONADO COM SUCESSO!!$f";
echo -e "${white}//${yellow}//${green}//${mag}//    ${mag}Pressione uma tecla para retornar ao menu.$f"; read -n1 -r -p "";
rdymain
}

help(){
clear
echo -ne "\n${white} (${mag}<${green}i${mag}>${white})  ${blue}AJUDA\n ${gren}
ESTE É UM SIMPLES GERENNCIADOR DE CONECXÕES ${mag}SSH ${gree}& ${mag}SFTP $VERSION.\n
${green}ADICIONE NOVOS ENDEREÇOS DIGITANDO A OPÇÃO ${mag}add ${green}OU ${mag}sftp.bash add\n
${green}INICIE UMA CONEXÃO SSH OU SFTP DA SEGUINTE FORMA:\n
${mag}sftp.bash ssh\n
sftp.bash sftp\n
${green}(Por padrão, o script já pode ser executado apenas com ${mag}sftp.bash\n${green} e será diretamente definido à uma conexão sftp.)
${white}(TAGS: add, ADD, exit, EXIT, 0, 00, help, ajuda)\n\n$about\n\n$f";
exit
}

if [[ $1 == "help" ]] || [[ $1 == "ajuda" ]]; then
help
elif [[ $1 == "" ]]; then
action=sftp
elif [[ $1 == "add" ]]; then
addend
else
action=$1
fi

rdymain(){
clear

echo -e $DIVIS
echo -e "$green ##### $white IP:$cyano  $ip $f";
echo -e "$green ##### $white $SYSTEM:$cyano  $(cat /etc/so) $f";
echo -e "$green ##### $white $USERNAME:$cyano  $USERPROFILENAME $f";
echo -e "$green ##### $white  $about $f";
echo -e $DIVIS
echo -e "$white                     GERENCIDOR DE CONEXÕES SSH/SFTP $VERSION $f";
echo -e $DIVIS
echo "";
echo -e "${blue} [add]${geen} /> ${yellow} ADICIONAR ENDEREÇOS$f";
nl -w2 -s " /> " $directory
echo "";
echo -ne "$cyano Opção [1 - $numberlist2, ${red}0 exit${cyano}] $f"; read -p "/> " option

if [[ "$option" = 'add' ]] || [[ "$option" = 'ADD' ]] || [[ "$option" = 'help' ]] || [[ "$option" = 'ajuda' ]] || [[ "$option" = '0' ]] || [[ "$option" = 'exit' ]] || [[ "$option" = 'EXIT' ]]; then
case $option in
add | ADD) addend ;;
help | ajuda) help ;;
00 | 0 | exit | EXIT) exit ;;
 *)echo -e "$red Opção inválida!$f" ; echo "" ; sleep 2 ; $rdymain;;
   esac
else
command=$(sed -n ${option}p $directory)
echo "$action";
$action $command
fi
}

rdymain

