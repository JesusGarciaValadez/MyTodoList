//
//  ViewController.swift
//  MyTodoList
//
//  Created by Jesus Garcia on 29/11/16.
//  Copyright © 2016 Hydrastudio. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  @IBOutlet weak var itemTextField: UITextField!
  @IBOutlet weak var tableView: UITableView!
  let todoList: TodoList = TodoList()

  @IBAction func addButtonPressed( sender: UIButton ) {
    print( "Agregando un elemento a la lista: \( itemTextField.text! )" )

    todoList.addItem( item: itemTextField.text! )
    tableView.reloadData()
    self.itemTextField?.resignFirstResponder()
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.

    tableView.register( UITableViewCell.self, forCellReuseIdentifier: "Cell" )
    tableView.dataSource = todoList
    tableView.delegate = self
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

}

extension ViewController: UITableViewDelegate {
  // MARK: Methods of UITableView Delegate
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    self.itemTextField?.resignFirstResponder()
  }
}
