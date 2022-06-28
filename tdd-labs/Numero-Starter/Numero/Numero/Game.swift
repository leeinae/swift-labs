/// Copyright (c) 2018 Razeware LLC
///
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
///
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
///
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import Foundation

class Game {
  let maxAttemptsAllowed = 10
  let maxNumberToGenerate = 4000
  
  var score: Int
  var attempt: Int
  var numbersToConvert: [Int]
  var answersToDisplay: [String]
  var isCorrectConversion: [Bool]
  
  var converter: Converter
  
  init() {
    score = 0
    attempt = 0
    numbersToConvert = []
    answersToDisplay = []
    isCorrectConversion = []
    converter = Converter()
    generatePlays()
  }
  
  func play(_ guess: Bool) -> (correct: Bool, score: Int)? {
    if done() {
      return nil
    }
    if isCorrectConversion[attempt] == guess {
      score = score + 1
      attempt = attempt + 1
      return (true, score)
    } else {
      attempt = attempt + 1
      return (false, score)
    }
  }
  
  func showNextPlay() -> (question: Int, answer: String) {
    return (numbersToConvert[attempt], answersToDisplay[attempt])
  }
  
  func done() -> Bool {
    return attempt >= maxAttemptsAllowed
  }
  
  func reset() {
    score = 0
    attempt = 0
    
    numbersToConvert.removeAll()
    answersToDisplay.removeAll()
    isCorrectConversion.removeAll()
    
    generatePlays()
  }
}

// MARK: - Private methods
private extension Game {
  func generatePlays() {
    numbersToConvert = (1...maxAttemptsAllowed).map{_ in
      Int(arc4random_uniform(UInt32(maxNumberToGenerate))) + 1
    }
    answersToDisplay = numbersToConvert.enumerated().map{ (index, numberToConvert) in
      generateAnswers(index, number: numberToConvert)
    }
  }
  
  func showWrongConversion() -> Bool {
    return arc4random_uniform(2) == 0
  }
  
  func generateAnswers(_ index: Int, number: Int) -> String {
    // TODO: (Final project) Uncomment line below and comment out following line
    // to use the converter
    //    let correctAnswer = converter.convert(number)
    // TODO: (Starter project) Uncomment line below and comment out the previous
    // line
    let correctAnswer = "ABCD"
    if showWrongConversion() {
      isCorrectConversion.append(false)
      return correctAnswer.garbled()
    } else {
      isCorrectConversion.append(true)
      return correctAnswer
    }
  }
}
