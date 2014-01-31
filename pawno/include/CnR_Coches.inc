#if defined _CnR_Coches_included
    #endinput
#endif
#define _CnR_Coches_included

#include <YSI\y_ini>

#define GCoches "/Coches/%i.ini"

new UltimaIDVeh;

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

forward CargarCoche(id,name[],value[]);
public CargarCoche(id,name[],value[])
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

forward GuardarCoche(idcoche);
public GuardarCoche(idcoche)
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

forward BorrarCoche(idcoche);
public BorrarCoche(idcoche)
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
