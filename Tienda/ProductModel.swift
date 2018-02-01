//
//  ProductModel.swift
//  Liverpool
//
//  Created by Abner Abbey on 01/02/18.
//  Copyright © 2018 Abner Abbey. All rights reserved.
//

import Foundation

class SearchResult {
    
    var products = [Product]()
    
    init?(data: Data) {
        do {
            guard let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any], let contents = json["contents"] as? [[String: Any]] else { return }
            let dictContents = contents[0]
            guard let mainContent = dictContents["mainContent"] as? [[String: Any]], let lastObject = mainContent.last, let contenido = lastObject["contents"] as? [[String: Any]] else { return }
            let dictContent = contenido[0]
            guard let records = dictContent["records"] as? [[String: Any]] else { return }
            products = records.map { Product(json: $0) }
        } catch {
            print("Error while parsing json object: \(error.localizedDescription)")
        }
    }
}

class Product {
    
    var productName: String?
    var pictureUrlString: String?
    var location: String?
    var price: String?
    
    init(json: [String: Any]) {
        guard let attributes = json["attributes"] as? [String: Any], let names = attributes["product.displayName"] as? [String], let smallImages = attributes["product.smallImage"] as? [String], let prices = attributes["sku.list_Price"] as? [String], let locations = attributes["common.id"] as? [String] else { return }
        self.productName = names.first
        self.pictureUrlString = smallImages.first
        self.price = prices.first
        self.location = locations.first
    }
}













































