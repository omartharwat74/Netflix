//
//  UpComingViewController.swift
//  Netflix
//
//  Created by Omar Tharwat on 7/3/22.
//  Copyright © 2022 Omar Tharwat. All rights reserved.
//

import UIKit

class UpComingViewController: UIViewController{
    
    private var titles : [Title] = [Title]()

    private let upcomingTable : UITableView = {
        let table = UITableView()
        table.register(TitleTableViewCell.self, forCellReuseIdentifier: TitleTableViewCell.identifier)
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Upcoming"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        
        view.addSubview(upcomingTable)
        upcomingTable.dataSource = self
        upcomingTable.delegate = self
        fetchUpcoming()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        upcomingTable.frame = view.bounds
    }
    
    private func fetchUpcoming(){
        APICaller.shared.getUpComingMovies { [weak self] result in
            switch result {
            case .success(let titles) :
                self?.titles = titles
                DispatchQueue.main.async {
                     self?.upcomingTable.reloadData()
                }
            case .failure(let error) :
                print(error.localizedDescription)
            }
        }
    }
    
}
extension UpComingViewController :  UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TitleTableViewCell.identifier, for: indexPath) as? TitleTableViewCell else{return UITableViewCell()}
        let title = titles[indexPath.row]
        cell.configure(with: TitleViewModel(titleName: (title.original_title ?? title.original_name) ?? "UnKnown title name", posterURL: title.poster_path ?? ""))
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let title = titles[indexPath.row]
        
        guard let titleName = title.original_title ?? title.original_name else {return}
        APICaller.shared.getMovie(with: titleName) { [weak self] (result) in
            switch result {
            case .success(let videoElement) :
                DispatchQueue.main.async {
                    let vc = TitlePreviewViewController()
                               vc.configure(with: TitlePreviewViewModel(title: titleName, youtubeVideo: videoElement, titleOverview: title.overview ?? ""))
                               self?.navigationController?.pushViewController(vc, animated: true)
                }
           
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
}
