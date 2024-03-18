import UIKit
import SnapKit

class ViewController: UIViewController {
    
    let explame: UILabel = {
        let explameq = UILabel()
        explameq.text = "explame"
        explameq.textColor = .black
        explameq.font = .boldSystemFont(ofSize: 35)
        return explameq
        }()
    
override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(explame)
        
        explame.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        }
    }
