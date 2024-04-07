//
//  SearchViewViewModel.swift
//  RickAndMorty
//
//  Created by Dmitrii Iakovlev on 23.03.2024.
//
import UIKit

final class SearchViewViewModel {
    let config: SearchViewController.Config
    
    private var optionMap: [SearchInputViewViewModel.DynamicOption: String] = [:]
    private var searchText = ""
    private var optionMapUpdateBlock: (((SearchInputViewViewModel.DynamicOption, String)) -> Void)?
    private var searchResultHandler: (() -> Void)?
    
    init(config: SearchViewController.Config) {
        self.config = config
    }
    
    private func registerSearchResultHandler(_ block: @escaping () -> Void) {
        self.searchResultHandler = block
    }
     
    public func executeSearch() {
        searchText = "Rick"
        var queryParams: [URLQueryItem] = [ URLQueryItem(name: "name", value: searchText)]
        
        queryParams.append(contentsOf: optionMap.enumerated().compactMap({ _, element in
            let key: SearchInputViewViewModel.DynamicOption = element.key
            let value: String = element.value
            return URLQueryItem(name: key.queryArgument, value: value)}))
        
        
        let request = Request(endpoint: config.type.endpoint,
                              queryParameters: queryParams)
        
        Service.shared.execute(request, expecting: GetAllCharactersResponse.self) { result in
            switch result {
            case .success(let model):
                print("Search results found: \(model.results.count)")
            case .failure:
                break
            }
        }
    }
    
    public func set(query text: String) {
        self.searchText = text
    }
    
    public func set(value: String, for option: SearchInputViewViewModel.DynamicOption) {
        optionMap[option] = value
        let tuple = (option, value)
        optionMapUpdateBlock?(tuple)
    }
    
    public func registerOptionChangeBlock(_ block: @escaping ((SearchInputViewViewModel.DynamicOption, String)) -> Void) {
        self.optionMapUpdateBlock = block
    }
}
