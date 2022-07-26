import UIKit
import AVFoundation

class ViewController: UIViewController {
    //MARK: - UI Elements
    @IBOutlet weak var musicTitleLabel: UILabel!
    @IBOutlet weak var sliderView: UISlider!
    
    //MARK: - Sub properties
    private lazy var player = AVAudioPlayer()
    private lazy var displayLink: CADisplayLink = {
        let display = CADisplayLink(target: self, selector: #selector(updateMusicProgress(_:)))
        display.add(to: .current, forMode: .default)
        return display
    }()

    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        player = getAudioPlayer(for: "Queen")
        setTitle(of: player.url)
    }
}

//MARK: - Syb functions
extension ViewController {
    func getAudioPlayer(for resource: String) -> AVAudioPlayer {
        guard let path = Bundle.main.path(forResource: resource, ofType: "mp3") else {
            return AVAudioPlayer()
        }
        
        let url = URL(fileURLWithPath: path)
        
        do {
            let player = try AVAudioPlayer(contentsOf: url)
            player.delegate = self
            player.prepareToPlay()
            
            return player
        } catch {
            fatalError()
        }
    }
    
    func setTitle(of music: URL?) {
        guard let url = music else {
            return
        }
        
        let playerItem = AVPlayerItem(url: url)
        let metadataList = playerItem.asset.commonMetadata
        
        let titleValue = metadataList.first { value in
            value.commonKey == .commonKeyTitle
        }
        musicTitleLabel.text = titleValue?.stringValue ?? url.lastPathComponent.components(separatedBy: ".")[0].capitalized
    }
}
//MARK: - Actions
extension ViewController {
    @IBAction func backwardButtonPressed(_ sender: UIButton) {
    }
    
    @IBAction func forwardButtonPressed(_ sender: UIButton) {
//        player = getAudioPlayer(for: "spacecadet")
//        setTitle(of: player.url)
    }
    
    @IBAction func playButtonPressed(_ sender: Any) {
        if !player.isPlaying {
            player.play()
        } else {
            player.stop()
        }
        displayLink.isPaused = !player.isPlaying
    }
    
    @IBAction func stopButtonPressed(_ sender: Any) {
        if !player.isPlaying {
            player.stop()
            displayLink.isPaused = true
            sliderView.setValue(0, animated: false)
        }
        player.currentTime = 0
    }
    
    @IBAction func sliderValueChanged(_ sender: UISlider) {
        player.currentTime = Double(sender.value) * player.duration
    }
    
    @objc private func updateMusicProgress(_ sender: CADisplayLink) {
        sliderView.setValue(Float(player.currentTime) / Float(player.duration),
                            animated: true)
    }
}

//MARK: - AVAudioPlayerDelegate
extension ViewController: AVAudioPlayerDelegate {
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        if flag {
            displayLink.isPaused = true
            sliderView.setValue(0, animated: false)
        }
    }
}
