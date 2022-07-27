import UIKit
import AVFoundation

class ViewController: UIViewController {
    //MARK: - UI Elements
    @IBOutlet weak var musicTitleLabel: UILabel!
    @IBOutlet weak var sliderView: UISlider!
    
    //MARK: - Sub properties
    private lazy var displayLink: CADisplayLink = {
        let display = CADisplayLink(target: self, selector: #selector(updateMusicProgress(_:)))
        display.add(to: .current, forMode: .default)
        return display
    }()
    private lazy var audioPlayerManager = AudioPlayerManager(delegate: self)

    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        audioPlayerManager.currentMusicTitle()
    }
}

//MARK: - Actions
extension ViewController {
    @IBAction func backwardButtonPressed(_ sender: UIButton) {
        audioPlayerManager.playPreviousMusic()
    }
    
    @IBAction func forwardButtonPressed(_ sender: UIButton) {
        audioPlayerManager.playNextMusic()
    }
    
    @IBAction func playButtonPressed(_ sender: Any) {
        audioPlayerManager.play()
    }
    
    @IBAction func stopButtonPressed(_ sender: Any) {
        audioPlayerManager.stop()
    }
    
    @IBAction func sliderValueChanged(_ sender: UISlider) {
        audioPlayerManager.setCurrentTime(by: Double(sender.value))
    }
    
    @objc private func updateMusicProgress(_ sender: CADisplayLink) {
        let timeInfo = audioPlayerManager.getMusicTimeInfo()
        sliderView.setValue(Float(timeInfo.currentTime) / Float(timeInfo.duration),
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
//        audioPlayerManager.playNextMusic()
    }
}

//MARK: - AudioPlayeManagerDelegate
extension ViewController: AudioPlayerManagerDelegate {
    func musicBeginPlay(_ audioManager: AudioPlayerManager) {
        displayLink.isPaused = !audioPlayerManager.playerIsPlaying
    }
    
    func musicDidStopped(_ audioManager: AudioPlayerManager) {
        if !audioManager.playerIsPlaying {
            displayLink.isPaused = true
            sliderView.setValue(0, animated: false)
        }
    }
    
    func updateMusicTitle(_ audioManager: AudioPlayerManager, with title: String) {
        musicTitleLabel.text = title
    }
}
