#if defined _Coches_included
    #endinput
#endif
#define _Coches_included

#define GCoches "/Coches/%i.ini"

enum cInfo
{
	cID,
	cColor1,
	cColor2,
	cModelo,
	cNombre[30],
	Float:cX,
	Float:cY,
	Float:cZ,
	Float:cA
}
new InfoCoche[MAX_VEHICLES][cInfo];

puvlic CargarCoches()
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
				InfoCoche[idcoche][cID] = InfoCoche[i][cID];
				InfoCoche[idcoche][cColor1] = InfoCoche[i][cColor1];
				InfoCoche[idcoche][cColor2] = InfoCoche[i][cColor2];
				InfoCoche[idcoche][cModelo] = InfoCoche[i][cModelo];
				strmid(InfoCoche[idcoche][cNombre],InfoCoche[i][cNombre],0,30,30);
				new Float:pos[4];
		     	GetVehiclePos(idcoche,pos[0],pos[1],pos[2]);
		      	GetVehicleZAngle(idcoche,pos[3]);
		  		InfoCoche[idcoche][cX] = pos[0];
		  		InfoCoche[idcoche][cY] = pos[1];
		  		InfoCoche[idcoche][cZ] = pos[2];
		  		InfoCoche[idcoche][cA] = pos[3];
		    	ResetearVariablesCoches(idcoche);
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

funcion CargarCoche(id,name[],value[]) //Trenico
{
	INI_Float("X",InfoCoche[id][cX]);
	INI_Float("Y",InfoCoche[id][cY]);
	INI_Float("Z",InfoCoche[id][cZ]);
	INI_Float("A",InfoCoche[id][cA]);
	INI_Int("ID",InfoCoche[id][cID]);
	INI_Int("Color1",InfoCoche[id][cColor1]);
	INI_Int("Color2",InfoCoche[id][cColor2]);
	INI_Int("Modelo",InfoCoche[id][cModelo]);
	INI_String("Nombre",InfoCoche[id][cNombre],30);
	return 0;
}

funcion GuardarCoche(idcoche)
{
	new file[64];
 	format(file,sizeof file,GCoches,InfoCoche[idcoche][cID]);
  	new INI:arch = INI_Open(file);
  	INI_WriteInt(arch,"Color1",InfoCoche[idcoche][cColor1]);
  	INI_WriteInt(arch,"Color2",InfoCoche[idcoche][cColor2]);
  	INI_WriteInt(arch,"Modelo",InfoCoche[idcoche][cModelo]);
  	INI_WriteString(arch,"Nombre",InfoCoche[idcoche][cNombre]);
  	INI_WriteFloat(arch,"X",InfoCoche[idcoche][cX]);
  	INI_WriteFloat(arch,"Y",InfoCoche[idcoche][cY]);
  	INI_WriteFloat(arch,"Z",InfoCoche[idcoche][cZ]);
  	INI_WriteFloat(arch,"A",InfoCoche[idcoche][cA]);
    INI_Close(arch);
    return 1;
}

funcion BorrarCoche(idcoche) //Trenico
{
	new string[40];
    new idccoche = InfoCoche[idcoche][cID];
    format(string, sizeof(string),GCoches,idccoche);
	if(fexist(string))
	{
        DestroyVehicle(idcoche);
        InfoCoche[idcoche][cID] = 0;
        InfoCoche[idcoche][cColor1] = 0;
        InfoCoche[idcoche][cColor2] = 0;
        InfoCoche[idcoche][cModelo] = 0;
        strmid(InfoCoche[idcoche][cNombre],"Nada",0,30,30);
        InfoCoche[idcoche][cX] = 0.0;
        InfoCoche[idcoche][cY] = 0.0;
        InfoCoche[idcoche][cZ] = 0.0;
        InfoCoche[idcoche][cA] = 0.0;
        fremove(string);
        return 1;
	}
	return 0;
}
