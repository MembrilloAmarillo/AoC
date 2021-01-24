//
// Created by SadenPain on 23/01/2021.
//
#include <iostream>
#include <string>
#include <cstdio>
#include <cassert>

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
        for (int y_ = 0; y_ < N; y_++) {
            coordinates[x_][y_] = 0;
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

    delete[](coordinates);
    fclose(f);
    return EXIT_SUCCESS;
}