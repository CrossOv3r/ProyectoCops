/*
********************************************************************************
********************************************************************************
********************************************************************************
							Cops n' Robers - Las Vegas
                                  Scripteado por:
							    Trenico - Crossover
********************************************************************************
********************************************************************************
********************************************************************************
*/

////////////////////////////////////INCLUDES////////////////////////////////////

#include <a_samp>
//#include <CnR_Anticheat>
#include <CnR_Coches>
#include <sscanf2>
#include <YSI\y_ini>
#include <zcmd>

//////////////////////////////////////NEWS//////////////////////////////////////

////Eleccion de Personaje

new PlayerText:SelFlechaDer[MAX_PLAYERS];
new PlayerText:SelFlechaIzq[MAX_PLAYERS];
new PlayerText:SelCaja[MAX_PLAYERS];
new PlayerText:SelCajaTit[MAX_PLAYERS];
new PlayerText:SelCajaDes[MAX_PLAYERS];
new PlayerText:SelBotonSel[MAX_PLAYERS];

//////////////////////////////////////ENUMS/////////////////////////////////////

////Usuarios

enum jInfo
{
	jAdmin,
	jDinero,
	jPass[129]
};
new InfoJugador[MAX_PLAYERS][jInfo];

/////////////////////////////////////DEFINES////////////////////////////////////

////Colores

#define COLOR_WHITE         0xFFFFFFFF
#define COLOR_GREY          0xAFAFAFAA
#define COLOR_GREEN         0x9EC73DAA
#define COLOR_GROVE         0x00FF00FF
#define COLOR_RED           0xAA3333AA
#define COLOR_LIGHTRED      0xFF6347AA
#define COLOR_LIGHTBLUE     0x33CCFFAA
#define COLOR_LIGHTGREEN    0x9ACD32AA
#define COLOR_YELLOW        0xDABB3EAA
#define COLOR_YELLOW2       0xF5DEB3AA
#define COLOR_PURPLE        0xC2A2DAAA
#define COLOR_DBLUE         0x2641FEAA
#define COLOR_BLUE          0x2641FEAA
#define COLOR_DARKNICERED   0x9D000096
#define COLOR_LIGHT_BLUE    0x9FB1EEAA

////Dialogos

#define D_REGISTRO  1
#define D_LOGUEO    2
#define D_DATOS     3

////Funciones

#define funcion%0(%1) 	forward%0(%1); public%0(%1)
#define Mensaje         SendClientMessage
native WP_Hash(buffer[], len, const str[]);

////Razones Kick

#define KICK_LOG_FALLIDO    1

////Rutas

#define RLogKick  "/Logs/kicklog.log"
#define RUsuarios "/Usuarios/%s.ini"

//_________ EASY COLORS _________//
#define COL_EASY           "{FFF1AF}"
#define COL_WHITE          "{FFFFFF}"
#define COL_BLACK          "{0E0101}"
#define COL_GREY           "{C3C3C3}"
#define COL_GREEN          "{6EF83C}"
#define COL_RED            "{F81414}"
#define COL_YELLOW         "{F3FF02}"
#define COL_ORANGE         "{FFAF00}"
#define COL_LIME           "{B7FF00}"
#define COL_CYAN           "{00FFEE}"
#define COL_LIGHTBLUE      "{00C0FF}"
#define COL_BLUE           "{0049FF}"
#define COL_MAGENTA        "{F300FF}"
#define COL_VIOLET         "{B700FF}"
#define COL_PINK           "{FF00EA}"
#define COL_MARONE         "{A90202}"
#define COL_CMD            "{B8FF02}"
#define COL_PARAM          "{3FCD02}"
#define COL_SERVER         "{AFE7FF}"
#define COL_VALUE          "{A3E4FF}"
#define COL_RULE           "{F9E8B7}"
#define COL_RULE2          "{FBDF89}"
#define COL_RWHITE         "{FFFFFF}"
#define COL_LGREEN         "{C9FFAB}"
#define COL_LRED           "{FFA1A1}"
#define COL_LRED2          "{C77D87}"

#define EDITARCOCHE 12
#define COCHEPOS 13
#define COCHECOLOR 14

main()
{
	print("\n**************************************************************");
	print("\n**************************************************************");
	print("\n                 Cops n' Robers - Las Vegas");
	print("\n                     Trenico & Crossover");
	print("\n**************************************************************");
	print("\n**************************************************************");
}

public OnGameModeInit()
{
	AddPlayerClass(1,2324.0203,1283.4076,97.2350,297.1866,0,0,0,0,0,0);
	AddPlayerClass(2,2324.0203,1283.4076,97.2350,297.1866,0,0,0,0,0,0);
	AddPlayerClass(3,2324.0203,1283.4076,97.2350,297.1866,0,0,0,0,0,0);
	AddPlayerClass(4,2324.0203,1283.4076,97.2350,297.1866,0,0,0,0,0,0);
	AddPlayerClass(5,2324.0203,1283.4076,97.2350,297.1866,0,0,0,0,0,0);
	AddPlayerClass(6,2324.0203,1283.4076,97.2350,297.1866,0,0,0,0,0,0);
	AddPlayerClass(7,2324.0203,1283.4076,97.2350,297.1866,0,0,0,0,0,0);
	AddPlayerClass(9,2324.0203,1283.4076,97.2350,297.1866,0,0,0,0,0,0);
	AddPlayerClass(11,2324.0203,1283.4076,97.2350,297.1866,0,0,0,0,0,0);
	AddPlayerClass(12,2324.0203,1283.4076,97.2350,297.1866,0,0,0,0,0,0);
	AddPlayerClass(13,2324.0203,1283.4076,97.2350,297.1866,0,0,0,0,0,0);
    AddPlayerClass(14,2324.0203,1283.4076,97.2350,297.1866,0,0,0,0,0,0);
    AddPlayerClass(15,2324.0203,1283.4076,97.2350,297.1866,0,0,0,0,0,0);
    AddPlayerClass(17,2324.0203,1283.4076,97.2350,297.1866,0,0,0,0,0,0);
    AddPlayerClass(19,2324.0203,1283.4076,97.2350,297.1866,0,0,0,0,0,0);
    AddPlayerClass(20,2324.0203,1283.4076,97.2350,297.1866,0,0,0,0,0,0);
    AddPlayerClass(21,2324.0203,1283.4076,97.2350,297.1866,0,0,0,0,0,0);
    AddPlayerClass(22,2324.0203,1283.4076,97.2350,297.1866,0,0,0,0,0,0);
    AddPlayerClass(23,2324.0203,1283.4076,97.2350,297.1866,0,0,0,0,0,0);
	CargarCoches();
	return 1;
}

public OnGameModeExit()
{
	return 1;
}

public OnPlayerRequestClass(playerid, classid)
{
	LimpiarChat(playerid,20);
    SetPlayerPos(playerid,2324.0203,1283.4076,97.2350);
    SetPlayerFacingAngle(playerid,297.1866);
    if(classid >= 1 && classid <= 23)
    {
    }
	return 1;
}

public OnPlayerConnect(playerid)
{
	new string[160];
	LimpiarChat(playerid,20);
	if(EstaRegistrado(playerid))
	{
 	    format(string,sizeof(string),"\n{FFFFFF}Bienvenido a {3030D3}Cops n' Robbers - Las Vegas{FFFFFF}, %s.\n\n\nEstás registrado.\nEscribe tu contraseña para loguearte:\n",VerNombre(playerid));
	    ShowPlayerDialog(playerid,D_LOGUEO,DIALOG_STYLE_INPUT,"{3030D3}Cops n' Robbers - Las Vegas",string,"Loguear","Salir");
	}
	else
	{
 	    format(string,sizeof(string),"\n{FFFFFF}Bienvenido a {3030D3}Cops n' Robbers - Las Vegas{FFFFFF}, %s.\n\n\nParece que no estás registrado.\nEscribe una contraseña para registrarte:\n",VerNombre(playerid));
	    ShowPlayerDialog(playerid,D_REGISTRO,DIALOG_STYLE_INPUT,"{3030D3}Cops n' Robbers - Las Vegas",string,"Registrar","Salir");
	}
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
	return 1;
}

public OnPlayerSpawn(playerid)
{
	return 1;
}

public OnPlayerDeath(playerid, killerid, reason)
{
	return 1;
}

public OnPlayerUpdate(playerid)
{
    //CheckPlayerRemoteJacking(playerid);
	return 1;
}

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	switch(dialogid)
	{
	    case D_REGISTRO:
	    {
	        if(response)
	        {
				new pass[129];
	            format(pass,sizeof(pass),"%s",inputtext);
	            WP_Hash(pass,sizeof(pass),pass);
	        	RegistrarJugador(playerid,pass,inputtext);
			}
			else
			{
			    Mensaje(playerid,COLOR_WHITE,"Gracias por visitarnos!, vuelve pronto.");
				Kick(playerid);
				return 1;
			}
		}
	    case D_LOGUEO:
	    {
	        if(response)
	        {
	            new pass[129];
				new string[185];
	            new file[64];
	            format(pass,sizeof(pass),"%s",inputtext);
	            WP_Hash(pass,sizeof(pass),pass);
				format(file,sizeof(file),RUsuarios,VerNombre(playerid));
	            INI_ParseFile(file,"CargarPass",.bExtra=true,.extra=playerid);
	        	if(!strcmp(pass,InfoJugador[playerid][jPass])) { CargarJugador(playerid); }
				else
				{
				    if(GetPVarInt(playerid,"IntentosLog") >= 5)
				    {
				        Mensaje(playerid,COLOR_WHITE,"Has excedido los intentos para loguearte y has sido kickeado del servidor.");
				        Kickear(playerid,KICK_LOG_FALLIDO);
				        return 1;
					}
				    format(string,sizeof(string),"\n{FFFFFF}Bienvenido a {3030D3}Cops n' Robbers - Las Vegas{FFFFFF}, %s.\n\n\n{3030D3}Contraseña incorrecta.\n{FFFFFF}Escribe tu contraseña para loguearte:\n",VerNombre(playerid));
				    ShowPlayerDialog(playerid,D_LOGUEO,DIALOG_STYLE_INPUT,"{3030D3}Cops n' Robbers - Las Vegas",string,"Loguear","Salir");
				    SetPVarInt(playerid,"IntentosLog",GetPVarInt(playerid,"IntentosLog")+1);
					return 0;
				}
			}
			else
			{
			    Mensaje(playerid,COLOR_WHITE,"Gracias por visitarnos!, vuelve pronto.");
				Kick(playerid);
				return 1;
			}
		}
	    case D_DATOS:
	    {
	        if(response) { CargarJugador(playerid); }
			else { CargarJugador(playerid); }
		}
	    case EDITARCOCHE:
		{
			if(response)
			{
			    if(listitem == 0)
			    {
			        ShowPlayerDialog(playerid,COCHEPOS,DIALOG_STYLE_MSGBOX,"{D1DCE9}Servidor {FFFFFF}- Edición de Vehiculo","{FFFFFF}\n\nLa posición del vehículo será guardada donde estas ahora mismo. ¿Continuar?\n\n","Editar","Cancelar");
				}
				if(listitem == 1)
				{
				    ShowPlayerDialog(playerid,COCHECOLOR,DIALOG_STYLE_INPUT,"{D1DCE9}Servidor {FFFFFF}- Edición de Vehiculo","{FFFFFF}\n\nEscribe el ID del color para este coche\n\n","Editar","Cancelar");
				}
			}
		}

  	    case COCHEPOS:
		{
		    if(response)
		    {
		        new Float:pos[4];
		        GetPlayerPos(playerid,pos[0],pos[1],pos[2]);
		        new idcoche = GetPlayerVehicleID(playerid);
		        GetVehicleZAngle(idcoche,pos[3]);
		        InfoCoche[idcoche][cX] = pos[0];
		        InfoCoche[idcoche][cY] = pos[1];
		        InfoCoche[idcoche][cZ] = pos[2];
		        InfoCoche[idcoche][cA] = pos[3];
				SendClientMessage(playerid, -1, "Posición del coche cambiada!");
		        GuardarCoche(idcoche);
			}
		}

		case COCHECOLOR:
		{
		    if(response)
		    {
		        new idcar = GetPlayerVehicleID(playerid);
  	   			if(strval(inputtext) < 0 || strval(inputtext) > 255) return SendClientMessage(playerid, -1, "ID Incorrecto de Color (0-255)");
            	InfoCoche[idcar][cColor1] = strval(inputtext);
            	InfoCoche[idcar][cColor2] = strval(inputtext);
            	ChangeVehicleColor(idcar,InfoCoche[idcar][cColor1],InfoCoche[idcar][cColor2]);
            	GuardarCoche(idcar);
		    }
		}

	}
	return 1;
}

stock VerNombre(idjugador)
{
	new nombre[MAX_PLAYER_NAME];
	GetPlayerName(idjugador,nombre,sizeof(nombre));
	return nombre;
}

stock VerIP(playerid)
{
    new ip[16];
    GetPlayerIp(playerid,ip,sizeof(ip));
	return ip;
}

stock LimpiarChat(idjugador,lineas)
{
	for(new l=0;l<lineas;l++)
	{
		Mensaje(idjugador,COLOR_WHITE," ");
	}
}

//____________________ USUARIOS GUARDADO ________________//

funcion EstaRegistrado(idjugador)
{
	new ruta[30];
	format(ruta,sizeof(ruta),RUsuarios,VerNombre(idjugador));
	if(fexist(ruta)) return 1;
	else return 0;
}

funcion RegistrarJugador(idjugador,contra[],dcontra[])
{
	new ruta[50];
	new string[90];
	InfoJugador[idjugador][jAdmin] = 0;
	InfoJugador[idjugador][jDinero] = 0;
	format(ruta,sizeof(ruta),RUsuarios,VerNombre(idjugador));
	new INI:arch = INI_Open(ruta);
	INI_WriteString(arch,"Pass",contra);
	INI_WriteInt(arch,"Admin",InfoJugador[idjugador][jAdmin]);
	INI_WriteInt(arch,"Dinero",InfoJugador[idjugador][jDinero]);
	INI_Close(arch);
	format(string,sizeof(string),"\n\n{3030D3}Nombre: {FFFFFF}%s\n{3030D3}Contraseña: {FFFFFF}%s\n\n",VerNombre(idjugador),dcontra);
	ShowPlayerDialog(idjugador,D_DATOS,DIALOG_STYLE_MSGBOX,"Tus Datos",string,"Aceptar","");
}

funcion CargarJugador(playerid)
{
	new file[64];
	format(file,sizeof(file),RUsuarios,VerNombre(playerid));
	if(fexist(file))
	{
		INI_ParseFile(file, "CargarDatos",.bExtra=true,.extra=playerid);
		SetPlayerCameraPos(playerid,2334.63,1289.75,101.42);
	    SetPlayerCameraLookAt(playerid,2324.0203,1283.4076,97.2350);
		InterpolateCameraPos(playerid,2334.63,1289.75,101.42,2325.72,1286.11,98.18,3000,CAMERA_MOVE);
  		MostrarSeleccion(playerid);
    }
}

funcion CargarPass(id,name[],value[])
{
	INI_String("Pass",InfoJugador[id][jPass],129);
	return 0;
}

funcion CargarDatos(id,name[],value[])
{
	INI_Int("Admin",InfoJugador[id][jAdmin]);
	INI_Int("Dinero",InfoJugador[id][jDinero]);
	return 0;
}

funcion Kickear(idjugador,razon)
{
	new ano,mes,dia;
	new hora,minu,seg;
	getdate(ano,mes,dia);
	gettime(hora,minu,seg);
	if(IsPlayerConnected(idjugador))
	{
	    new causa[160];
	    new razontext[30];
	    if(razon == KICK_LOG_FALLIDO) { razontext = "Contrasena erronea login"; }
	    format(causa,sizeof(causa),"Fecha: %d-%d-%d | Hora: %d:%d:%d | Jugador: %s | IP: %s | Razon: %s\n",dia,mes,ano,hora,minu,seg,VerNombre(idjugador),VerIP(idjugador),razontext);
	    print(causa);
	    new File:log = fopen(RLogKick,io_append);
	    fwrite(log,causa);
	    fclose(log);
	    Kick(idjugador);
	}
}

funcion MostrarSeleccion(playerid)
{
    SelFlechaDer[playerid] = CreatePlayerTextDraw(playerid,569.000000, 366.000000, "ld_beat:right");
	PlayerTextDrawBackgroundColor(playerid,SelFlechaDer[playerid], 255);
	PlayerTextDrawFont(playerid,SelFlechaDer[playerid], 4);
	PlayerTextDrawLetterSize(playerid,SelFlechaDer[playerid], 0.500000, 1.000000);
	PlayerTextDrawColor(playerid,SelFlechaDer[playerid], -1);
	PlayerTextDrawSetOutline(playerid,SelFlechaDer[playerid], 0);
	PlayerTextDrawSetProportional(playerid,SelFlechaDer[playerid], 1);
	PlayerTextDrawSetShadow(playerid,SelFlechaDer[playerid], 1);
	PlayerTextDrawUseBox(playerid,SelFlechaDer[playerid], 1);
	PlayerTextDrawBoxColor(playerid,SelFlechaDer[playerid], 255);
	PlayerTextDrawTextSize(playerid,SelFlechaDer[playerid], 33.000000, 32.000000);
	PlayerTextDrawSetSelectable(playerid,SelFlechaDer[playerid], 0);

	SelFlechaIzq[playerid] = CreatePlayerTextDraw(playerid,448.000000, 366.000000, "ld_beat:left");
	PlayerTextDrawBackgroundColor(playerid,SelFlechaIzq[playerid], 255);
	PlayerTextDrawFont(playerid,SelFlechaIzq[playerid], 4);
	PlayerTextDrawLetterSize(playerid,SelFlechaIzq[playerid], 0.500000, 1.000000);
	PlayerTextDrawColor(playerid,SelFlechaIzq[playerid], -1);
	PlayerTextDrawSetOutline(playerid,SelFlechaIzq[playerid], 0);
	PlayerTextDrawSetProportional(playerid,SelFlechaIzq[playerid], 1);
	PlayerTextDrawSetShadow(playerid,SelFlechaIzq[playerid], 1);
	PlayerTextDrawUseBox(playerid,SelFlechaIzq[playerid], 1);
	PlayerTextDrawBoxColor(playerid,SelFlechaIzq[playerid], 255);
	PlayerTextDrawTextSize(playerid,SelFlechaIzq[playerid], 33.000000, 32.000000);
	PlayerTextDrawSetSelectable(playerid,SelFlechaIzq[playerid], 0);

	SelCaja[playerid] = CreatePlayerTextDraw(playerid,603.000000, 70.000000, "_");
	PlayerTextDrawBackgroundColor(playerid,SelCaja[playerid], 255);
	PlayerTextDrawFont(playerid,SelCaja[playerid], 1);
	PlayerTextDrawLetterSize(playerid,SelCaja[playerid], 0.949999, 24.000000);
	PlayerTextDrawColor(playerid,SelCaja[playerid], -1);
	PlayerTextDrawSetOutline(playerid,SelCaja[playerid], 0);
	PlayerTextDrawSetProportional(playerid,SelCaja[playerid], 1);
	PlayerTextDrawSetShadow(playerid,SelCaja[playerid], 1);
	PlayerTextDrawUseBox(playerid,SelCaja[playerid], 1);
	PlayerTextDrawBoxColor(playerid,SelCaja[playerid], 255);
	PlayerTextDrawTextSize(playerid,SelCaja[playerid], 446.000000, 0.000000);
	PlayerTextDrawSetSelectable(playerid,SelCaja[playerid], 0);

	SelCajaTit[playerid] = CreatePlayerTextDraw(playerid,524.500000, 70.000000, "Eleccion de Personaje");
	PlayerTextDrawAlignment(playerid,SelCajaTit[playerid], 2);
	PlayerTextDrawBackgroundColor(playerid,SelCajaTit[playerid], 255);
	PlayerTextDrawFont(playerid,SelCajaTit[playerid], 2);
	PlayerTextDrawLetterSize(playerid,SelCajaTit[playerid], 0.200000, 1.200000);
	PlayerTextDrawColor(playerid,SelCajaTit[playerid], -1);
	PlayerTextDrawSetOutline(playerid,SelCajaTit[playerid], 1);
	PlayerTextDrawSetProportional(playerid,SelCajaTit[playerid], 1);
	PlayerTextDrawUseBox(playerid,SelCajaTit[playerid], 1);
	PlayerTextDrawBoxColor(playerid,SelCajaTit[playerid], 65535);
	PlayerTextDrawTextSize(playerid,SelCajaTit[playerid], 420.000000, 149.000000);
	PlayerTextDrawSetSelectable(playerid,SelCajaTit[playerid], 0);

	SelCajaDes[playerid] = CreatePlayerTextDraw(playerid,455.000000, 94.000000, "Clase: Civil~n~~n~Trabajos~n~- Ladron~n~- Equipos~n~~n~~n~Exp: 500");
	PlayerTextDrawBackgroundColor(playerid,SelCajaDes[playerid], 255);
	PlayerTextDrawFont(playerid,SelCajaDes[playerid], 2);
	PlayerTextDrawLetterSize(playerid,SelCajaDes[playerid], 0.200000, 1.200000);
	PlayerTextDrawColor(playerid,SelCajaDes[playerid], -1);
	PlayerTextDrawSetOutline(playerid,SelCajaDes[playerid], 0);
	PlayerTextDrawSetProportional(playerid,SelCajaDes[playerid], 1);
	PlayerTextDrawSetShadow(playerid,SelCajaDes[playerid], 1);
	PlayerTextDrawSetSelectable(playerid,SelCajaDes[playerid], 0);

	SelBotonSel[playerid] = CreatePlayerTextDraw(playerid,525.000000, 375.000000, "Seleccionar");
	PlayerTextDrawAlignment(playerid,SelBotonSel[playerid], 2);
	PlayerTextDrawBackgroundColor(playerid,SelBotonSel[playerid], 255);
	PlayerTextDrawFont(playerid,SelBotonSel[playerid], 2);
	PlayerTextDrawLetterSize(playerid,SelBotonSel[playerid], 0.190000, 1.300000);
	PlayerTextDrawColor(playerid,SelBotonSel[playerid], -1);
	PlayerTextDrawSetOutline(playerid,SelBotonSel[playerid], 0);
	PlayerTextDrawSetProportional(playerid,SelBotonSel[playerid], 1);
	PlayerTextDrawSetShadow(playerid,SelBotonSel[playerid], 1);
	PlayerTextDrawUseBox(playerid,SelBotonSel[playerid], 1);
	PlayerTextDrawBoxColor(playerid,SelBotonSel[playerid], 336860415);
	PlayerTextDrawTextSize(playerid,SelBotonSel[playerid], 483.000000, 73.000000);
	PlayerTextDrawSetSelectable(playerid,SelBotonSel[playerid], 0);
	
	PlayerTextDrawShow(playerid,SelFlechaDer[playerid]);
	PlayerTextDrawShow(playerid,SelFlechaIzq[playerid]);
	PlayerTextDrawShow(playerid,SelCaja[playerid]);
	PlayerTextDrawShow(playerid,SelCajaTit[playerid]);
	PlayerTextDrawShow(playerid,SelCajaDes[playerid]);
	PlayerTextDrawShow(playerid,SelBotonSel[playerid]);
}

//=================Sistema administrativo ===================
/*CMD:daradmin(playerid, params[])
{
	new string[128], nombre[MAX_PLAYER_NAME];
	if(InfoJugador[playerid][USER_ADMIN] < 5) return SendClientMessage(playerid, -1, ""#COL_RED"[ERROR] "#COL_WHITE"Usted no cuenta con el nivel administrativo necesario para usar este comando");
	if(sscanf(params, "ud", params[0], params[1])) return SendClientMessage(playerid, -1, ""#COL_RED"[ERROR] "#COL_WHITE"Use /daradmin + playerid + nivel");
	if(params[0] == INVALID_PLAYER_ID) return SendClientMessage(playerid, -1, ""#COL_RED"[ERROR] "#COL_WHITE"Jugador inválido");
	InfoJugador[params[0]][USER_ADMIN] = params[1];
	GetPlayerName(params[0], nombre, sizeof(nombre));
	format(string, sizeof(string), ""#COL_PINK"[ADMIN] "#COL_WHITE"Has dado nivel administrativo %d a %s", params[1], nombre);
	SendClientMessage(playerid, -1, string);
	GetPlayerName(playerid, nombre, sizeof(nombre));
	format(string, sizeof(string), ""#COL_PINK"[ADMIN] "#COL_WHITE"%s te ha dado nivel administrativo: %d", nombre, params[1]);
	SendClientMessage(params[0], -1, string);
	return 1;
}

CMD:dardinero(playerid, params[])
{
	new string[128], nombre[MAX_PLAYER_NAME];
	if(InfoJugador[playerid][USER_ADMIN] < 5) return SendClientMessage(playerid, -1, ""#COL_RED"[ERROR] "#COL_WHITE"Usted no cuenta con el nivel administrativo necesario para usar este comando");
	if(sscanf(params, "ud", params[0], params[1])) return SendClientMessage(playerid, -1, ""#COL_RED"[ERROR] "#COL_WHITE"Use /dardinero + playerid + cantidad");
	if(params[0] == INVALID_PLAYER_ID) return SendClientMessage(playerid, -1, ""#COL_RED"[ERROR] "#COL_WHITE"Jugador inválido");
	InfoJugador[params[0]][USER_DINERO] += params[1];
	GetPlayerName(params[0], nombre, sizeof(nombre));
	format(string, sizeof(string), ""#COL_PINK"[ADMIN] "#COL_WHITE"Has dado $%d a %s", params[1], nombre);
	SendClientMessage(playerid, -1, string);
	GetPlayerName(playerid, nombre, sizeof(nombre));
	format(string, sizeof(string), ""#COL_PINK"[ADMIN] "#COL_WHITE"%s te ha dado %d", nombre, params[1]);
	SendClientMessage(params[0], -1, string);
	GivePlayerMoney(params[0], InfoJugador[params[0]][USER_DINERO]);
	return 1;
}


//___________ CMD de Creacion de Coches __________________//
CMD:crearveh(playerid,params[])
{
	if(GetPlayerState(playerid) == 1)
			{
			    new modelo,color1,color2;
			    if(InfoJugador[playerid][USER_ADMIN] < 5) return SendClientMessage(playerid,-1, ""#COL_RED"[ERROR] "#COL_WHITE"No autorizado!");
			    if(!sscanf(params,"iii",modelo,color1,color2))
			    {
			        if(modelo < 400 || modelo > 611) return SendClientMessage(playerid,-1,""#COL_RED"[ERROR] "#COL_WHITE"El modelo no debe ser menor a 400 ni mayor a 611.");
			        if(color1 < 0 || color1 > 255) return SendClientMessage(playerid,-1,""#COL_RED"[ERROR] "#COL_WHITE"El color no debe ser menor a 0 ni mayor a 255.");
			        if(color2 < 0 || color2 > 255) return SendClientMessage(playerid,-1,""#COL_RED"[ERROR] "#COL_WHITE"El color no debe ser menor a 0 ni mayor a 255.");
			        new Float:pos[3];
			        GetPlayerPos(playerid,pos[0],pos[1],pos[2]);
			        new vehicleid = CreateVehicle(modelo,pos[0]+2,pos[1],pos[2],90.0,color1,color2,200000);
					InfoCoche[vehicleid][cID] = UltimaIDVeh+1;
					InfoCoche[vehicleid][cColor1] = color1;
					InfoCoche[vehicleid][cColor2] = color2;
	 				InfoCoche[vehicleid][cModelo] = modelo;
					strmid(InfoCoche[vehicleid][cNombre], NombreCoche(vehicleid), 0, strlen(NombreCoche(vehicleid)), 40);
					InfoCoche[vehicleid][cX] = pos[0]+2;
					InfoCoche[vehicleid][cY] = pos[1];
					InfoCoche[vehicleid][cZ] = pos[2];
					InfoCoche[vehicleid][cA] = 90.0;
                	SetVehicleToRespawn(vehicleid);
                	SetVehicleVirtualWorld(vehicleid,GetPlayerVirtualWorld(playerid));
	 				new file[64];
	 				format(file,sizeof file,GCoches,InfoCoche[vehicleid][cID]);
	  				new INI:arch = INI_Open(file);
	  				INI_WriteInt(arch,"ID",InfoCoche[vehicleid][cID]);
	  				INI_Close(arch);
	  				SetVehicleHealth(vehicleid, 900);
                	GuardarCoche(vehicleid);
                	UltimaIDVeh++;
				}
				else
				{
				    SendClientMessage(playerid,-1,""#COL_RED"[INFO] "#COL_WHITE"Usa /crearveh [modelo] [color 1] [color 2].");
				}
			}
			else SendClientMessage(playerid,-1,""#COL_RED"[ERROR] "#COL_WHITE"Debes estar fuera de un vehículo para usar este comando.");
	return 1;
}

CMD:borrarveh(playerid,params[])
{
 	new idcoche = GetPlayerVehicleID(playerid);
 	if(InfoJugador[playerid][USER_ADMIN] < 5) return SendClientMessage(playerid,-1, ""#COL_RED"[ERROR] "#COL_WHITE"No autorizado!");
  	if(GetPlayerState(playerid) == 2)
	{
 		BorrarCoche(idcoche);
	}
	else SendClientMessage(playerid,-1,""COL_RED"[ERROR] "#COL_WHITE"Debes estar en un vehículo para usar este comando.");
	return 1;
}

CMD:editar(playerid,params[])
{
	new opc[10];
	if(InfoJugador[playerid][USER_ADMIN] < 5) return SendClientMessage(playerid,-1, ""#COL_RED"[ERROR] "#COL_WHITE"No autorizado!");
 	if(!sscanf(params,"s[10]",opc))
  	{
 		if(!strcmp(opc,"vehiculo",true))
 		{
   			if(IsPlayerInAnyVehicle(playerid))
			{
				ShowPlayerDialog(playerid,EDITARCOCHE,DIALOG_STYLE_LIST,"{D1DCE9}Servidor {FFFFFF}- Edición de Vehículo","Editar Posición\nColor","Editar","Cancelar");
			}
			else SendClientMessage(playerid,-1,""#COL_RED"[ERROR] "#COL_WHITE"Debes estar en un vehículo para usar este comando.");
		}
	}
	else
	{
 		SendClientMessage(playerid,-1,""#COL_RED"[INFO] "COL_WHITE"Usa /editar [opción].");
   		SendClientMessage(playerid,-1,"| Vehículo |");
	}
	return 1;
}

CMD:ls(playerid, params[])
{
	SetPlayerPos(playerid, 1601.30004883,-1684.50000000,5.69999981);
	return 1;
}*/
