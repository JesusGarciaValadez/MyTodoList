//
//  DetailViewController.swift
//  MyTodoList
//
//  Created by Jesus Garcia on 30/11/16.
//  Copyright © 2016 Hydrastudio. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

  var item: String?
  @IBOutlet weak var descriptionLabel: UILabel!
  @IBOutlet weak var dateLabel: UILabel!

  override func viewDidLoad() {
    super.viewDidLoad()

    print( "Item: \(item)" )
    self.descriptionLabel.text = item!
  }

  @IBAction func dateSelected(_ sender: UIDatePicker) {
    self.dateLabel.text = formatDate(date: sender.date)
  }

  func formatDate( date: Date ) -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "dd/MM/yyyy HH:mm"
    return formatter.string(from: date)
  }
  
  @IBAction func addNotification(_ sender: UIBarButtonItem) {
    
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
    

  /*
  // MARK: - Navigation

  // In a storyboard-based application, you will often want to do a little preparation before navigation
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
  }
  */

}
