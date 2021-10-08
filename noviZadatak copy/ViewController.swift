//
//  ViewController.swift
//  noviZadatak
//
//  Created by Andjela Rakic on 9/30/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var stores = [Stats]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func downloadJSON() {
        print("Successful")
        
    }

    func downloadJSON(completed: @escaping () -> ()) {
        
        let url = URL(string: "http://sandbox.bottlerocketapps.com/BR_Android_CodingExam_2015_Server/stores.json")
        
        URLSession.shared.dataTask(with: url!) {
            
            (data, response, error) in
            if error == nil {
                do {
                    self.stores = try JSONDecoder().decode([Stats].self, from: data!)
                    
                    DispatchQueue.main.async {
                        completed()
                    }
                    
                } catch {
                    print("JSON Error")
                }
            }
        }.resume()
    }
}

