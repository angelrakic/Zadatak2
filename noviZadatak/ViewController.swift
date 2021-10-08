//
//  ViewController.swift
//  noviZadatak
//
//  Created by Andjela Rakic on 9/30/21.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var stores = [Stats]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        downloadJSON() {
        self.tableView.reloadData()
        }
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stores.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.textLabel?.text = stores[indexPath.row].name.capitalized
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showDetails", sender: self)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? ViewControllerClass {
            destination.store = stores[(tableView.indexPathForSelectedRow?.row)!]
        }
    }
    
    func downloadJSON(completed: @escaping () -> ()) {
        
        let url = URL(string: "http://sandbox.bottlerocketapps.com/BR_Android_CodingExam_2015_Server/stores.json")
       
        URLSession.shared.dataTask(with: url!) {
            
            (data, response, error) in
            if error == nil {
                do {
                    let storeData = try JSONDecoder().decode(Stores.self, from: data!)
                    self.stores = storeData.stores
                    
                    DispatchQueue.main.async {
                        completed()
                    }
                    
                } catch let error {
                    print("JSON Error: \(error.localizedDescription)")
                }
            }
        }.resume()
    }
}

