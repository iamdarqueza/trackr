//
//  TrackListViewController.swift
//  Trackr
//
//  Created by Danmark Arqueza on 1/24/21.
//

import UIKit
import RealmSwift

class TrackListViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var lastVisitLabel: UILabel!
    
    
    private var trackList: [Results] = []
    private var originalList: [Results] = []
    private var track: Results?
    
    var testTrackList = try! Realm().objects(FavoriteTracks.self)
    
    private var isSearching: Bool = false
    

    override func viewDidLoad() {
        super.viewDidLoad()
        configureSearchBar()
        configureTableView()
        getTrackList()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        checkPreviousOpen()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == SegueIdentifiers.showSpecificTrack.rawValue {
              let destination = segue.destination as! SpecificTrackViewController
              destination.result = track
        }
    }
    

    // MARK: - Configure search button
    private func configureSearchBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        searchBar.placeholder = "Search track"
        searchBar.delegate = self
    }
    
    // MARK: - Configure Table View
    private func configureTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
        tableView.rowHeight = 94
    }
    
    
    // MARK: - Check previous open of app
    private func checkPreviousOpen() {
        guard let previousOpen = UserDefaults.standard.string(forKey: "PreviousOpen") else {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM/dd/yyyy HH:mm"
            let dateInFormat = dateFormatter.string(from: Date())
            lastVisitLabel.text = "Last visit: \(dateInFormat)"
            return
        }
        
        lastVisitLabel.text = "Last visit: \(previousOpen)"
    }
    
    
    // MARK: - Get track list from API
    private func getTrackList() {
      
        TrackServices.shared.getTrackList(term: "star", country: "au", media: "movie", all: "") { (response, error) in

          guard error == nil else {
              self.presentErrorAlertController(error: error!)
              return
          }

          guard let unwrappedResponse = response else {
              self.presentDismissableAlertController(title: "Oops!", message: "Failed to retrieve tracks")
              return
          }
            
            print("RESPONSE: \(unwrappedResponse)")
            
            self.trackList = unwrappedResponse.results
            self.originalList = unwrappedResponse.results
            self.tableView.reloadData()
      
          
      }
    }
    
    
    // MARK: - Save Favorites to Realm Database
    private func writeToRealm(track: Results) {
       
        let realm = try! Realm()
           
         try! realm.write {
           let newFavorite = FavoriteTracks()
             
            newFavorite.trackName = "\(track.trackName ?? track.collectionName ?? "Unknown")"
            newFavorite.trackGenre = "\(track.primaryGenreName ?? "Unknown")"
            newFavorite.trackPrice = track.trackPrice ?? track.collectionPrice ?? 0.0
            newFavorite.trackLongDescription = "\(track.longDescription ?? "No description available..")"
            newFavorite.trackAlbumArt = "\(track.artworkUrl100 ?? "")"
             
           realm.add(newFavorite)
           
         }
        
        
    }
    

    // MARK: - Search track
    private func searchTrack(text: String) {
      if !text.isEmpty {
          trackList = originalList.filter({ (track) -> Bool in
            let trackName = track.trackName?.lowercased().contains(text.lowercased())
            let trackArtist = track.artistName.lowercased().contains(text.lowercased())
            let trackCollectionName = track.collectionName?.lowercased().contains(text.lowercased())
          return (trackName == true || trackArtist == true || trackCollectionName == true)
        })
      } else {
          trackList = originalList
      }
    }

}

extension TrackListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return trackList.count == 0 ? 10 : trackList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.trackListTableViewCell.rawValue, for: indexPath) as! TrackListTableViewCell
        
        if trackList.count != 0 {
            cell.hideSkeletonView()
            cell.index = indexPath
            cell.configure(withTrack: trackList[indexPath.row])
        } else {
          cell.showAnimatedGradientSkeleton()
        }
        
       
        return cell
    }
    
    func tableView(_ tableView: UITableView,
                   trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?
    {
        let favoriteAction = UIContextualAction(style: .normal, title:  "Favorite", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
                print("Favorite")
            self.writeToRealm(track: self.trackList[indexPath.row])
            success(true)
            self.presentDismissableAlertController(title: "Success", message: "You've added this to your favorites.")
            })
        favoriteAction.image = UIImage(named: "btn_favorite")
        favoriteAction.backgroundColor = UIColor.colorWithRGBHex(0x773EE5)

            return UISwipeActionsConfiguration(actions: [favoriteAction])

    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.track = trackList[indexPath.row]
        performSegue(withIdentifier: SegueIdentifiers.showSpecificTrack.rawValue, sender: self)
    }
    
}


extension TrackListViewController: UISearchBarDelegate {

    // MARK: - Update search result
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if let text = searchBar.text, !text.isEmpty {
          isSearching = true
            self.searchTrack(text: text)
        } else {
          isSearching = false
          self.trackList = originalList
        }
        tableView.reloadData()
    }
    

}
