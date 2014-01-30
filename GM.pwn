#include <a_samp>
#include <YSI\y_commands>
#include <YSI\y_timers>
#include <YSI\y_ini>
#include <sscanf2>

//__________________NEWS____________________________//
//Remote Jacking Control
enum E_CARJACK_DATA
{
    Float: E_LAST_X,        Float: E_LAST_Y,        Float: E_LAST_Z,
    E_LAST_VEH
}
new g_carjackData[ MAX_PLAYERS ] [ E_CARJACK_DATA ];

new bool: UsuarioLogueado[MAX_PLAYERS];

//_________________ Guardado de datos (Usuarios) ___________//
enum DATOS_USERS
{
	USER_NOMBRE[MAX_PLAYER_NAME],
	USER_PASSWORD[129],
	USER_ADMIN,
	USER_DINERO
};
new InfoJugador[MAX_PLAYERS][DATOS_USERS];

#define PATH "/usuarios/%s.ini"
//_________________Sistema de coches (Dinámicos) ___________//
#undef  MAX_VEHICLES
#define MAX_VEHICLES 1000
#define GCoches "/Coches/%i.ini"
new UltimaIDVeh;
enum cInfo
{
	cID,
	cColor1,
	cColor2,
	cNombre[30],
	cPlaca[8],
	cDueno[24],
	cModelo,
	Float:cX,
	Float:cY,
	Float:cZ,
	Float:cA
}
new InfoCoche[MAX_VEHICLES][cInfo];

forward GuardarCoche(idcoche);
public GuardarCoche(idcoche)
{
	new file[64];
 	format(file,sizeof file,GCoches,InfoCoche[idcoche][cID]);
  	new INI:arch = INI_Open(file);
  	INI_WriteInt(arch,"Color1",InfoCoche[idcoche][cColor1]);
  	INI_WriteInt(arch,"Color2",InfoCoche[idcoche][cColor2]);
  	INI_WriteString(arch,"Dueno",InfoCoche[idcoche][cDueno]);
  	INI_WriteInt(arch,"Modelo",InfoCoche[idcoche][cModelo]);
  	INI_WriteString(arch,"Nombre",InfoCoche[idcoche][cNombre]);
  	INI_WriteString(arch,"Placa",InfoCoche[idcoche][cPlaca]);
  	INI_WriteFloat(arch,"X",InfoCoche[idcoche][cX]);
  	INI_WriteFloat(arch,"Y",InfoCoche[idcoche][cY]);
  	INI_WriteFloat(arch,"Z",InfoCoche[idcoche][cZ]);
  	INI_WriteFloat(arch,"A",InfoCoche[idcoche][cA]);
    INI_Close(arch);
    return 1;
}

forward CargarCoche(id,name[],value[]);
public CargarCoche(id,name[],value[])
{
	INI_Int("Modelo",InfoCoche[id][cModelo]);
	INI_Float("X",InfoCoche[id][cX]);
	INI_Float("Y",InfoCoche[id][cY]);
	INI_Float("Z",InfoCoche[id][cZ]);
	INI_Float("A",InfoCoche[id][cA]);
	INI_Int("Color1",InfoCoche[id][cColor1]);
	INI_Int("Color2",InfoCoche[id][cColor2]);
	INI_Int("ID",InfoCoche[id][cID]);
	INI_String("Dueno",InfoCoche[id][cDueno],24);
	INI_Int("Modelo",InfoCoche[id][cModelo]);
	INI_String("Nombre",InfoCoche[id][cNombre],30);
	INI_String("Placa",InfoCoche[id][cPlaca],8);
	return 0;
}

forward BorrarCoche(idcoche);
public BorrarCoche(idcoche)
{
	new string[40];
    new idccoche = InfoCoche[idcoche][cID];
    format(string, sizeof(string),GCoches,idccoche);
	if(fexist(string))
	{
        DestroyVehicle(idcoche);
        UltimaIDVeh--;
        InfoCoche[idcoche][cID] = 0;
        InfoCoche[idcoche][cColor1] = 0;
        InfoCoche[idcoche][cColor2] = 0;
        strmid(InfoCoche[idcoche][cDueno],"Nadie",0,24,24);
        InfoCoche[idcoche][cModelo] = 0;
        strmid(InfoCoche[idcoche][cNombre],"Nada",0,30,30);
        strmid(InfoCoche[idcoche][cPlaca],"Nada",0,8,8);
        InfoCoche[idcoche][cX] = 0.0;
        InfoCoche[idcoche][cY] = 0.0;
        InfoCoche[idcoche][cZ] = 0.0;
        InfoCoche[idcoche][cA] = 0.0;
        InfoCoche[idcoche][cID] = -1;
        fremove(string);
        return 1;
	}
	return 0;
}

stock NombreCoche(idcoche)
{
	new texto[30];
	switch (GetVehicleModel(idcoche))
	{
	    case 400: texto = "Landstalker";
	    case 401: texto = "Bravura";
	    case 402: texto = "Buffalo";
	    case 403: texto = "Linerunner";
	    case 404: texto = "Perenniel";
	    case 405: texto = "Sentinel";
	    case 406: texto = "Dumper";
	    case 407: texto = "Bomberos";
	    case 408: texto = "Basurero";
	    case 409: texto = "Stretch";
	    case 410: texto = "Manana";
	    case 411: texto = "Infernus";
	    case 412: texto = "Voodo";
	    case 413: texto = "Pony";
     	case 414: texto = "Mule";
	    case 415: texto = "Cheetah";
     	case 416: texto = "Ambulancia";
      	case 417: texto = "Leviathan";
	    case 418: texto = "Moonbeam";
	    case 419: texto = "Esperanto";
	    case 420: texto = "Taxi";
	    case 421: texto = "Washington";
	    case 422: texto = "Bobcat";
	    case 423: texto = "Mr Whoopee";
	    case 424: texto = "BF Injection";
	    case 425: texto = "Hunter";
	    case 426: texto = "Premier";
	    case 427: texto = "Enforcer";
	    case 428: texto = "Securicar";
	    case 429: texto = "Banshee";
	    case 430: texto = "Predator";
	    case 431: texto = "Bus";
	    case 432: texto = "Rhino";
	    case 433: texto = "Barracks";
	    case 434: texto = "Hotknife";
	    case 435: texto = "Trailer";
	    case 436: texto = "Previon";
	    case 437: texto = "Coach";
	    case 438: texto = "Cabbie";
	    case 439: texto = "Stallion";
	    case 440: texto = "Rumpo";
	    case 441: texto = "RC Bandit";
	    case 442: texto = "Romero";
	    case 443: texto = "Packer";
	    case 444: texto = "Monster";
	    case 445: texto = "Admiral";
	    case 446: texto = "Squallo";
	    case 447: texto = "Seasparrow";
	    case 448: texto = "Pizza";
	    case 449: texto = "Tram";
	    case 450: texto = "Article Trailer 2";
	    case 451: texto = "Turismo";
	    case 452: texto = "Speeder";
	    case 453: texto = "Reefer";
	    case 454: texto = "Tropic";
	    case 455: texto = "Flatbed";
	    case 456: texto = "Yankee";
	    case 457: texto = "Caddy";
	    case 458: texto = "Solair";
	    case 459: texto = "Berkley's RC Van";
	    case 460: texto = "Skimmer";
	    case 461: texto = "PCJ-600";
	    case 462: texto = "Faggio";
	    case 463: texto = "Freeway";
	    case 464: texto = "RC Baron";
	    case 465: texto = "RC Raider";
	    case 466: texto = "Glendale";
	    case 467: texto = "Oceanic";
	    case 468: texto = "Sanchez";
	    case 469: texto = "Sparrow";
	    case 470: texto = "Patriot";
	    case 471: texto = "Quad";
	    case 472: texto = "Coastguard";
	    case 473: texto = "Dinghy";
	    case 474: texto = "Hermes";
	    case 475: texto = "Sabre";
	    case 476: texto = "Rustler";
	    case 477: texto = "ZR-350";
	    case 478: texto = "Walton";
	    case 479: texto = "Regina";
	    case 480: texto = "Comet";
	    case 481: texto = "BMX";
	    case 482: texto = "Burrito";
	    case 483: texto = "Camper";
	    case 484: texto = "Marquis";
	    case 485: texto = "Baggage";
	    case 486: texto = "Dozer";
	    case 487: texto = "Maverick";
	    case 488: texto = "News Maverick";
	    case 489: texto = "Rancher";
	    case 490: texto = "FBI Rancher";
	    case 491: texto = "Virgo";
	    case 492: texto = "Greenwood";
	    case 493: texto = "Jetmax";
	    case 494: texto = "Hotring Racer";
	    case 495: texto = "Sandking";
	    case 496: texto = "Blista Compact";
	    case 497: texto = "Poli Maverick";
	    case 498: texto = "BoxVille";
	    case 499: texto = "Benson";
	    case 500: texto = "Mesa";
	    case 501: texto = "RC Goblin";
	    case 502: texto = "Hotring Racer";
	    case 503: texto = "Hotring Racer";
	    case 504: texto = "Bloodring Racer";
	    case 505: texto = "Rancher";
	    case 506: texto = "Super GT";
	    case 507: texto = "Elegant";
	    case 508: texto = "Journey";
	    case 509: texto = "Bike";
	    case 510: texto = "Mountain Bike";
	    case 511: texto = "Beagle";
	    case 512: texto = "Cropduster";
	    case 513: texto = "Stuntplane";
	    case 516: texto = "Nebula";
	    case 517: texto = "Majestic";
	    case 518: texto = "Buccaneer";
	    case 519: texto = "Shamal";
	    case 520: texto = "Hydra";
	    case 521: texto = "FCR-900";
	    case 522: texto = "NRG-500";
	    case 523: texto = "HPV1000";
	    case 524: texto = "Cemento";
	    case 525: texto = "Grua";
	    case 526: texto = "Fortune";
	    case 527: texto = "Cadrona";
	    case 528: texto = "FBI Coche";
	    case 529: texto = "Willard";
	    case 530: texto = "Forklift";
	    case 531: texto = "Tractor";
	    case 532: texto = "Cultivadora";
	    case 533: texto = "Feltzer";
	    case 534: texto = "Remington";
	    case 535: texto = "Slamvan";
	    case 536: texto = "Blade";
	    case 537: texto = "Freight";
	    case 538: texto = "BrownStreak";
	    case 539: texto = "Vortex";
	    case 540: texto = "Vincent";
	    case 541: texto = "Bullet";
	    case 542: texto = "Clover";
	    case 543: texto = "Sadler";
	    case 544: texto = "PBomberos";
	    case 545: texto = "Hustler";
	    case 546: texto = "Intruder";
	    case 547: texto = "Primo";
	    case 548: texto = "Nevada";
	    case 549: texto = "Tampa";
	    case 550: texto = "Sunrise";
	    case 551: texto = "Merit";
	    case 552: texto = "Utility Van";
	    case 553: texto = "Nevada";
	    case 554: texto = "Yosemite";
	    case 555: texto = "Windsor";
	    case 556: texto = "Monster";
	    case 557: texto = "Monster";
	    case 558: texto = "Uranus";
	    case 559: texto = "Jester";
	    case 560: texto = "Sultan";
	    case 561: texto = "Stratum";
	    case 562: texto = "Elegy";
	    case 563: texto = "Raindance";
        case 564: texto = "RC Tiger";
	    case 565: texto = "Flash";
	    case 566: texto = "Tahoma";
	    case 567: texto = "Savanna";
	    case 568: texto = "Bandito";
	    case 569: texto = "Freight Flat Trailer";
	    case 570: texto = "Streak Trailer";
	    case 571: texto = "Kart";
	    case 572: texto = "Mower";
	    case 573: texto = "Dune";
	    case 574: texto = "Sweeper";
	    case 575: texto = "Broadway";
	    case 576: texto = "Tornado";
	    case 577: texto = "AT400";
	    case 578: texto = "DFT-30";
	    case 579: texto = "Huntley";
	    case 580: texto = "Stafford";
	    case 581: texto = "BF-400";
	    case 582: texto = "NewsVan";
	    case 583: texto = "Tug";
	    case 584: texto = "Trailer";
	    case 585: texto = "Emperor";
	    case 586: texto = "Wayfarer";
	    case 587: texto = "Euros";
	    case 588: texto = "HotDog";
	    case 589: texto = "Club";
	    case 590: texto = "Box Trailer";
	    case 591: texto = "Trailer";
	    case 592: texto = "Andromada";
	    case 593: texto = "Dodo";
	    case 594: texto = "RC Cam";
	    case 595: texto = "Launch";
	    case 596: texto = "Poli LS";
	    case 597: texto = "Poli SF";
	    case 598: texto = "Poli LV";
	    case 599: texto = "RangerPo";
	    case 600: texto = "Picador";
	    case 601: texto = "S.W.A.T";
	    case 602: texto = "Alpha";
	    case 603: texto = "Phoenix";
	    case 604: texto = "Glendale";
	    case 605: texto = "Sadler";
	    case 606: texto = "Baggage Trailer A";
	    case 607: texto = "Baggage Trailer B";
	    case 608: texto = "Tug Stairs Trailer";
	    case 609: texto = "Boxville";
	    case 610: texto = "Farm Trailer";
	    case 611: texto = "Utility Trailer";
	}
	return texto;
}

forward CargarCoches();
public CargarCoches()
{
	for(new i = 0;i<MAX_VEHICLES;i++)
	{
		new file[64];
		format(file,sizeof(file),GCoches,i);
		if(fexist(file))
		{
			new INI:arch = INI_Open(file);
			INI_ParseFile(file,"CargarCoche",.bExtra = true, .extra = i);
			if(InfoCoche[i][cModelo] >= 400)
			{
				new idcoche = AddStaticVehicleEx(InfoCoche[i][cModelo],InfoCoche[i][cX],InfoCoche[i][cY],InfoCoche[i][cZ],InfoCoche[i][cA],InfoCoche[i][cColor1],InfoCoche[i][cColor2],600000);
				SetVehicleHealth(idcoche, 900);
				InfoCoche[idcoche][cID] = InfoCoche[i][cID];
				InfoCoche[idcoche][cColor1] = InfoCoche[i][cColor1];
				InfoCoche[idcoche][cColor2] = InfoCoche[i][cColor2];
				strmid(InfoCoche[idcoche][cDueno],InfoCoche[i][cDueno],0,24,24);
				InfoCoche[idcoche][cModelo] = InfoCoche[i][cModelo];
				strmid(InfoCoche[idcoche][cNombre],InfoCoche[i][cNombre],0,30,30);
				strmid(InfoCoche[idcoche][cPlaca],InfoCoche[i][cPlaca],0,8,8);
				new Float:pos[4];
		     	GetVehiclePos(idcoche,pos[0],pos[1],pos[2]);
		      	GetVehicleZAngle(idcoche,pos[3]);
		  		InfoCoche[idcoche][cX] = pos[0];
		  		InfoCoche[idcoche][cY] = pos[1];
		  		InfoCoche[idcoche][cZ] = pos[2];
		  		InfoCoche[idcoche][cA] = pos[3];
		    	SetVehicleNumberPlate(idcoche,InfoCoche[idcoche][cPlaca]);
		     	if(InfoCoche[idcoche][cID] > UltimaIDVeh)
				{
					UltimaIDVeh = InfoCoche[idcoche][cID];
				}
			}
			else print("Un coche no pudo ser cargado.");
			INI_Close(arch);
		}
	}
	return 1;
}

//___________ COLORES ________________//
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

//________ DEFINES _________//

//_________________ DIALOGS ______________________//
#define LOGIN 10
#define REGISTRO 11
#define EDITARCOCHE 12
#define COCHEPOS 13
#define COCHECOLOR 14

main()
{
	print("\n----------------------------------");
	print(" Blank Gamemode by your name here");
	print("----------------------------------\n");
}

public OnGameModeInit()
{
	SetGameModeText("Blank Script");
	SendRconCommand("reloadbans");
	AddPlayerClass(0, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	CargarCoches();
	return 1;
}

public OnGameModeExit()
{
	return 1;
}

public OnPlayerRequestClass(playerid, classid)
{
	SetPlayerPos(playerid, 1958.3783, 1343.1572, 15.3746);
	SetPlayerCameraPos(playerid, 1958.3783, 1343.1572, 15.3746);
	SetPlayerCameraLookAt(playerid, 1958.3783, 1343.1572, 15.3746);
	return 1;
}

public OnPlayerConnect(playerid)
{
	repeat AntiCheat(playerid);
	if(fexist(Usuario(playerid)))
	{
 		INI_ParseFile(Usuario(playerid), "CargarUsuario", .bExtra = true, .extra = playerid);
	    ShowPlayerDialog(playerid, LOGIN, DIALOG_STYLE_PASSWORD, "LOGIN", "Ingrese su password para loguearse", "Aceptar", "Salir");
	}
	else
	{
	    ShowPlayerDialog(playerid, REGISTRO, DIALOG_STYLE_INPUT, "REGISTRO", "Escoga una password para registrar esta cuenta", "Registrar", "Salir");
	}
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
	if(UsuarioLogueado[playerid] == true)
	{
    }
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
    CheckPlayerRemoteJacking(playerid);
	return 1;
}

//Funciones
//Anticheat
timer AntiCheat[8000](playerid)
{
	new string[128], nombre[MAX_PLAYER_NAME];
	//Anti-Cheat dinero
	if(GetPlayerMoney(playerid) > InfoJugador[playerid][USER_DINERO])
	{
	    GetPlayerName(playerid, nombre, sizeof(nombre));
	    format(string, sizeof(string), ""#COL_ORANGE"[ANTICHEAT] "#COL_WHITE"%s ha sido baneado por hack de dinero", nombre);
		SendClientMessageToAll(-1, string);
		BanRetrasado(playerid);
	}
}

//REMOTE CARJACK
stock CheckPlayerRemoteJacking( playerid )
{
    new iVehicle = GetPlayerVehicleID( playerid );

    if( !IsPlayerInAnyVehicle( playerid ) )
        GetPlayerPos( playerid, g_carjackData[ playerid ] [ E_LAST_X ], g_carjackData[ playerid ] [ E_LAST_Y ], g_carjackData[ playerid ] [ E_LAST_Z ] );

    if( ( iVehicle != g_carjackData[ playerid ] [ E_LAST_VEH ] ) && ( iVehicle != 0 ) && ( GetPlayerState( playerid ) == PLAYER_STATE_DRIVER ) )
    {
        new
            Float: fDistance = GetVehicleDistanceFromPoint( iVehicle, g_carjackData[ playerid ] [ E_LAST_X ], g_carjackData[ playerid ] [ E_LAST_Y ], g_carjackData[ playerid ] [ E_LAST_Z ] ),
            Float: fOffset = 10.0
        ;

        if( ( GetVehicleModel( iVehicle ) == 577 ) || ( GetVehicleModel( iVehicle ) == 592 )) fOffset = 25.0; // Andromanda | AT-400

        if( fDistance > fOffset) {
            new string[128], nombre[MAX_PLAYER_NAME];
			KickRetrasado(playerid);
			GetPlayerName(playerid, nombre, sizeof(nombre));
			format(string, sizeof(string), ""#COL_ORANGE"[ANTICHEAT] "#COL_WHITE"%s ha sido kickeado por posible robo remoto de vehículos", nombre);
            SendClientMessageToAll(-1, string);
        }

        GetPlayerPos( playerid, g_carjackData[ playerid ] [ E_LAST_X ], g_carjackData[ playerid ] [ E_LAST_Y ], g_carjackData[ playerid ] [ E_LAST_Z ] );
        g_carjackData[ playerid ] [ E_LAST_VEH ] = iVehicle;
    }
}

stock KickRetrasado(playerid)
{
	defer KickRetra(playerid);
}

timer KickRetra[1000](playerid)
{
	Kick(playerid);
}

stock BanRetrasado(playerid)
{
	defer BanRetra(playerid);
}

timer BanRetra[1000](playerid)
{
	Ban(playerid);
}

//____________________ USUARIOS GUARDADO ________________//
stock Usuario(playerid)
{
	new string[128],nombre[MAX_PLAYER_NAME];
	GetPlayerName(playerid, nombre, sizeof(nombre));
	format(string, sizeof(string), PATH, nombre);
	return string;
}

forward CargarUsuario(playerid, name[], value[]);
public CargarUsuario(playerid, name[], value[])
{
	INI_String("Pass", InfoJugador[playerid][USER_PASSWORD], 129);
	INI_Int("Dinero", InfoJugador[playerid][USER_DINERO]);
	INI_Int("Administrador", InfoJugador[playerid][USER_ADMIN]);
	return 1;
}

forward GuardarCuenta(playerid);
public GuardarCuenta(playerid)
{
	new INI:Arch = INI_Open(Usuario(playerid));
	INI_WriteInt(Arch, "Dinero", InfoJugador[playerid][USER_DINERO]);
	INI_WriteInt(Arch, "Administrador", InfoJugador[playerid][USER_ADMIN]);
	INI_Close(Arch);
	return 1;
}

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	switch(dialogid)
	{
	    case REGISTRO:
	    {
         	if(!response) return Kick(playerid);
	        if(response)
	        {
         		new string[128], nombre[MAX_PLAYER_NAME];
	    		GetPlayerName(playerid, nombre, sizeof(nombre));
	    		format(string, sizeof(string), "{FFFFFF}Bienvenido por primera vez {FF6600}%s {FFFFFF}a nuestro gamemode!\nEscribe una password para crear tu nueva cuenta", nombre);
	            if(!strlen(inputtext)) return ShowPlayerDialog(playerid, REGISTRO, DIALOG_STYLE_INPUT, "{FFFFFF}REGISTRO", string, "Registrarse", "Salir");
	            new INI:Arch = INI_Open(Usuario(playerid));
	            INI_SetTag(Arch, "[Cuenta del jugador]");
	            INI_WriteString(Arch, "Pass", inputtext);
	            INI_WriteInt(Arch, "Dinero", 5000);
	            INI_WriteInt(Arch, "Administrador", 0);
				INI_Close(Arch);
				format(string, sizeof(string), "{FFFFFF}Felicidades! Tu cuenta {FF0000}%s {FFFFFF}se ha creado exitosamente..", nombre);
				SendClientMessage(playerid, 0, string);
	        }
	    }

	    case LOGIN:
	    {
         	if(!response) return Kick(playerid);
	        if(response)
	        {
				if(strcmp(inputtext, InfoJugador[playerid][USER_PASSWORD]) == 0)
				{
				    new string[128], name[MAX_PLAYER_NAME];
				    GetPlayerName(playerid, name, sizeof(name));
				    INI_ParseFile(Usuario(playerid), "CargarUsuario", .bExtra = true, .extra = playerid);
				    format(string, sizeof(string), " >> Bienvenido %s a tu cuenta!", name);
					SendClientMessage(playerid, -1, string);
				}
				else
				{
    				new string[128], nombre[MAX_PLAYER_NAME];
	    			GetPlayerName(playerid, nombre, sizeof(nombre));
	    			format(string, sizeof(string), "{FF0000}Password incorrecto. {FFFFFF}Bienvenido {FF0000}%s {FFFFFF}a nuestro gamemode!\nIngresa tu password para ingresar a tu cuenta", nombre);
	    			ShowPlayerDialog(playerid, LOGIN, DIALOG_STYLE_PASSWORD, "{FFFFFF}Login", string, "Ingresar", "Salir");
				}
			}
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

//=================Sistema administrativo ===================
CMD:daradmin(playerid, params[])
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
       				new placa[8];
					new randomplaca = random(9999);
			        GetPlayerPos(playerid,pos[0],pos[1],pos[2]);
			        new vehicleid = CreateVehicle(modelo,pos[0]+2,pos[1],pos[2],90.0,color1,color2,200000);
					InfoCoche[vehicleid][cID] = UltimaIDVeh+1;
					InfoCoche[vehicleid][cColor1] = color1;
					InfoCoche[vehicleid][cColor2] = color2;
					strmid(InfoCoche[vehicleid][cDueno], "Nadie",0,24,24);
	 				InfoCoche[vehicleid][cModelo] = modelo;
					strmid(InfoCoche[vehicleid][cNombre], NombreCoche(vehicleid), 0, strlen(NombreCoche(vehicleid)), 40);
					format(placa, sizeof(placa), "LS-%d", randomplaca);
					strmid(InfoCoche[vehicleid][cPlaca], placa, 0, 8, 8);
					InfoCoche[vehicleid][cX] = pos[0]+2;
					InfoCoche[vehicleid][cY] = pos[1];
					InfoCoche[vehicleid][cZ] = pos[2];
					InfoCoche[vehicleid][cA] = 90.0;
     				SetVehicleNumberPlate(vehicleid,InfoCoche[vehicleid][cPlaca]);
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
}
