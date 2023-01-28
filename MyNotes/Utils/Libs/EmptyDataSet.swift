//
//  EmptyDataSet.swift
//  MyNotes
//
//  Created by Anwar Alhayek on 24/01/2023.
//

import Foundation
import UIKit

extension UIScrollView {

    func emptyDataSet(headerHeight: CGFloat? = nil, message: String = "", messageFont: UIFont? = nil, image: String = "") {

        let view = self.setupView(headerHeight: headerHeight, message: message, messageFont: messageFont, image: image)

        if itemsCount == 0 {
            //TableView
            if let tableView = self as? UITableView {
                if tableView.backgroundView == nil {
                    tableView.backgroundView = view
                }
            }
            //CollectionView
                else if let collectionView = self as? UICollectionView {
                if collectionView.backgroundView == nil {
                    collectionView.backgroundView = view
                }
            }
            self.animate(view)

        } else {
            if let tableView = self as? UITableView {
                tableView.backgroundView = nil
            } else if let collectionView = self as? UICollectionView {
                collectionView.backgroundView = nil
            }
        }
    }


    // MARK: Create View
    func setupView(headerHeight: CGFloat? = nil, message: String = "", messageFont: UIFont? = nil, image: String = "") -> UIView {

        let tableViewHeight = self.frame.height
        let tableViewWidth = self.frame.width
        let _headerHeight = tableViewHeight * ((headerHeight ?? 1) / tableViewHeight)

        //_________Create Suber StackView_________
        let suberStackView = UIStackView.init(frame: CGRect(x: 0, y: 0, width: tableViewWidth, height: tableViewHeight))
        suberStackView.axis = NSLayoutConstraint.Axis.horizontal
        suberStackView.alignment = UIStackView.Alignment.center

        //_________Create Sub StackView_________
        let subStackView = UIStackView.init()
        subStackView.axis = NSLayoutConstraint.Axis.vertical
        subStackView.spacing = 25

        //_________Create Label_________
        let label = UILabel()
        label.text = message
        label.textAlignment = .center
        label.font = messageFont ?? UIFont.systemFont(ofSize: 22, weight: .light)
        label.numberOfLines = 0

        //_________Create imageView_________
        let imageView = UIImageView.init(frame: CGRect(x: 0, y: 0, width: 200, height: 300))
        imageView.image = image._toImage
        imageView.contentMode = UIView.ContentMode.scaleAspectFill

        //_________Create Header View_________
        let view = UIView.init()

        //_________Create Bottom View_________
        let bottomView = UIView.init()


        if headerHeight != nil {
            view.heightAnchor.constraint(equalToConstant: _headerHeight).isActive = true
            subStackView.addArrangedSubview(view)
            subStackView.addArrangedSubview(imageView)
            subStackView.addArrangedSubview(label)
            subStackView.addArrangedSubview(bottomView)
            return subStackView
        }

        suberStackView.addArrangedSubview(subStackView)
        subStackView.addArrangedSubview(imageView)
        subStackView.addArrangedSubview(label)
        return suberStackView
    }

    // MARK: Animation
    func animate(_ view: UIView) {
        let animation = CABasicAnimation(keyPath: #keyPath(CALayer.opacity))
        animation.fromValue = 0.0
        animation.toValue = 1.0
        animation.duration = 1.0
        animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        view.layer.add(animation, forKey: "animate")
    }

    internal var itemsCount: Int {
        var items = 0

        if let tableView = self as? UITableView {
            var sections = 1

            if let dataSource = tableView.dataSource {
                if dataSource.responds(to: #selector(UITableViewDataSource.numberOfSections(in:))) {
                    sections = dataSource.numberOfSections!(in: tableView)
                }
                if dataSource.responds(to: #selector(UITableViewDataSource.tableView(_: numberOfRowsInSection:))) {
                    for i in 0 ..< sections {
                        items += dataSource.tableView(tableView, numberOfRowsInSection: i)
                    }
                }
            }
        } else if let collectionView = self as? UICollectionView {
            var sections = 1

            if let dataSource = collectionView.dataSource {
                if dataSource.responds(to: #selector(UICollectionViewDataSource.numberOfSections(in:))) {
                    sections = dataSource.numberOfSections!(in: collectionView)
                }
                if dataSource.responds(to: #selector(UICollectionViewDataSource.collectionView(_: numberOfItemsInSection:))) {
                    for i in 0 ..< sections {
                        items += dataSource.collectionView(collectionView, numberOfItemsInSection: i)
                    }
                }
            }
        }
        return items
    }
}


