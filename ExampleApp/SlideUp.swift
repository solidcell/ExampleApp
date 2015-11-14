import UIKit

class SlideUpViewController: ViewPresenter {
    @IBOutlet weak var mainLabel: UILabel!
    @IBAction func didTapShinyButton(sender: AnyObject) {
        mainLabel.text = "you clicked the button 1 time"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.greenColor()
    }
}