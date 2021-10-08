//
//  ViewControllerClass.swift
//  noviZadatak
//
//  Created by Andjela Rakic on 9/30/21.
//

import UIKit

extension UIImageView {
    func downloaded(from url: URL, contentMode mode: ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    func downloaded(from link: String, contentMode mode: ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}

class ViewControllerClass: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var storeNameLabel: UILabel!
    @IBOutlet weak var cityNameLabel: UILabel!
    
    var store:Stats?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        storeNameLabel.text = store?.name
        cityNameLabel.text = store?.city
        
        if let stringUrl = store?.storeLogoURL,  let url = URL(string: stringUrl) {
            
            imageView.downloaded(from: url)
        }

        
    }

}
