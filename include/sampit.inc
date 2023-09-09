// SAMPit Query include by Hauke Marquardt alias |-|auke - 26.10.2012
/*
License:
        This code is free: you can redistribute it and/or modify
        it under the terms of the GNU General Public License as published by
        the Free Software Foundation, either version 3 of the License, or
        (at your option) any later version.

        This code is distributed in the hope that it will be useful,
        but WITHOUT ANY WARRANTY; without even the implied warranty of
        MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
        GNU General Public License for more details.

        You should have received a copy of the GNU General Public License
        along with this program.  If not, see <http://www.gnu.org/licenses/>.
        You´re not allowed to copy any code from this, into your code without
        naming authors name in credits!
*/

#if !defined _h_library_norm_included
    #define PAWN_TYPE_INT                   1
    #define PAWN_TYPE_FLOAT                 2
    #define PAWN_TYPE_ARRAY                 3
    #define _h_library_norm_included
#endif

#if defined _sampit_query_include
	#endinput
#endif
#define _sampit_query_include

native SAMPit_Query_Invoke ( );

public OnGameModeInit ( )
{
	SAMPit_Query_Invoke ( );
	if ( funcidx ( "SAMPit_Query_OnGameModeInit" ) != -1 )
	{
		return CallLocalFunction ( "SAMPit_Query_OnGameModeInit" , "" );
	}
	return 1;
}

#if defined _ALS_OnGameModeInit
	#undef OnGameModeInit
#else
	#define _ALS_OnGameModeInit
#endif
#define OnGameModeInit SAMPit_Query_OnGameModeInit

forward SAMPit_Query_OnGameModeInit ( );
