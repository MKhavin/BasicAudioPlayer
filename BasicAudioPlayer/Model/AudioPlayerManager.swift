import Foundation
import AVFoundation

//MARK: - AUdioPlayerManager delegate protocol
protocol AudioPlayerManagerDelegate: AVAudioPlayerDelegate {
    func updateMusicTitle(_ audioManager: AudioPlayerManager, with title: String)
    func musicDidStopped(_ audioManager: AudioPlayerManager)
    func musicBeginPlay(_ audioManager: AudioPlayerManager)
}

struct AudioPlayerManager {
    //MARK: - Properties
    private var player: AVAudioPlayer?
    private let audioFiles: [URL] = {
        guard let folderPath = Bundle.main.resourcePath else {
            return [URL]()
        }
        
        let musicPath = URL(fileURLWithPath: folderPath + "/Music")
        do {
            let audioFiles = try FileManager.default.contentsOfDirectory(at: musicPath,
                                                                         includingPropertiesForKeys: nil)
            return audioFiles
        } catch {
            print(error.localizedDescription)
            return [URL]()
        }
    }()
    private(set) var currentMusic = 0
    var playerIsPlaying: Bool {
        player?.isPlaying ?? false
    }
    weak var delegate: AudioPlayerManagerDelegate?
    
    //MARK: - Life cycle
    init(delegate: AudioPlayerManagerDelegate? = nil) {
        self.delegate = delegate
        player = prepareAudioPlayer(for: audioFiles[0])
    }
    
    //MARK: - Sub methods
    private func prepareAudioPlayer(for resource: URL) -> AVAudioPlayer {
        do {
            let player = try AVAudioPlayer(contentsOf: resource)
            player.delegate = delegate
            player.prepareToPlay()
            
            return player
        } catch {
            fatalError()
        }
    }
    
    func currentMusicTitle() {
        let playerItem = AVPlayerItem(url: audioFiles[currentMusic])
        let metadataList = playerItem.asset.commonMetadata
        
        let titleValue = metadataList.first { value in
            value.commonKey == .commonKeyTitle
        }
        
        let currentTitle = titleValue?.stringValue ?? audioFiles[currentMusic].lastPathComponent.components(separatedBy: ".")[0].capitalized
        
        delegate?.updateMusicTitle(self,
                                   with: currentTitle)
    }
    
    //MARK: - Music control methods
    func play() {
        guard let player = self.player else {
            return
        }
        
        if !player.isPlaying {
            player.play()
            delegate?.musicBeginPlay(self)
        } else {
            player.stop()
        }
    }
    
    func stop() {
        if !playerIsPlaying {
            player?.stop()
        }
        player?.currentTime = 0
        
        delegate?.musicDidStopped(self)
    }
    
    mutating func playNextMusic() {
        guard currentMusic < audioFiles.count - 1 else {
            return
        }
        
        currentMusic += 1
        player = prepareAudioPlayer(for: audioFiles[currentMusic])
        currentMusicTitle()
        play()
    }
    
    mutating func playPreviousMusic() {
        guard currentMusic > 0 else {
            return
        }
        
        currentMusic -= 1
        player = prepareAudioPlayer(for: audioFiles[currentMusic])
        currentMusicTitle()
        play()
    }
    
    //MARK: - Time info methods
    func getMusicTimeInfo() -> (currentTime: Double, duration: Double) {
        (player?.currentTime ?? 0, player?.duration ?? 0)
    }
    
    func setCurrentTime(by value: Double) {
        guard let player = self.player else {
            return
        }
        
        player.currentTime = value * player.duration
    }
}
