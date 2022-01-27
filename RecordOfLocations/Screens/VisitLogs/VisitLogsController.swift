//
//  VisitLogsController.swift
//  RecordOfLocations
//
//  Created by Chandrachudh K on 27/01/22.
//

import UIKit

class VisitLogsController: UIViewController {

    //MARK: Public Properties
    
    //MARK: UI Elements
    @IBOutlet weak var locationsTableView: UITableView!
    
    //MARK: Layout Constraints
    
    //MARK: Private Properties
    private var  viewModel:VisitLogViewModel!
    
    //MARK: Overidable Properties and Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        NotificationCenter.default.addObserver(self, selector: #selector(newLocationFound), name: .newLocationSaved, object: nil)
    }
    
    //MARK: Public Methods
    convenience init(viewModel:VisitLogViewModel) {
        self.init()
        self.viewModel = viewModel
    }
    
    //MARK: Private methods
    private func setupUI() {
        locationsTableView.registerCellWith(nibName: VisitLogCell.reuseIdentifier)
        locationsTableView.dataSource = self
        locationsTableView.tableFooterView = UIView()
        locationsTableView.reloadData()
    }
    
    //MARK: Target Methods
    @objc private func newLocationFound() {
        locationsTableView.reloadData()
    }
}


extension VisitLogsController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return LocationsStorage.shared.locations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: VisitLogCell.reuseIdentifier, for: indexPath) as! VisitLogCell
        cell.populateWith(location: LocationsStorage.shared.locations.reversed()[indexPath.row], index: indexPath.row)
        cell.selectionStyle = .none
        return cell
    }
}
