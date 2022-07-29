import UIKit

class VideoListViewController: UIViewController {
    //MARK: - UI Elements
    @IBOutlet weak var videoListTableView: UITableView!
    
    //MARK: - Sub properties
    private let videoPlayerManager = VideoPlayerManager()
    
    //MARK: - Life cycle
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "playVideo" {
            guard let view = segue.destination as? VideoViewController,
                  let sender = sender as? VideoViewCell,
                  let currentIndexPath = videoListTableView.indexPath(for: sender) else {
                return
            }
            
            view.videoPlayerManager = videoPlayerManager
            view.videoId = currentIndexPath.row
            videoListTableView.deselectRow(at: currentIndexPath, animated: false)
        }
    }
    
}

//MARK: - TableView DataSource
extension VideoListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        videoPlayerManager.youtubeVideos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "VideoCell") as? VideoViewCell else {
            return UITableViewCell()
        }
        
        let currentData = videoPlayerManager.youtubeVideos[indexPath.item]
        cell.setCell(data: currentData)
        
        return cell
    }
}

