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
        
        let view = UIView(frame: CGRect(x: 50, y: 50, width: 50, height: 50))
        view.backgroundColor = .white
        
        img.addSubview(view)

        return img
    }()

    lazy var btn: UIButton = {
        let btn = UIButton(type: .close, primaryAction: UIAction(handler: { [weak self] _ in
            print(self?.imageView.bounds)
            self?.imageView.bounds = CGRect(x: 10, y: 10, width: (self?.imageView.frame.width)!, height: (self?.imageView.frame.height)!)
            self?.imageView.layoutIfNeeded()
        }))
        
        return btn
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setConstraints()
        setImage()
    }

    func setConstraints() {
        view.addSubview(imageView)
        imageView.frame = CGRect(x: 100, y: 100, width: 200, height: 200)
        
        view.addSubview(btn)
        btn.frame = CGRect(x: 100, y: 500, width: 100, height: 100)

//        imageView.snp.makeConstraints {
//            $0.center.equalToSuperview()
//        }
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
