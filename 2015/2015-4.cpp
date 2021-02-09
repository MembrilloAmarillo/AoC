#include <iostream>
#include <string>

// Librerias externas usadas para la funcion hash
// Debe compilarse especificando CPPFLAGS:= -I/usr/include/hashlib++/ -lhl++
// si quieres usarlo como libreria estatica
// Para mas documentacion http://hashlib2plus.sourceforge.net/doc/README.TXT.html
#include "/usr/include/hashlib++/hashlibpp.h"
#include "/usr/include/hashlib++/hl_md5wrapper.h"

int main (int argc, char *argv[]) 
{
	std::string secret_key = "yzbqklnj"; // El input que me ha tocado
	
	hashwrapper *hash = new md5wrapper(); // Funcion hash
	
	// Para la primera parte
	std::string ans = hash->getHashFromString(secret_key);
	
	// Para la segunda parte
	std::string ans_2 = hash->getHashFromString(secret_key);
	
	int counter = 0;

	// Descomentas la parte que quieras calcular
	while (/*ans != "00000"*/ ans_2 != "000000" ) {

		secret_key.resize(8); // Restauramos el valor

		secret_key.append(std::to_string(counter));
		
		// usado para calcular la primera parte
		/*
	    ans = hash->getHashFromString(secret_key);
		ans = ans.substr(0,5);
		*/
		
		// Usado para calcular la segunda parte
	    ans_2 = hash->getHashFromString(secret_key);
		ans_2 = ans_2.substr(0,6);

		counter++;
	}

	std::cout << secret_key;

	return EXIT_SUCCESS;
}
