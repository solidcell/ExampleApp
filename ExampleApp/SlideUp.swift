import UIKit

class SlideUpViewModel {

    private var clickCount = 0

    private var possiblyPluralS: String {
        return clickCount == 1 ? "" : "s"
    }

    var clickCountText: String {
        return "you clicked the button \(clickCount) time\(possiblyPluralS)"
    }

    func didClick() {
        clickCount++
    }
}

class SlideUpViewController: UIViewController {

    let viewModel = SlideUpViewModel()

    @IBOutlet weak var mainLabel: UILabel!

    @IBAction func didTapShinyButton(sender: AnyObject) {
        viewModel.didClick()
        UIView.animateWithDuration(0.5) {[weak self] () -> Void in
            guard let vSelf = self else {
                return
            }
            vSelf.mainLabel.text = vSelf.viewModel.clickCountText
        }
    }

    @IBAction func didTapDoneButton(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.greenColor()
        mainLabel.text = viewModel.clickCountText
    }
}