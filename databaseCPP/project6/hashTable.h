/* Ben Hawk
   This is the header file for the hashtable class, it uses the shuffle function found in shuffle.h
   to create a random array for psuedo-random probing, as well as the hashfunction to create intiial home 
   positions for its slots. The slots have a key and index value which are used to match them to Student Records
*/

#include "Slot.h"
#include "hashfunction.h"
#include "Record.h"
#include "shuffle.h"
#include <iostream>

using namespace std;
#define MAX_HASH 20;
class hashTable{

    private:
    int maxHash; // variable to keep track of the maximum number of elements allowed
    int numElts; // variable to update the loading factor of the hashtable 
    array<int, 19> randHash;
    // slot list is public so it can be accessed by database print function
    public:
    Slot slotList[20];
    hashTable();

    ~hashTable();
    
    bool find(int, int&, int&);

    bool insert(int, int&, int&);

    bool remove(int);
    
    float alpha();

    friend ostream& operator<<(ostream& os, const hashTable& me);
};
