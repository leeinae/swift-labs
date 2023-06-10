//
//  TicTacToeViewController.swift
//  ribs-labs
//
//  Created by inae Lee on 2023/06/10.
//

import RIBs
import RxSwift
import UIKit
import SnapKit

protocol TicTacToePresentableListener: AnyObject {
    func placeCurrentPlayerMark(atRow row: Int, col: Int)
    func closeGame()
}

final class TicTacToeViewController: UIViewController, TicTacToePresentable, TicTacToeViewControllable {
    weak var listener: TicTacToePresentableListener?

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("Method is not supported")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.yellow
        buildCollectionView()
    }

    // MARK: - TicTacToePresentable

    func setCell(atRow row: Int, col: Int, withPlayerType playerType: PlayerType) {
        let indexPathRow = row * GameConstants.colCount + col
        let color: UIColor = {
            switch playerType {
            case .red:
                return UIColor.red
            case .blue:
                return UIColor.blue
            }
        }()
        let cell = collectionView.cellForItem(at: IndexPath(row: indexPathRow, section: Constants.sectionCount - 1))
        cell?.backgroundColor = color
    }

    func announce(winner: PlayerType) {
        let winnerString: String = {
            switch winner {
            case .red:
                return "Red"
            case .blue:
                return "Blue"
            }
        }()
        let alert = UIAlertController(title: "\(winnerString) Won!", message: nil, preferredStyle: .alert)
        let closeAction = UIAlertAction(title: "Close Game", style: .default) { [weak self] _ in
            self?.listener?.closeGame()
        }
        alert.addAction(closeAction)
        present(alert, animated: true, completion: nil)
    }

    // MARK: - Private

    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.itemSize = CGSize(width: Constants.cellSize, height: Constants.cellSize)
        return UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
    }()

    private func buildCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: Constants.cellIdentifier)
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { (maker: ConstraintMaker) in
            maker.center.equalTo(self.view.snp.center)
            maker.size.equalTo(CGSize(width: CGFloat(GameConstants.colCount) * Constants.cellSize, height: CGFloat(GameConstants.rowCount) * Constants.cellSize))
        }
    }
}

private enum Constants {
    static let sectionCount = 1
    static let cellSize: CGFloat = UIScreen.main.bounds.width / CGFloat(GameConstants.colCount)
    static let cellIdentifier = "TicTacToeCell"
    static let defaultColor = UIColor.white
}

extension TicTacToeViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        Constants.sectionCount
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        GameConstants.rowCount * GameConstants.colCount
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let reusedCell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.cellIdentifier, for: indexPath)
        reset(cell: reusedCell)
        return reusedCell
    }

    private func reset(cell: UICollectionViewCell) {
        cell.backgroundColor = Constants.defaultColor
        cell.contentView.layer.borderWidth = 2
        cell.contentView.layer.borderColor = UIColor.lightGray.cgColor
    }
}

// MARK: - UICollectionViewDelegate

extension TicTacToeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let row = indexPath.row / GameConstants.colCount
        let col = indexPath.row - row * GameConstants.rowCount
        listener?.placeCurrentPlayerMark(atRow: row, col: col)
    }
}
