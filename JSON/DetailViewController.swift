//
//  ViewController.swift
//  JSON
//
//  Created by Fisher Coburn on 11/2/20.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet var mediaImage: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var yearLabel: UILabel!
    @IBOutlet var episodeLabel: UILabel!
    @IBOutlet var formatLabel: UILabel!
    @IBOutlet var studioLabel: UILabel!
    @IBOutlet var seasonsLabel: UILabel!
    @IBOutlet var summaryLabel: UITextView!
    @IBOutlet var descriptionTextView: UILabel!
    @IBOutlet var genresLabel: UILabel!
    
    @IBOutlet weak var storyDescriptionTextView: UITextView!
    
    var detailItem: Shows? {
        didSet {
            configureView()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    let nav = self.navigationController?.navigationBar
    
    nav?.barStyle = UIBarStyle.black
    nav?.tintColor = UIColor.init(red: 245/255, green: 196/255, blue: 72/255, alpha: 1)
        // Do any additional setup after loading the view.
        title = detailItem?.name
        
        configureView()
    }
    
    func configureView() {
        if let entry = detailItem {
            //For title
            if let label = titleLabel{
                label.text = entry.name
            }
            //For year
            if let label = yearLabel {
                if let ended = entry.yearEnd {
                    label.text = "\(entry.yearStart) - \(ended)"
                } else {
                    label.text = entry.yearStart
                }
            }
            //For seasons
            if let label = seasonsLabel {
                label.text = "\(entry.seasons) Seasons"
            }
            //For episodes
            if let label = episodeLabel {
                label.text = "\(entry.episodes ?? 0) Episodes"
            }
            //For genres
            if let label = genresLabel {
                label.text = entry.genres
            }
            //For description
            if let label = descriptionTextView {
                label.text = entry.description
            }
            //For story line
            if let textView = storyDescriptionTextView {
                textView.text = entry.longDesc
            }
            //For image
            if let imageView = mediaImage {
                let url = URL(string: entry.imageURL)
                let data = try? Data(contentsOf: url!)
                imageView.image = UIImage(data: data!)
            }
        }
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.

        if segue.identifier == "showCastList" {
            let controller = segue.destination as! CastTableViewController
            if let castArrayList = detailItem?.castSummary {
                controller.castListArray = castArrayList
            }
        }
    }

    }



