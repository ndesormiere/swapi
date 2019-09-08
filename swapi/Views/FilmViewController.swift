//
//  FilmViewController.swift
//  swapi
//
//  Created by Nicolas Desormiere on 8/9/19.
//  Copyright © 2019 Nicolas Desormiere. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class FilmViewController: UITableViewController {

    private let disposeBag = DisposeBag()
    private let viewModel = FilmViewModel()
    private var filmRefreshControl = UIRefreshControl()
    private var films = [FilmResult]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerCells()
        setupUI()
        bindViewModel()
        refresh()
    }
    
    private func registerCells() {
        tableView.register(FilmTableViewCell.self, forCellReuseIdentifier: FilmTableViewCell.nameOfClass)
    }
    
    private func setupUI() {
        filmRefreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        tableView.refreshControl = filmRefreshControl
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        title = "Films"
    }
    
    private func bindViewModel() {
        Driver.combineLatest(viewModel.output.filmResult, viewModel.output.isLoading)
            .drive(onNext: { [weak self] (films, isLoading) in
                guard let `self` = self else { return }
                if isLoading {
                    self.filmRefreshControl.beginRefreshing()
                } else {
                    self.filmRefreshControl.endRefreshing()
                }
                self.films = films
                self.tableView.reloadData()
            })
            .disposed(by: disposeBag)
    }
    
    @objc private func refresh() {
        viewModel.input.refresh.onNext(())
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return films.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FilmTableViewCell.nameOfClass, for: indexPath) as! FilmTableViewCell
        cell.releaseDateLabel.text = films[indexPath.row].releaseDate
        cell.directorLabel.text = films[indexPath.row].director
        cell.producerLabel.text = films[indexPath.row].producer
        cell.titleLabel.text = films[indexPath.row].title
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard.Storyboards.instanciate(.main)
        let detailViewController = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        detailViewController.filmResult = films[indexPath.row]
        navigationController?.pushViewController(detailViewController, animated: true)
    }
    
}
