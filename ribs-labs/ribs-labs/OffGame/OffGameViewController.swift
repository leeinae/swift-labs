//
//  OffGameViewController.swift
//  ribs-labs
//
//  Created by inae Lee on 2023/06/08.
//

import RIBs
import RxCocoa
import RxSwift
import SnapKit
import UIKit

protocol OffGamePresentableListener: AnyObject {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
    func start(_ game: Game)
}

final class OffGameViewController: UIViewController, OffGamePresentable, OffGameViewControllable {
    var uiviewController: UIViewController {
        self
    }

    weak var listener: OffGamePresentableListener?
    private let games: [Game]

    private let disposeBag = DisposeBag()

    init(games: [Game]) {
        self.games = games
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("Method is not supported")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.yellow
        buildStartButtons()
    }

    func show(scoreBoardView: ViewControllable) {
        addChild(scoreBoardView.uiviewController)
        view.addSubview(scoreBoardView.uiviewController.view)
        scoreBoardView.uiviewController.view.snp.makeConstraints { (maker: ConstraintMaker) in
            maker.top.equalTo(self.view).offset(70)
            maker.leading.trailing.equalTo(self.view).inset(20)
            maker.height.equalTo(120)
        }
    }

    // MARK: - OffGamePresentable

//    func set(score: Score) {
//        self.score = score
//    }

    // MARK: - Private

    private func buildStartButtons() {
        var previousButton: UIView?
        for game in games {
            previousButton = buildStartButton(with: game, previousButton: previousButton)
        }
    }

    private func buildStartButton(with game: Game, previousButton: UIView?) -> UIButton {
        let startButton = UIButton()
        view.addSubview(startButton)
        startButton.accessibilityIdentifier = game.name
        startButton.snp.makeConstraints { (maker: ConstraintMaker) in
            if let previousButton = previousButton {
                maker.bottom.equalTo(previousButton.snp.top).offset(-20)
            } else {
                maker.bottom.equalTo(self.view.snp.bottom).inset(30)
            }
            maker.leading.trailing.equalTo(self.view).inset(40)
            maker.height.equalTo(50)
        }
        startButton.setTitle(game.name, for: .normal)
        startButton.setTitleColor(UIColor.white, for: .normal)
        startButton.backgroundColor = UIColor.black
        startButton.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.listener?.start(game)
            })
            .disposed(by: disposeBag)

        return startButton
    }
}
