//
//  String+Ext.swift
//  MovieApplication
//
//  Created by Oliwia Procyk on 28/03/2023.
//

import Foundation

extension String {
    func toDate(withFormat format: String = "dd/MM/yyyy") -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        guard let date = dateFormatter.date(from: self) else {
            return Date()
        }
        return date
    }
}
