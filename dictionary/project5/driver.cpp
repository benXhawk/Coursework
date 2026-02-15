/* Ben Hawk
   The purpose of this file is to read from a dictionary file and add all of the words
   Into a single alphabet trie. Once this is done, the user will have the ability to look up 
   any words within the trie by typing the prefix that those words start with. 
*/

#include "trie.h"
#include <fstream>
#include <iostream>
#include <limits>

using namespace std;

/* this function takes a vector of strings and then prints out each string in the 
    vector*/

   void printMatches(vector<string> printedVec){
    cout << "Combinations:" << endl;
    cout << "--------------" << endl;
    for(string s: printedVec){
        cout << s << endl;
    }
};

/* This function checks to see that the user's input is a letter by getting the ASCII Value
   And checking if it falls within the range of all the letters
   It returns false if it does not fall within range
   */

bool correctInput(string input){
    for(char c: input){
        int tester = static_cast<int>(c);
        if(!((tester >= 65 && tester <= 132)&& (tester >= 97 && tester <= 122))){
            return false;
        }
    }
    return true;
}

int main(){

    ifstream dictionary ; // initializing the wordlist file as a variable
    dictionary.open("wordlist_windows.txt");
    trie dictionaryTrie;  // creating an empty trie to store the words

    // Iterates over each line in the dictionary file and adds the word to
    // the trie, then closes the variable.
    if(dictionary.is_open()){
        string addedWord;
        while(dictionary.good()){
            dictionary >> addedWord;
            dictionaryTrie.insert(addedWord);
        }
    }
    dictionary.close();

    

    int length;  // declares an integer to use for checking the length of the user input

    while(true){
        string input; // string to store the user input in for comparison 
        vector<string> matchingWords; // initialzing a vector to store any words matching a prefix
        int matchingWordCount; // integer to store the lenegth of the vector

        /* while loop asks the user to type something in and checks to see if the input is valid
           repeats constantly until input is valid or they press the enter key
        */
        while(true){
            cout << "Please enter a prefix. (Press enter to exit)" << endl;
            cin >> input;
            char test = input[0];
            if (test == '\n'){
                cout << "Exiting program." << endl;
                return 0;
            }else if(correctInput(input) == false){
                continue;
            } else {
                break;
            }
        }
        
        // converts all of the characters in the input to lowercase for more 
        // consistent comparisons
        length = (int)(input.size());
        for(int i; i < length; i++){
            input[i] = (char)(tolower(input[i]));
        }
        matchingWords = dictionaryTrie.complete(input); // adds the matching words to the vector
        matchingWordCount = dictionaryTrie.completeCount(input); // updates the size to the new vector contents
    

        // prints out if no words match and restarts the loop
        if(matchingWordCount == 0){
            cout << "No words found." << endl;
            continue;
        } 
        /* Prints out how many words match the prefix and asks the user whether or not to
           Display them. Converts input to lowercase and then checks if input equals yes,
           Then calls the print function and restarts the loop.
        */
        cout << "There are " << matchingWordCount << " words starting with the prefix '" << input 
        << "'. Do you want to see them?" << endl;
        cin >> input; 
        length = (int)(input.size());
        for(int i; i < length; i++){
        input[i] = (char)(tolower(input[i]));
        }
        if(input == "yes"){
        printMatches(matchingWords);
        }   
       
        
    } 

    
    return 0;
};




