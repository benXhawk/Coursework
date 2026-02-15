/* Ben Hawk
    This file outlines the main functions of the trie class, enabling it to insert
    Words and split their characters into individual nodes. The class can be used to search for 
    Any words that might start with a given prefix, and tries can be copied into each other.

*/

#include <iostream>
#include "trie.h"

using namespace std;


trie::trie(){
    root = new node();
    wordCount = 0;
    nodes = 0;
}

// Initializes a new trie, and calls the traversal function to 
// copy the nodes and variables of the passed trie.

trie::trie(const trie& t){
    wordCount = 0;
    nodes = 0;
    root = new node();
    node * current = t.root;
    traversal(current, root);
    wordCount = t.wordCount;
    nodes = t.nodes;
}


trie& trie::operator=(const trie& t){
    // deletes the trie's current values
    wordCount = 0;
    nodes = 0;
    delete root;

    // creates a new root
    root = new node();
    node * current = t.root; // uses a pointer to the other trie's root
    traversal(current, root); // sets the new root's children equal to the other trie's 
    // updates the trie's variables to match the other trie's 
    this->wordCount = t.wordCount; 
    this->nodes = t.nodes;
    return *this;
}

/*Uses the copiedNode to get the values of the trie that is being copied, and the copyingNode is passed as 
  A reference in order to copy the nodes and variables from the copiedNode. Iterates over the copiedNode 
  and adds the children nodes to the copyingNode's trie 
*/

void trie::traversal(node* copiedNode, node*& copyingNode){
    
    copyingNode = new node();
    copyingNode->isEnd = copiedNode->isEnd;
    copyingNode->value = copiedNode->value;

    for(int i = 0; i < 26; i++){
        if(copiedNode->children[i] != nullptr){  
            traversal(copiedNode->children[i], copyingNode->children[i]);
        }
    }
}

trie::~trie(){
    wordCount = 0;
    nodes = 0;
    delete root;
}

/* 
    This function first calls the find function with the passed string as its parameter
    And ends immediately if the word is already within the trie. For each character within the 
    passed word, the if statement checks if the current node has a child node at the same index as 
    the character's alphabet value. If it doesn't, a new node is created for that position and its value
    is Initialized with the current character, then the trie's total nodes value is updated.
    Once the children are iterated over, it checks if the current node is the last one, if it 
    isn't then the isEnd value is set to true, and the total number of words in the trie is updated.
    If it is the last node, then the function returns false.
*/

bool trie::insert(string word){
    if(find(word) == true){
        return false;
    }
    node * current = root;
    for(char c: word){
        if(current->children[(c- 'a')] == nullptr){
            current->children[(c -'a')] = new node(c);
            nodes++;
            
        }
        current = current->children[(c -'a')];        
    }

        if(current->isEnd == false){
            current->isEnd = true;
            wordCount++;
            return true;
        } else {
            return false;
        }
}


/* This function by default returns false, and iterates over the trie by using the 
   Alphabet value of each letter to index the children. If the child node at this index
   is null, then returns false. Once all nodes have been iterated over, it checks to see if
   The current node is the last node, and sets returns true if it is, or false if not.
*/

bool trie::find(string word){
    node* current = root;  
    bool found = false;
    for(char c: word){
        if(current->children[c- 'a'] == nullptr){
            return found;
        }
        current = current->children[c - 'a'];
    }
    if(current->isEnd == true){
        found = true;
    } else {
        found = false;
    }
    return found;
}

/* Creates a string vector sets it equal to the vector returned by the complete function
   Using the same string parameter, then returns the size of the vector
*/

int trie::completeCount(string word){
    vector<string> wordList = complete(word);
    int size = (int)(wordList.size());
    return size;
}


// returns the number of words within the trie
// by returning the trie's wordcount variable
int trie::count(){
    return wordCount;
}

// returns the total number of nodes in the trie
int trie::getSize(){
    return nodes;
}

/* This function creates an empty vector of strings, and 
   Iterates over the trie, if there is no node at the character's alphabet 
   Index, then the vector is not added to and the function ends
   Otherwise, the vector is updated to be the return value of the recursive function
*/

vector<string> trie::complete(string word){
    
    vector<string> list;
    node * current = root;
    for(char c: word){
        current = current->children[c -'a'];
        if(current == nullptr){
            return list;
        }
    }
    list = complete(current, word, list);
    return list;
}

/* This function checks if the current node exists, returns the vector if it doesn't. 
   Otherwise, it checks if the current node is the last one. If it is, then the vector is searched for 
   That word, and the word is added to the vector if it is not already in there. Then, the for loop iterates over
   the children nodes and calls itself recursively if the current node has a value, updating the prefix with the current
   node's character value and using the node's children as a parameter
*/

vector<string> trie::complete(node* current, string word, vector<string> list){

    if(current == nullptr){
        return list;
    }

    if(current->isEnd == true){
        bool finder = false;
        for(string s: list){
            if(s == word){
                finder = true;
                break;
            } else {
                finder = false;
            }
        }
        if(finder == false){
            list.push_back(word);
        }
        
    }     

    for(int i =  0; i < 26; i++){
        if(current->children[i] != nullptr){
            list = complete(current->children[i], word+current->children[i]->value, list);
        }
        
    }
    return list;
}

