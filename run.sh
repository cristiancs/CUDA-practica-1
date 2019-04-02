rm -rf ejercicio
# nvcc -o ejercicio -arch sm_61 main.cu 
g++ main.cpp -o ejercicio
./ejercicio
cat img_salida.txt