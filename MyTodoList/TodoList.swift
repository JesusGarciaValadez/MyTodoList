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

  // Obtain a FileManager reference for save information to disk
  private let fileURL: URL = {
    let fileManager = FileManager.default
    let documentDirectoryURLs = fileManager.urls( for: .documentDirectory, in: .userDomainMask ) as [ URL ]
    var documentDirectoryURL = documentDirectoryURLs.first!
    documentDirectoryURL.appendPathComponent( "todolist.items", isDirectory: false )

    print( "Path de documentos \( documentDirectoryURL )" )
    return documentDirectoryURL
  }()

  // Load items from todolist.item file into the application
  override init() {
    super.init()

    loadItems()
  }

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
}

extension TodoList: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return items.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
    let item = items[ indexPath.row ]

    cell.textLabel!.text = item

    return cell
  }

  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
}
