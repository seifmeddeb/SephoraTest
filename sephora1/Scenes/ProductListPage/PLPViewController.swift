//
//  PLPViewController.swift
//  sephora1
//
//  Created by Seif Meddeb on 04/01/2023.
//

import UIKit
import Combine

class PLPViewController: UIViewController {

    var viewModel: PLPViewModelProtocol?
    private var products = [DisplayableProduct]()
    
    private let tableView = UITableView()
    private let activityIndicator = UIActivityIndicatorView()
    private let errorLabel = UILabel()
    private let refreshControl = UIRefreshControl()
    
    private var cancellable: AnyCancellable?
    private let cellId = "ProductCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Products"
        setupUI()
    }


    private func setupUI() {
        setupTableView()
        setupActivityIndicator()
        fetchProductList()
    }
    
    private func setupErrorLabel() {
        errorLabel.text = "Oops! an error has occured pull down to refresh ;)"
        errorLabel.numberOfLines = 0
        errorLabel.font = UIFont.systemFont(ofSize: 20.0, weight: .bold)
        errorLabel.isHidden = true
        errorLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(errorLabel)
        errorLabel.safeAreaLayoutGuide.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        errorLabel.safeAreaLayoutGuide.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        errorLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    private func setupActivityIndicator() {
        activityIndicator.hidesWhenStopped = true
        activityIndicator.color = .systemPink
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(activityIndicator)
        activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }

    private func setupTableView() {
        tableView.dataSource = self
        tableView.register(ProductCell.self, forCellReuseIdentifier: cellId)
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.safeAreaLayoutGuide.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        tableView.safeAreaLayoutGuide.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        tableView.safeAreaLayoutGuide.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        tableView.addSubview(refreshControl)
    }
    
    @objc func refresh(_ sender: AnyObject) {
        fetchProductList()
    }
    
    private func fetchProductList() {
        errorLabel.isHidden = true
        activityIndicator.startAnimating()
        let plpSubject = viewModel?.fetchProducts()
        cancellable = plpSubject?.sink { [weak self] completion in
            self?.activityIndicator.stopAnimating()
            switch completion {
            case .finished:
                debugPrint("Received finished")
            case .failure(let error):
                self?.errorLabel.isHidden = false
                debugPrint("❌\(error)")
            }
        } receiveValue: { [weak self] products in
            self?.activityIndicator.stopAnimating()
            self?.products = products
            self?.tableView.reloadData()
            self?.title = "Products (\(products.count))"
            self?.refreshControl.endRefreshing()
        }
    }
}
// MARK: DataSource
extension PLPViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.products.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! ProductCell
        let product = products[indexPath.row]
        cell.selectionStyle = .none
        cell.setup(with: product)
        return cell
    }

}
