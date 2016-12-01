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
  var selectedItem: String?

  static let MAX_TEXT_SIZE = 50

  // Add the new task to the items array.
  // Reload the UITableView.
  // Clean the UITextField after press the save button.
  // Hide the keyboard after press the button.
  @IBAction func addButtonPressed( sender: UIButton ) {
    print( "Agregando un elemento a la lista: \( itemTextField.text! )" )

    todoList.addItem( item: itemTextField.text! )
    tableView.reloadData()
    self.itemTextField.text = nil
    self.itemTextField?.resignFirstResponder()
  }

  // Register a new cell into the UITableView in a programmatic way and assign
  // an ID.
  // Register the UITableViewDataSource and UITableViewDelegate.
  // Register the UITextFieldDelegate.
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.

    tableView.register( UITableViewCell.self, forCellReuseIdentifier: "Cell" )
    tableView.dataSource = todoList
    tableView.delegate = self
    itemTextField.delegate = self
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

}

// MARK: Methods of UITableView Delegate
extension ViewController: UITableViewDelegate {

  // Hide the keyboard if we scroll the table
  func scrollViewDidScroll(_ scrollView: UIScrollView) {

    self.itemTextField?.resignFirstResponder()
  }

  // If select a cell obtain the task from the array and perform a segue to 
  // another view using the "showItem" segue
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    self.selectedItem = self.todoList.getItem(index: indexPath.row)
    self.performSegue(withIdentifier: "showItem", sender: self)
  }

  // Obtain the DetailViewController as a destination and passing it the 
  // task from the selected row
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

    if let detailViewController = segue.destination as? DetailViewController {
      detailViewController.item = self.selectedItem
    }
  }
}

// MARK: Methods of UITextField Delegate
extension ViewController: UITextFieldDelegate {

  // Restringe the max length of the text field.
  func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

    if let taskString = textField.text as NSString? {

      let updatedString = taskString.replacingCharacters(in: range, with: string)
      return updatedString.characters.count <= ViewController.MAX_TEXT_SIZE
    } else {

      return true
    }
  }
}
