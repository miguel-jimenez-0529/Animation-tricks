/**
 * Copyright (c) 2017 Razeware LLC
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
 * distribute, sublicense, create a derivative work, and/or sell copies of the
 * Software in any work that is designed, intended, or marketed for pedagogical or
 * instructional purposes related to programming, coding, application development,
 * or information technology.  Permission for such use, copying, modification,
 * merger, publication, distribution, sublicensing, creation of derivative works,
 * or sale is expressly withheld.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

import UIKit
import QuartzCore


//MARK: ViewController
class ViewController: UIViewController {
    
    @IBOutlet var bgImageView: UIImageView!
    
    @IBOutlet var summaryIcon: UIImageView!
    @IBOutlet var summary: UILabel!
    
    @IBOutlet var flightNr: UILabel!
    @IBOutlet var gateNr: UILabel!
    @IBOutlet var departingFrom: UILabel!
    @IBOutlet var arrivingTo: UILabel!
    @IBOutlet var planeImage: UIImageView!
    
    @IBOutlet var flightStatus: UILabel!
    @IBOutlet var statusBanner: UIImageView!
    
    var snowView: SnowView!
    
    //MARK:- animations
    func fade(
        toImage: UIImage,
        showEffects: Bool
        ) {
        let tempView = UIImageView(frame: bgImageView.frame)
        tempView.image = toImage
        tempView.alpha = 0
        tempView.center.y += 20
        tempView.bounds.size.width = bgImageView.bounds.width * 1.3
        bgImageView.superview?.insertSubview(tempView, aboveSubview: bgImageView)
        UIView.animate(withDuration: 0.5, animations: {
            tempView.alpha = 1
            tempView.center.y -= 20
            tempView.bounds.size = self.bgImageView.bounds.size
        }) { (_) in
            self.bgImageView.image = toImage
            tempView.removeFromSuperview()
        }
        //TODO: Create a crossfade animation for the background
        
        //TODO: Create a fade animation for snowView
        UIView.animate(withDuration: 1.0,
                       delay: 0,
                       options : .curveEaseOut,
                       animations: {
                        self.snowView.alpha = showEffects ? 1 : 0
        })
    }
    
    func moveLabel(_ label : UILabel, text : String, offset: CGPoint) {
        //TODO: Animate a label's translation property
        let tempLabel = duplicateLabel(label: label)
        tempLabel.text = text
        tempLabel.transform = CGAffineTransform(translationX: offset.x, y: offset.y)
        tempLabel.alpha = 0
        view.addSubview(tempLabel)
        
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseIn, animations: {
            label.transform = CGAffineTransform(translationX: offset.x, y: offset.y)
            label.alpha = 0
        }, completion: nil)
        
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseIn, animations: {
            tempLabel.alpha = 1
            tempLabel.transform = .identity
        }) { (_) in
            label.text = text
            label.transform = .identity
            label.alpha = 1
            tempLabel.removeFromSuperview()
        }
    }
    
    func cubeTransition(_ label : UILabel, text : String) {
        //TODO: Create a faux rotating cube animation
        let tempLabel = duplicateLabel(label: label)
        tempLabel.text = text
        let tempLabelOffeset = label.frame.height / 2
        let scale = CGAffineTransform(scaleX: 1, y: 0.1)
        let transalate = CGAffineTransform(translationX: 0, y: tempLabelOffeset)
        tempLabel.transform = scale.concatenating(transalate)
        
        label.superview?.addSubview(tempLabel)
        
        UIView.animate(withDuration: 0.5, delay: 0, options: UIViewAnimationOptions.curveEaseIn, animations: {
            tempLabel.transform = .identity
            label.transform = scale.concatenating(transalate.inverted())
        }) { (_) in
            label.text = text
            label.transform = .identity
            tempLabel.removeFromSuperview()
        }
    }
    
    
    func planeDepart() {
        //TODO: Animate the plane taking off and landing
        let center = planeImage.center
        UIView.animateKeyframes(withDuration: 1.5, delay: 0, animations: {
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.25, animations: {
               self.planeImage.center.x += 80
                self.planeImage.center.y -= 10
            })
            UIView.addKeyframe(withRelativeStartTime: 0.1, relativeDuration: 0.4, animations: {
                self.planeImage.transform = CGAffineTransform(rotationAngle: -.pi / 8)
            })
            UIView.addKeyframe(withRelativeStartTime: 0.25, relativeDuration: 0.25, animations: {
                self.planeImage.center.x += 100
                self.planeImage.center.y -= 50
                self.planeImage.alpha = 0
            })
            UIView.addKeyframe(withRelativeStartTime: 0.51, relativeDuration: 0.01, animations: {
                self.planeImage.transform = .identity
                self.planeImage.center = CGPoint(x: 0, y: center.y)
            })
            UIView.addKeyframe(withRelativeStartTime: 0.55, relativeDuration: 0.45, animations: {
               self.planeImage.alpha = 1
                self.planeImage.center = center
            })
            
        }) { (_) in
            
        }
    }
    
    func changeSummary(to summaryText: String) {
        //TODO: Animate the summary text
        UIView.animateKeyframes(withDuration: 1.5, delay: 0, animations: {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.45, animations: {
                self.summary.center.y -= 100
            })
            
            UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.45, animations: {
                self.summary.center.y += 100
            })
        }, completion: nil)
        
        delay(seconds: 0.5) {
            self.summary.text = summaryText
        }
    }
    //MARK:- custom methods
    
    func changeFlight(to data: FlightData, animated: Bool = false) {
        // populate the UI with the next flight's data
        if animated {
            //TODO: Call your animation
            fade(toImage: UIImage(named: data.weatherImageName)!, showEffects: data.showWeatherEffects)
            
            let departingOffset = CGPoint(x: -80, y: 0)
            moveLabel(departingFrom, text: data.departingFrom, offset: departingOffset)
            let arrivingOffset = CGPoint(x: 0, y: -50)
            moveLabel(arrivingTo, text: data.arrivingTo, offset: arrivingOffset)
            cubeTransition(flightStatus, text: data.flightStatus)
            cubeTransition(flightNr, text: data.flightNr)
            cubeTransition(gateNr, text: data.gateNr)
            planeDepart()
            changeSummary(to: data.summary)
        } else {
            bgImageView.image = UIImage(named: data.weatherImageName)
            snowView.isHidden = !data.showWeatherEffects
            departingFrom.text = data.departingFrom
            arrivingTo.text = data.arrivingTo
            flightStatus.text = data.flightStatus
            flightNr.text = data.flightNr
            gateNr.text = data.gateNr
            summary.text = data.summary
        }
        
        // schedule next flight
        delay(seconds: 3.0) {
            self.changeFlight(to: data.isTakingOff ? parisToRome : londonToParis, animated: true)
        }
    }
    
    //MARK:- view controller methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //adjust UI
        summary.addSubview(summaryIcon)
        summaryIcon.center.y = summary.frame.size.height/2
        
        //add the snow effect layer
        snowView = SnowView(frame: CGRect(x: -150, y:-100, width: 300, height: 50))
        let snowClipView = UIView(frame: view.frame.offsetBy(dx: 0, dy: 50))
        snowClipView.clipsToBounds = true
        snowClipView.addSubview(snowView)
        view.addSubview(snowClipView)
        
        //start rotating the flights
        changeFlight(to: londonToParis, animated: false)
    }
    
    
    //MARK:- utility methods
    func delay(seconds: Double, completion: @escaping ()-> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds, execute: completion)
    }
    
    func duplicateLabel(label: UILabel) -> UILabel {
        let newLabel = UILabel(frame: label.frame)
        newLabel.font = label.font
        newLabel.textAlignment = label.textAlignment
        newLabel.textColor = label.textColor
        newLabel.backgroundColor = label.backgroundColor
        return newLabel
    }
}

