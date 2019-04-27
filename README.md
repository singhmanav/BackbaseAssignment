# Mobile assignment RnD

Pattern Searching for prefix can be done using Trie as it is also known as Prefix tree. Trie is an efficient information retrieval data structure. Every node of Trie consists of multiple branches. Each branch represents a possible character of String. 

Searching a prefix from Trie is a simple approach. We compare the characters and move down, the search can terminate due to the end of the string or lack of prefix in the trie. Using Trie, we can search the prefix in O(N) time. However, the penalty is on Trie storage requirements.

Every terminating node of trie stores corresponding city data which is again array as we have multiple cities with the same name. 

## Requirements

* [Xcode 10.1](https://developer.apple.com/xcode/)
* [Swift 4.2](https://github.com/apple/swift).

## How to build
The project can be run using Xcode 10.2 and built/tested using the standard Xcode build (⌘B) and test (⌘U) commands.

## Disclaimer :
The icons are taken from [Backbase](https://backbase.com/).
