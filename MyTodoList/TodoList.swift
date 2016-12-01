//
//  TodoList.swift
//  MyTodoList
//
//  Created by Jesus Garcia on 30/11/16.
//  Copyright © 2016 Hydrastudio. All rights reserved.
//

import UIKit

class TodoList: NSObject {
  var items: [ String ] = []

  // MARK: Obtain a FileManager reference for save information to disk
  private let fileURL: URL = {
    let fileManager = FileManager.default
    let documentDirectoryURLs = fileManager.urls( for: .documentDirectory, in: .userDomainMask ) as [ URL ]
    var documentDirectoryURL = documentDirectoryURLs.first!
    documentDirectoryURL.appendPathComponent( "todolist.items", isDirectory: false )

    print( "Path de documentos \( documentDirectoryURL )" )
    return documentDirectoryURL
  }()

  // MARK: Load items from todolist.item file into the application
  override init() {
    super.init()

    loadItems()
  }

  // Add the task to the items array and save the items to disk
  func addItem( item: String ) {
    items.append( item )

    saveItems()
  }

  // Save items to disk
  func saveItems() {
    let itemsArray = items as NSArray

    if itemsArray.write( to: self.fileURL, atomically: true ) {
      print( "Guardado" )
    } else {
      print( "No guardado" )
    }
  }

  // Load items from disk
  func loadItems() {
    if let itemsArray = NSArray( contentsOf: self.fileURL ) as? [ String ] {
      self.items = itemsArray
    }
  }

  func getItem( index: Int ) -> String {
    return items[ index ]
  }
}

// MARK: Implements UITableViewDataSource Methods
extension TodoList: UITableViewDataSource {
  // Define the number of rows in each section
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return items.count
  }

  // Define which cell are used for populate the UITableView and what information
  // are showed
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
    let item = items[ indexPath.row ]

    cell.textLabel!.text = item

    return cell
  }

  // Make a row deletable
  func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
    return true
  }

  // Delete a task selected and animate the row deleted
  func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
    items.remove(at: indexPath.row)
    saveItems()

    tableView.beginUpdates()
    tableView.deleteRows(at: [ indexPath ], with: UITableViewRowAnimation.middle)
    tableView.endUpdates()
  }
}
