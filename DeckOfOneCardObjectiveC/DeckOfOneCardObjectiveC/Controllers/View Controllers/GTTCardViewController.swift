//
//  GTTCardViewController.swift
//  DeckOfOneCardObjectiveC
//
//  Created by Chris Gottfredson on 3/24/20.
//  Copyright © 2020 Gottfredson. All rights reserved.
//

import UIKit

class GTTCardViewController: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var cardImageView: UIImageView!
    @IBOutlet weak var newCardButton: UIButton!
    
    //MARK: - Properties
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        newCardButton.layer.cornerRadius = 22.5
        newCardButton.layer.borderWidth = 2
    }
    
    //MARK: - Actions
    @IBAction func newCardButtonTapped(_ sender: UIButton) {
        fetchCard()
    }
    
    
    //MARK: - Methods
    
    func updateViews(card: GTTCard, image: UIImage){
        DispatchQueue.main.async {
            self.nameLabel.text = "You have picked the\n\(card.value) of \(card.suit)!"
            self.cardImageView.image = image
        }
    }
    
    func fetchCard() {
        GTTCardController.shared().drawANewCard(1) { (cards, error) in
            guard let card = cards.first else { return }
            GTTCardController.shared().getCardImage(card) { (cardImage, error) in
                let cardImage = cardImage
                self.updateViews(card: card, image: cardImage)
            }
        }
    }
    
}
