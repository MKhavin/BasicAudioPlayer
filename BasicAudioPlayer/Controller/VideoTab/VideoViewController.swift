import UIKit

class VideoViewController: UIViewController {
    //MARK: - Sub properties
    var videoPlayerManager: VideoPlayerManager?
    var videoId: Int?
    
    //MARK: - UI Elements
    private var videoLayer: CALayer?
    @IBOutlet weak var videoView: UIView!
    
    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let videoLayer = videoPlayerManager?.setUpVideoPlayer(with: videoId ?? 0) else {
            return
        }
        videoView.layer.addSublayer(videoLayer)
        self.videoLayer = videoLayer
        videoPlayerManager?.play()
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        if traitCollection.horizontalSizeClass != previousTraitCollection?.horizontalSizeClass {
            videoView.layer.sublayers![0].frame = videoView.bounds
        }
    }
    
    override func viewDidLayoutSubviews() {
        videoLayer?.frame = videoView.bounds
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        videoPlayerManager?.stop()
    }
    
    //MARK: - Actions
    @IBAction func closeButtonTouched(_ sender: Any) {
        dismiss(animated: true)
    }
}
