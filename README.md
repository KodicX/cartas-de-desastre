# Cartas de desastre

Repositorios rotos a propósito para practicar cómo deshacer errores en Git. Cada carta del taller cuenta qué pasó, y este script arma el repositorio donde pasó.

## Cómo se usa

En Git Bash, dentro de esta carpeta, ejecuten el script con el número de su carta, del 1 al 6:

```bash
bash preparar.sh 3
```

Al terminar dice `Carta 3 lista`.

## Dónde queda cada carta

El script crea la carpeta `~/desastres/cartaN`, donde `N` es el número de la carta. Adentro hay dos cosas:

* `repo`: el repositorio del equipo. Aquí se trabaja.
* `remoto.git`: hace de GitHub. Recibe `git push` igual que el de verdad, así que pueden subir cambios sin miedo. No hace falta entrar a esta carpeta.

Para empezar a trabajar en la carta 3:

```bash
cd ~/desastres/carta3/repo
```

## Si algo sale mal

Corran otra vez el script con el mismo número. Borra la carta y la deja como estaba al principio, así que se pierde lo que hayan hecho en ella.

```bash
cd ~/cartas-de-desastre
bash preparar.sh 3
cd ~/desastres/carta3/repo
```

Si clonaron este repositorio en otro lugar, cambien la primera línea por esa carpeta. El último `cd` sí hace falta: el script borra la carpeta anterior aunque estén dentro de ella.

## Avisos normales en Windows

Al correr el script pueden salir mensajes como este:

```
warning: in the working copy of 'README.md', LF will be replaced by CRLF the next time Git touches it
```

Se pueden ignorar. Git solo avisa que ajusta los finales de línea para Windows, y no afecta las cartas.
