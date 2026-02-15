/* Ben Hawk
   This file establishes the database class, which contains both a vector of records, and a hashtable of slots, 
   It shares much of the same functionality of the hashtable, with the addition of the recordStore variable
*/

#include "hashtable.h"
#include "Record.h"
#include <iostream>
#include <vector>

using namespace std;

class database{
    private: 
    hashTable indexTable;
    vector<Record>  recordStore;

    public:
    // constructor
    database();
    // destructor
    ~database();

    bool find(int, Record&, int&);
    
    bool insert(const Record&, int&);

    bool remove(int);

    float alpha();

   // print function 

   friend ostream& operator<<(ostream& os, const database& me);

};
    
