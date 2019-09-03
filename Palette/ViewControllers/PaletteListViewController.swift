//
//  PaletteListViewController.swift
//  Palette
//
//  Created by Blake kvarfordt on 9/3/19.
//  Copyright © 2019 trevorAdcock. All rights reserved.
//

import UIKit

class PaletteListViewController: UIViewController {
    
    var photos: [UnsplashPhoto] = []

    var safeArea: UILayoutGuide {
        return self.view.safeAreaLayoutGuide
    }
    
    override func loadView() {
        super.loadView()
        addAllSubviews()
        setupStackView()
        tableView.anchor(top: buttonStackView.bottomAnchor, bottom: safeArea.bottomAnchor, leading: safeArea.leadingAnchor, trailing: safeArea.trailingAnchor, topPadding: 8, bottomPadding: 0, leadingPadding: 0, trailingPadding: 0)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        configureTableView()
    }
    
    func addAllSubviews() {
        self.view.addSubview(featuredButton)
        self.view.addSubview(randomButton)
        self.view.addSubview(doubleRainbowButton)
        self.view.addSubview(buttonStackView)
        self.view.addSubview(tableView)
    }
    
    func setupStackView() {
        buttonStackView.translatesAutoresizingMaskIntoConstraints = false
        buttonStackView.addArrangedSubview(featuredButton)
        buttonStackView.addArrangedSubview(randomButton)
        buttonStackView.addArrangedSubview(doubleRainbowButton)
        
        // Setup Contraints
        buttonStackView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 0).isActive = true
        buttonStackView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16).isActive = true
        buttonStackView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -16).isActive = true

    }
    
    func configureTableView() {
        // delegate, data source
        tableView.delegate = self
        tableView.dataSource = self
        // register our custom cell
        tableView.register(PaletteTableViewCell.self, forCellReuseIdentifier: "colorCell")
        // do any edigin to tableView properties
        tableView.allowsSelection = false
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    //MARK: - Views
    let featuredButton: UIButton = {
        let button = UIButton()
        button.setTitle("Featured", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.contentHorizontalAlignment = .center
        return button
    }()
    
    let randomButton: UIButton = {
        let button = UIButton()
        button.setTitle("Random", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.contentHorizontalAlignment = .center
        return button
    }()
    
    let doubleRainbowButton: UIButton = {
        let button = UIButton()
        button.setTitle("DoubleRainbow", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.contentHorizontalAlignment = .center
        return button
    }()
    
    let buttonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .equalCentering
        return stackView
    }()
    
    let tableView: UITableView = {
        let tableView = UITableView()
        
        return tableView
    }()
}

extension PaletteListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let imageViewSpacing: CGFloat = (view.frame.width - (SpacingConstants.outerHorizontalPadding * 2))
        let titleLabelSpacing: CGFloat = SpacingConstants.oneLineElementHeight
        let colorPaletteSpacing: CGFloat = SpacingConstants.twoLineElementHeight
        let verticalPadding: CGFloat = (3 * SpacingConstants.verticalObjectBuffer)
        let outerVerticalPadding: CGFloat = (2 * SpacingConstants.outerHorizontalPadding)
        
        return imageViewSpacing + titleLabelSpacing + colorPaletteSpacing + verticalPadding + outerVerticalPadding
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "colorCell", for: indexPath) as? PaletteTableViewCell else { return UITableViewCell() }
       let photo = photos[indexPath.row]
        cell.unsplashPhoto = photo
        return cell
    }
    
    
}
