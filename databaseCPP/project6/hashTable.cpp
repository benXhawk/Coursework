/* Ben Hawk 
   The Purpose of this file is to create an array of slot elements, that each have a key and index value, that can be
   easily searched and updated. 
*/

#include "hashtable.h"
#include "hashfunction.h"
#include <iostream>


/* This constructor intializes the maxHash variable to 20, the number of elements in the array*/

using namespace std;
hashTable::hashTable(){
    maxHash = MAX_HASH;
    numElts = 0;
    randHash = makeShuffledArray();
}

// The destructor sets all of the slots back to -1 index and -1 key, and then sets their status to empty
// then sets the numElts and maxHash to -1 as well
hashTable::~hashTable(){
   
    for(int i = 0; i < maxHash; i++){
        slotList[i].load(-1,-1);
        slotList[i].kill();
    }
    numElts = -1;
    maxHash = -1;
}
/*This find function uses the hash function create a new index for the slot to be located, and then 
  while it has not found any empty since start slots and it hasn't searched for the maximum amount of slots
  in slotlist, it checks if the key is equal to the key that is being searched. It returns true if it is, and 
  if it isn't, uses the shuffled array elements to add to the index that is being searched, adds one to slotsChecked and 
  the total number of collisions during the search
*/

bool hashTable::find(int key, int& index, int& collisions){
    index = jsHash(key) % maxHash;
    Slot currentSlot = slotList[index];
    int slotsChecked = 0;
    int probeCount = 0;
    while((currentSlot.isEmptySinceStart() == false) && slotsChecked < maxHash){
        if((currentSlot.isEmpty() == false)&& currentSlot.getKey() == key){
            return true;
        }
        slotsChecked++;
        collisions++;
        probeCount = randHash[slotsChecked];
        index = (index + probeCount)%maxHash;
        currentSlot = slotList[index];
    }
    return false;
}

// this function first checks if there is a slot with the given value in the table
// evaluating to false if there is a duplicate slot, and then selects an index based 
// on the key value, then searches for an empty slot by using pseudo random probing
// to iterate the home position
bool hashTable::insert(int key, int& index, int& collisions){
    if((find(key, index, collisions)==true) || numElts == maxHash){
        return false;
    } else {
        index = jsHash(key) % maxHash;
        collisions = 0; // resets the collisions variable from the find function
        int iterator = 0;
        int probeCount = 0;
        while(slotList[index].isEmpty() == false){
            collisions++;
            probeCount = randHash[iterator];
            index = (index + probeCount)%maxHash;
        }
            slotList[index].load(key, index);
            numElts++;
            return true;
        }
    }

/*
    This functions looks for a slot containing the key, sets the key/index values
    to their default values if it is true, and then sets it to emptyAfterRemoval
    Otherwise, it just returns false
*/

bool hashTable::remove(int key){
    int index = 0;
    int collisions = 0;
    if(find(key, index, collisions)== true){
        slotList[index].load(-1, -1);
        slotList[index].kill();
        numElts--;
        return true;
    } else {
        return false;
    }
}

// returns the loading factor of the table, by dividing the 
// the current number of elements by the maximum allowed elements
float hashTable::alpha(){
    return float(numElts/maxHash);
}
// iterates over slotList, printing the contents of each slot if it is not empty
ostream& operator<<(ostream& os, const hashTable& me){
    for(int i = me.maxHash-1; i >= 0; i++){
        if(me.slotList[i].isEmpty() == false){
            os << "HashTable Slot " << i << ": , Index = " << me.slotList[i].getIndex() << ", Key = " << me.slotList[i].getKey() << endl; 
        }
    }
    return os;
}

