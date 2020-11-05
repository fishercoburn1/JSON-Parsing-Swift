//
//  IRDBTableViewController.swift
//  JSON
//
//  Created by Fisher Coburn on 11/2/20.
//

import UIKit

class IRDBTableViewController: UITableViewController {

    var outerArray = ["First Section Name", "Second Section Name"]
    var innerArray1 = ["first thing", "second thing", "third thing"]
    var innerArray2 = ["first thing", "second thing", "third thing", "FOURTH THING" ]
    
    var mediaModel: MediaDataModel? {
        didSet {
            tableView.reloadData()
        }
    }
    
    var dataController = DataController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "The real housewives"
            
        let nav = self.navigationController?.navigationBar
        
        nav?.barStyle = UIBarStyle.black
        nav?.tintColor = UIColor.init(red: 245/255, green: 196/255, blue: 72/255, alpha: 1)
        
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 44))
        imageView.contentMode = .scaleAspectFit
        
        let image = UIImage(named: "irdblogo")
        imageView.image = image
        
        navigationItem.titleView = imageView
        
        dataController.getJSONData(completion: {dataModel in
            self.mediaModel = dataModel
        })
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return mediaModel?.TVShows.count ?? 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return mediaModel?.TVShows[section].show.count ?? 0
    }


    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return mediaModel?.TVShows[section].location
    }
   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mediaCell", for: indexPath)

        
        // Configure the cell...
        cell.textLabel?.text = mediaModel?.TVShows[indexPath.section].show[indexPath.row].name
        cell.detailTextLabel?.text = mediaModel?.TVShows[indexPath.section].show[indexPath.row].rate
        return cell
    }
   
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "showMediaDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let selectedObject = mediaModel!.TVShows[indexPath.section].show[indexPath.row]
                let controller = segue.destination as! DetailViewController
                controller.detailItem = selectedObject
                
            }
        }
    }
}
