//
//  ViewController.swift
//  kingfisher-labs
//
//  Created by inae Lee on 2021/09/19.
//

import Kingfisher
import SnapKit
import UIKit

class ViewController: UIViewController {
    let imageView: UIImageView = {
        let img = UIImageView()
        img.bounds.size = CGSize(width: 200, height: 200)

        return img
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setConstraints()
        setImage()
    }

    func setConstraints() {
        view.addSubview(imageView)

        imageView.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }

    func setImage() {
        print(imageView.bounds.size)
        let url = URL(string: "http://ucc.ssgcdn.com/uphoto/202105/20210513004138_1132896529_1.jpeg")
        let processor = DownsamplingImageProcessor(size: imageView.bounds.size)
            |> RoundCornerImageProcessor(cornerRadius: 20)

        imageView.kf.indicatorType = .activity
        imageView.kf.setImage(
            with: url,
            placeholder: UIImage(named: "placeholder 🥳"),
            options: [
                .processor(processor),
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(1)),
                .cacheOriginalImage
            ]) {
                result in
                switch result {
                case .success(let value):
                    print("Task done for: \(value.source.url?.absoluteString ?? "")")
                case .failure(let error):
                    print("Job failed: \(error.localizedDescription)")
                }
        }
    }
}
