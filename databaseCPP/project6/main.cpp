/* Ben Hawk
   This file creates a database with a hashtable the size of maxHash, and uses it to allow the user
   to enter new records, search and delete existing ones, and print out the current contents of the database
*/

#include <iostream>
#include "database.h"

using namespace std;

int main(){


    // main database variable
    database studentList;
    // variables to store user input
    string input;
    int intput;
    // used to pass as the collisions variable in the database functions
    int collisions = 0;


 
    while(true){
        cout << "Would you like to (I)nsert a record, or (D)elete a record, (S)earch for a record, (P)rint the database, (Q)uit? " << endl;
        cout << "Enter Action: " ;
        cin >> input;
        if(input == "I"){
          cout << "Inserting a new record" << endl;
          Record newRecord; // creates a new record variable to update its values
                   
          // This takes the users input and passes it as the parameters to the records setter functions
          cout << "Last Name: " ;
          cin >> input;
          newRecord.setLast(input);
          cout << "First Name: " ;
          cin >> input;
          newRecord.setFirst(input);
          cout << "UID: " ;
          cin >> intput;
          newRecord.setUid(intput);
          cout << "Year: ";
          cin >> input;
          newRecord.setYear(input);
        
          // Checks if the insertion is successful and informs the user
          if(studentList.insert(newRecord, collisions)== false){
            cout << "Student could not be added to records." << endl;
          } else {
            cout << "Student successfully added to records. (" << collisions << " collisions during insertion)" << endl;
          }
        } else if(input == "D"){
          cout << "Enter UID to remove" ; // lets the user enter UID to remove
          cin >> intput; 
          if(studentList.remove(intput) == false){ // checks if the UID could actually be removed
            cout << "This student is not in the database and could not be removed" << endl;
          } else {
            cout << "Student succesfully removed" << endl;
          }
        } else if(input == "S"){
          cout << "Enter UID to search for" ;
          cin >> intput; 
          Record foundRecord; // creates record to pass values from find function into
          if(studentList.find(intput, foundRecord, collisions) == false){ // checks if search is successful
           cout << "Student not found in Records" << endl;
          } else { // If successful, the foundRecord is updated and is printed out
            cout << "Student found in records (" << collisions << " collisions during search)" << endl;
            cout << foundRecord << endl; 
          }
        } else if(input == "P"){ // calls print function of the database
            cout << studentList << endl;
        }else if(input == "Q"){ // ends program
            cout << "Finally, It's Over" << endl;
            break;
        }
    }
    return 0;
};