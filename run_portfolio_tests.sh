#!/data/data/com.termux/files/usr/bin/bash
# Tests de démonstration reproductibles du portfolio (Termux / Linux)
set -eu
BASE="$(cd "$(dirname "$0")/.." && pwd)"
MEDIA="$BASE/medias"
cd "$MEDIA"

printf '\n===== ENVIRONNEMENT =====\n'
printf 'Date : '; date
printf 'Dossier : '; pwd
printf '\n===== PYTHON : CALCULATRICE =====\n'
printf '17\n+\n25\n' | python3 calculatrice.py
printf '\n===== PYTHON : JEU DE DEVINETTES =====\n'
# Le nombre secret est aléatoire : plusieurs propositions permettent de jouer.
python3 -c "import builtins, runpy, random; random.randint=lambda a,b: 50; builtins.input=lambda prompt='': '50'; runpy.run_path('devinettes.py')"
printf '\n===== PYTHON : GESTIONNAIRE DE NOTES =====\n'
printf '2\nMathématiques\n16\nInformatique\n18\n' | python3 gestionnaire_notes.py

printf '\n===== C : COMPILATION ET EXÉCUTION =====\n'
if ! command -v clang >/dev/null 2>&1; then
  echo "clang absent. Installe-le avec : pkg install clang"
  exit 2
fi
for src in variables-conditions.c boucles-tableaux.c fonctions-pointeurs.c; do
  exe="${src%.c}"
  echo "--- $src ---"
  clang -Wall -Wextra -std=c11 "$src" -o "$exe"
  case "$src" in
    variables-conditions.c) printf '15\n' | "./$exe" ;;
    *) "./$exe" ;;
  esac
done

printf '\n===== SYSTÈME D’EXPLOITATION / TERMINAL =====\n'
printf '$ pwd\n'; pwd
printf '\n$ ls -la\n'; ls -la | head -20
printf '\n$ uname -a\n'; uname -a
printf '\n$ mkdir -p preuve-terminal\n'; mkdir -p preuve-terminal
printf '\n$ printf ... > preuve-terminal/test.txt\n'; printf 'Portfolio numérique - test terminal OK\n' > preuve-terminal/test.txt
printf '\n$ cat preuve-terminal/test.txt\n'; cat preuve-terminal/test.txt
printf '\n$ df -h .\n'; df -h .
printf '\n===== FIN DES TESTS =====\n'
echo 'Les tests ci-dessus sont des démonstrations. Faites vos propres captures d’écran dans Termux.'
