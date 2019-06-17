//
//  heroTableViewController.swift
//  DOTA api
//
//  Created by RMS2018 on 22/03/2019.
//  Copyright © 2019 RMS2018. All rights reserved.
//

import UIKit

class heroTableViewController: UITableViewController, UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {

        filteredTableData.removeAll(keepingCapacity: false)
        filteredTableData = heroes.filter{
            $0.name.range(of: searchController.searchBar.text!, options: .caseInsensitive) != nil
        }

        self.tableView.reloadData()
    }

    
    
    
    //MARK: Properties
    var heroes = [Hero]()
    var index = 0
    var filteredTableData = [Hero]()
    var resultSearchController = UISearchController()


    override func viewDidLoad() {
        super.viewDidLoad()
                
        loadData()
        resultSearchController = ({
            let controller = UISearchController(searchResultsController: nil)
            controller.searchResultsUpdater = self
            controller.dimsBackgroundDuringPresentation = false
            controller.searchBar.sizeToFit()

            tableView.tableHeaderView = controller.searchBar

            return controller
        })()

        // Reload the table
        tableView.reloadData()
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {

        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if  (resultSearchController.isActive) {
            return filteredTableData.count
        } else {
            return heroes.count
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "testTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? testTableViewCell else {
            fatalError("The dequeued cell is not an instance of testTableViewCell.")
        }
        var hero : Hero
        
        if (resultSearchController.isActive) {
            hero = filteredTableData[indexPath.row]
        }
        else {
            hero = heroes[indexPath.row]
        }
        
        cell.heroName.text = hero.name
        cell.heroImg.image = hero.img
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.index = indexPath.row
        performSegue(withIdentifier: "heroSeg", sender: self)
        self.resultSearchController.isActive = false
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? testViewController{
            if (resultSearchController.isActive) {
                vc.hero = filteredTableData[index]
            }
            else {
                vc.hero = heroes[index]
            }
        }
    }
    
    private func loadData(){
        var heroArray = Dictionary<String,NSDictionary>()
        let textLoad = BlockOperation {
            let url = URL(string: "https://api.opendota.com/api/heroStats")!
            let task = URLSession.shared.dataTask(with: url){ (data, response, error) in
                if error == nil {
                    do{
                        if let jsonArray = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [NSDictionary]
                        {
                            for i in jsonArray{
                                heroArray.updateValue(i, forKey: i["localized_name"] as! String)
                            }
                        }else{
                            print("Coś nie pykło")
                        }
                    }catch let error as NSError{
                        print(error)
                    }
                }
            }
            task.resume()
        }
        let imgLoad = BlockOperation {
            sleep(1)
            let group = DispatchGroup()
            for i in heroArray{
                group.enter()
                let url = URL(string: "https://api.opendota.com" + (i.value["img"] as! String))!
                let task = URLSession.shared.dataTask(with: url){ (data, response, error) in
                    if error == nil {
                        let uimage = UIImage(data: data!)
                        self.heroes.append(Hero(name: i.key,img: uimage,data: i.value)!)
                    }
                    group.leave()
                }
                task.resume()
            }
            group.wait()
        }
        let reload = BlockOperation {
//            sleep(1)
            self.tableView.reloadData()
        }
        imgLoad.addDependency(textLoad)
        reload.addDependency(imgLoad)
        let radQueue = OperationQueue()
        radQueue.addOperation(textLoad)
        radQueue.addOperation(imgLoad)
        radQueue.addOperation(reload)
    }

}
