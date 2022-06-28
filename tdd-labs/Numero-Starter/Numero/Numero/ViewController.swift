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

import UIKit

class ViewController: UIViewController {

  @IBOutlet weak var scoreLabel: UILabel!
  @IBOutlet weak var converterLabel: UILabel!
  @IBOutlet weak var numberLabel: UILabel!
  @IBOutlet weak var romanNumeralLabel: UILabel!
  
  @IBOutlet weak var falseButton: UIButton!
  @IBOutlet weak var trueButton: UIButton!
  
  var game: Game?
  var score: Int? {
    didSet {
      if let score = score, let game = game {
        scoreLabel.text = "\(score) / \(game.maxAttemptsAllowed)"
      }
    }
  }
  var originalIndicatorColor: UIColor?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    game = Game()
    originalIndicatorColor = converterLabel.textColor
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    game?.reset()
    score = game?.score
    numberLabel.center.x -= view.bounds.width
    romanNumeralLabel.center.x += view.bounds.width
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    showNextPlay()
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "gameDoneSegue" {
      if let destinationViewController = segue.destination as? GameDoneViewController {
        destinationViewController.score = score
      }
    }
  }
  
  @IBAction func choiceButtonPressed(_ sender: UIButton) {
    if sender == falseButton {
      play(false)
    } else if sender == trueButton {
      play(true)
    }
  }
  
}

// MARK: - Private methods
private extension ViewController {
  func showNextPlay() {
    guard let game = game else { return }
    if !game.done() {
      let (question, answer) = game.showNextPlay()
      numberLabel.text = "\(question)"
      romanNumeralLabel.text = answer
      converterLabel.textColor = originalIndicatorColor
      controlsEnabled(true)
      // Show info
      UIView.animate(withDuration: 0.5) {
        self.numberLabel.center.x += self.view.bounds.width
        self.romanNumeralLabel.center.x -= self.view.bounds.width
        self.converterLabel.alpha = 1.0
      }
    }
  }
  
  func controlsEnabled(_ on: Bool) {
    falseButton.isEnabled = on
    trueButton.isEnabled = on
  }
  
  func play(_ selection: Bool) {
    controlsEnabled(false)
    if let result = game?.play(selection) {
      score = result.score
      displayResults(result.correct)
    }
    DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(2000)) {
      if (self.game?.done())! {
        self.performSegue(withIdentifier: "gameDoneSegue", sender: nil)
      } else {
        // Clear info
        UIView.animate(withDuration: 0.5, animations: {
          self.numberLabel.center.x -= self.view.bounds.width
          self.romanNumeralLabel.center.x += self.view.bounds.width
          self.converterLabel.alpha = 0.0
        }, completion: { _ in
          DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(500)) {
            self.showNextPlay()
          }
        })
      }
    }
  }
  
  func displayResults(_ correct: Bool) {
    if correct {
      print("You answered correctly!")
      converterLabel.textColor = .green
    } else {
      print("That one got you.")
      converterLabel.textColor = .red
    }
    // Visual indicator of correctness
    UIView.animate(withDuration: 0.5, animations: {
      self.converterLabel.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
    }, completion: { _ in
      UIView.animate(withDuration: 0.5) {
        self.converterLabel.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
      }
    })
  }
}

