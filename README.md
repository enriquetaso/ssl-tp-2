# SSL: Trabajo practico N2 - Realizar un intérprete del lenguaje MICRO

Para compilar el proyecto, debe seguirse los siguientes pasos en Windows:
1. `bison -yd micro.y`
2. `Flex micro.l`
3.  `gcc y.tab.c lex.yy.c -ll -o salida`


## Trabajo escrito para entregar

https://docs.google.com/document/d/1d66TJlU3g4_jXTxKp_gQAHaZQSzA2YfQy7DAlaV3bkY/edit


## Linux cross-compilation Windows

Para compilar un ejecutable de Windows en Linux, usamos la técnica llamada *cross-compilation*. El proyecto [MinGW-w64](http://mingw-w64.org/doku.php) cumple este propósito. Y puede usarse de la siguiente manera:

1. Primero lo installamos `sudo dnf install mingw64-gcc-*`. Yo estoy usando Fedora 28. Depende la distro que uses instalar el paquete adecuado. 
2. Compilamos de la siguiente manera `x86_64-w64-mingw32-gcc -o hello_world.exe hello_world.c`.


### Cosas curiosas
1. [¿Por qué no compila en Windows?](https://stackoverflow.com/questions/32117572/why-does-a-linux-compiled-program-not-work-on-windows)
