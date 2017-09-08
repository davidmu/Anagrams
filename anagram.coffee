fs = require 'fs'
dictionary = {}
phrase= "poultry outwitsants"
sortedPhraseLetterArray = []
wordarray = []
keys = []
crypto = require 'crypto'
easy = "e4820b45d2277f3844eac66c903e84be"
medium = "23170acc097c24edb98fc5488ab033fe"
hard = "665e5bcb0c20062fe8abaaf4628bb154"
Elapsed = require('ns-elapsed')
e = new Elapsed()
#possiblePhrases = []
i=0
module.exports=->
	setupDictionary ()->
		parsePhrase()
		#keys.sort()
		#console.log keys.length
		#console.log findPossibleKeys ['a', 'n', 't', 's'], keys, true
		#console.log getNewWordList(['a', 'n', 't', 's'], wordarray)
		#console.log "printout".split("").sort().join("")
		#console.log "stout".split("").sort().join("")
		#console.log "yawls".split("").sort().join("")
		#anagrams "", sortedPhraseLetterArray, wordarray
		#anagramsKey "", sortedPhraseLetterArray, keys
		i=0
		anagramsKeyMaxWord 3, "", sortedPhraseLetterArray, keys,null, ()->
			#console.log possiblePhrases
			#i=0
			#anagramsKeyMaxWord 2, "", sortedPhraseLetterArray, keys,null, ()->
				#i=0
				#anagramsKeyMaxWord 3, "", sortedPhraseLetterArray, keys,null, ()->
					#i=0
					#anagramsKeyMaxWord 4, "", sortedPhraseLetterArray, keys,null, ()->
						#console.log "got em"


anagrams = (word, remainingletters, wordlist, phrase)->
	templetters = removeLetters(word, remainingletters)
	newList = getNewWordList(templetters, wordlist)
	#console.log phrase
	i = 0
	if newList.length > 0
		newList.forEach (word)->
			if word.length > 4
				tempphrase = phrase
				if not phrase
					tempphrase = word
				else
					tempphrase += " " +word
				#console.log word
				if tempphrase.split(" ").length<4
					anagrams word, templetters.slice(), newList.slice(), tempphrase
	else
		#console.log phrase
		hash = crypto.createHash('md5').update(phrase).digest("hex")
		if easy is hash
			console.log phrase, "is the one"
			#return phrase
		if medium is hash
			console.log phrase, "is medium"
		if hard is hash
			console.log phrase, "is hard"
i= 0
currentNumber = 0 
anagramsKey = (key, remainingletters, remainingKeys, phrase)->
	templetters = removeLetters(key, remainingletters)
	newList = findPossibleKeys(templetters, remainingKeys)
	#console.log phrase
	if newList.length > 0
		newList.forEach (word)->
			if word.length > 3
				tempphrase = phrase
				if not phrase
					i++
					#number = (100*i/1975).toFixed(0)
					#if currentNumber<number
						#currentNumber = number
						#console.log number + '% done'
					tempphrase = word
				else
					tempphrase += " " +word
				#console.log word
				if tempphrase.split(" ").length<4
					anagramsKey word, templetters.slice(), newList.slice(), tempphrase
	else
		console.log phrase
		tryPhrase(phrase.split(" "))

anagramsKeyMaxWord = (max, key, remainingletters, remainingKeys, phrase, cb)->
	i++
	templetters = removeLetters(key, remainingletters)
	newList = []
	if phrase and phrase.split(" ").length is max-1
		newList = [templetters.join("")]
	else
		newList = findPossibleKeys(templetters, remainingKeys, false)
	#console.log phrase
	if newList.length > 0
		newList.forEach (word)->
			if word.length > 1
				tempphrase = phrase
				if not phrase
					number = (100*i/1975).toFixed(0)
					if currentNumber<number
						currentNumber = number
						#console.log number + '% done'
					tempphrase = word
				else
					tempphrase += " " +word
				#console.log word
				if tempphrase.split(" ").length<max+1
					anagramsKeyMaxWord max, word, templetters.slice(), newList.slice(), tempphrase, cb
	else
		#possiblePhrases.push phrase
		#console.log phrase
		tryPhrase(phrase.split(" "),null,cb)
	i--
	if i is 0
		cb()

tryPhrase = (keyparts, phraseTry,cb)->
	#console.log keyparts
	if keyparts.length>0
		if phraseTry
			if dictionary[keyparts[0]]
				dictionary[keyparts[0]].forEach (word)->
					tempphrase = phraseTry
					tempphrase+= " " + word
					tempArray = keyparts.slice()
					tempArray.splice 0,1
					tryPhrase(tempArray, tempphrase, cb)
		else
			dictionary[keyparts[0]].forEach (word)->
				tempphrase=word
				tempArray = keyparts.slice()
				tempArray.splice 0,1
				tryPhrase(tempArray, tempphrase, cb)
	else
		#console.log phraseTry
		hash = crypto.createHash('md5').update(phraseTry).digest("hex")
		if easy is hash
			console.log phraseTry, "is the one"
			console.log "found in", e.get()
			return phrase
		if medium is hash
			console.log phraseTry, "is medium"
			console.log "found in", e.get()
		if hard is hash
			console.log phraseTry, "is hard"
			console.log "found in", e.get()
		if i is 0
			cb()

removeLetters = (word, array)->
	tempArray = array.slice(0)
	for letter, index in word
		arrayIndex = tempArray.indexOf(letter)
		if arrayIndex>-1
			tempArray.splice arrayIndex,1
	return tempArray

parsePhrase = ()->
	phraseNoWhiteSpace = phrase.replace(/\s+/, "") 
	sortedPhraseLetterArray = phraseNoWhiteSpace.split('').sort()

setupDictionary = (cb)->
	loadWordList (err, wordArray)->
		prevWord = ''
		for word, index in wordArray
			if word isnt prevWord
				processWord(word)
			prevWord = word
		cb()

getNewWordList = (letters, wordList)->
	wordlist = wordList.slice()
	newWordList = []
	for word, intex in wordlist
		templetters = letters.slice()
		#console.log word
		#console.log templetters
		works = true
		if word
			wordLetters = word.split("")
			for letter, index in wordLetters
				#console.log letter
				if templetters.indexOf(letter)<0
					works = false
					break
				else
					#console.log templetters
					templetters.splice templetters.indexOf(letter), 1
		if works
			newWordList.push word
	return newWordList

findPossibleKeys = (remainingletters, remainingKeys, last)->
	possibleKeys = []
	remainingKeys.forEach (key)->
		remLetters = remainingletters.slice()
		work = true
		if last and key.split().length isnt remainingletters.length
			work = false
		else
			for letter, index in key.split("")
				#console.log letter
				if remLetters.indexOf(letter)<0
					work = false
					break
				else
					#console.log remLetters
					remLetters.splice(remLetters.indexOf(letter), 1)
		if work
			possibleKeys.push key
	#console.log possibleKeys
	return possibleKeys			

processWord = (word)->
	letters= word.split('')
	phraseContains = true
	containsvowel = false
	notweird = true
	if letters.length >1 or isVowel(letters[0])
		templetters = phrase.replace(" ", "").split("")
		for letter, index in letters
			if isReallyVowel(letter)
				containsvowel = true
			if letter and phrase.indexOf(letter)<0
				phraseContains = false
			else
				templetters.splice phrase.indexOf(letter), 1
		if phraseContains and containsvowel and notweird
			alphaLetters = word.split("").sort().join("")
			if not dictionary[alphaLetters]
				dictionary[alphaLetters] =[word]
				keys.push alphaLetters
			else
				dictionary[alphaLetters].push(word)
			wordarray.push word

isVowel = (char)->
	vowels = ['a','i']
	return vowels.indexOf(char)>-1

isReallyVowel = (char)->
	vowels = ['a','e','i','o','u','y']
	return vowels.indexOf(char)>-1

loadWordList = (cb)->
	fs.exists './wordlist', (exist)->
		if exist
			fs.readFile './wordlist', "utf8", (err,data)->
				if err
					console.log err
				else
					bibarray = data.split("\n")
					cb null, bibarray
		else
			cb "file doesn't exist", null

