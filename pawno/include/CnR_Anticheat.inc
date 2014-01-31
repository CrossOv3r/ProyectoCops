#if defined _CnR_Anticheat_included
    #endinput
#endif
#define _CnR_Anticheat_included

forward CnR_OnPlayerConnect(playerid);
forward AntiCheat(playerid);

enum E_CARJACK_DATA
{
    Float: E_LAST_X,        Float: E_LAST_Y,        Float: E_LAST_Z,
    E_LAST_VEH
}
new g_carjackData[ MAX_PLAYERS ] [ E_CARJACK_DATA ];

public AntiCheat(playerid)
{
	new string[128], nombre[MAX_PLAYER_NAME];
	//Anti-Cheat dinero
	if(GetPlayerMoney(playerid) > InfoJugador[playerid][USER_DINERO])
	{
	    GetPlayerName(playerid, nombre, sizeof(nombre));
	    format(string, sizeof(string), ""#COL_ORANGE"[ANTICHEAT] "#COL_WHITE"%s ha sido baneado por hack de dinero", nombre);
		SendClientMessageToAll(-1, string);
	}
}

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
			GetPlayerName(playerid, nombre, sizeof(nombre));
			format(string, sizeof(string), ""#COL_ORANGE"[ANTICHEAT] "#COL_WHITE"%s ha sido kickeado por posible robo remoto de vehículos", nombre);
            SendClientMessageToAll(-1, string);
        }

        GetPlayerPos( playerid, g_carjackData[ playerid ] [ E_LAST_X ], g_carjackData[ playerid ] [ E_LAST_Y ], g_carjackData[ playerid ] [ E_LAST_Z ] );
        g_carjackData[ playerid ] [ E_LAST_VEH ] = iVehicle;
    }
}

public OnPlayerConnect(playerid)
{
    SetTimerEx("AntiCheat",8000,1,"i",playerid);
	return CallLocalFunction("CnR_OnPlayerConnect","i",playerid);
}

#define OnPlayerConnect CnR_OnPlayerConnect
