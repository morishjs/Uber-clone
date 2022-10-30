//
//  RideRequestView.swift
//  Uber
//
//  Created by Park Junsuk on 2022/10/19.
//

import SwiftUI

struct RideRequestView: View {
    var body: some View {
        VStack {
            Capsule()
                .foregroundColor(Color(.systemGray5))
                .frame(width: 48, height: 6)
            
            HStack {
                VStack(alignment: .leading) {
                    HStack {
                        Rectangle()
                            .foregroundColor(.gray)
                            .frame(width: 8, height: 8)
                        HStack {
                            Text("Starbuck")
                            Spacer()
                            Text("1:30 PM")
                        }
                    }
                    
                    Rectangle()
                        .frame(width: 1, height: 32)
                    
                    HStack {
                        Rectangle()
                            .frame(width: 8, height: 8)
                        
                        HStack {
                            Text("Starbuck")
                            Spacer()
                            Text("1:30 PM")
                        }
                    }
                }
                .padding(.trailing)
            }.padding(.leading)
            
            Divider()
            
            Text("SUGGESTED RIDES")
                .font(.subheadline)
                .fontWeight(.semibold)
                .padding()
                .foregroundColor(.gray)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            ScrollView(.horizontal) {
                HStack(spacing: 12) {
                    ForEach(0 ..< 3, id: \.self) {_ in
                        VStack(alignment: .leading) {
                            Image("uber-x")
                                .resizable()
                                .scaledToFit()
                            
                            VStack(alignment: .leading, spacing: 4) {
                                Text("UberX")
                                    .font(.system(size: 14, weight: .semibold))
                                Text("$22.04")
                                    .font(.system(size: 14, weight: .semibold))
                            }
                            .padding(8)
                        }
                        .frame(width: 114, height: 120)
                    }
                }
            }
            .padding(.horizontal)
            
            HStack(spacing: 12) {
                Text("Visa")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .padding(6)
                    .background(.blue)
                    .cornerRadius(4)
                    .foregroundColor(.white)
                    .padding(.leading)
                
                Text("**** 1234")
                    .fontWeight(.bold)
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .imageScale(.medium)
                    .padding()
            }
            .frame(height: 50)
            .background(Color(.systemGroupedBackground))
            .cornerRadius(10)
            .padding(.horizontal)
            
            
            Divider()
                .padding(.vertical, 8)
            
            Button {
                
            } label: {
                Text("CONFIRM RIDE")
                    .fontWeight(.bold)
                    .frame(width: UIScreen.main.bounds.width - 32, height: 50)
                    .background(.blue)
                    .cornerRadius(10)
                    .foregroundColor(.white)
                    .padding(.vertical)
            }
        }
        .padding(.top)
        .background(.white)
        .cornerRadius(16)
    }
}

struct RideRequestView_Previews: PreviewProvider {
    static var previews: some View {
        RideRequestView()
    }
}
