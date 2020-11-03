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
    @IBOutlet var summaryLabel: UITextView!
    @IBOutlet var descriptionTextView: UILabel!
    
    
    var detailItem: Entry? {
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
            
            if let thisMediaImage = mediaImage {
                //Add the image
                
                let url = URL(string: entry.imageURL)
                let data = try? Data(contentsOf: url!)
                
                thisMediaImage.image = UIImage(data: data!)
            }
            
            if let thisTitleLabel = titleLabel {
                thisTitleLabel.text = entry.name
            }
            if let thisYearLabel = yearLabel {
                //Format the year here
                thisYearLabel.text = entry.yearStart
            }
            if let thisFormatLabel = formatLabel {
                thisFormatLabel.text = entry.format
            }
            if let thisEpisodeLabel = episodeLabel {
                thisEpisodeLabel.text = " "
                if let episodeCount = entry.episodes {
                if(entry.episodes == 1) {
                    thisEpisodeLabel.text = "\(episodeCount) Episode"
                }
                else {
                    thisEpisodeLabel.text = "\(episodeCount) Episodes"
                }
                }
            }
            if let thisStudioLabel = studioLabel {
                thisStudioLabel.text = entry.studio
            }
            
            if let thisDescriptionTextView = descriptionTextView {
                thisDescriptionTextView.text = entry.description
            }
            if let thisSummaryLabel = summaryLabel {
                thisSummaryLabel.text = entry.summary
            }
            
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "showCastList" {
                
            let controller = segue.destination as! CastTableViewController
            controller.castListArray = detailItem?.starring
                
                
            }
        }
    }



