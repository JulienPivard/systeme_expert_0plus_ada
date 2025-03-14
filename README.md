[![Build binaries](https://github.com/JulienPivard/systeme_expert_0plus_ada/workflows/Build%20build/badge.svg)](https://github.com/JulienPivard/systeme_expert_0plus_ada/actions)

# Systeme Expert 0+

Projet C++ universitaire de master 1 informatique en binome. Le projet
était à l'origine en C++, le défis était de le refaire en Ada.

Le devoir consistait à mettre en place un système expert 0+ en étant un
peu guidé sur les _design patterns_ à utiliser, mais l'architecture de
l'application et l'agencement des _design patterns_ entre eux est de notre
conception. Parmi les consignes qui nous avaient été données :
* Respecter la philosophie du langage.
* Ne pas faire d'allocation dynamique à la main.
* Les messages d'erreurs seront volontairement négligés étant donné la
  masse déjà conséquente de travail.
* La grammaire à implémenter est la grammaire _lorraine_.

## Configurer et compiler avec Cmake
### Méthode automatique.

Tapez simplement `make` pour lancer la compilation.

## Exécution

Exemple d'exécution :
* `make run`
pour lancer l'exécution avec les paramètres défini dans _makefile.conf_.

Manuellement on peux le lancer avec
* `./bin/{dev,debug,release}/executable lorraine.txt`

Pour lancer avec un affichage debug de l'exécution des règles.
* `./bin/{dev,debug,release}/executable lorraine.txt -d`

Les erreurs ne sont volontairement pas très explicites du fait de la masse
de travail du devoir, il nous a été demandé de ne pas pousser cet aspect.
Il n'est ainsi pas possible pour le moment de savoir quelle règle
à déclenché un problème.

## Tests unitaires

Les tests unitaires sont dans le dossier `tests_unitaires/` et dispose de
son propre makefile. La compilation et l'exécution fonctionne de la même
manière que pour le programme principale.

## Générer la documentation développeur

Pour générer la documentation placez-vous à la racine du dépôt et tapez :
* `make doc`
