//
//  LocationView.swift
//  RickAndMorty
//
//  Created by Dmitrii Iakovlev on 15.03.2024.
//

import UIKit

protocol LocationViewDelegate: AnyObject {
    func LocationView(_ loactionView: LocationView, didSelect location: Location)
}

final class LocationView: UIView {
    
    public weak var delegate: LocationViewDelegate?
    
    private var viewModel: LocationViewViewModel? {
        didSet {
            spinner.stopAnimating()
            tableView.isHidden = false
            tableView.reloadData()
            UIView.animate(withDuration: 0.3) {
                self.tableView.alpha = 1
            }
        }
    }
    
    private let tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.alpha = 0
        table.isHidden = true
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(LocationTableViewCell.self, forCellReuseIdentifier: LocationTableViewCell.cellIdentifier)
       return table
    }()
    
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView()
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.hidesWhenStopped = true
        return spinner
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setDelegate()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func setupViews() {
        backgroundColor = .systemBackground
        translatesAutoresizingMaskIntoConstraints = false
        addSubviews(tableView, spinner)
        spinner.startAnimating()
    }
    
    private func setDelegate() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    public func configure(with viewModel: LocationViewViewModel) {
        self.viewModel = viewModel
    }
}

//MARK: - Set Constraints
extension LocationView {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            spinner.heightAnchor.constraint(equalToConstant: 100),
            spinner.widthAnchor.constraint(equalToConstant: 100),
            spinner.centerXAnchor.constraint(equalTo: centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.leftAnchor.constraint(equalTo: leftAnchor),
            tableView.rightAnchor.constraint(equalTo: rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}


//MARK: - UITableViewDelegate
extension LocationView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let locationModel = viewModel?.location(at: indexPath.row) else {
            return
        }
        delegate?.LocationView(self, didSelect: locationModel)
    }
}

//MARK: - UITableViewDataSource
extension LocationView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
          return viewModel?.cellViewModels.count ?? 0
      }

      func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
          guard let cellViewModels = viewModel?.cellViewModels else {
              fatalError()
          }
          guard let cell = tableView.dequeueReusableCell(withIdentifier: LocationTableViewCell.cellIdentifier,
              for: indexPath) as? LocationTableViewCell else {
              fatalError()
          }
          let cellViewModel = cellViewModels[indexPath.row]
          cell.configure(with: cellViewModel)
          return cell
      }
  }
