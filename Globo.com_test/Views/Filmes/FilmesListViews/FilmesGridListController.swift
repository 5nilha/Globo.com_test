//
//  FilmesGridListController.swift
//  Globo.com_test
//
//  Created by Fabio Quintanilha on 12/9/19.
//  Copyright © 2019 FabioQuintanilha. All rights reserved.
//

import UIKit

class FilmesGridListController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    fileprivate lazy var segmentedControl = UISegmentedControl(items: ["Todos os Filmes", "Favoritos"])
    private lazy var logoImage = UIImageView(image: UIImage(named: "logo"))
    private lazy var splashView = UIView()

    fileprivate var filmesListViewModel: FilmesListViewModel!
    private var selectedFilme: FilmeViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setDelegates()
        self.setupSplash()
        self.setupUI()
        self.filmesListViewModel.loadFilmes()
    }
    
    override func viewWillAppear(_ animated: Bool) {
           super.viewWillAppear(animated)
           self.scaleUpAnimation()
       }
    
    func setDelegates() {
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.filmesListViewModel = FilmesListViewModel()
        self.filmesListViewModel.delegate = self
    }
    
    func setupUI() {
        self.segmentedControl.frame = CGRect(x: 0, y: 0, width: 300, height: 30)
        self.segmentedControl.tintColor = .white
        self.segmentedControl.backgroundColor = .orange
        self.segmentedControl.apportionsSegmentWidthsByContent = true
        self.segmentedControl.selectedSegmentIndex = 0
        self.segmentedControl.addTarget(self, action: #selector(segmentedControlChanged), for: .valueChanged)
        self.navigationItem.titleView = segmentedControl
    }
    
    @objc func segmentedControlChanged() {
        if segmentedControl.selectedSegmentIndex == 0 {
             self.filmesListViewModel.loadFilmes()
        } else {
            USER.readFavoriteMovies()
            self.collectionView.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToFilmeDetail" {
            let destination = segue.destination as? FilmePopUpDetailController
            destination?.filme = selectedFilme
            destination?.filmeDelegate = self
        }
    }
    
    @IBAction func settingsClicked() {
        performSegue(withIdentifier: "goToSettings", sender: self)
    }
}

//MARK: -> Conforms the contoller to FilmeViewDelegate
/* To reload the collection view after the webservice ends fetching the data from a remote JSON file, we conform with the FilmeViewDelegate
 * Every time the webservice loads the inofmraiton from the file , the delegate is called, passing the infomation back to the filme list.
 */
extension FilmesGridListController: FilmesViewDelegate {
    func filmesDidLoad() {
        self.collectionView.reloadData()
    }
    
    func filmesDidUpdate() {
        self.collectionView.reloadData()
    }
}

//MARK: -> Setup the splash view
/* The splash view will load when the sceen will appear.
 When the animation ends, it will dismiss itself automatically*/
extension FilmesGridListController {
    private func setupSplash() {
        // Do any additional setup after loading the view.
         splashView.backgroundColor = UIColor.black
         view.addSubview(splashView)
         splashView.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height)
        
         splashView.contentMode = .scaleAspectFit
         splashView.addSubview(logoImage)
         logoImage.frame = CGRect(x: (splashView.frame.width / 2) - 50, y: (splashView.frame.height / 2) - 50, width: 100, height: 100)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    private func scaleUpAnimation() {
        UIView.animate(withDuration: 0.75, delay: 0.1, options: .curveEaseInOut, animations: {
            self.logoImage.transform = CGAffineTransform(scaleX: 5, y: 5)
        }) { (success) in
            self.removeSplashView()
        }
    }
    
    private func removeSplashView() {
        UIView.animate(withDuration: 0.5, delay: 0.1, options: .curveEaseOut, animations: {
            self.logoImage.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        }, completion: { (success) in
            self.splashView.removeFromSuperview()
            self.navigationController?.navigationBar.isHidden = false
        })
        
    }
}

//MARK: -> Setup the Collection view
extension FilmesGridListController: UICollectionViewDelegate, UICollectionViewDataSource {
   
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if segmentedControl.selectedSegmentIndex == 0 {
            return filmesListViewModel != nil ? filmesListViewModel.numOfFilmes : 0
        } else {
            return USER.favoriteFilmes.numOfFilmes
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "filmeCell", for: indexPath) as! FilmeCollectionCell
        if segmentedControl.selectedSegmentIndex == 0 {
            cell.setupView(filme: self.filmesListViewModel.filmeForCellAt(indexPath: indexPath))
        } else {
            cell.setupView(filme: USER.favoriteFilmes.filmeForCellAt(indexPath: indexPath))
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if segmentedControl.selectedSegmentIndex == 0 {
            selectedFilme = self.filmesListViewModel.filmeForCellAt(indexPath: indexPath)
        } else {
            selectedFilme = USER.favoriteFilmes.filmeForCellAt(indexPath: indexPath)
        }
        performSegue(withIdentifier: "goToFilmeDetail", sender: self)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let noOfCellsInRow = 4

        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout

        let totalSpace = flowLayout.sectionInset.left
            + flowLayout.sectionInset.right
            + (flowLayout.minimumInteritemSpacing * CGFloat(noOfCellsInRow - 1))

        let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(noOfCellsInRow))

        return CGSize(width: size, height: size)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, layout
        collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
