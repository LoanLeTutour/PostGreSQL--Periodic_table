#! /bin/bash

PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

if [[ -z $1 ]]
then echo "Please provide an element as an argument."
else
if [[ $1 =~ ^[0-9]*$ ]]
then 
ATOMIC_NUMBER=$($PSQL "SELECT atomic_number FROM properties WHERE atomic_number=$1")
if [[ -z $ATOMIC_NUMBER ]] 
then echo "I could not find that element in the database."
else
SYMBOL=$($PSQL "SELECT symbol FROM properties INNER JOIN elements USING(atomic_number) WHERE atomic_number=$1")
NAME=$($PSQL "SELECT name FROM properties INNER JOIN elements USING(atomic_number) WHERE atomic_number=$1")
ATOMIC_MASS=$($PSQL "SELECT atomic_mass FROM properties INNER JOIN elements USING(atomic_number) WHERE atomic_number=$1")
MELTING_POINT=$($PSQL "SELECT melting_point_celsius FROM properties WHERE atomic_number=$1")
BOILING_POINT=$($PSQL "SELECT boiling_point_celsius FROM properties WHERE atomic_number=$1")
TYPE=$($PSQL "SELECT type FROM properties INNER JOIN types USING(type_id) WHERE atomic_number=$1")
echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
fi
else 
if [[  $1 =~ ^[a-zA-Z]{0,2}$ ]]
then 
SYMBOL=$($PSQL "SELECT symbol FROM properties INNER JOIN elements USING(atomic_number) WHERE symbol='$1'")
if [[ -z $SYMBOL ]] 
then echo "I could not find that element in the database."
else
ATOMIC_NUMBER=$($PSQL "SELECT atomic_number FROM properties INNER JOIN elements USING(atomic_number) WHERE symbol='$1'")
NAME=$($PSQL "SELECT name FROM properties INNER JOIN elements USING(atomic_number) WHERE symbol='$1'")
ATOMIC_MASS=$($PSQL "SELECT atomic_mass FROM properties INNER JOIN elements USING(atomic_number) WHERE symbol='$1'")
MELTING_POINT=$($PSQL "SELECT melting_point_celsius FROM properties INNER JOIN elements USING(atomic_number) WHERE symbol='$1'")
BOILING_POINT=$($PSQL "SELECT boiling_point_celsius FROM properties INNER JOIN elements USING(atomic_number) WHERE symbol='$1'")
TYPE=$($PSQL "SELECT type FROM properties INNER JOIN elements USING(atomic_number) INNER JOIN types USING(type_id) WHERE symbol='$1'")
echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
fi
else
NAME=$($PSQL "SELECT name FROM properties INNER JOIN elements USING(atomic_number) WHERE name='$1'")
if [[ -z $NAME ]]
then echo "I could not find that element in the database."
else
SYMBOL=$($PSQL "SELECT symbol FROM properties INNER JOIN elements USING(atomic_number) WHERE name='$1'")
ATOMIC_NUMBER=$($PSQL "SELECT atomic_number FROM properties INNER JOIN elements USING(atomic_number) WHERE name='$1'")
ATOMIC_MASS=$($PSQL "SELECT atomic_mass FROM properties INNER JOIN elements USING(atomic_number) WHERE name='$1'")
MELTING_POINT=$($PSQL "SELECT melting_point_celsius FROM properties INNER JOIN elements USING(atomic_number) WHERE name='$1'")
BOILING_POINT=$($PSQL "SELECT boiling_point_celsius FROM properties INNER JOIN elements USING(atomic_number) WHERE name='$1'")
TYPE=$($PSQL "SELECT type FROM properties INNER JOIN elements USING(atomic_number) INNER JOIN types USING(type_id) WHERE name='$1'")
echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
fi
fi
fi
fi