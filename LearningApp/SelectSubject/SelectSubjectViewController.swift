//
//  SelectSubjectViewController.swift
//  LearningApp
//
//  Created by Busha Ltd on 06/11/2018.
//  Copyright © 2018 Codegene. All rights reserved.
//

import UIKit
import Siesta

class SelectSubjectViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    private var statusOverlay = ResourceStatusOverlay()
    
    //private var statusOverlay = ResourceStatusOverlay()
    
    var subjectList = [Subject]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    private var restaurants: [[String: Any]] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    var restaurantListResource: Resource? {
        didSet {
            oldValue?.removeObservers(ownedBy: self)
            restaurantListResource?
                .addObserver(self)
                .addObserver(statusOverlay, owner: self)
                .loadIfNeeded()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subjectList.count
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // when an item on the TableView is clicked
        self.performSegue(withIdentifier: "showTableDetails", sender: subjectList[indexPath.row])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showTableDetails" {
            // pass parameters to the next view controller
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let currentSubject = subjectList[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! SubjectsTableViewCell
        cell.setSubject(subject: currentSubject)
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupListMockData()
        //restaurantListResource = UtmePrepAPI.sharedInstance.restaurantList(for:"currentLocation")
        //statusOverlay.embed(in: self)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        statusOverlay.positionToCoverParent()
    }
    
    func setupListMockData (){
        let img = UIImage(named: "carbon")
        let subj = Subject(uiImage:img!, title: "Hello World")
        subjectList.append(subj)
        subjectList.append(subj)
        subjectList.append(subj)
    }

    
}

extension SelectSubjectViewController: ResourceObserver {
    func resourceChanged(_ resource: Resource, event: ResourceEvent) {
        restaurants = resource.jsonDict["businesses"] as? [[String: Any]] ?? []

    }
}

