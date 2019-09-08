//
//  DetailViewController.swift
//  swapi
//
//  Created by Nicolas Desormiere on 8/9/19.
//  Copyright © 2019 Nicolas Desormiere. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class DetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var releseYearLabel: UILabel!
    @IBOutlet weak var directorLabel: UILabel!
    @IBOutlet weak var producerLabel: UILabel!
    @IBOutlet weak var peopleTableView: UITableView!
    
    private let disposeBag = DisposeBag()
    private let viewModel = DetailViewModel()
    private var peopleRefreshControl = UIRefreshControl()
    private var people: [People] = []
    var filmResult: FilmResult!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        precondition(filmResult != nil, "developer must set filmResult")
        viewModel.input.peopleURLs.onNext(filmResult.characters ?? [])
        
        registerCells()
        setupUI()
        bindViewModel()
        refresh()
    }
    
    private func registerCells() {
        peopleTableView.register(UITableViewCell.self, forCellReuseIdentifier: UITableViewCell.nameOfClass)
    }
    
    private func setupUI() {
        peopleRefreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        peopleTableView.refreshControl = peopleRefreshControl
        peopleTableView.tableFooterView = UIView()
        peopleTableView.separatorStyle = .none
        peopleTableView.dataSource = self
        peopleTableView.delegate = self
        
        releseYearLabel.text = filmResult.created
        producerLabel.text = filmResult.producer
        directorLabel.text = filmResult.director
        
        view.backgroundColor = .white
        title = "Details"
    }
    
    private func bindViewModel() {
        Driver.combineLatest(viewModel.output.peopleResult, viewModel.output.isLoading)
            .drive(onNext: { [weak self] (people, isLoading) in
                guard let `self` = self else { return }
                if isLoading {
                    self.peopleRefreshControl.beginRefreshing()
                } else {
                    self.peopleRefreshControl.endRefreshing()
                }
                self.people = people
                self.peopleTableView.reloadData()
            })
            .disposed(by: disposeBag)
    }
    
    @objc private func refresh() {
        viewModel.input.refresh.onNext(())
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return people.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UITableViewCell.nameOfClass, for: indexPath)
        cell.textLabel?.text = people[indexPath.row].name
        return cell
    }
    
}
