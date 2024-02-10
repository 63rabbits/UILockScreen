//
//  ViewController.swift
//  UILockScreen
//
//  Created by 63rabbits goodman on 2024/02/10.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var labelOrientation: UILabel!

    @IBOutlet weak var switchPortrait: UISwitch!
    @IBOutlet weak var switchLandscapeRight: UISwitch!
    @IBOutlet weak var switchLandscapeLeft: UISwitch!
    @IBOutlet weak var switchPortraitUpsideDown: UISwitch!

    @IBAction func actionPortrait(_ sender: Any)            { setSupportedIFOrientations() }
    @IBAction func actionLandscapeRight(_ sender: Any)      { setSupportedIFOrientations() }
    @IBAction func actionLandscapeLeft(_ sender: Any)       { setSupportedIFOrientations() }
    @IBAction func actionPortraitUpsideDown(_ sender: Any)  { setSupportedIFOrientations() }

//    var windowScene: UIWindowScene?
//    var viewController: UIViewController?
    var supportedIFOrientations: UIInterfaceOrientationMask = [ .portrait ]

    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(ViewController.orientationChanged),
            name: UIDevice.orientationDidChangeNotification,
            object: nil)

        setSupportedIFOrientations()
    }

    @objc func orientationChanged() {
        let orientation = UIDevice.current.orientation
        labelOrientation.text = orientationTranslator(orientation)
    }

    func orientationTranslator(_ orientation: UIDeviceOrientation) -> String {
        var message = ""
        switch orientation {
        case .unknown:              message += "unknown"
        case .portrait:             message += "portrait"
        case .portraitUpsideDown:   message += "portraitUpsideDown"
        case .landscapeLeft:        message += "landscapeLeft"
        case .landscapeRight:       message += "landscapeRight"
        case .faceUp:               message += "faceUp"
        case .faceDown:             message += "faceDown"
        @unknown default:
            break
        }
        return message
    }

    func setSupportedIFOrientations() {
        var orientation: UInt = 0
        if switchPortrait.isOn              { orientation |= UIInterfaceOrientationMask.portrait.rawValue }
        if switchLandscapeRight.isOn        { orientation |= UIInterfaceOrientationMask.landscapeRight.rawValue }
        if switchLandscapeLeft.isOn         { orientation |= UIInterfaceOrientationMask.landscapeLeft.rawValue }
        if switchPortraitUpsideDown.isOn    { orientation |= UIInterfaceOrientationMask.portraitUpsideDown.rawValue }
        supportedIFOrientations = UIInterfaceOrientationMask(rawValue: orientation)

//        windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
//        windowScene?.requestGeometryUpdate(.iOS(interfaceOrientations: supportedIFOrientations))
//        viewController = parentViewController(view: view)
//        viewController?.setNeedsUpdateOfSupportedInterfaceOrientations()
        self.setNeedsUpdateOfSupportedInterfaceOrientations()
    }

//    private func parentViewController(view: UIView) -> UIViewController? {
//        var parent = view as UIResponder
//        while let next = parent.next {
//            if let viewController = next as? UIViewController {
//                return viewController
//            }
//            parent = next
//        }
//        return nil
//    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return supportedIFOrientations
    }

}
