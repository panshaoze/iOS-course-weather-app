//
//  ViewController.swift
//  Weather Forecast
//
//  Created by Shaoze Pan on 2016-07-09.
//  Copyright © 2016 FriedChicken. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet var cityTextField: UITextField!
    @IBOutlet var resultLabel: UILabel!
    
    @IBAction func findWeather(sender: AnyObject) {
        
        var wasSuccessful = false
        
        let attemptedUrl = NSURL(string: "http://www.weather-forecast.com/locations/" + cityTextField.text!.stringByReplacingOccurrencesOfString(" ", withString: "") + "/forecasts/latest")
        
        if let url = attemptedUrl {
        
        let task = NSURLSession.sharedSession().dataTaskWithURL(url) { (data, response, error) in
            
            if let urlContent = data {
                
                let webContent = NSString(data: urlContent, encoding: NSUTF8StringEncoding)
                
                let websiteArray = webContent!.componentsSeparatedByString("3 Day Weather Forecast Summary:</b><span class=\"read-more-small\"><span class=\"read-more-content\"> <span class=\"phrase\">")
                
                if websiteArray.count > 1 {
                    
                    let websiteArray = websiteArray[1].componentsSeparatedByString("</span>")
                    
                    if websiteArray.count > 1 {
                        
                        wasSuccessful = true
                        
                        let weatherSummary = websiteArray[0].stringByReplacingOccurrencesOfString("&deg;", withString: "º")
                        
                        dispatch_async(dispatch_get_main_queue(), {
                            
                            self.resultLabel.text = weatherSummary
                            
                        })
                    }
                }
                
                
                
                
            }
            
            if wasSuccessful == false {
                
                
            }
        }
            
        
        task.resume()
        
        } else {
            
            self.resultLabel.text = "Couldn't find weather for that city, please try again!"

            
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
   
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

