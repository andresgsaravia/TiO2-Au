
Photodegradation of methylene blue with TiO2 impregnated with Au via plasma
===========================================================================

Dataset by Debra Jene Kirkconnell Reyes measured at CINVESTAV-Merida.

## Normalization

First we normalize all the data. To do this we subtract from each dataset the minimum in the range 800-1000nm and then multiply for the maximum in that same range. This is done in the file "normalize.R".

# Integration

To quantify the degradation we calculate the integrals of the normalized data from 500nm to 800nm. This is done using an interpolating spline in this range. Later we normalize this integration by making the maximum integral value 1. This is done in the file "integrate.R"