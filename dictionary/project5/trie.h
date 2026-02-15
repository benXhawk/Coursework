/* Ben Hawk
   This file consists of the methods used in the trie.cpp file, as well as the declaration 
   the trie's inner trie node class. Each trie node acts as its own subtrie, as it has an array of 27
   child trie nodes that can be iterated over. 
*/


#include <iostream>
#include <vector>

using namespace std;

class trie{

    private: 
    // class used to contain a given character as well as any other character's below it
    // The isEnd boolean is used to signify the end node of a given word. 
    class node {
        public:
        char value;
        int charCount;
        node *children[27];
        bool isEnd;

        // Constructor initializing all of the children nodes to null and setting 
        // the is end boolean to false and charcount to 0

        node(){
            for(int i = 0; i < 26; i++){
                children[i] = nullptr;
            }
            isEnd = false;
            charCount = 0;
        }

        // Parameterized constructor to intialize the trie's value to the 
        // passed character
        node(char c){
            for(int i = 0; i < 26; i++){
                children[i] = nullptr;
            }
            isEnd = false;
            charCount = 0;
            value = c;
        }

        ~node(){
            isEnd = false;
            for(int i = 0; i < 26; i++){
                if(children[i] != nullptr){
                    delete children[i];
                }
            }
            charCount = 0;
        }

    };

    public: 
    int wordCount;
    int nodes;
    node * root;


    bool insert(string); // inserts a word if the trie doesn't already have it

    vector<string> complete(string); // returns a vector of strings containing the passed string
    vector<string> complete(node*, string, vector<string>); // recursive function to update vector's values

    
    int count(); // returns the number of words within the trie
    int getSize(); // returns the number of nodes within the trie
    
    bool find(string); // returns true if the trie has the string, false if not
    int completeCount(string); // returns the number of words matching the given prefix

    trie(); // constructor
    trie(const trie&); // copy constructor

    ~trie(); // destructor

    trie& operator=(const trie& t); // deletes current trie root and updates it to passed trie
    void  traversal(node *, node*&); // recursive function for copy constructor and operator= function
};