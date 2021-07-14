//
//  DesktopViewController.swift
//  Mahjong
//
//  Created by 王涛 on 2021/7/11.
//

import UIKit

class DesktopViewController: UIViewController {
    
    var participant: Participant?

    @IBOutlet weak var topCollectionView: UICollectionView!
    
    @IBOutlet weak var bottomCollectionView: UICollectionView!
    
    @IBOutlet weak var displayLabel: UILabel!
    init() {
        super.init(nibName: "DesktopViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        topCollectionView.register(UINib(nibName: "MahongCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MahongCollectionViewCell")
        bottomCollectionView.register(UINib(nibName: "MahongCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MahongCollectionViewCell")
        displayLabel.text = participant?.user.name
    }
    
    func refresh() {
        topCollectionView.reloadData()
        bottomCollectionView.reloadData()
    }

}

extension DesktopViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == topCollectionView {
            return participant?.selector.showDiscardTiles().count ?? 0
        } else {
            return participant?.selector.showHandTiles().count ?? 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var card: Card = .MAHJONG_PLACEHOLDER
        let cards: [Card]?
        if collectionView == topCollectionView {
            cards = participant?.selector.showDiscardTiles()
        } else {
            cards = participant?.selector.showHandTiles()
        }
        card = cards?[indexPath.row] ?? .MAHJONG_PLACEHOLDER
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MahongCollectionViewCell", for: indexPath) as? MahongCollectionViewCell {
            cell.displayLabel.text = "\(card.rawValue)"
            return cell
        }
        return UICollectionViewCell()
    }
    
}

extension DesktopViewController: UICollectionViewDelegate {
    
}
