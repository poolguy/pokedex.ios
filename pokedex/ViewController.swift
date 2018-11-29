//
//  ViewController.swift
//  pokedex
//
//  Created by Seth Donaldson on 11/27/18.
//  Copyright © 2018 Seth Donaldson. All rights reserved.
//

import UIKit
import Foundation
// import PokemonKit

class ViewController: UIViewController {
    private var pokemonList = PokemonList()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pokemonList.requestData { [weak self] (data: String) in
            self?.useData(data: data)
        }
        
    }
    
    private func useData(data: String) {
        print(data)
    }
    
    class ViewController: UITableViewController {
        
        override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return pokemonList.count
        }
        
        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "customcell", for: indexPath) as! UITableViewCell
            cell.textLabel?.text = "test"
            return cell
        }
    }
    
}




class PokemonList {
    var name: String?
    var url: String?
    
    func requestData(completion: @escaping ((_ data: String) -> Void)) {
        // Do any additional setup after loading the view, typically from a nib.
        let url = URL(string: "https://pokeapi.co/api/v2/pokemon/")
        let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if let data = data {
                do {
                    // Convert the data to JSON
                    let jsonSerialized = try JSONSerialization.jsonObject(with: data, options: []) as? [String : Any]
                    
                    if let json = jsonSerialized, let count = json["count"], let results = json["results"] {
                        print(count)
                        print(results)
                    }
                }  catch let error as NSError {
                    print(error.localizedDescription)
                }
            } else if let error = error {
                print(error.localizedDescription)
            }
            
            completion(data as! String)
        }
        task.resume()
        
    }
}

