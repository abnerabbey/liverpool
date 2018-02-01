//
//  ProductViewModel.swift
//  Tienda
//
//  Created by Abner Abbey on 01/02/18.
//  Copyright © 2018 Abner Abbey. All rights reserved.
//

import Foundation

protocol ProductViewModelItem {
    var sectionTitle: String { get }
    var rows: Int { get }
}

class ProductViewModel {
    var sections = [ProductViewModelItem]()
    
    init(data: Data?) {
        guard let data = data, let searchResults = SearchResult(data: data) else { return }
        
        let products = searchResults.products
        if !products.isEmpty {
            let productsItem = ProductsViewModelResultItem(results: products)
            sections.append(productsItem)
        }
    }
}

class ProductsViewModelResultItem: ProductViewModelItem {
    var sectionTitle: String {
        return "Resultados"
    }
    
    var rows: Int {
        return results.count
    }

    var results: [Product]
    init(results: [Product]) {
        self.results = results
    }
}
