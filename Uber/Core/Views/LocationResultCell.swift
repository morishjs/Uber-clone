//
//  LocationResultCell.swift
//  Uber
//
//  Created by Park Junsuk on 2022/10/07.
//

import SwiftUI

struct LocationResultCell: View {
    var body: some View {
        HStack {
            Image(systemName: "mappin.circle.fill")
                .resizable()
                .foregroundColor(.blue)
                .accentColor(.white)
                .frame(width: 40, height: 40)
                .padding(.trailing, 4)
            
            VStack(alignment: .leading) {
                Text("Starbucks Coffee")
                    .font(.body)
                
                Text("123 Main St")
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
