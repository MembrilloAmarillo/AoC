
// Created by_r SadenPain on 23/01/2021.
//
#include <iostream>
#include <string>
#include <cstdio>
#include <cassert>

int robo_san (int **coor, FILE *f, int N) {

	for (int x = 0; x < N; x++) {
        for (int y = 0; y < N; y++) {
            coor[x][y] = 0;
        }
    }

    coor[0][0] = 1;
    int x_s = 0;  // Creamos coordenadas distintas para ambos
    int y_s = 0;
    int x_r = 0;
    int y_r = 0;
    int visited_houses = 1;

	int switch_to = 2; // Lo usamos para diferenciar entre
					   // santa y robot santa

	rewind(f);

	char c;

	while ( (c=getc(f)) != EOF ) {
		if ( switch_to % 2 == 0 ) {
			switch(c) {
				case '^':
					++y_s;
				   if (y_s == N)
					   y_s = 0;
					break;
				case 'v':
					--y_s;
					if (y_s < 0)
						y_s = N - 1;
					break;
				case '>':
					++x_s;
				   if (x_s == N)
						x_s = 0;
					break;
				case '<':
					--x_s;
					if (x_s < 0)
						x_s = N - 1;
					break;
				default:
					break;
			}
		}
		else {
			switch(c) {
				case '^':
					++y_r;
				   if (y_r == N)
					   y_r = 0;
					break;
				case 'v':
					--y_r;
					if (y_r < 0)
						y_r = N - 1;
					break;
				case '>':
					++x_r;
				   if (x_r == N)
						x_r = 0;
					break;
				case '<':
					--x_r;
					if (x_r < 0)
						x_r = N - 1;
					break;
				default:
					break;
			}
		}

		if (switch_to % 2 == 0) {
			if (coor[x_s][y_s] == 0) {
				visited_houses++;
				coor[x_s][y_s] = 1;
			}
		} else {
			if (coor[x_r][y_r] == 0) {
				visited_houses++;
				coor[x_r][y_r] = 1;
			}
		}
		switch_to++;
	}

	return visited_houses;
}

int main (int argc, char *argv[])
{
    char file_name[256];
    FILE *f;
    if (argc < 2) {
        printf("Introduce file: ");
        fgets(file_name, 256, stdin);
        f = fopen(file_name, "r");
    } else {
        f = fopen(argv[1], "r");
    }

    assert(f != nullptr);

    int n = 0;
    while ( getc(f) != EOF ) {
        n++;
    }
    rewind(f);
/*
    int **coordinates = (int**)malloc((n+1) * sizeof(int*));
    for (int i = 0; i < n; i++) {
        coordinates[i] = (int*)malloc((n+1) * sizeof(int));
        assert(coordinates[i] != nullptr);
    }
*/
    const int N = n+1;

    int (**coordinates) = new int*[N];
    for (int i = 0; i < N; i++)
        coordinates[i] = new int[N];

    for (int x_ = 0; x_ < N; x_++) {
        for (int y_r_ = 0; y_r_ < N; y_r_++) {
            coordinates[x_][y_r_] = 0;
        }
    }

    coordinates[0][0] = 1;
    int x = 0;
    int y = 0;
    int visited_houses = 1;

    char c;
    while ((c = fgetc(f)) != EOF) {
        switch(c) {
            case '^':
                ++y;
               if (y == N)
                   y = 0;
                break;
            case 'v':
                --y;
                if (y < 0)
                    y = N - 1;
                break;
            case '>':
                ++x;
               if (x == N)
                    x = 0;
                break;
            case '<':
                --x;
                if (x < 0)
                    x = N - 1;
                break;
            default:
                break;
        }
		if (coordinates[x][y] == 0)
			visited_houses++;
		coordinates[x][y] = 1;
    }

    std::cout << "Visited houses: " << visited_houses << std::endl;
	
	visited_houses = robo_san (coordinates, f, N);
	
	std::cout << "Visited houses with robo and santa: " 
		<< visited_houses << std::endl;

    delete[](coordinates);
    fclose(f);
    return EXIT_SUCCESS;
}
