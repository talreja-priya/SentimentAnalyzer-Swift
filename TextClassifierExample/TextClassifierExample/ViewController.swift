//
//  ViewController.swift
//  TextClassifierExample
//
//  Created by Priya Talreja on 01/12/19.
//  Copyright © 2019 Priya Talreja. All rights reserved.
//

import UIKit
import NaturalLanguage

class ViewController: UIViewController {

    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var resultImage: UIImageView!
    @IBOutlet weak var showResultButton: UIButton!
    @IBOutlet weak var movieReviewText: UITextView!
    
    private lazy var sentimentClassifier: NLModel? = {
        let model = try? NLModel(mlModel: MovieReviewsClassifier().model)
        return model
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.showResultButton.isUserInteractionEnabled = false
        self.showResultButton.alpha = 0.5
        self.movieReviewText.layer.borderColor = UIColor.lightGray.cgColor
        self.movieReviewText.layer.borderWidth = 1.0
        self.movieReviewText.layer.cornerRadius = 10
        self.movieReviewText.textColor = UIColor.black
        self.movieReviewText.text = ""
        self.resultLabel.text = ""
        self.movieReviewText.becomeFirstResponder()
    }

    @IBAction func showResult(_ sender: UIButton) {
        if let label = sentimentClassifier?.predictedLabel(for: self.movieReviewText.text) {
            switch label {
            case "pos":
                self.resultImage.image = UIImage(named: "positive")
                self.resultLabel.text = "Positive"
            case "neg":
                self.resultImage.image = UIImage(named: "negative")
                self.resultLabel.text = "Negative"
            default:
                self.resultImage.image = UIImage(named: "neutral")
                self.resultLabel.text = "Neutral"
            }
        }
    }
    
    @IBAction func clearAction(_ sender: UIButton) {
        self.resultImage.image = UIImage(named: "")
        self.resultLabel.text = ""
        self.movieReviewText.text = ""
        self.showResultButton.isUserInteractionEnabled = false
        self.showResultButton.alpha = 0.5
    }
    
}

extension ViewController:UITextViewDelegate
{
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if textView.text.isEmpty == false {
            self.showResultButton.isUserInteractionEnabled = true
            self.showResultButton.alpha = 1.0
        }
        return true
    }
    func textViewDidChange(_ textView: UITextView) {
        self.showResultButton.isUserInteractionEnabled = true
        self.showResultButton.alpha = 1.0
    }
}
