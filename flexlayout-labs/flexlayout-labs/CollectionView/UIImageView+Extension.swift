//
//  UIImageView+Extension.swift
//  flexlayout-labs
//
//  Created by Inae Lee on 2023/06/28.
//

import UIKit

extension UIImageView {
    func download(url: URL) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
            else { return }

            DispatchQueue.main.async {
                self.image = image
            }
        }.resume()
    }
}
