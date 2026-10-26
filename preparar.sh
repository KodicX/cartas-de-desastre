#!/usr/bin/env bash
# Prepara un repositorio roto para las cartas de desastre del Bloque 2.
# Uso: bash preparar.sh <numero de carta 1 a 6>
# Crea ~/desastres/cartaN/repo (el repo del equipo) y ~/desastres/cartaN/remoto.git (hace de GitHub).
set -e

N="$1"
if [[ ! "$N" =~ ^[1-6]$ ]]; then
  echo "Uso: bash preparar.sh <1 a 6>"
  exit 1
fi

BASE="$HOME/desastres/carta$N"
rm -rf "$BASE"
mkdir -p "$BASE"
cd "$BASE"

git -c init.defaultBranch=main init -q --bare remoto.git
git -c init.defaultBranch=main init -q repo
cd repo
git remote add origin ../remoto.git

c() { git add -A && git commit -q -m "$1"; }

# Historia base, igual en todas las cartas
printf "# Pagina del congreso\n\nSitio de ejemplo para el taller.\n" > README.md
c "Agrega README"
printf "<h1>Congreso Proxy</h1>\n<p>Bienvenida</p>\n" > index.html
c "Agrega portada"
printf "<h2>Agenda</h2>\n<p>8:00 Registro</p>\n" > agenda.html
c "Agrega agenda"
git push -q -u origin main 2>/dev/null

case "$N" in
  1) # restore: cambios sin commit en working directory y staging
     printf "texto pegado por error\nlorem ipsum\n" > README.md
     printf "usuario=admin\nclave=1234\n" > claves.txt
     git add claves.txt
     ;;
  2) # amend: ultimo commit local con mal mensaje y archivo olvidado
     printf "<p>Sede: Edificio L5</p>\n" >> index.html
     printf "h1 { color: navy; }\n" > estilos.css
     git add index.html
     git commit -q -m "asdf"
     ;;
  3) # reset --soft: tres commits locales que deberian ser uno
     printf "<p>9:00 Taller de Git</p>\n" >> agenda.html;  c "wip"
     printf "<p>12:00 Comida</p>\n" >> agenda.html;        c "wip2"
     printf "<p>15:00 Clausura</p>\n" >> agenda.html;      c "ya quedo"
     ;;
  4) # revert: commit roto ya publicado
     printf "<h1>Congreso Proxy</h1>\n" > index.html
     c "Actualiza portada"
     printf "Contacto: proxy@ejemplo.com\n" >> README.md
     c "Agrega contacto"
     git push -q origin main 2>/dev/null
     ;;
  5) # reflog: commits borrados con reset --hard
     printf "<h2>Ponentes</h2>\n<p>Ana, Luis y Marta</p>\n" > ponentes.html; c "Agrega ponentes"
     printf "<p>Taller de Git</p>\n" >> ponentes.html;                       c "Agrega talleres a ponentes"
     printf "<a href=\"ponentes.html\">Ponentes</a>\n" >> index.html;         c "Enlaza ponentes desde la portada"
     git reset -q --hard HEAD~3
     ;;
  6) # push rechazado: amend sobre un commit ya publicado
     printf "<p>Sede: Edificio L5</p>\n" >> index.html
     c "Agrega sede a la portda"
     git push -q origin main 2>/dev/null
     git commit -q --amend -m "Agrega sede a la portada"
     ;;
esac

echo "Carta $N lista. Ejecutar: cd ~/desastres/carta$N/repo"