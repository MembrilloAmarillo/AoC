#include <cstdio>
#include <iostream>
#include <cassert>

using namespace std;

long int mult_dimension(const int& l, const int& w, const int& h) {
	int resolve;
	
	resolve = 2*l*w + 2*w*h + 2*h*l;
	
	int min_side = l*w;

	if ( l * h < min_side )
		min_side = l*h;
	if ( w*h < min_side )
		min_side = w*h;
	
	resolve += min_side;

	return resolve;
}

long int mul_ribbon (const int& l, const int& w, const int& h) {
	long int resolve = 0;
	
	long int shortest_distance = l + l + w + w;

	if ( l + l + h + h < shortest_distance )
		shortest_distance = l + l + h + h;
	if ( w + w + h + h < shortest_distance )
		shortest_distance = w + w + h + h;

	resolve += shortest_distance;
	resolve += (w * h * l);

	return resolve;
}

int main (int argc, char *argv[])
{
	char *fi = argv[1];
	FILE *f = fopen(fi, "r");

	assert(f != nullptr);
		
	char c;
	int x_counter = 0;
	int value[3];
	int hold_value = 0;
	int hold_temp_value_c = 0;
	
	long int resolve = 0;
	long int ribbon  = 0;

	while ((c = fgetc(f)) != EOF) {
		if (c != 'x') {
			hold_value = atoi(&c);

			while (((c = fgetc(f)) != 'x') && (c != '\n') && (c != EOF)) {
				hold_temp_value_c = atoi(&c);
				hold_value *= 10;
				hold_value += hold_temp_value_c;
			}
			switch (x_counter) {
				case 0:
					value[0] = hold_value;
					break;
				case 1:
					value[1] = hold_value;
					break;
				case 2:
					value[2] = hold_value;
					break;
				default:
					break;
			}
			hold_value = 0;
		}
		if (c == 'x')
			x_counter++;
		else if ( c == '\n' ) {
			x_counter = 0;
			resolve += mult_dimension(value[0], value[1], value[2]);
			ribbon += mul_ribbon(value[0], value[1], value[2]);
		}
	}
	cout << resolve << endl;
	cout << ribbon << endl;

	return EXIT_SUCCESS;
}
