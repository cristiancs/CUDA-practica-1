rm -rf ejercicio
nvcc -o ejercicio -arch sm_61 main.cu 
./ejercicio