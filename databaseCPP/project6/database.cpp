/* Ben Hawk
   This file creates the functionality of the database class, which uses the established functions
   of the hashtable class to create its own vector of records.
*/
#include "database.h"
#include <iostream>


using namespace std;

    // initializes the hashtable
    database::database(){
        indexTable = hashTable();
    }
    // destructor
    database::~database(){
        for(Record r: recordStore){
            recordStore.pop_back();
        }
        
    }

    /* This function searches the databases's hashtable for the record first, and returns false
       if the uid cannot be found. Otherwise, it iterates over the recordStore vector until a matching 
       uid is found to the passed parameter, and sets the foundRecord parameter equal to that record and
       returns true;
    */
    bool database::find(int uid, Record& foundRecord, int& collisions){
        int index = 0;
        if(indexTable.find(uid, index, collisions) == false){
            return false;
        } else if(indexTable.find(uid, index, collisions) == true){
            for(Record r: recordStore){
                if(r.getUID() == uid){
                    foundRecord = r;
                    break;
                }
            }
            return true;
        }
        return false;
    }

    /* This function looks in the hashtable for a slot matching the uid of the new record,
       And returns false if it already present. Otherwise, it adds the new record to the database's
       vector, and calls the insert function to insert the new key into the hashtable
    */
    
    bool database::insert(const Record& newRecord, int& collisions){
        int index = 0;
        if(indexTable.find(newRecord.getUID(),index, collisions)== true){
            return false;
        } else if (indexTable.find(newRecord.getUID(), index, collisions) == false){
            recordStore.push_back(newRecord);
            if(indexTable.insert(newRecord.getUID(), index, collisions)== true){
                 return true;
            }
           
        }
        return false;
    }

    /* This Function makes sure the key could be removed from the hashtable, 
        replaces the item to be removed with the last item in the vector,
        and then removes the last item in the vector
    */
    bool database::remove(int key){
        if(indexTable.remove(key) == true){
              for(Record r: recordStore){
                if(r.getUID() == key){
                    r = recordStore.back();
                    recordStore.pop_back();
                }
            }
            return true;
        } else {
            return false;
          
        }
    }
    // calls the hashtable's alpha function
    float database::alpha(){
        return indexTable.alpha();
    }

    // Iterates over the database's hashtable and looks for nonempty slots, then looks
    // for the matching uid to the current slot, and then prints it out.
    ostream& operator<<(ostream& os, const database& me) {
		os << "Database contents: " << endl;
      for(int i = 19; i >= 0; i--){
        if(me.indexTable.slotList[i].isEmpty() == false){
            os << "Hashtable Slot: " << i << ", " << "Record Store Slot: " << me.indexTable.slotList[i].getIndex() << " ";
        }
         for(Record r: me.recordStore){
            if(r.getUID() == me.indexTable.slotList[i].getKey()){
             os << r << endl;
          }   
        }
      }
      return os;
	}

    