//
//  Trie.swift
//  Backbase-Assignment
//
//  Created by Manav on 31/03/19.
//  Copyright © 2019 singhmanav. All rights reserved.
//


/*
 Trie is an efficient information retrieval data structure. Every node of Trie consists of multiple branches. Each branch represents a possible character of String. Searching a prefix from Trie is simple approach.  We compare the characters and move down, the search can terminate due to end of string or lack of prefix in trie.Using Trie, we can search the prefix in O(N) time. However the penalty is on Trie storage requirements.
 
 */
import Foundation

class TrieNode<T: Hashable, U> {
    weak var parentNode: TrieNode?
    
    var value: T?
    var data: [U]?
    var children: [T: TrieNode] = [:]
    var isTerminating = false
    
    init(value: T? = nil, parentNode: TrieNode? = nil) {
        self.value = value
        self.parentNode = parentNode
    }
    
    func add(value: T) {
        guard children[value] == nil else {
            return
        }
        children[value] = TrieNode(value: value, parentNode: self)
    }
}

class Trie<T> {
    typealias Node = TrieNode<Character, T>
    
    fileprivate let root: Node
    fileprivate var wordCount: Int
    
    init() {
        root = Node()
        wordCount = 0
    }
    
    public var words: [T] {
        return wordsInSubtrie(rootNode: root, partialWord: "")
    }
}

extension Trie {
    func insert(word: String, data: T) {
        guard !word.isEmpty else { return }
        
        var currentNode = root
        for character in word.lowercased() {
            if let childNode = currentNode.children[character] {
                currentNode = childNode
            } else {
                currentNode.add(value: character)
                currentNode = currentNode.children[character]!
            }
        }
        
        wordCount += 1
        currentNode.isTerminating = true
        if currentNode.data == nil{
            currentNode.data = [data]
        }else{
            currentNode.data?.append(data)
        }
        
    }
    
    private func findLastNodeOf(word: String) -> Node? {
        var currentNode = root
        for character in word.lowercased() {
            guard let childNode = currentNode.children[character] else {
                return nil
            }
            currentNode = childNode
        }
        return currentNode
    }
    
    fileprivate func wordsInSubtrie(rootNode: Node, partialWord: String) -> [T] {
        var subtrieWords = [T]()
        var previousLetters = partialWord
        
        if let value = rootNode.value {
            previousLetters.append(value)
        }
        
        if rootNode.isTerminating {
            if let data = rootNode.data {
                subtrieWords.append(contentsOf: data)
            }
        }
        
        for childNode in rootNode.children.values {
            let childWords = wordsInSubtrie(rootNode: childNode, partialWord: previousLetters)
            subtrieWords += childWords
        }
        
        return subtrieWords
    }
    
    func findWordsWithPrefix(prefix: String) -> [T] {
        var words = [T]()
        let prefixLowerCased = prefix.lowercased()
        if let lastNode = findLastNodeOf(word: prefixLowerCased) {
            if lastNode.isTerminating {
                if let data = lastNode.data {
                    words.append(contentsOf: data)
                }
            }
            
            for childNode in lastNode.children.values {
                let childWords = wordsInSubtrie(rootNode: childNode, partialWord: prefixLowerCased)
                words += childWords
            }
        }
        return words
    }
}
