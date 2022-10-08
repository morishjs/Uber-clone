//
//  LocationResultCell.swift
//  Uber
//
//  Created by Park Junsuk on 2022/10/07.
//

import SwiftUI

struct LocationResultCell: View {
    private var title = ""
    private var subtitle = ""
    
    init(title: String = "", subtitle: String = "") {
        self.title = title
        self.subtitle = subtitle
    }
    
    var body: some View {
        HStack {
            Image(systemName: "mappin.circle.fill")
                .resizable()
                .foregroundColor(.blue)
                .accentColor(.white)
                .frame(width: 40, height: 40)
                .padding(.trailing, 4)
            
            VStack(alignment: .leading) {
                Text(title)
                    .font(.body)
                
                Text(subtitle)
                    .font(.system(size: 15))
                    .foregroundColor(.gray)
            }
            
            Spacer()
        }
    }
}

struct LocationResultCell_Previews: PreviewProvider {
    static var previews: some View {
        LocationResultCell()
    }
}
